Received: from eggs.gnu.org ([2001:4830:134:3::10]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1caoSZ-00008v-KQ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1caoSY-0008GV-FB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:56:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
	<20170206163331.GF31991@redhat.com>
	<87d1evi65h.fsf@dusky.pond.sub.org> <20170206175055.GB3249@redhat.com>
Date: Mon, 06 Feb 2017 19:56:09 +0100
In-Reply-To: <20170206175055.GB3249@redhat.com> (Daniel P. Berrange's message
	of "Mon, 6 Feb 2017 17:50:55 +0000")
Message-ID: <87a89zcfna.fsf@dusky.pond.sub.org>
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

Note: a bit more context restored.

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Mon, Feb 06, 2017 at 06:24:42PM +0100, Markus Armbruster wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>> 
>> > On Mon, Feb 06, 2017 at 04:36:50PM +0100, Markus Armbruster wrote:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >> 
>> >> > Am 02.02.2017 um 20:42 hat Markus Armbruster geschrieben:
[...]
>> >> >> === Structured values ===
>> >> >> 
>> >> >> The dotted key convention messes with KEY syntax to permit structured
>> >> >> values.  Works, but the more conventional way to support structured
>> >> >> values is a syntax for structured values.  
>> >> >> 
>> >> >> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
>> >> >> ... ] for arrays.  Looks like this:
>> >> >> 
>> >> >>     -drive 'driver=quorum,
>> >> >>             child=[{ driver=file, filename=disk1.img },
>> >> >>                    { driver=host_device, filename=/dev/sdb },
>> >> >>                    { driver=nbd, host=localhost } ]'
>> >> >> 
>> >> >> Again, lines broken and indented for legibility; you need to join them
>> >> >> for actual use.
>> >> >
>> >> > This looks more like what you really want to use. However, being able to
>> >> > write a={b=x,c=y} for a.b=x,a.c=y is really just syntactic sugar and
>> >> > could be a second step after we got the basics working.
>> >> >
>> >> > Note that treating it simply as syntactic sugar for the expanded dotted
>> >> > form would also allow mixing (and I think that's a good thing):
>> >> >
>> >> >     -drive 'driver=qcow2,
>> >> >             backing.file.filename=backing.qcow2,
>> >> >             file={driver=file, filename=overlay.qcow2, aio=native}'
>> >> >
>> >> > Or even add to a previously defined thing, which should make Max happy
>> >> > when he forgot a nested option at first:
>> >> >
>> >> >     -drive 'driver=qcow2,
>> >> >             file={driver=nbd,host=localhost},
>> >> >             lazy-refcounts=on,
>> >> >             file.port=1234'
>> >> >
>> >> >> There's a syntactic catch, though: a value of the form [ ... ] can
>> >> >> either be an array or a string.  Which one it is depends on the type of
>> >> >> the key.  To parse this syntax, you need to know the types, unlike JSON
>> >> >> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
>> >> >> '[', which feels impractical.
>> >> >
>> >> > We would have to look at the schema and only treat it as a nested object
>> >> > or an array if the expected type has one there.
>> >> >
>> >> > Your other mail says that even this doesn't work because of "any" types,
>> >> > but I don't think this is a real problem: In that case, you simply use
>> >> > the type that we always used, i.e. string. That's the fully backwards
>> >> > compatible way.
>> >> >
>> >> > Want to make use of the shiny new QemuOpts and get things parsed into
>> >> > a nested object? Well, provide a real schema instead of "any" then.
>> >> 
>> >> Sadly, this is somewhere between impractical and impossible.
>> >> 
>> >> The QAPI schema is fixed at compile-time.  It needs to be, because its
>> >> purpose is to let us generate code we can compile and link into QEMU.
>> >> 
>> >> We use 'any' basically for things that aren't fixed at compile-time.
>> >> 
>> >> Example: qdev properties and device_add
>> >> 
>> >> Even though traditional qdev properties are fixed at compile time, they
>> >> are not known until run-time.  That's because they're defined in the
>> >> device models, and the registry of device models is only built at
>> >> run-time.
>> >> 
>> >> I believe this would've been fixable with some effort: make the devices
>> >> define suitable pieces of schema, and collect them somehow at
>> >> compile-time.  "Would've been", because progress!  See next example.
>> >> 
>> >> Example: QOM properties and object-add, qom-set, qom-get
>> >> 
>> >> QOM properties are created at run-time.  They cannot be fixed at
>> >> compile-time *by design*.  I always hated that part of the design, but I
>> >> was assured we absolutely need that much rope^Wflexibility.
>> >> 
>> >> So, all we know about the "props" argument of object-add is that it's a
>> >> JSON object.  The tightest imaginable QAPI schema would be an 'object'
>> >> type, except that doesn't exist, so we settle for 'any'.
>> >
>> > The CLI parser is executing at runtime though, so I would think
>> > it should need to care if the schema its using to parse the CLI
>> > args was defined at build time or execution time. It merely needs
>> > the schema to be present at the time it parses the data.
>> 
>> Whatever "the schema" is, it can't be the QAPI schema, and it can't be
>> used by generating code (which is how the visitors use the QAPI schema).
>> 
>> Let's assume for the moment that QOM is the only source of schema stuff
>> that becomes known only at run-time.  Then "the schema" is an
>> amalgamation of the QAPI schema and QOM reflection.  I say "reflection",
>> not "schema", because there is no QOM schema, only ways to examine (the
>> current structure of) QOM objects.
>> 
>> > So is there a way we dynamically report the info we need by improving
>> > visitor support for QOM somehow.
>> 
>> To parse the argument of -object, we need to create a QOM object of the
>> type given by qom-type, so we can examine it to find its properties and
>> their types.
>> 
>> Consider
>> 
>>     -object foo=[eins,qom-type=zwei,bar={x=y,qom-type=drei,baz=}]
>> 
>> What's the value of qom-type?  Remember, -object has "props" unwrapped
>> so that everything stays flat.
>> 
>> If foo is an array, qom-type is missing.
>> 
>> If foo is a string, then qom-type is zwei.  Except when bar is a string,
>> because then it gets overridden to drei.
>
> That's a strange syntax you've used for illustration there - a half
> way between json and nested-dotted syntax.

We're discussing section "=== Structured values ===" of my memo.  I
described the string vs. object/array ambiguity, Kevin suggested using
the QAPI schema as a solution, and I explained why it doesn't suffice.
You suggested we can have the necessary type information at run-time,
and I explained why that doesn't suffice, either, even if we assume QOM
is the only troublemaker here.

>                                            For pure json syntax it
> would be a clear if qom-type was missing at the top level.

That's section "== JSON ==".  No argument.

>                                                            for nested
> dotted syntax, it again seems clear to me - split on ',' and find the
> unqualified qom-type key (or the leading default arg)

That's section "=== Dotted keys ===".  No argument.
