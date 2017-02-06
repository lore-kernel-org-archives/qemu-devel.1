Received: from eggs.gnu.org ([2001:4830:134:3::10]:58684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1camEa-0002Sl-Bp
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1camEZ-0005LY-8D
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:33:44 -0500
Date: Mon, 6 Feb 2017 16:33:31 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206163331.GF31991@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Feb 06, 2017 at 04:36:50PM +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
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
> 
> Example: QOM properties and object-add, qom-set, qom-get
> 
> QOM properties are created at run-time.  They cannot be fixed at
> compile-time *by design*.  I always hated that part of the design, but I
> was assured we absolutely need that much rope^Wflexibility.
> 
> So, all we know about the "props" argument of object-add is that it's a
> JSON object.  The tightest imaginable QAPI schema would be an 'object'
> type, except that doesn't exist, so we settle for 'any'.

The CLI parser is executing at runtime though, so I would think
it should need to care if the schema its using to parse the CLI
args was defined at build time or execution time. It merely needs
the schema to be present at the time it parses the data.

So is there a way we dynamically report the info we need by improving
visitor support for QOM somehow.


> This isn't just a "can't decide between integer and string" problem,
> which Dan solved by auto-converting strings in the input visitor,
> i.e. by delaying some parsing of terminals.  It's a "can't even figure
> out the tree structure" problem.

Yep, my gross hack was because I was explicitly trying to avoid making
any changes to QemuOpts. I wanted to tokenize the string without knowing
anything about the schema, then convert to QDict, and then visit it to
create the object. Only the 3rd step had any kind of access to QOM type
information.

It feels like the gross hacks in this area could have been avoided if
I had been willing to sacrifice the layering to make schema info
available to the QemuOpts parser somehow. Then it could have dynamically
queried the QOM props to determine their expected types and parses the
opts accordingly.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
