Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df7L2-0001Wj-Je
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df7Ky-0007T8-CR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:26:36 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:48739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1df7Ky-0007Sg-5a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:26:32 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 950B68A13C
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 18:26:30 +0200 (CEST)
Date: Tue, 8 Aug 2017 18:26:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170808182623.45e88fd6@bahia.lan>
In-Reply-To: <20170808153827.427-1-cohuck@redhat.com>
References: <20170808153827.427-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/xHPGHSHKH4J5PNsiC0_rE2t";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org

--Sig_/xHPGHSHKH4J5PNsiC0_rE2t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  8 Aug 2017 17:38:27 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> on CONFIG_VIRTFS and on the presence of an appropriate virtio transport
> device.
>=20
> Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
> CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> This is the alternative approach to "9pfs: fix and simplify dependencies".
> Uglier; but probably not broken...
>=20

Yikes. I don't know why yet but this doesn't work for PCI-less targets
like cris-softmmu...

  LINK    cris-softmmu/qemu-system-cris
vl.o: In function `fsdev_init_func':
vl.c:2360: undefined reference to `qemu_fsdev_add'

> ---
>  default-configs/s390x-softmmu.mak | 1 +
>  fsdev/Makefile.objs               | 9 +++------
>  hw/Makefile.objs                  | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-so=
ftmmu.mak
> index 51191b77df..e4c5236ceb 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_S390_FLIC=3Dy
>  CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
>  CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=3Dy
> +CONFIG_VIRTIO_CCW=3Dy
> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> index 659df6e187..10d8caa291 100644
> --- a/fsdev/Makefile.objs
> +++ b/fsdev/Makefile.objs
> @@ -1,10 +1,7 @@
> -ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
> -# only pull in the actual virtio-9p device if we also enabled virtio.
> -common-obj-y =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> -else
> -common-obj-y =3D qemu-fsdev-dummy.o
> -endif
> +# only pull in the actual virtio-9p device if we also enabled a virtio b=
ackend.
> +common-obj-$(call land, $(CONFIG_VIRTFS),$(call lor, $(CONFIG_VIRTIO_PCI=
),$(CONFIG_VIRTIO_CCW)))=3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> +common-obj-$(call lnot, $(call land, $(CONFIG_VIRTFS),$(call lor, $(CONF=
IG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))) =3D qemu-fsdev-dummy.o
>  common-obj-y +=3D qemu-fsdev-opts.o qemu-fsdev-throttle.o
> =20
>  # Toplevel always builds this; targets without virtio will put it in
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index a2c61f6b09..10942fe0b4 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -1,4 +1,4 @@
> -devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),=
$(CONFIG_PCI))) +=3D 9pfs/
> +devices-dirs-$(call land, $(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_PC=
I),$(CONFIG_VIRTIO_CCW))) +=3D 9pfs/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D acpi/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D adc/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D audio/


--Sig_/xHPGHSHKH4J5PNsiC0_rE2t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmJ5i8ACgkQAvw66wEB28JcFACgqGtYhpOs7W2Ix1T5A6b2dktc
suYAnjKwsVL6tkNyfAjHvaJXMa+pVSwY
=cOOk
-----END PGP SIGNATURE-----

--Sig_/xHPGHSHKH4J5PNsiC0_rE2t--
