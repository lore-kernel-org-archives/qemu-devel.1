Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZboC-00047A-Pb
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZboB-0001iD-Bm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:13:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170203100311.GC10350@redhat.com>
Date: Fri, 03 Feb 2017 12:13:28 +0100
In-Reply-To: <20170203100311.GC10350@redhat.com> (Daniel P. Berrange's message
	of "Fri, 3 Feb 2017 10:03:11 +0000")
Message-ID: <87fujvplwn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Thu, Feb 02, 2017 at 08:42:33PM +0100, Markus Armbruster wrote:
>> === Dotted keys ===
>> 
>> One sufficiently powerful syntax extension already exists: the dotted
>> key convention.  It's syntactically unambiguous only when none of the
>> KEYs involved contains '.'  To adopt it across the board, we'd have to
>> outlaw '.' in KEYs.  QAPI outlaws '.' already, but we have a bunch of
>> QOM properties names with '.'.  We'd have to rename at least the ones
>> that need to be accessible in -object.
>
> We don't neccessarily need to rename - there's a couple of alternatives
>
>  - Allow registration of property name aliases, so there's two
>    names to access the same property. The old one with the '.'
>    in it for back compat, and a new one without the '.'.

Might have other uses, too.

>  - Magically remap '.' to '_'. eg if user specifies foo_bar and
>    there's no foo_bar present, then also look for foo.bar

I'm wary of such magic, but yes, it's an option.

Rename is the simplest fix when it's possible.

>> Dotted keys can't express member names that look like integers.  We'd
>> have to outlaw them at least for the objects that are accessible on the
>> command line.  Once again, QAPI outlaws such names already.  QOM is
>> anarchy when it comes to names, however.
>> 
>> The way dotted keys do arrays is inconsistent with how QOM's automatic
>> arrayification (commit 3396590) do them: foo.0 vs. foo[0].  Backward
>> compatibility makes changing the dotted key convention awkward.  Perhaps
>> we can still change QOM.
>
> It is a shame - foo[0] is clearly better as it avoids need to outlaw
> member names that are pure integers.

Yes, but you have to quote foo[0] for the shell, unlike foo.0.

> IIRC, we outlaw members names that begin with a "_", so if we must
> support member names that are integers, we could allow them to be
> given unambigously by using  foo._0  to dinstiguish from foo.0
> array access.

QAPI permits leading '_' only for __RFQDN_ downstream extension
prefixes.

Note that even without dotted key convention, you can define QOM names
hostile to command line use: ',' needs be escaped by doubling, shell
meta-characters need to be escaped for the shell, and anything with '='
is impossible to use as KEY.

I stand by my opinion that our failure to define and outlaw anti-social
names consistently is a self-inflicted wound.

>> === Structured values ===
>> 
>> The dotted key convention messes with KEY syntax to permit structured
>> values.  Works, but the more conventional way to support structured
>> values is a syntax for structured values.  
>> 
>> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
>> ... ] for arrays.  Looks like this:
>> 
>>     -drive 'driver=quorum,
>>             child=[{ driver=file, filename=disk1.img },
>>                    { driver=host_device, filename=/dev/sdb },
>>                    { driver=nbd, host=localhost } ]'
>> 
>> Again, lines broken and indented for legibility; you need to join them
>> for actual use.
>> 
>> There's a syntactic catch, though: a value of the form [ ... ] can
>> either be an array or a string.  Which one it is depends on the type of
>> the key.  To parse this syntax, you need to know the types, unlike JSON
>> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
>> '[', which feels impractical.
>> 
>> But wait, there's another syntactic catch: in traditional QemuOpts, a
>> value ends at the next unescaped ',' or '\0'.  Inside an object, it now
>> also ends at the next unescaped '}', and inside an array, at the next
>> unescaped ']'.  Or perhaps at the next space (the example above assumes
>> it does).  That means we either have to provide a way to escape '}', ']'
>> and space, or find another way to delimit string values, say require '"'
>> around strings whenever the string contains "funny" characters.
>> 
>> So, if escaped ',' wasn't ugly and confusing enough for you...
>
> I'm not a fan of this because it essentially introduces yet another
> syntax, different from everything that exists today.
>
>> === Comparison ===
>> 
>> In my opinion, dotted keys are weird and ugly, but at least they don't
>> add to the quoting mess.  Structured values look better, except when
>> they do add to the quoting mess.
>> 
>> I'm having a hard time deciding which one I like less :)
>> 
>> Opinions?  Other ideas?
>
> I think the JSON approach is fine, *iff*, QEMU is being managed by
> a machine (ie libvirt). If QEMU is being managed by a human, then
> typing & quoting json in the CLI is pretty horrible - when I write
> json I pretty much always get the syntax wrong several times, with
> the trailing comma rules being particularly tedious. IMHO this is
> why humans tend to still use the HMP (or the HMP-lookalike QMP-shell
> to talk to QMP), rather ever using QMP directly.

Getting humans to use QMP for interactive work is a non-goal.

> The block layer allows both dotted keys and JSON already IIUC.
>
> As such I'm inclined to say we should support dotted syntax as the
> primary human facing syntax and JSON as the machine targetted
> syntax. Essentially just do what the block layer already does
> and avoid inventing something new. It might not be perfectly
> to our taste if we had a green-field, but given historical
> baggage, I think its basically fine.

Thanks!
