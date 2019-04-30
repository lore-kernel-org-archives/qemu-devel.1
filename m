Received: from eggs.gnu.org ([209.51.188.92]:53999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZY0-0004nn-O5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZXz-0005KA-L7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:40:16 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
Date: Tue, 30 Apr 2019 15:40:10 -0500
MIME-Version: 1.0
In-Reply-To: <66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oX1gu2JDw7BAEh4ISXFf35nv2B0183G55"
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oX1gu2JDw7BAEh4ISXFf35nv2B0183G55
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Message-ID: <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 3:09 PM, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/lin=
ux-user/uname.c:94:3:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 output may be truncated copying 64 bytes from a string o=
f length 64 [-Werror=3Dstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/uname.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..293b2238f2 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -90,6 +90,11 @@ int sys_uname(struct new_utsname *buf)
>     * struct linux kernel uses).
>     */
> =20
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wstringop-truncation"
> +#endif

Why do we need the pragma?

> +
>    memset(buf, 0, sizeof(*buf));

We are prezeroing the entire field, at which point...

>    COPY_UTSNAME_FIELD(buf->sysname, uts_buf.sysname);
>    COPY_UTSNAME_FIELD(buf->nodename, uts_buf.nodename);

=2E..using strncpy() for a shorter string is wasteful (we're writing the
tail end twice), and for a long string is warning-prone.  Why not
rewrite COPY_UTSNAME_FIELD() to use memcpy() for the MIN(strlen(src),
__NEW_UTS_LEN) and drop the write of the trailing NUL, since it will
already be NUL from your memset()?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oX1gu2JDw7BAEh4ISXFf35nv2B0183G55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIsqoACgkQp6FrSiUn
Q2p5QggAmRbDUofOs6DtDyWbmGr57+sNOXDrihPOQcGy75xEmgpZpDhWSzEA6kLb
ByIU2AEe/nal/bgQLg5Sn/rot7arlPlfx0M4RCJB1Vu/W270YRZ9QfoYYVCBIJeG
uTL1d3QY2nBH+dy1PYxXD2WVKtytjKqBNQo5pe6z+y0aAYZ3Q+xXDMJlcoB+4YFi
2MeO8N1mbvD97yLzK7sKTAhipLls3PK9kuAG2iKglj1an2wuI0GFoxEwd7tGxwcW
UqxW7bcMHXPbC3c5zRiD5vFi3ZCArVp+CegDAutRShypmsEjo0XfD5Av/p7NLQHx
rWG4SdxcUsrOmNv925uUQCLyD62hqg==
=chvo
-----END PGP SIGNATURE-----

--oX1gu2JDw7BAEh4ISXFf35nv2B0183G55--
