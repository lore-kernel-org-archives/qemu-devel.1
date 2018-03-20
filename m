Received: from eggs.gnu.org ([2001:4830:134:3::10]:58144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eyIYb-0007G4-Ux
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eyIYX-0003W8-T0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:48:10 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eyIYX-0003VD-LP
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:48:05 -0400
Received: by mail-wm0-x243.google.com with SMTP id f19so4021078wmc.0
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 07:48:05 -0700 (PDT)
Date: Tue, 20 Mar 2018 14:48:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180320144802.GE24329@stefanha-x1.localdomain>
References: <1521545718.1125216.1309456936.3F023B51@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <1521545718.1125216.1309456936.3F023B51@webmail.messagingengine.com>
Subject: Re: [Qemu-devel] [PATCH] nvdimm: ensure that dsm memory is read in
 nvdimm_dsm_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artemis Tosini <lists@artemis.re>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com, jim@groklearning.com, joel@jms.id.au


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 07:35:18AM -0400, Artemis Tosini wrote:
> This patch ensures that the client OS does not cause the host to read inv=
alid memory from the NVDIMM DSM. It is not tested, since the Linux NVDIMM d=
river will not cause an invalid memory read.

Thanks for the patch!

Please move this line into the patch description...

>=20
> This patch is for my outreachy assignment, and is my first open source pa=
tch.
>=20
> From bcb717b761ac62adeda145e895f92e4bde1003af Mon Sep 17 00:00:00 2001
> From: Artemis Tosini <me@artemis.re>
> Date: Sat, 10 Mar 2018 20:38:07 +0000
> Subject: [PATCH] nvdimm: ensure that dsm memory is read in nvdimm_dsm_wri=
te

=2E..here so that git-log(1) will retain it after your patch is merged.

>=20
> Signed-off-by: Artemis Tosini <me@artemis.re>
> ---
>  hw/acpi/nvdimm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 59d6e4254c..67dda723a7 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -838,7 +838,12 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t=
 val, unsigned size)
>       * this by copying DSM memory to QEMU local memory.
>       */
>      in =3D g_new(NvdimmDsmIn, 1);
> -    cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
> +    if (address_space_read(&address_space_memory, dsm_mem_addr,
> +                          MEMTXATTRS_UNSPECIFIED, in,
> +                          sizeof(*in)) !=3D MEMTX_OK) {
> +                            nvdimm_debug("Failed to read DSM memory");
> +                            goto exit;
> +                          }

Please follow QEMU coding style (see ./CODING_STYLE in the source tree)
with 4 space indentation.  You can use scripts/checkpatch.pl to check
for coding style violations.  Try this:

    if (address_space_read(&address_space_memory, dsm_mem_addr,
                           MEMTXATTRS_UNSPECIFIED, in,
			   sizeof(*in)) !=3D MEMTX_OK) {
        nvdimm_debug("Failed to read DSM memory");
        goto exit;
    }

Please also look at the compiler error that patchew (the continuous
integration system used by QEMU) has reported.

The actual change looks good to me - it stops the device from processing
*in when we were unable to copy bytes from guest RAM.

Stefan

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJasR8iAAoJEJykq7OBq3PIS6EH/AxH8em/WePN4CJZkmwWwmi4
oGvfdNVgJNzTK3mAeik13/5VhURXaQ+srJMlI0OqnmmLe/Q8fCRMN1tPBlqIyUVq
kmhceW+4DcUKifwn1fVzica00+IUb+RLpozGOmCm0MDchibl2YnW57spNKThEdVQ
jZhlnQFjHNOCwXLlFfXwVP4KtjyRCJCMu1hblzFR9c4vfro8Ul8QOg1PLxM6MiFY
Q8ZcmKYroWdbFdviS9bNYPpBbGjl0NzQuOjfa0Fz8X0+AYbA/+SwKehHRffIjxwY
2UY7FAySuX5nD9mv65khJw9tjpDW05hBMyVWesaS1GKrmae6mfFbC2lQwoSt5Co=
=mbqH
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
