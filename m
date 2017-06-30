Received: from eggs.gnu.org ([2001:4830:134:3::10]:34855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dQpuL-0006rz-Sq
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dQpuI-0007Ku-Qk
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:00:01 -0400
Message-ID: <1498805986.4282.5.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 30 Jun 2017 08:59:46 +0200
In-Reply-To: <149876999083.10485.13933378544182209124@loki>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<804c9b1a-6803-e920-9d3d-60fc33dd2fea@redhat.com>
	<149876999083.10485.13933378544182209124@loki>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] hotplug: fix premature rebinding
 of VFIO devices to host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Laine Stump <laine@redhat.com>, libvir-list@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, pkrempa@redhat.com, berrange@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

On Thu, 2017-06-29 at 15:59 -0500, Michael Roth wrote:
> > > Patches 1-4 address 1) by deferring rebinding of a hostdev to the h=
ost driver
> > > until all the devices in the group have been detached, at which poi=
nt all
> > > the hostdevs are rebound as a group. Until that point, the devices =
are traced
> > > by the drvManager's inactiveList in a similar manner to hostdevs th=
at are
> > > assigned to VFIO via the nodedev-detach interface.
> >=C2=A0
> > What happens if libvirtd is restarted during this period? Is the
> > inactiveList rebuilt with all the info necessary to assure that the
> > nodedev-reattach does/doesn't happen (as appropriate) for all devices=
?
>=C2=A0
> Hmm, good question.
>=C2=A0
> The Unbindable() check only needs to know that nothing in the activeLis=
t
> belongs to the group we're checking, and that list at least seems to ge=
t
> rebuilt appropriately on restart.
>=C2=A0
> But the Unbind() relies on inactiveList and the behavior there is what
> nodedev-detach currently does, which is to add it to inactive list whil=
e
> libvirtd is running, and then just forget about it when libvirtd restar=
ts.
> For nodedev-detach it's fine since virHostdevPreparePCIDevices() re-add=
s
> it as needed in the device-attach path. But yah, for this purpose it en=
ds
> up losing track of hostdevs that are still pending rebind to the host, =
and
> that means some devices may not get rebound at the appropriate time if
> there was a libvirtd restart.
>=C2=A0
> Unlike with device-attach, we can't just re-add it on-demand because we
> actually need to know whether or not it was previously in the list. So
> I think we'd need to add some persistent state to track this. Will look
> into adding handling for that.

FWIW last time a tried to attack this issue[1] I got pretty
much as far as this, eg. the code worked as intended but
restarting libvirtd would result in an inconsistent state
which prevented you from performing some operations.

Unfortunately I got sidetracked by other work and stopped
just short of implementing a way to persist the relevant
information on disk :(


[1] ~1.5 years ago, according to git log
--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
