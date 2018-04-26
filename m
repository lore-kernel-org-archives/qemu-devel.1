Received: from eggs.gnu.org ([2001:4830:134:3::10]:38290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkgQ-0002g1-Nm
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkgN-0004jA-Fr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:27:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBkgN-0004iy-AY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:27:47 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-3-git-send-email-ian.jackson@eu.citrix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b3c510e-c497-79b8-bc88-76d5b8b0d184@redhat.com>
Date: Thu, 26 Apr 2018 12:27:45 -0500
MIME-Version: 1.0
In-Reply-To: <1524761612-5307-3-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fQ5iF2BOQfoMwnHZndrZwUXewB1zj3Ksk"
Subject: Re: [Qemu-devel] [RFC PATCH 2/7] error reporting: Provide
 error_report_errno (and error_vreport_errno)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fQ5iF2BOQfoMwnHZndrZwUXewB1zj3Ksk
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Daniel_P_._Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <3b3c510e-c497-79b8-bc88-76d5b8b0d184@redhat.com>
Subject: Re: [RFC PATCH 2/7] error reporting: Provide error_report_errno (and
 error_vreport_errno)
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-3-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-3-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:53 AM, Ian Jackson wrote:
> This will let us replace a lot of open coded calls to perror,
> strerror, etc.
>=20
> No callers yet so no functional change.
>=20
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  include/qemu/error-report.h |  2 ++
>  util/qemu-error.c           | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e1c8ae1..2b29678 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -37,10 +37,12 @@ void error_printf_unless_qmp(const char *fmt, ...) =
GCC_FMT_ATTR(1, 2);
>  void error_set_progname(const char *argv0);
> =20
>  void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
> +void error_vreport_errno(const char *fmt, va_list ap) GCC_FMT_ATTR(1, =
0);

I'd rather us ALWAYS require an explicit argument for the error value,
rather than reading errno.  That way, it's easier to audit that the
caller is passing in a known error value, rather than checking if errno
has been inadvertently changed during intermediate code between when the
error was detected and when the message is generated.  Furthermore, this
is inconsistent with the existing error_setg_errno().

Thus, I do not think we want this function.  Your addition in 5/7 is
better, but a rather verbose name, so I think THAT addition deserves to
be named error_vreport_errno.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fQ5iF2BOQfoMwnHZndrZwUXewB1zj3Ksk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriDBEACgkQp6FrSiUn
Q2pAHwgAgQsxqZaPn9Fl5G0g2meobeiz57JRCXGl7UE3SU+QWziqjsw23WxhooUg
qHGSe9GaaZO9o2wTunG+pt29h6GXBU3ZPtBLFlbErGbHOVSAtFWBVOFUTgWALyLx
io8ma8pK+9IcHKyfDNGOscyW3X5h5ISzpdNArOd/FgTjBB0nEQiTBZdJBKMAqrZ7
0EM91Uf1htrrBsY2ZDr45ULzs7AwSY+OE7ZMliYHZQzNC5IOznjWXVATfCIN0XC8
mnS5MyTPNUv3TtZNfo3QT+Sbp0UL6yK6JUupg2VcuAZmzLyVgi4f+fA7Ov0eE294
d5eqTRXWaDmmzkJBu5Yst5Dov2aTCA==
=3UXp
-----END PGP SIGNATURE-----

--fQ5iF2BOQfoMwnHZndrZwUXewB1zj3Ksk--
