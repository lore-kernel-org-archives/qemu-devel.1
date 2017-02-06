Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1calLg-0001xE-UW
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1calLf-0002NC-E4
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:37:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
Date: Mon, 06 Feb 2017 16:36:50 +0100
In-Reply-To: <20170206132321.GB11987@noname.redhat.com> (Kevin Wolf's message
	of "Mon, 6 Feb 2017 14:23:21 +0100")
Message-ID: <877f53l4a5.fsf@dusky.pond.sub.org>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 02.02.2017 um 20:42 hat Markus Armbruster geschrieben:
>> = Brief recap of dotted key convention =
>> 
>> We'll discuss use of dotted key convention later, so let me explain it
>> briefly for the readers who don't know it already.
>> 
>> The dotted key convention interprets the KEY part as a sequence of names
>> separated by dots.  If a name looks like an integer *handwave*, it's an
>> array index, else it's an object member name.
>
> I think that's not really what we have, but just what it looks like to
> you from your perspective of someone who wants to write a parser that
> generically parses these things into nested QObjects.
>
> In reality, pretty much all users of the dotted syntax know from context
> whether this is an array or an object. In the former case they call
> something like qdict_array_entries()/split(), and in the latter case
> qemu_opts_absorb_qdict(). Both of them are happy with numeric keys.
>
> The one exception is qdict_crumple(), which already is a parser like
> you're intending to write. The difference is that it's used only in very
> few specific cases where we know that the assumption holds true.
>
> In other words: To do things properly, you'd have to look at the schema.

See discussion of 'any' types below.

>> = Structured option argument syntax =
>> 
>> == JSON ==
>> [...]
>> There's also the -drive file=json:... syntax.  It's a bad fit for
>> QemuOpts, because QemuOpts and JSON fight for the comma.  I'd show you
>> if I could get it to work.
>
> Just double all the commas in the JSON object. It's not really that hard
> to come up with something working, but it makes it even uglier than
> plain JSON on the command line.

I tried, I failed, I suck :)

> Bonus: You get to guess which options are parsed by QemuOpts and which
> aren't. qemu-img usually takes parameters directs from argv, so doubling
> the comma there like you have to in -drive will result in an error.
>
>> We obviously can't replace QemuOpts with JSON.  But accepting JSON in
>> addition to QemuOpts is a debatable feature: it lets management
>> applications reuse the code to build QMP arguments for option arguments.
>
> Management applications already have working code for the existing
> syntax, they might not want to switch just because (and probe whether
> qemu is new enough to even support JSON for QemuOpts).

If it was my code, and that code converted from an internal
representation of JSON either to JSON or QemuOpts as libvirt does, I'd
gladly ditch the second conversion.  Less code, fewer bugs.

Note that "less code, fewer bugs" applies both to the management
application and QEMU: parsing KEY=VALUE,... in dotted key convention to
QAPI object is additional code that is tricky in places, e.g. where it
auto-converts string values.

> When I talked to Peter, his concern wasn't really about what the exact
> syntax was, but just that the content is a 1:1 mapping of QMP arguments.
>
> I take this as a sign that we should find something that works well
> for human users, and management tools can easily cope with whatever we
> choose.
>
>> === Dotted keys ===
>> 
>> One sufficiently powerful syntax extension already exists: the dotted
>> key convention.  It's syntactically unambiguous only when none of the
>> KEYs involved contains '.'  To adopt it across the board, we'd have to
>> outlaw '.' in KEYs.  QAPI outlaws '.' already, but we have a bunch of
>> QOM properties names with '.'.  We'd have to rename at least the ones
>> that need to be accessible in -object.
>> 
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
> Dotted key syntax is a bit longwinded, but it's the simplest thinkable
> extension of key=value and seems to be relatively easy to implement; the
> necessary renaming should be possible to do.
>
> This is not perfect for human users because of its repetitive nature,
> but it could be the first step for 2.9.
>
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
>
> This looks more like what you really want to use. However, being able to
> write a={b=x,c=y} for a.b=x,a.c=y is really just syntactic sugar and
> could be a second step after we got the basics working.
>
> Note that treating it simply as syntactic sugar for the expanded dotted
> form would also allow mixing (and I think that's a good thing):
>
>     -drive 'driver=qcow2,
>             backing.file.filename=backing.qcow2,
>             file={driver=file, filename=overlay.qcow2, aio=native}'
>
> Or even add to a previously defined thing, which should make Max happy
> when he forgot a nested option at first:
>
>     -drive 'driver=qcow2,
>             file={driver=nbd,host=localhost},
>             lazy-refcounts=on,
>             file.port=1234'
>
>> There's a syntactic catch, though: a value of the form [ ... ] can
>> either be an array or a string.  Which one it is depends on the type of
>> the key.  To parse this syntax, you need to know the types, unlike JSON
>> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
>> '[', which feels impractical.
>
> We would have to look at the schema and only treat it as a nested object
> or an array if the expected type has one there.
>
> Your other mail says that even this doesn't work because of "any" types,
> but I don't think this is a real problem: In that case, you simply use
> the type that we always used, i.e. string. That's the fully backwards
> compatible way.
>
> Want to make use of the shiny new QemuOpts and get things parsed into
> a nested object? Well, provide a real schema instead of "any" then.

Sadly, this is somewhere between impractical and impossible.

The QAPI schema is fixed at compile-time.  It needs to be, because its
purpose is to let us generate code we can compile and link into QEMU.

We use 'any' basically for things that aren't fixed at compile-time.

Example: qdev properties and device_add

Even though traditional qdev properties are fixed at compile time, they
are not known until run-time.  That's because they're defined in the
device models, and the registry of device models is only built at
run-time.

I believe this would've been fixable with some effort: make the devices
define suitable pieces of schema, and collect them somehow at
compile-time.  "Would've been", because progress!  See next example.

Example: QOM properties and object-add, qom-set, qom-get

QOM properties are created at run-time.  They cannot be fixed at
compile-time *by design*.  I always hated that part of the design, but I
was assured we absolutely need that much rope^Wflexibility.

So, all we know about the "props" argument of object-add is that it's a
JSON object.  The tightest imaginable QAPI schema would be an 'object'
type, except that doesn't exist, so we settle for 'any'.

-object unwraps "props" to get a flat QemuOpts, but let's ignore that
and pretend we'd want to parse -object qom-type=T,id=ID,props=...

If we made "props" an 'object' in the schema, we'd know we need to parse
the right hand side of props={foo=[bar]} as object, not as string.  We'd
still not know (and cannot know at compile-time) whether to parse [bar]
as array or as string.

But it gets worse.  Consider

    props={foo=[bar,baz=]}

If foo turns out to an array of string, we need to parse this like JSON

    { "foo": [ "bar", "baz=" ] }

But if it's of string type, we need to parse it like JSON

    { "foo": "[bar", "baz": ... }

This isn't just a "can't decide between integer and string" problem,
which Dan solved by auto-converting strings in the input visitor,
i.e. by delaying some parsing of terminals.  It's a "can't even figure
out the tree structure" problem.

I'm afraid there's no way to make this syntax work without requiring
some kind of quotes for at least "funny" strings.  Which makes me go
"okay, what's the advantage over plain JSON again?"

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
> This is actually the part that troubles me the most about adding such a
> syntax with new special characters. Otherwise it's pretty close to
> optimal, in my opinion.
>
> Kevin
