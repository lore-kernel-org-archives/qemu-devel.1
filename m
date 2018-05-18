Received: from eggs.gnu.org ([2001:4830:134:3::10]:40644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJjO2-0003Bz-JW
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJjO1-0001EL-0F
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:41:50 -0400
Date: Fri, 18 May 2018 14:41:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180518174133.GC25013@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518170956.GI8615@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, May 18, 2018 at 06:09:56PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, May 18, 2018 at 06:30:38PM +0300, Michael S. Tsirkin wrote:
> > Hi!
> > Right now, QEMU supports multiple machine types within
> > a given architecture. This was the case for many architectures
> > (like ARM) for a while, somewhat more recently this is the case
> > for x86 with I440FX and Q35 options.
> >=20
> > Unfortunately this means that it's no longer possible
> > to more or less reliably boot a VM just given a disk image,
> > even if you select the correct QEMU binary:
> > you must supply the correct machine type.
>=20
> You must /sometimes/ supply the correct machine type.
>=20
> It is quite dependent on the guest OS you have installed, and even
> just how the guest OS is configured.  In general Linux is very
> flexible and can adapt to a wide range of hardware, automatically
> detecting things as needed. It is possible for a sysadmin to build
> a Linux image in a way that would only work with I440FX, but I
> don't think it would be common to see that. Many distros build
> and distribute disk images that can work across VMWare, KVM,
> and VirtualBox which all have very quite different hardware.
> Non-x86 archs may be more fussy but I don't have personal
> experiance with them
>=20
> Windows is probably where things get more tricky, as it is not
> happy with disks moving between different controller types
> for example, and you might trigger license activation again.

All I'm suggesting here is just adding extra hints that OpenStack
can use.

I have very specific goal here: the goal is to make it less
painful to users when OpenStack+libvirt+QEMU switch to using a
different machine-type by default (q35), and/or when guest OSes
stop supporting pc-i440fx.  I assume this is a goal for OpenStack
as well.

We can make the solution to be more extensible and solve other
problems as well, but my original goal is the one above.

>=20
>=20
> > Some guests go even further and require specific devices to be presen=
t.
> >=20
> > Would it be reasonable to support storing this information in the qco=
w
> > image itself?  For example, I can see it following immediately the
> > backing file path within the image.
>=20
> The backing file string needs to go in space between the end of headers
> and start of first cluster, and the spec explicitly says nothing else
> must be stored there. Also we can already hit the length limit on the
> backing file.
>=20
> There would need to be an explicit header extension defined with its
> own clusters allocated instead.

This sounds correct.


>=20
> That said I'm not really convinced that using the qcow2 headers is
> a good plan. We have many disk image formats in common use, qcow2
> is just one. Even if the user provides the image in qcow2 format,
> that doesn't mean that mgmt apps actually store the qcow2 file.
>=20

Why this OpenStack implementation detail matters?  Once the hints
are included in the input, it's up to OpenStack to choose how to
deal with it.


> For example in some deployments OpenStack will immediately
> convert the image to raw for storage in an RBD volume as it is
> uploaded to Glance. So the glance image store would need to
> have a way to extract & save the info at time of upload. OpenStack
> targets multiple hypervisors though, so I'm not sure they would
> welcome something that is specific to just qcow2 in this area.
>=20

I don't get the "something that is specific to just qcow2" part.
Adding extra info to qcow2 doesn't prevent other file formats
from carrying the same information as well.


> The closest to a cross-hypervisor standard is OVF which can store
> metadata about required hardware for a VM. I'm pretty sure it does
> not have the concept of machine types, but maybe it has a way for
> people to define metadata extensions. Since it is just XML at the
> end of the day, even if there was nothing official in OVF, it would
> be possible to just define a custom XML namespace and declare a
> schema for that to follow.

There's nothing preventing OVF from supporting the same kind of
hints.

I just don't think we should require people to migrate to OVF if
all they need is to tell OpenStack what's the recommended
machine-type for a guest image.

Requiring a different image format seems very likely to not
fulfill the goal I stated above: it will require using different
tools to create the guest images, and we can't force everybody
publishing guest images to stop using qcow2.

>=20
>=20
> > As Eduardo pointed out off-list, the format could be a set of key-val=
ue
> > pairs. Initially qemu-img could gain ability to retrieve and manipula=
te
> > these. Down the road we could teach qemu to use them automatically.
> > We could also thinkably warn the user, or drop the image from the boo=
t
> > order.
> >=20
> > Reasonable (IMO) things we could store in such a section:
> > - qemu architecture to use with the image
> > - machine type
>=20
> A concern is about what you actually put here. We could easily create a
> situation where we make images /less/ portable. eg take a Linux image
> which is capable of running on both i440fx and q35, if that was built
> on i44fx and that gets recorded, a mgmt app which honours this info
> is needless restricting how the image can be run.

That's why it should be just a hint, not a requirement.

>=20
> Or consider that LTS distros typically create custom machine types,
> so you can have a image with machine type  pc-rhel-7.4.0 which is
> now unable to be used on an Ubuntu distro which lacks the RHEL
> machine types.

That's why recording the machine-type family is more useful than
recording the full versioned machine-type name.

>=20
> IOW, there's a distinction between what's recommended, vs what's
> required, vs what's forbidden. Whitelisting valid machine types
> is too restrictive, but blacklisting is not broad enough.
>=20
> > more possibilities:
> > - required cpu flags
>=20
> Again this is not so black & white - there's a distinction between
> what is absolutely required vs what is merely recommended
>=20
> > - expected frontend devices
> > - kernel flags for device tree based guests
> >=20
> > Security considerations
> > - If there is a machine type specific security issue,
> >   this makes it easier to trick user to hitting it.
> >   Not sure how common this is.
>=20
> This would imply setting very specific versioned machine type
> choice, but that kills any kind of platform portability.

True.

>=20
> > - We most likely shouldn't get backend parameters from the image
> >=20
> > Thoughts?
>=20
> I tend to think we'd be better looking at what we can do in the context
> of an existing standard like OVF rather than inventing something that
> only works with qcow2. I think it would need to be more expressive than
> just a single list of key,value pairs for each item.

Why you claim we are inventing something that only works with
qcow2?

About being more expressive than just a single list of key,value
pairs, I don't see any evidence of that being necessary for the
problems we're trying to address.

--=20
Eduardo
