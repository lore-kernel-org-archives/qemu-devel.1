Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df5Iq-0007aD-LM
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df5Il-0003iV-M1
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:16:12 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:47440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1df5Il-0003h7-CU
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:16:07 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id D0498870E6
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:16:05 +0200 (CEST)
Date: Tue, 8 Aug 2017 16:15:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170808161559.3f623c89@bahia.lan>
In-Reply-To: <20170808145000.3259f597@bahia.lan>
References: <20170808121701.18353-1-cohuck@redhat.com>
	<20170808121701.18353-2-cohuck@redhat.com>
	<20170808145000.3259f597@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oTx9bixkkO6urrMTlvetUpD";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/1] 9pfs: fix and simplify dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com, aneesh.kumar@linux.vnet.ibm.com, agraf@suse.de

--Sig_/oTx9bixkkO6urrMTlvetUpD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Aug 2017 14:50:00 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue,  8 Aug 2017 14:17:01 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > We want to compile the 9pfs code iff virtfs is enabled and a virtio
> > transport is available (not only pci!).
> >=20
> > Let's make the generated CONFIG_VIRTFS statement depend on either
> > CONFIG_VIRTIO_PCI or (new) CONFIG_VIRTIO_CCW. The Makefiles for fsdev/
> > and hw/9pfs/ can then depend on CONFIG_VIRTFS directly.
> >=20
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > --- =20
>=20
> It looks good to me.
>=20

Oops, reading Thomas's other mail, I now realize that with this patch we
end up with the following in config-host.mak:

CONFIG_VIRTFS=3D$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))

which looks wrong even if it may "work"... but we also get the
following in config-host.h:

#define CONFIG_VIRTFS $(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))

which is clearly wrong.

Maybe post the changes from your other mail instead ?

Message-ID: <20170808111542.16422571@gondolin>

The patch isn't that ugly, given the ugliness of the current makefiles :)

And we can come up with some cleanup patch later.

> Acked-by: Greg Kurz <groug@kaod.org>
>=20

NAcked-by: in fact :)

> >  configure                         | 2 +-
> >  default-configs/s390x-softmmu.mak | 1 +
> >  fsdev/Makefile.objs               | 2 +-
> >  hw/Makefile.objs                  | 2 +-
> >  4 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/configure b/configure
> > index dd73cce62f..709884dff1 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5771,7 +5771,7 @@ if test "$libattr" =3D "yes" ; then
> >    echo "CONFIG_LIBATTR=3Dy" >> $config_host_mak
> >  fi
> >  if test "$virtfs" =3D "yes" ; then
> > -  echo "CONFIG_VIRTFS=3Dy" >> $config_host_mak
> > +  echo 'CONFIG_VIRTFS=3D$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRT=
IO_CCW))' >> $config_host_mak
> >  fi
> >  if test "$vhost_scsi" =3D "yes" ; then
> >    echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
> > diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-=
softmmu.mak
> > index 51191b77df..e4c5236ceb 100644
> > --- a/default-configs/s390x-softmmu.mak
> > +++ b/default-configs/s390x-softmmu.mak
> > @@ -8,3 +8,4 @@ CONFIG_S390_FLIC=3Dy
> >  CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
> >  CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
> >  CONFIG_WDT_DIAG288=3Dy
> > +CONFIG_VIRTIO_CCW=3Dy
> > diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> > index 659df6e187..604cc8b6c4 100644
> > --- a/fsdev/Makefile.objs
> > +++ b/fsdev/Makefile.objs
> > @@ -1,4 +1,4 @@
> > -ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
> > +ifeq ($(CONFIG_VIRTFS),y)
> >  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
> >  # only pull in the actual virtio-9p device if we also enabled virtio.
> >  common-obj-y =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> > diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> > index a2c61f6b09..147d1dc9fb 100644
> > --- a/hw/Makefile.objs
> > +++ b/hw/Makefile.objs
> > @@ -1,4 +1,4 @@
> > -devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS=
),$(CONFIG_PCI))) +=3D 9pfs/
> > +devices-dirs-$(CONFIG_VIRTFS) +=3D 9pfs/
> >  devices-dirs-$(CONFIG_SOFTMMU) +=3D acpi/
> >  devices-dirs-$(CONFIG_SOFTMMU) +=3D adc/
> >  devices-dirs-$(CONFIG_SOFTMMU) +=3D audio/ =20
>=20


--Sig_/oTx9bixkkO6urrMTlvetUpD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmJx58ACgkQAvw66wEB28LKigCgifkd8BA0p80pDx41fmsT9Ncq
+SUAn2QyIy5f8wbEpIgu77ilEpbSEnKy
=X82h
-----END PGP SIGNATURE-----

--Sig_/oTx9bixkkO6urrMTlvetUpD--
