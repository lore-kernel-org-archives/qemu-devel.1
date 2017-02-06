Received: from eggs.gnu.org ([2001:4830:134:3::10]:43187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1can23-0007kM-JQ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1can22-00036p-Bx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:24:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
	<20170206163331.GF31991@redhat.com>
Date: Mon, 06 Feb 2017 18:24:42 +0100
In-Reply-To: <20170206163331.GF31991@redhat.com> (Daniel P. Berrange's message
	of "Mon, 6 Feb 2017 16:33:31 +0000")
Message-ID: <87d1evi65h.fsf@dusky.pond.sub.org>
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

> On Mon, Feb 06, 2017 at 04:36:50PM +0100, Markus Armbruster wrote:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > Want to make use of the shiny new QemuOpts and get things parsed into
>> > a nested object? Well, provide a real schema instead of "any" then.
>> 
>> Sadly, this is somewhere between impractical and impossible.
>> 
>> The QAPI schema is fixed at compile-time.  It needs to be, because its
>> purpose is to let us generate code we can compile and link into QEMU.
>> 
>> We use 'any' basically for things that aren't fixed at compile-time.
>> 
>> Example: qdev properties and device_add
>> 
>> Even though traditional qdev properties are fixed at compile time, they
>> are not known until run-time.  That's because they're defined in the
>> device models, and the registry of device models is only built at
>> run-time.
>> 
>> I believe this would've been fixable with some effort: make the devices
>> define suitable pieces of schema, and collect them somehow at
>> compile-time.  "Would've been", because progress!  See next example.
>> 
>> Example: QOM properties and object-add, qom-set, qom-get
>> 
>> QOM properties are created at run-time.  They cannot be fixed at
>> compile-time *by design*.  I always hated that part of the design, but I
>> was assured we absolutely need that much rope^Wflexibility.
>> 
>> So, all we know about the "props" argument of object-add is that it's a
>> JSON object.  The tightest imaginable QAPI schema would be an 'object'
>> type, except that doesn't exist, so we settle for 'any'.
>
> The CLI parser is executing at runtime though, so I would think
> it should need to care if the schema its using to parse the CLI
> args was defined at build time or execution time. It merely needs
> the schema to be present at the time it parses the data.

Whatever "the schema" is, it can't be the QAPI schema, and it can't be
used by generating code (which is how the visitors use the QAPI schema).

Let's assume for the moment that QOM is the only source of schema stuff
that becomes known only at run-time.  Then "the schema" is an
amalgamation of the QAPI schema and QOM reflection.  I say "reflection",
not "schema", because there is no QOM schema, only ways to examine (the
current structure of) QOM objects.

> So is there a way we dynamically report the info we need by improving
> visitor support for QOM somehow.

To parse the argument of -object, we need to create a QOM object of the
type given by qom-type, so we can examine it to find its properties and
their types.

Consider

    -object foo=[eins,qom-type=zwei,bar={x=y,qom-type=drei,baz=}]

What's the value of qom-type?  Remember, -object has "props" unwrapped
so that everything stays flat.

If foo is an array, qom-type is missing.

If foo is a string, then qom-type is zwei.  Except when bar is a string,
because then it gets overridden to drei.

This way is madness.

Want still more?  Okay.  What if setting a property adds, deletes or
modifies other properties?  Or some other stimulus beyond our control
does?  Obviously not possible while we create a new object (which nobody
else can find just yet), but my point is that in the fully general case,
QOM reflection comes with TOCTTOU traps.

>> This isn't just a "can't decide between integer and string" problem,
>> which Dan solved by auto-converting strings in the input visitor,
>> i.e. by delaying some parsing of terminals.  It's a "can't even figure
>> out the tree structure" problem.
>
> Yep, my gross hack was because I was explicitly trying to avoid making
> any changes to QemuOpts. I wanted to tokenize the string without knowing
> anything about the schema, then convert to QDict, and then visit it to
> create the object. Only the 3rd step had any kind of access to QOM type
> information.

Exactly.

> It feels like the gross hacks in this area could have been avoided if
> I had been willing to sacrifice the layering to make schema info
> available to the QemuOpts parser somehow.

We briefly discussed an alternative design that can use the *QAPI*
schema to direct the parse: an input visitor that parses
KEY=VALUE,... straight into a QAPI object.

>                                           Then it could have dynamically
> queried the QOM props to determine their expected types and parses the
> opts accordingly.

Won't do, I'm afraid.
