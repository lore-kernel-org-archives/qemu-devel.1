Received: from eggs.gnu.org ([2001:4830:134:3::10]:50749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKrGH-0001bo-22
	for qemu-devel@nongnu.org; Mon, 21 May 2018 16:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKrGF-0006sM-Kv
	for qemu-devel@nongnu.org; Mon, 21 May 2018 16:18:29 -0400
Date: Mon, 21 May 2018 21:18:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180521201817.GA10382@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518174133.GC25013@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, May 18, 2018 at 02:41:33PM -0300, Eduardo Habkost wrote:
> On Fri, May 18, 2018 at 06:09:56PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, May 18, 2018 at 06:30:38PM +0300, Michael S. Tsirkin wrote:
> > > Hi!
> > > Right now, QEMU supports multiple machine types within
> > > a given architecture. This was the case for many architectures
> > > (like ARM) for a while, somewhat more recently this is the case
> > > for x86 with I440FX and Q35 options.
> > >=20
> > > Unfortunately this means that it's no longer possible
> > > to more or less reliably boot a VM just given a disk image,
> > > even if you select the correct QEMU binary:
> > > you must supply the correct machine type.
> >=20
> > You must /sometimes/ supply the correct machine type.
> >=20
> > It is quite dependent on the guest OS you have installed, and even
> > just how the guest OS is configured.  In general Linux is very
> > flexible and can adapt to a wide range of hardware, automatically
> > detecting things as needed. It is possible for a sysadmin to build
> > a Linux image in a way that would only work with I440FX, but I
> > don't think it would be common to see that. Many distros build
> > and distribute disk images that can work across VMWare, KVM,
> > and VirtualBox which all have very quite different hardware.
> > Non-x86 archs may be more fussy but I don't have personal
> > experiance with them
> >=20
> > Windows is probably where things get more tricky, as it is not
> > happy with disks moving between different controller types
> > for example, and you might trigger license activation again.
>=20
> All I'm suggesting here is just adding extra hints that OpenStack
> can use.
>=20
> I have very specific goal here: the goal is to make it less
> painful to users when OpenStack+libvirt+QEMU switch to using a
> different machine-type by default (q35), and/or when guest OSes
> stop supporting pc-i440fx.  I assume this is a goal for OpenStack
> as well.
>=20
> We can make the solution to be more extensible and solve other
> problems as well, but my original goal is the one above.

Configuring the machine type is just one thing that users
would do with OpenStack though.  A simple example might be

    openstack image set \
         --property hw_disk_bus=3Dscsi \
	 --property hw_vif_model=3De1000e

Or if they're using libosinfo to set preferred devices=20

    openstack image set \
         --property os_distro=3Dfedora26

which will identify virtio-blk & virtio-net as disk+nic
respectively. Using libosinfo is more flexible than setting
the hw_disk_bus & hw_vif_model  explicitly, because libosinfo
will report multiple devices that can be used, and the virt
driver can then pick one which best suits the particular
host or hypervisor.

Setting a non-default machine type is one extra prop

    openstack image set \
         --property hw_machine_type=3Dq35
         --property os_distro=3Dfedora26

So while your immediate motivation is only considering the
machine type, from the Openstack POV thats only one property
out of many that users might be setting.


> > That said I'm not really convinced that using the qcow2 headers is
> > a good plan. We have many disk image formats in common use, qcow2
> > is just one. Even if the user provides the image in qcow2 format,
> > that doesn't mean that mgmt apps actually store the qcow2 file.
> >=20
>=20
> Why this OpenStack implementation detail matters?  Once the hints
> are included in the input, it's up to OpenStack to choose how to
> deal with it.

Well openstack aims to support multiple hypervisors - if there's a
choice between implementing something that is a cross-vendor standard
like OVF, or implementing something that only works with qcow2, the
latter is not very appealing to support.

> > The closest to a cross-hypervisor standard is OVF which can store
> > metadata about required hardware for a VM. I'm pretty sure it does
> > not have the concept of machine types, but maybe it has a way for
> > people to define metadata extensions. Since it is just XML at the
> > end of the day, even if there was nothing official in OVF, it would
> > be possible to just define a custom XML namespace and declare a
> > schema for that to follow.
>=20
> There's nothing preventing OVF from supporting the same kind of
> hints.
>=20
> I just don't think we should require people to migrate to OVF if
> all they need is to tell OpenStack what's the recommended
> machine-type for a guest image.
>=20
> Requiring a different image format seems very likely to not
> fulfill the goal I stated above: it will require using different
> tools to create the guest images, and we can't force everybody
> publishing guest images to stop using qcow2.

It doesn't have to require different tools - existing tools could
create a OVF/OVA file for the disk image as part of an "export"
process.


> > > - We most likely shouldn't get backend parameters from the image
> > >=20
> > > Thoughts?
> >=20
> > I tend to think we'd be better looking at what we can do in the conte=
xt
> > of an existing standard like OVF rather than inventing something that
> > only works with qcow2. I think it would need to be more expressive th=
an
> > just a single list of key,value pairs for each item.
>=20
> Why you claim we are inventing something that only works with
> qcow2?

It works with a disk image format that has ability to record extra
metadata. With raw files you would have to have a separate file to
record it, likewise for any other vendor disk formats that are
not extended.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
