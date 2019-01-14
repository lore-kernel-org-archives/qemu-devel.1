Received: from eggs.gnu.org ([209.51.188.92]:35462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj5KM-0000eI-6S
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj5KL-0006gH-DC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:43:06 -0500
References: <1547481872-17870-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a53046c-8c6b-4eb6-b255-87b84d3b080f@redhat.com>
Date: Mon, 14 Jan 2019 10:42:46 -0600
MIME-Version: 1.0
In-Reply-To: <1547481872-17870-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U5KDadatYrLjRu5eRi4U1cSvNRzy1qasY"
Subject: Re: [Qemu-devel] [PATCH v3] configure: Work-around a bug in
 libiscsi 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, berrange@redhat.com
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U5KDadatYrLjRu5eRi4U1cSvNRzy1qasY
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-block@nongnu.org
Message-ID: <6a53046c-8c6b-4eb6-b255-87b84d3b080f@redhat.com>
Subject: Re: [PATCH v3] configure: Work-around a bug in libiscsi 1.9.0 when
 used in gnu99 mode
References: <1547481872-17870-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547481872-17870-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 10:04 AM, Thomas Huth wrote:
> The header "scsi-lowlevel.h" of libiscsi 1.9.0 contains some bad
> "inline" prototype definitions which GCC refuses to compile in its
> gnu99 mode:
>=20
> In file included from block/iscsi.c:52:0:
> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> =E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
> =E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
>              ^
> [...]
>=20
> This has been fixed by upstream libiscsi in version 1.10.0 (see
> https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
> since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
> have to work-around the issue by redefining the "inline" keyword
> to use the old "gnu89" mode behavior via "gnu_inline" instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/iscsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index a7e8c1f..ff47320 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -49,7 +49,9 @@
>  /* Conflict between scsi/utils.h and libiscsi! :( */
>  #define SCSI_XFER_NONE ISCSI_XFER_NONE
>  #include <iscsi/iscsi.h>
> +#define inline __attribute__((gnu_inline))  /* required for libiscsi v=
1.9.0 */
>  #include <iscsi/scsi-lowlevel.h>
> +#undef inline
>  #undef SCSI_XFER_NONE
>  QEMU_BUILD_BUG_ON((int)SCSI_XFER_NONE !=3D (int)ISCSI_XFER_NONE);

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--U5KDadatYrLjRu5eRi4U1cSvNRzy1qasY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8vAYACgkQp6FrSiUn
Q2qYTQgAngh+FNHYneEXTngn5LA9SpmpaPwuyvL0jy7F0FuWKdZKXxXKiyfChGvH
XgyDrTA6t+/EuAnsOM0Hl35Dtg459fZjRsV3R8V8XUiap+5WFavbIBMqU7tzYOXv
Dxr/Fp054juegJyKECfyLnQrKL7+TL317tuZ0XdPw2TxEwzaFYHu/ZCGWVKLqpzT
g8w4idLdcpWw09EVhKFol2iw3Y7X3wjkG8h8DJ8KIFwfXvr/NO+74/Z3cMi+9tw7
0OMJZcKljrIXe/54/9cVs8YG/SfEiOAGCYX3yJsPojCKAr6Jw9Wz2T6owUxjFNo5
pZqPF1ngOFWokk3CjC1D6vLpTZV7LQ==
=TqdY
-----END PGP SIGNATURE-----

--U5KDadatYrLjRu5eRi4U1cSvNRzy1qasY--
