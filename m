Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZYkS-0000Me-AW
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZYkR-0000CB-91
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:57:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<f546e25b-cd7f-abc4-ece6-0be122483561@redhat.com>
Date: Fri, 03 Feb 2017 08:57:26 +0100
In-Reply-To: <f546e25b-cd7f-abc4-ece6-0be122483561@redhat.com> (Eric Blake's
	message of "Thu, 2 Feb 2017 14:23:53 -0600")
Message-ID: <87r33fhfkp.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2017 01:42 PM, Markus Armbruster wrote:
>
>> 
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
>
> Another syntactic catch: from the shell,
>
> -drive driver=quorum,child=[...]
>
> is insufficiently quoted, and MIGHT glob to a completely different
> argument (or even multiple arguments) depending on the (oddly-named)
> contents of the current directory.  Any use of [] HAS to consistently
> recommend use with shell quotes.  Using straight JSON already has to use
> shell quotes (generally '' for the overall argument, and "" for key
> names and string values within the JSON, although our parser as an
> extension supports '' for key names and string values which pairs with
> "" for the overall argument and allows the use of $var shell interpolation).

I forgot to mention interactions with shell meta-characters and
quoting.  Glad you brought it up.

>> === Comparison ===
>> 
>> In my opinion, dotted keys are weird and ugly, but at least they don't
>> add to the quoting mess.  Structured values look better, except when
>> they do add to the quoting mess.
>> 
>> I'm having a hard time deciding which one I like less :)
>
> Both are a bit awkward.  I think dotted keys require more typing but
> less shell quoting than structured values.  And with either approach, it
> would STILL be nice if we taught QemuOpts to strip whitespace after
> delimiting commas - the only requirement is that no key value can start
> with space, which QAPI enforces, and QOM is unlikely to break, although
> the benefits of stripping whitespace are only apparent when you remember
> to use shell quoting over the entire argument (which partially defeats
> the purpose of trying to come up with a syntax that needs less shell
> quoting).

Syntax that requires shell quoting even in simple cases is not nice.

Syntax that requires it in complicated cases could be tolerable.  If
you're the kind of person to type option arguments exceeding 200
characters into an interactive shell, you should be the kind of person
to know when to quote.  Programs generating shell input should probably
quote everything except the specific parts they *want* the shell to
expand.

>> Opinions?  Other ideas?
>
> I don't think command line length is a problem; most command lines are
> generated. I'm torn on whether a simplified structured values is nicer
> than full-blown JSON; your argument about having the same JSON work on
> both the command line and through QMP resulting in less work for
> management apps is interesting.  And reusing an existing syntax instead
> of inventing yet another one always has the benefit of less code to
> maintain.  So even though it's harder to type by hand, I'm somewhat
> leaning towards full JSON (where a leading '{' says to parse using JSON
> until the closing '}'), rather than any other structured value
> representation.

Thanks!
