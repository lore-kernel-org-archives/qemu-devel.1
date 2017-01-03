Received: from eggs.gnu.org ([2001:4830:134:3::10]:47808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORyH-0005GI-AC
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORyD-0005qk-AW
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:29:57 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cORyD-0005p2-0T
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:29:53 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so49124922wmi.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 08:29:52 -0800 (PST)
Date: Tue, 3 Jan 2017 16:29:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103162950.GI14707@stefanha-x1.localdomain>
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Junkang Fu <fujunkang@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 30, 2016 at 10:41:35AM +0800, Junkang Fu wrote:
> From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
> From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> Date: Wed, 24 Aug 2016 19:36:53 +0800
> Subject: [PATCH] virtio-blk: add disk-name device property
>=20
> Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
> target dev
> name specified in libvirt xml file. For example, we may get disk name
> /dev/vdb in
> VM while target dev specified in libvirt xml is vdc. This may lead to a
> little trouble
> to find out the relationship between the disk name in VM and somewhere out
> of
> VM, for example in the control board of Public cloud service providers. I
> suggest
> if Qemu could add a VIRTIO_BLK_F_DISK_NAME feature, with
> VIRTIO_BLK_F_DISK_NAME
> capable Qemu and virtio-blk frontend drivers, disk name in the vm can be
> specified
> as follows:
>         -device virtio-blk-pci,disk-name=3Dvdabc

Did you try -device virtio-blk-pci,serial=3Dvdabc and
/dev/disk/by-id/virtio-vdabc inside a Linux guest?

> ---
>  hw/block/virtio-blk.c                       | 5 +++++
>  include/hw/virtio/virtio-blk.h              | 1 +
>  include/standard-headers/linux/virtio_blk.h | 6 ++++++
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 331d766..4039fb9 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -716,6 +716,8 @@ static void virtio_blk_update_config(VirtIODevice
> *vdev, uint8_t *config)
>      blkcfg.alignment_offset =3D 0;
>      blkcfg.wce =3D blk_enable_write_cache(s->blk);
>      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> +    if (s->disk_name)
> +        strncpy((char *)blkcfg.disk_name, s->disk_name, DISK_NAME_LEN);
>      memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
>  }
> @@ -740,6 +742,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice
> *vdev, uint64_t features,
>      virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
>      virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
>      virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
> +    virtio_add_feature(&features, VIRTIO_BLK_F_DISK_NAME);
> +
>      if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
>          if (s->conf.scsi) {
>              error_setg(errp, "Please set scsi=3Doff for virtio-blk devic=
es
> in order to use virtio 1.0");
> @@ -970,6 +974,7 @@ static Property virtio_blk_properties[] =3D {
>      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging,
> 0,
>                      true),
>      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> +    DEFINE_PROP_STRING("disk-name", VirtIOBlock, disk_name),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
> index 180bd8d..003e810 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -56,6 +56,7 @@ typedef struct VirtIOBlock {
>      bool dataplane_disabled;
>      bool dataplane_started;
>      struct VirtIOBlockDataPlane *dataplane;
> +    char *disk_name;
>  } VirtIOBlock;
>=20
>  typedef struct VirtIOBlockReq {
> diff --git a/include/standard-headers/linux/virtio_blk.h
> b/include/standard-headers/linux/virtio_blk.h
> index ab16ec5..1f5d89d 100644
> --- a/include/standard-headers/linux/virtio_blk.h
> +++ b/include/standard-headers/linux/virtio_blk.h
> @@ -38,6 +38,7 @@
>  #define VIRTIO_BLK_F_BLK_SIZE  6   /* Block size of disk is available*/
>  #define VIRTIO_BLK_F_TOPOLOGY  10  /* Topology information is available =
*/
>  #define VIRTIO_BLK_F_MQ        12  /* support more than one vq */
> +#define VIRTIO_BLK_F_DISK_NAME  13      /* specify /dev/xxx name */

These bits are defined in the VIRTIO specification.  In addition to
modifying QEMU and guest drivers you would also need to send a patch to
the VIRTIO Technical Committee to update the specification:
https://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x=
1-2050003

>=20
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -51,6 +52,9 @@
>=20
>  #define VIRTIO_BLK_ID_BYTES    20  /* ID string length */
>=20
> +/* micro defined in kernel genhd.h */
> +#define DISK_NAME_LEN 32
> +
>  struct virtio_blk_config {
>     /* The capacity (in 512-byte sectors). */
>     uint64_t capacity;
> @@ -84,6 +88,8 @@ struct virtio_blk_config {
>=20
>     /* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
>     uint16_t num_queues;
> +
> +   uint8_t disk_name[DISK_NAME_LEN];
>  } QEMU_PACKED;
>=20
>  /*
> --
> 1.9.4



--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa9F9AAoJEJykq7OBq3PIn0YH/RtMxmSzLmmFeYDJn3Bg3PEI
aLQj5fzMOTd2S7pxwQ2gwa0Oz6HUOE6uSHBhHHsOOJSIQjBWSUla7Tm84EiS9unN
HfZiBE+z1QsIcvZIzal5g7dbV1rxAev2HOjXc2MrRMo5peULymxfWc1DlqbIJAAg
me0XxK9AxIlysrxBtLkW2dpNh2l9wN3MwYQy/640sMxXRV228ZMJAN/5ljT9tjKa
gPuIqkiEU2kIYh21GYhQU0eQ0bavPfbojNQgtRkEoIoemMmihBH5kh9Wci/Lr6vX
5ygPQPZUZajf9NuC9pIT+Xw9Ldg8didf7PstjhhG0Ve2wNO1ECQPHP406Whr+sM=
=sIWB
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
