Received: from eggs.gnu.org ([2001:4830:134:3::10]:49034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQJyT-000785-9b
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQJyS-0002ke-CA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:58:41 -0400
Date: Tue, 5 Jun 2018 23:58:30 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180605235830.4905ee97@kitsune.suse.cz>
In-Reply-To: <874liycoto.fsf@dusky.pond.sub.org>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
	<87bmdc18q5.fsf@dusky.pond.sub.org>
	<20180521182928.GO25013@localhost.localdomain>
	<20180521184440.GB8214@redhat.com>
	<20180521190112.GP25013@localhost.localdomain>
	<87o9h6hb59.fsf@dusky.pond.sub.org>
	<20180523121344.GB8988@localhost.localdomain>
	<874liycoto.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Wed, 23 May 2018 18:35:31 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Wed, May 23, 2018 at 01:19:46PM +0200, Markus Armbruster wrote: =20
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>  =20
> >> > On Mon, May 21, 2018 at 07:44:40PM +0100, Daniel P. Berrang=C3=A9
> >> > wrote: =20
> >> >> On Mon, May 21, 2018 at 03:29:28PM -0300, Eduardo Habkost
> >> >> wrote: =20
> >> >> > On Sat, May 19, 2018 at 08:05:06AM +0200, Markus Armbruster
> >> >> > wrote: =20
... =20
> >> >> > The point here is to allow users to simply copy an existing
> >> >> > disk image, and it will contain enough hints for a cloud
> >> >> > stack to choose reasonable defaults for machine-type and disk
> >> >> > type automatically.  Requiring the user to perform a separate
> >> >> > step to encapsulate the disk image in another file format
> >> >> > defeats the whole purpose of the proposal. =20
> >> >>=20
> >> >> It doesn't have to mean more work for the user - the application
> >> >> that is used to create the image can do that on their behalf.
> >> >> oVirt for example can import/export OVA files, containing OVF
> >> >> metadata. I could imagine virt-manager, and other tools adding
> >> >> export ability without much trouble if this was deemed a
> >> >> desirable thing. Bundling gives ability to have multiple disk
> >> >> images in one archive, which is something OVF does. =20
> >> >
> >> > I have the impression that "the application that is used to
> >> > create the image" is a very large set.  It can be virt-manager,
> >> > virt-install, virt-manager, or even QEMU itself.
> >> >
> >> > Today people can simply create a VM on virt-manager, or run QEMU
> >> > manually, and upload the qcow2 image directly from its original
> >> > location (they don't need to copy/export it).  Don't we want the
> >> > same procedure to keep working instead of requiring users to use
> >> > another tool? =20
> >>=20
...
> >> With OVF, you solve the problem further up the stack: you do
> >> virtual appliances instead of disk images.
> >>  =20
> >
> > I guess the main problem is that people are already using disk
> > images as if they were virtual appliances.
> >
> > We can tell people to stop doing that and use OVF, but then we
> > won't make anybody's life any easier: publishers of images might
> > need to generate both qcow2 and OVF images if they want it to
> > work with older hosts; consumers will need to find out if they
> > need qcow2 or OVF. =20
>=20
> I'm afraid providing for "hints" in QCOW2 could only add problems.  To
> pick the right hints, publishers need to predict how future software
> consuming the image will interpret them.  Consumers may have to
> configure their software to interpret hints in various ways.

That depends on the hint.

If you define that the key libvirt-xml contains the libvirt machine
definition it is up to libvirt to define what exactly the hint contains.

It allows exporting a machine from virt-manager or virsh and importing
into same with exact same properties. Looking at it will probably give
you some idea how to configure the VM in another virtualization
solution.

Similarly OpenStack can define different hint for OpenStack VMs.=20

You are free to equip you appliance with multiple hints if you want it
to work it on multiple virtualization solutions. It is much more
efficient than providing multiple appliance images that embed the
same disk image and different metadata. Virtualization solutions are
free to implement conversions to ease importing VMs from different
source, even for something as horrible as OVF.

It is a bit limiting, though.

You cannot make an applicance with multiple disks when the metadata is
embedded in a disk image.

Thanks

Michal
