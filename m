Received: from eggs.gnu.org ([2001:4830:134:3::10]:39867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkkY-0005aH-UF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkkV-0006hX-NK
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:32:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBkkV-0006hK-Ho
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:32:03 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-6-git-send-email-ian.jackson@eu.citrix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ccb01c57-22e7-8b04-d278-eb7c0e654fe7@redhat.com>
Date: Thu, 26 Apr 2018 12:31:55 -0500
MIME-Version: 1.0
In-Reply-To: <1524761612-5307-6-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zztr7n6E8x95COWsJ9BUGFknKUiukNNry"
Subject: Re: [Qemu-devel] [RFC PATCH 5/7] error reporting: Provide
 error_report_errnoval (and error_vreport_errnoval)
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
--zztr7n6E8x95COWsJ9BUGFknKUiukNNry
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Daniel_P_._Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <ccb01c57-22e7-8b04-d278-eb7c0e654fe7@redhat.com>
Subject: Re: [RFC PATCH 5/7] error reporting: Provide error_report_errnoval
 (and error_vreport_errnoval)
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-6-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-6-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:53 AM, Ian Jackson wrote:
> This will let us replace more open coded calls to error_report and
> strerror.
>=20
> I have chosen to provide all of
>    error_report_errno       error_vreport_errno
>    error_report_errnoval    error_vreport_errnoval
> because the former are much more common, and deserve a short spelling;
> whereas there are still at least 30-40 potential callers of the latter.=


As mentioned in 2/7, that's inconsistent with error_setg_errno().  I'd
MUCH rather see us have JUST error_[v]report_errno with a mandatory
error parameter, rather than blindly relying on implicit use of errno;
it's not that much harder to write:

error_report_errno(errno, "fmt string...", args);

in the common case when directly using errno is intended.

> =20
> +void error_vreport_errnoval(int errnoval,
> +                            const char *fmt, va_list ap) GCC_FMT_ATTR(=
2, 0);
> +void error_report_errnoval(int errnoval,
> +                           const char *fmt, ...) GCC_FMT_ATTR(2, 3);

Bikeshedding - can we name the parameter 'os_error' (as in
error_seg_errno), or 'err' or 'errval', rather than the longer 'errnoval'=
?


> +++ b/util/qemu-error.c
> @@ -257,6 +257,18 @@ void error_vreport_errno(const char *fmt, va_list =
ap)
>  }
> =20
>  /*
> + * Print an error message to current monitor if we have one, else to s=
tderr.
> + * Format arguments like vsprintf().  The resulting message should be
> + * a single phrase, with no newline or trailing punctuation.
> + * Prepend the current location and append ": " strerror(errnoval) "\n=
".
> + * It's wrong to call this in a QMP monitor.  Use error_setg() there.
> + */
> +void error_vreport_errnoval(int errnoval, const char *fmt, va_list ap)=

> +{
> +    vreport(REPORT_TYPE_ERROR, errnoval, fmt, ap);
> +}

Should this explicitly document that passing 0 for errnoval is
acceptable or forbidden?  If acceptable, does that mean no suffix (other
than \n) is added?  If forbidden, do we want to assert() that?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--zztr7n6E8x95COWsJ9BUGFknKUiukNNry
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriDQsACgkQp6FrSiUn
Q2pzOgf9FnOa5mWeZYubGACUNcd9iLW6AQRIXry3qGx/jniK/bKUqLI/U0dgA0id
IdhB0u7cMXOkKqfNwKUA1ONn/Iu/i5D8ALiFdTE1k17k0wiHQ4UCZ+a9XgmmSCKy
RWmVHfrXzXMpWxDg/YfRdAxpFeqk96CW5vzM+8+fj+BIKVzvA14Pv8UGmZuf9O6W
HK8RrkRehqDxZYGl7Y/crexGGZe/UrInx1M7L8CXnoN1cxEcHD1DWgx5+GquR0OA
VwYRiA1PGJaOe2SQpxhhkC7vukyF8mYmYxHxJAIeJA+Kxw2i88i8IqlSdbL7gpN2
YCefOmn8n0cecNL/x+3dGNUs1gpatQ==
=cA0p
-----END PGP SIGNATURE-----

--zztr7n6E8x95COWsJ9BUGFknKUiukNNry--
