Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cb22e-0002Jr-25
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cb22c-0005TA-Pb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:26:28 -0500
Date: Tue, 7 Feb 2017 10:26:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170207092615.GA4760@noname.redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877f53l4a5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 06.02.2017 um 16:36 hat Markus Armbruster geschrieben:
> >> === Structured values ===
> >> 
> >> The dotted key convention messes with KEY syntax to permit structured
> >> values.  Works, but the more conventional way to support structured
> >> values is a syntax for structured values.  
> >> 
> >> An obvious one is to use { KEY=VALUE, ...} for objects, and [ VALUE,
> >> ... ] for arrays.  Looks like this:
> >> 
> >>     -drive 'driver=quorum,
> >>             child=[{ driver=file, filename=disk1.img },
> >>                    { driver=host_device, filename=/dev/sdb },
> >>                    { driver=nbd, host=localhost } ]'
> >> 
> >> Again, lines broken and indented for legibility; you need to join them
> >> for actual use.
> >
> > This looks more like what you really want to use. However, being able to
> > write a={b=x,c=y} for a.b=x,a.c=y is really just syntactic sugar and
> > could be a second step after we got the basics working.
> >
> > Note that treating it simply as syntactic sugar for the expanded dotted
> > form would also allow mixing (and I think that's a good thing):
> >
> >     -drive 'driver=qcow2,
> >             backing.file.filename=backing.qcow2,
> >             file={driver=file, filename=overlay.qcow2, aio=native}'
> >
> > Or even add to a previously defined thing, which should make Max happy
> > when he forgot a nested option at first:
> >
> >     -drive 'driver=qcow2,
> >             file={driver=nbd,host=localhost},
> >             lazy-refcounts=on,
> >             file.port=1234'
> >
> >> There's a syntactic catch, though: a value of the form [ ... ] can
> >> either be an array or a string.  Which one it is depends on the type of
> >> the key.  To parse this syntax, you need to know the types, unlike JSON
> >> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or
> >> '[', which feels impractical.
> >
> > We would have to look at the schema and only treat it as a nested object
> > or an array if the expected type has one there.
> >
> > Your other mail says that even this doesn't work because of "any" types,
> > but I don't think this is a real problem: In that case, you simply use
> > the type that we always used, i.e. string. That's the fully backwards
> > compatible way.
> >
> > Want to make use of the shiny new QemuOpts and get things parsed into
> > a nested object? Well, provide a real schema instead of "any" then.
> 
> Sadly, this is somewhere between impractical and impossible.
> 
> The QAPI schema is fixed at compile-time.  It needs to be, because its
> purpose is to let us generate code we can compile and link into QEMU.
> 
> We use 'any' basically for things that aren't fixed at compile-time.
> 
> Example: qdev properties and device_add
> 
> Even though traditional qdev properties are fixed at compile time, they
> are not known until run-time.  That's because they're defined in the
> device models, and the registry of device models is only built at
> run-time.
> 
> I believe this would've been fixable with some effort: make the devices
> define suitable pieces of schema, and collect them somehow at
> compile-time.  "Would've been", because progress!  See next example.

I think we might still be able to get there for -device. You won't be
able to set all QOM properties that could ever pop up during the life of
a device, but with -device I think you can't anyway, but just the good
old qdev properties.

Having a schema and generating all of the QOM boilerplate automatically
from it would probably be nice anyway.

> Example: QOM properties and object-add, qom-set, qom-get
> 
> QOM properties are created at run-time.  They cannot be fixed at
> compile-time *by design*.  I always hated that part of the design, but I
> was assured we absolutely need that much rope^Wflexibility.
> 
> So, all we know about the "props" argument of object-add is that it's a
> JSON object.  The tightest imaginable QAPI schema would be an 'object'
> type, except that doesn't exist, so we settle for 'any'.
> 
> -object unwraps "props" to get a flat QemuOpts, but let's ignore that
> and pretend we'd want to parse -object qom-type=T,id=ID,props=...
> 
> If we made "props" an 'object' in the schema, we'd know we need to parse
> the right hand side of props={foo=[bar]} as object, not as string.  We'd
> still not know (and cannot know at compile-time) whether to parse [bar]
> as array or as string.
> 
> But it gets worse.  Consider
> 
>     props={foo=[bar,baz=]}
> 
> If foo turns out to an array of string, we need to parse this like JSON
> 
>     { "foo": [ "bar", "baz=" ] }
> 
> But if it's of string type, we need to parse it like JSON
> 
>     { "foo": "[bar", "baz": ... }
> 
> This isn't just a "can't decide between integer and string" problem,
> which Dan solved by auto-converting strings in the input visitor,
> i.e. by delaying some parsing of terminals.  It's a "can't even figure
> out the tree structure" problem.
> 
> I'm afraid there's no way to make this syntax work without requiring
> some kind of quotes for at least "funny" strings.  Which makes me go
> "okay, what's the advantage over plain JSON again?"

Then don't make it work. As I said above:

> > Want to make use of the shiny new QemuOpts and get things parsed into
> > a nested object? Well, provide a real schema instead of "any" then.

So if you can't provide a real schema for a specific (sub)option, the
syntactic sugar simply doesn't work for this option and you get to use
longwinded explicit dotted keys. Not really a disaster either.

Now I see that this brings in some inconsistency, because the short
syntax would work for things like -blockdev (which is probably the
heaviest user of nesting) or -netdev, it might be possible to make it
work for -device, but it won't work for -object.

So there's a tradeoff between convenience and consistency here. You
could argue that having a more convenient way to specify things for
almost all options is nice and we definitely want it; or you could argue
that for consistency's sake the one remaining option means that we
shouldn't provide the convenient way anywhere.

Kevin
