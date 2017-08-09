Received: from eggs.gnu.org ([2001:4830:134:3::10]:38591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfNaJ-000328-Sv
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfNaF-0003G6-Od
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:47:27 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:55911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfNaF-0003D1-HQ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:47:23 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id F1C568BCC9
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 11:47:15 +0200 (CEST)
Date: Wed, 9 Aug 2017 11:47:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809114705.39dc0455@bahia.lan>
In-Reply-To: <20170809102737.18436fb4.cohuck@redhat.com>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_15auDsKsnWdJ9/xAVH8J8k";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/_15auDsKsnWdJ9/xAVH8J8k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 10:27:37 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 9 Aug 2017 10:23:04 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > On 09.08.2017 09:17, Cornelia Huck wrote: =20
> > > Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> > > on CONFIG_VIRTFS and on the presence of an appropriate virtio transpo=
rt
> > > device.
> > >=20
> > > Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
> > > CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).
> > >=20
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >=20
> > > Changes v1->v2: drop extraneous spaces, fix build on cris
> > >=20
> > > ---
> > >  default-configs/s390x-softmmu.mak | 1 +
> > >  fsdev/Makefile.objs               | 9 +++------
> > >  hw/Makefile.objs                  | 2 +-
> > >  3 files changed, 5 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390=
x-softmmu.mak
> > > index 51191b77df..e4c5236ceb 100644
> > > --- a/default-configs/s390x-softmmu.mak
> > > +++ b/default-configs/s390x-softmmu.mak
> > > @@ -8,3 +8,4 @@ CONFIG_S390_FLIC=3Dy
> > >  CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
> > >  CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
> > >  CONFIG_WDT_DIAG288=3Dy
> > > +CONFIG_VIRTIO_CCW=3Dy
> > > diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> > > index 659df6e187..3d157add31 100644
> > > --- a/fsdev/Makefile.objs
> > > +++ b/fsdev/Makefile.objs
> > > @@ -1,10 +1,7 @@
> > > -ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
> > >  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
> > > -# only pull in the actual virtio-9p device if we also enabled virtio.
> > > -common-obj-y =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> > > -else
> > > -common-obj-y =3D qemu-fsdev-dummy.o
> > > -endif
> > > +# only pull in the actual virtio-9p device if we also enabled a virt=
io backend.
> > > +common-obj-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_P=
CI),$(CONFIG_VIRTIO_CCW)))=3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> > > +common-obj-$(call lnot,$(call land,$(CONFIG_VIRTFS),$(call lor,$(CON=
FIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))) =3D qemu-fsdev-dummy.o
> > >  common-obj-y +=3D qemu-fsdev-opts.o qemu-fsdev-throttle.o
> > > =20
> > >  # Toplevel always builds this; targets without virtio will put it in
> > > diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> > > index a2c61f6b09..335f26b65e 100644
> > > --- a/hw/Makefile.objs
> > > +++ b/hw/Makefile.objs
> > > @@ -1,4 +1,4 @@
> > > -devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRT=
FS),$(CONFIG_PCI))) +=3D 9pfs/
> > > +devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO=
_PCI),$(CONFIG_VIRTIO_CCW))) +=3D 9pfs/
> > >  devices-dirs-$(CONFIG_SOFTMMU) +=3D acpi/
> > >  devices-dirs-$(CONFIG_SOFTMMU) +=3D adc/
> > >  devices-dirs-$(CONFIG_SOFTMMU) +=3D audio/   =20
> >=20
> > Patch should be fine now, I think...
> >=20
> > But thinking about this again, I wonder whether it would be enough to
> > simply check for CONFIG_VIRTIO=3Dy here instead. CONFIG_VIRTIO=3Dy shou=
ld be
> > sufficient to assert that there is also at least one kind of virtio
> > transport available, right?
> > Otherwise this will look really horrible as soon as somebody also tries
> > to add support for virtio-mmio here later ;-) =20
>=20

And virtio isn't the only transport for 9p: we also have a Xen backend,
which happen to be built because targets that support Xen also have
CONFIG_PCI I guess.

Cc'ing Stefano and Paolo who had a discussion during the review of
9p Xen backend patches:

https://patchwork.kernel.org/patch/9622325/

> Do all virtio transports have support for 9p, though? I thought it was
> only virtio-pci and virtio-ccw...

Hmm... I don't see any device-specific code in virtio-mmio.. why would it
be different for 9p than for block or net ?

--Sig_/_15auDsKsnWdJ9/xAVH8J8k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmK2hkACgkQAvw66wEB28KvSwCgkoAFfhFfJ9W6bRtDrJ+mgbTt
ED4AnR3DYoCvZ6mDjVxe8ajwzcBoxv7j
=3Q29
-----END PGP SIGNATURE-----

--Sig_/_15auDsKsnWdJ9/xAVH8J8k--
