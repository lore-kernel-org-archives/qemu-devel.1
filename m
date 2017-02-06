Received: from eggs.gnu.org ([2001:4830:134:3::10]:42970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cadEw-0004Gl-Rv
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 01:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cadEv-0000MM-JB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 01:57:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
Date: Mon, 06 Feb 2017 07:57:20 +0100
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 02 Feb 2017 20:42:33 +0100")
Message-ID: <87vasnu7qn.fsf@dusky.pond.sub.org>
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
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> === Structured values ===
>
> The dotted key convention messes with KEY syntax to permit structured
> values.  Works, but the more conventional way to support structured
> values is a syntax for structured values.  
>
> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
> ... ] for arrays.  Looks like this:
>
>     -drive 'driver=quorum,
>             child=[{ driver=file, filename=disk1.img },
>                    { driver=host_device, filename=/dev/sdb },
>                    { driver=nbd, host=localhost } ]'
>
> Again, lines broken and indented for legibility; you need to join them
> for actual use.
>
> There's a syntactic catch, though: a value of the form [ ... ] can
> either be an array or a string.  Which one it is depends on the type of
> the key.  To parse this syntax, you need to know the types, unlike JSON
> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
> '[', which feels impractical.

The parser having to know the types obviously precludes a design where a
simple parser feeds into a type-aware visitor, which is how the JSON ->
QObject -> QAPI pipeline works.

Perhaps less obviously, it even precludes a design where the parser is
derived from the QAPI schema to make it type-aware: the 'any' type
spoils that.

Consider -object/object-add and -device/device_add.  These take a few
statically known parameters such as "id".  Any additional parameters get
collected in a dictionary.  The schema represents it as value of type
'any'.  The code using this dictionary value matches its entries against
QOM properties.

To parse these additional parameters, knowing the (compile-time static)
schema isn't sufficient.  You also need to know the type of the QOM
property they'll get matched to at run-time.

This is a special case.  For the general case, you need to know how code
is going to use the value.  You generally can't know that until it's
done, so we'd have to parse lazily.  Thanks, but no thanks.

> But wait, there's another syntactic catch: in traditional QemuOpts, a
> value ends at the next unescaped ',' or '\0'.  Inside an object, it now
> also ends at the next unescaped '}', and inside an array, at the next
> unescaped ']'.  Or perhaps at the next space (the example above assumes
> it does).  That means we either have to provide a way to escape '}', ']'
> and space, or find another way to delimit string values, say require '"'
> around strings whenever the string contains "funny" characters.
>
> So, if escaped ',' wasn't ugly and confusing enough for you...
>
> === Comparison ===
>
> In my opinion, dotted keys are weird and ugly, but at least they don't
> add to the quoting mess.  Structured values look better, except when
> they do add to the quoting mess.
>
> I'm having a hard time deciding which one I like less :)
>
> Opinions?  Other ideas?
>
>
>
>
> [1] [PATCH v14 00/21] QAPI/QOM work for non-scalar object properties
> (actually v15)
> Message-Id: <1475246744-29302-1-git-send-email-berrange@redhat.com>
> http://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08238.html
>
> [2] [RFC PATCH] block: Crude initial implementation of -blockdev
> Message-Id: <1485968933-9162-1-git-send-email-armbru@redhat.com>
> http://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00182.html
>
> [3] Message-ID: <87h989ncse.fsf@dusky.pond.sub.org>
> http://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04046.html
