Received: from eggs.gnu.org ([2001:4830:134:3::10]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZwPj-0004TQ-8G
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZwPf-0001Sn-Us
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:18:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZwPf-0001Rd-LC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:18:15 -0500
Date: Fri, 12 Jan 2018 10:18:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112101807.GE7356@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 11:32:56AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 23:23, Stefan Hajnoczi wrote:
> > On Thu, Jan 11, 2018 at 06:57:03PM +0800, Jason Wang wrote:
> > >=20
> > > On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 00:14, Stefan Hajnoczi wrote:
> > > > Hi Wei,
> > > > I wanted to summarize the differences between the vhost-pci and
> > > > virtio-vhost-user approaches because previous discussions may have =
been
> > > > confusing.
> > > >=20
> > > > vhost-pci defines a new virtio device type for each vhost device ty=
pe
> > > > (net, scsi, blk).  It therefore requires a virtio device driver for=
 each
> > > > device type inside the slave VM.
> > > >=20
> > > > Adding a new device type requires:
> > > > 1. Defining a new virtio device type in the VIRTIO specification.
> > > > 3. Implementing a new QEMU device model.
> > > > 2. Implementing a new virtio driver.
> > > >=20
> > > > virtio-vhost-user is a single virtio device that acts as a vhost-us=
er
> > > > protocol transport for any vhost device type.  It requires one virt=
io
> > > > driver inside the slave VM and device types are implemented using
> > > > existing vhost-user slave libraries (librte_vhost in DPDK and
> > > > libvhost-user in QEMU).
> > > >=20
> > > > Adding a new device type to virtio-vhost-user involves:
> > > > 1. Adding any new vhost-user protocol messages to the QEMU
> > > >      virtio-vhost-user device model.
> > > > 2. Adding any new vhost-user protocol messages to the vhost-user sl=
ave
> > > >      library.
> > > > 3. Implementing the new device slave.
> > > >=20
> > > > The simplest case is when no new vhost-user protocol messages are
> > > > required for the new device.  Then all that's needed for
> > > > virtio-vhost-user is a device slave implementation (#3).  That slave
> > > > implementation will also work with AF_UNIX because the vhost-user s=
lave
> > > > library hides the transport (AF_UNIX vs virtio-vhost-user).  Even
> > > > better, if another person has already implemented that device slave=
 to
> > > > use with AF_UNIX then no new code is needed for virtio-vhost-user
> > > > support at all!
> > > >=20
> > > > If you compare this to vhost-pci, it would be necessary to design a=
 new
> > > > virtio device, implement it in QEMU, and implement the virtio drive=
r.
> > > > Much of virtio driver is more or less the same thing as the vhost-u=
ser
> > > > device slave but it cannot be reused because the vhost-user protocol
> > > > isn't being used by the virtio device.  The result is a lot of
> > > > duplication in DPDK and other codebases that implement vhost-user
> > > > slaves.
> > > >=20
> > > > The way that vhost-pci is designed means that anyone wishing to sup=
port
> > > > a new device type has to become a virtio device designer.  They nee=
d to
> > > > map vhost-user protocol concepts to a new virtio device type.  This=
 will
> > > > be time-consuming for everyone involved (e.g. the developer, the VI=
RTIO
> > > > community, etc).
> > > >=20
> > > > The virtio-vhost-user approach stays at the vhost-user protocol lev=
el as
> > > > much as possible.  This way there are fewer concepts that need to be
> > > > mapped by people adding new device types.  As a result, it will all=
ow
> > > > virtio-vhost-user to keep up with AF_UNIX vhost-user and grow becau=
se
> > > > it's easier to work with.
> > > >=20
> > > > What do you think?
> > > >=20
> > > > Stefan
> > > So a question is what's the motivation here?
> > >=20
> > > Form what I'm understanding, vhost-pci tries to build a scalable V2V =
private
> > > datapath. But according to what you describe here, virito-vhost-user =
tries
> > > to make it possible to implement the device inside another VM. I unde=
rstand
> > > the goal of vhost-pci could be done on top, but it looks to me it wou=
ld then
> > > rather similar to the design of Xen driver domain. So I can not figur=
e out
> > > how it can be done in a high performance way.
> > vhost-pci and virtio-vhost-user both have the same goal.  They allow
> > a VM to implement a vhost device (net, scsi, blk, etc).
>=20
> Looks not, if I read the code correctly, vhost-pci has a device
> implementation in qemu, and in slave VM it only have a vhost-pci-net driv=
er.

You are right that the current "[PATCH v3 0/7] Vhost-pci for inter-VM
communication" does not reach this goal yet.  The patch series focusses
on a subset of vhost-user-net for poll mode drivers.

But the goal is to eventually let VMs implement any vhost device type.
Even if Wei, you, or I don't implement scsi, for example, someone else
should be able to do it based on vhost-pci or virtio-vhost-user.

Wei: Do you agree?

> > This allows
> > software defined network or storage appliances running inside a VM to
> > provide I/O services to other VMs.
>=20
> Well, I think we can do it even with the existed virtio or whatever other
> emulated device which should not be bounded to any specific kind of devic=
e.=C2=A0

Please explain the approach you have in mind.

> And what's more important, according to the kvm 2016 slides of vhost-pci,
> the motivation of vhost-pci is not building SDN but a chain of VNFs. So
> bypassing the central vswitch through a private VM2VM path does make sens=
e.
> (Though whether or not vhost-pci is the best choice is still questionable=
).

This is probably my fault.  Maybe my networking terminology is wrong.  I
consider "virtual network functions" to be part of "software-defined
networking" use cases.  I'm not implying there must be a central virtual
switch.

To rephrase: vhost-pci enables exitless VM2VM communication.

> >   To the other VMs the devices look
> > like regular virtio devices.
> >=20
> > I'm not sure I understand your reference to the Xen driver domain or
> > performance.
>=20
> So what proposed here is basically memory sharing and event notification
> through eventfd, this model have been used by Xen for many years through
> grant table and event channel. Xen use this to move the backend
> implementation from dom0 to a driver domain which has direct access to so=
me
> hardwares. Consider the case of network, it can then implement xen netback
> inside driver domain which can access hardware NIC directly.
>
> This makes sense for Xen and for performance since driver domain (backend)
> can access hardware directly and event was triggered through lower overhe=
ad
> hypercall (or it can do busypolling). But for virtio-vhost-user, unless y=
ou
> want SRIOV based solutions inside the slave VM, I believe we won't want to
> go back to Xen since the hardware virtualization can bring extra overhead=
s.

Okay, this point is about the NFV use case.  I can't answer that because
I'm not familiar with it.

Even if the NFV use case is not ideal for VMs, there are many other use
cases for VMs implementing vhost devices.  In the cloud the VM is the
first-class object that users can manage.  They do not have the ability
to run vhost-user processes on the host.  Therefore I/O appliances need
to be able to run as VMs and vhost-pci (or virtio-vhost-user) solve that
problem.

> >   Both vhost-pci and virtio-vhost-user work using shared
> > memory access to the guest RAM of the other VM.  Therefore they can poll
> > virtqueues and avoid vmexit.  They do also support cross-VM interrupts,
> > thanks to QEMU setting up irqfd/ioeventfd appropriately on the host.
> >=20
> > Stefan
>=20
> So in conclusion, consider the complexity, I would suggest to figure out
> whether or not this (either vhost-pci or virito-vhost-user) is really
> required before moving ahead. E.g, for VM2VM direct network path, this lo=
oks
> simply an issue of network topology instead of the problem of device, so
> there's a lot of trick, for vhost-user one can easily image to write an
> application (or use testpmd) to build a zerocopied VM2VM datapath, isn't
> this not sufficient for the case?

See above, I described the general cloud I/O appliance use case.

Stefan

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWItfAAoJEJykq7OBq3PIvo4H/11EF3+VfvHPa5YH3yaMMNe4
LeL+DZFRTCQ7ALsZaTkONjYrU2P0ryXvvnCaCHSRvakYgrnpHuilwYKUF/xYzZ7v
hnt3klNkzUQiiluESs6knZneA0YawsAxA2BSefdtSxL2TdG33Bt5ALQT8oHBzDDk
EU5S0WCgH6KehChAKdaJBYyJRk8MDg9kNHuLShkWXntEcs8ue4S2+7bZQwukk/1u
888inHUSj1F3iSaX18N/YYBRE9XPGi3L23IRBpvAv1My2m+NMK/DtcjHU5ETGkW4
q32zfNT0Z88kZay9cYKhEY5wWemXtCFw8ImUb4BDuFIU2Tl5h++rqCNC9fqDGGE=
=+WHL
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
