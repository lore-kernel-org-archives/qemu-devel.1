Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLSeY-00063P-L0
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLSeX-0007Di-BB
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:14:02 -0400
Date: Wed, 23 May 2018 09:13:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180523121344.GB8988@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
	<87bmdc18q5.fsf@dusky.pond.sub.org>
	<20180521182928.GO25013@localhost.localdomain>
	<20180521184440.GB8214@redhat.com>
	<20180521190112.GP25013@localhost.localdomain>
	<87o9h6hb59.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o9h6hb59.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Wed, May 23, 2018 at 01:19:46PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Mon, May 21, 2018 at 07:44:40PM +0100, Daniel P. Berrang=E9 wrote:
> >> On Mon, May 21, 2018 at 03:29:28PM -0300, Eduardo Habkost wrote:
> >> > On Sat, May 19, 2018 at 08:05:06AM +0200, Markus Armbruster wrote:
> >> > > Eduardo Habkost <ehabkost@redhat.com> writes:
> >> > >=20
> >> > > [...]
> >> > > > About being more expressive than just a single list of key,val=
ue
> >> > > > pairs, I don't see any evidence of that being necessary for th=
e
> >> > > > problems we're trying to address.
> >> > >=20
> >> > > Short history of a configuration format you might have encounter=
ed:
> >>=20
> >> [snip]
> >>=20
> >> > > How confident are we a single list of (key, value) is really all=
 we're
> >> > > going to need?
> >> > >=20
> >> > > Even if we think it is, would it be possible to provide for a fu=
ture
> >> > > extension to trees at next to no cost?
> >> >=20
> >> > I'm confident that a list of key,values is all we need for the
> >> > current problem.
> >>=20
> >> I'm not convinced. A disk image may work with Q35 or i440fx,  or
> >> work with any of virtio, ide or sata disk. So that already means
> >> values have to be arrays, not scalars. You could do that with a
> >> simple key,value list, but only by defining a mapping of arrays
> >> into a flattened form. eg do we allow repeated keys, or do we
> >> allow array indexes on keys.=20
> >
> > No problem, we can support trees if it's necessary.
> >
> >
> >> > The point here is to allow users to simply copy an existing disk
> >> > image, and it will contain enough hints for a cloud stack to
> >> > choose reasonable defaults for machine-type and disk type
> >> > automatically.  Requiring the user to perform a separate step to
> >> > encapsulate the disk image in another file format defeats the
> >> > whole purpose of the proposal.
> >>=20
> >> It doesn't have to mean more work for the user - the application
> >> that is used to create the image can do that on their behalf.
> >> oVirt for example can import/export OVA files, containing OVF
> >> metadata. I could imagine virt-manager, and other tools adding
> >> export ability without much trouble if this was deemed a desirable
> >> thing. Bundling gives ability to have multiple disk images in one
> >> archive, which is something OVF does.
> >
> > I have the impression that "the application that is used to
> > create the image" is a very large set.  It can be virt-manager,
> > virt-install, virt-manager, or even QEMU itself.
> >
> > Today people can simply create a VM on virt-manager, or run QEMU
> > manually, and upload the qcow2 image directly from its original
> > location (they don't need to copy/export it).  Don't we want the
> > same procedure to keep working instead of requiring users to use
> > another tool?
>=20
> Today, I can take the disk out of my old computer, put it into my new
> computer, and it just works.  Don't we want the same procedure to keep
> working forever?

I don't think the comparison is fair: downloading hard disk
images for bare metal hardware is not as common as downloading
guest disk images for cloud infrastructure.

>=20
> Sadly, wanting something badly enough doesn't make actual solutions any
> easier :)

This part is true.  :)

>=20
> My point is: disk images (real or virtual) keep working in different
> hardware contexts by a mixture of flexibility built into system softwar=
e
> on the image, disciplined evolution of hardware (real or virtual), and
> dumb luck.  It works until it doesn't.  And then you get to tinker.

Personally, I believe that tools for running and managing virtual
hardware can and should be smarter than real hardware.

>=20
> With OVF, you solve the problem further up the stack: you do virtual
> appliances instead of disk images.
>=20

I guess the main problem is that people are already using disk
images as if they were virtual appliances.

We can tell people to stop doing that and use OVF, but then we
won't make anybody's life any easier: publishers of images might
need to generate both qcow2 and OVF images if they want it to
work with older hosts; consumers will need to find out if they
need qcow2 or OVF.

But I work too deep down the stack to tell if it's really
important to avoid these problems or not.  And as you said, this
doesn't make actual solutions any easier.


> How much space that leaves for useful solutions at the level of QEMU I
> can't say.

I have no doubt about "useful", but I'm not sure about
"important".

I guess the question is if we have people with time and resources
to work on solutions (whether using qcow2 or OVF).

--=20
Eduardo
