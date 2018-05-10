Received: from eggs.gnu.org ([2001:4830:134:3::10]:35635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGmqZ-0003VP-NW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGmqW-0004JQ-J3
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:47:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fGmqW-0004Iv-BT
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:47:04 -0400
Received: by mail-wm0-x243.google.com with SMTP id f6-v6so4329686wmc.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:47:04 -0700 (PDT)
Date: Thu, 10 May 2018 15:47:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180510144701.GB7734@stefanha-x1.localdomain>
References: <1525936711-24538-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1525936711-24538-2-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <1525936711-24538-2-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v7 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: darcysail@gmail.com, qemu-devel@nongnu.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 03:18:30PM +0800, Su Hang wrote:

Great, this is getting close.  A few more comments below...

>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
>          kernel_size =3D load_aarch64_image(info->kernel_filename,
>                                           info->loader_start, &entry, as);
>          is_linux =3D 1;
> -    } else if (kernel_size < 0) {
> -        /* 32-bit ARM */
> +    }
> +    if (kernel_size < 0) {
> +        /* 32-bit ARM binary file */

Why is this change necessary?  A 64-bit machine previously didn't
attempt a 32-bit kernel load.  I'm not sure why you changed this
behavior.

> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 5ed3fd8ae67a..ba82c9686ba3 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -28,6 +28,19 @@ ssize_t load_image_size(const char *filename, void *ad=
dr, size_t size);
>  int load_image_targphys_as(const char *filename,
>                             hwaddr addr, uint64_t max_sz, AddressSpace *a=
s);
> =20
> +/**load_image_targphys_hex_as:

s/load_image_targphys_hex_as/load_targphys_hex_as/

> + * @filename: Path to the .hex file
> + * @entry: Store the entry point get from .hex file

s/get from/given by the/g

> + * @max_sz: The maximum size of the .hex file to load

This argument does not exist, please drop it.

> @@ -241,6 +254,8 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
>      rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
>  #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
>      rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
> +#define rom_add_hex_blob_as(_f, _b, _l, _a, _as)      \
> +    rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)

This macro is equivalent to rom_add_blob_fixed_as().  Why not use
rom_add_blob_fixed_as()?

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9FtlAAoJEJykq7OBq3PIEjsIAMSCYXZDRMPdywea8FAVLt5A
nsD71beDHQOis2UPaJarwTNmkZhbPUWnzDG6i2GcCRG81i7+ORl0EiYgElXhOezP
1wpMZdPFv/Z/wdNhb4WfY6qMznCgRxJZJ/4OXme2T8jGy6iz7cRV1OtZS6crw8OO
Otn/R0t+KvVMPbey2uvagnFuf+p6R517THC3LKpHXVXJ0p22+lKwLhazKcmJHo4J
UCtrRzoy7kFHMZgdgmKT4LmCCWvpQkJJ3F+/QnXMgOkfIf2+Oiw74+Je9idwMaiU
zFdy5g6m8HyNszqUnxD9oByxcm5lpHKRVRoMaQUeLRE8U2KS9Tu9kTtDCcx/Q2Y=
=M5/X
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
