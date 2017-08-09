Received: from eggs.gnu.org ([2001:4830:134:3::10]:55311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfUEX-0004Sx-42
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfUES-0000aS-6q
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:53:25 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:58919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfUES-0000a0-17
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:53:20 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 78CA48BDC3
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 18:53:18 +0200 (CEST)
Date: Wed, 9 Aug 2017 18:53:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809185248.230b6166@bahia.lan>
In-Reply-To: <20170809163019.21593-1-cohuck@redhat.com>
References: <20170809163019.21593-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/tewdyiphgT6ddQBxikjGh21";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3] 9pfs: fix dependencies
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

--Sig_/tewdyiphgT6ddQBxikjGh21
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  9 Aug 2017 18:30:19 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> on CONFIG_VIRTFS and CONFIG_VIRTIO/CONFIG_XEN only.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20

I think we're ok now. Thanks for fixing that!

IIUC, this patch will be needed when your zpci cleanup patches get merged.
I suggest you add it to your series with my:

Acked-by: Greg Kurz <groug@kaod.org>

Cheers,

--
Greg

> v2->v3: switch dependencies to VIRTFS && (VIRTIO || XEN)
>         add explict VIRTIO dependency for virtio-9p-device.o
>=20
> ---
>  fsdev/Makefile.objs   | 9 +++------
>  hw/9pfs/Makefile.objs | 2 +-
>  hw/Makefile.objs      | 2 +-
>  3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> index 659df6e187..fb38017c0b 100644
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
> +# only pull in the actual 9p backend if we also enabled virtio or xen.
> +common-obj-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CO=
NFIG_XEN))) =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> +common-obj-$(call lnot,$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_=
VIRTIO),$(CONFIG_XEN)))) =3D qemu-fsdev-dummy.o
>  common-obj-y +=3D qemu-fsdev-opts.o qemu-fsdev-throttle.o
> =20
>  # Toplevel always builds this; targets without virtio will put it in
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index cab5e942ed..fd90b62900 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -7,4 +7,4 @@ common-obj-$(CONFIG_OPEN_BY_HANDLE) +=3D  9p-handle.o
>  common-obj-y +=3D 9p-proxy.o
>  common-obj-$(CONFIG_XEN) +=3D xen-9p-backend.o
> =20
> -obj-y +=3D virtio-9p-device.o
> +obj-$(CONFIG_VIRTIO) +=3D virtio-9p-device.o
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index a2c61f6b09..cf4cb2010b 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -1,4 +1,4 @@
> -devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),=
$(CONFIG_PCI))) +=3D 9pfs/
> +devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(=
CONFIG_XEN))) +=3D 9pfs/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D acpi/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D adc/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D audio/


--Sig_/tewdyiphgT6ddQBxikjGh21
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLPfcACgkQAvw66wEB28I4NQCfTE+LVep3XzMvvHItIhFcO54J
35kAn0m53zK2Q3858ViHsst2GhWuB7fB
=/vVO
-----END PGP SIGNATURE-----

--Sig_/tewdyiphgT6ddQBxikjGh21--
