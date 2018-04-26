Received: from eggs.gnu.org ([2001:4830:134:3::10]:37265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkdN-0000hq-UY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBkdM-0002dm-Kq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:24:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBkdM-0002da-FQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:24:40 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
Date: Thu, 26 Apr 2018 12:24:37 -0500
MIME-Version: 1.0
In-Reply-To: <1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AnnMCAGu7ES5vrbJ4hw9J1wfLnbjmV3wX"
Subject: Re: [Qemu-devel] [RFC PATCH 1/7] error reporting: Introduce
 errnoval parameter to vreport
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
--AnnMCAGu7ES5vrbJ4hw9J1wfLnbjmV3wX
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Daniel_P_._Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
Subject: Re: [RFC PATCH 1/7] error reporting: Introduce errnoval parameter to
 vreport
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:53 AM, Ian Jackson wrote:
> This will allow new callers of vreport to specify that an errno value
> should be printed too.  Update all existing callers.
>=20
> We use strerror rather than strerror_r because strerror_r presents
> portability difficulties.  Replacing strerror with strerror_r (or
> something else) is left to the future.

Is g_strerror() suitably easy to use, which would at least avoid the
portability difficulties?

>=20
> No functional change yet.
>=20
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  util/qemu-error.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index a25d3b9..9acc4b5 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -191,12 +191,14 @@ bool enable_timestamp_msg;
>  /*
>   * Print a message to current monitor if we have one, else to stderr.
>   * @report_type is the type of message: error, warning or informationa=
l.
> + * If @errnoval is nonnegative it is fed to strerror and printed too.

That implies 0 is fed to strerror(), which is not the case.  Better
would be "If @errnoval is positive...".  Or, if we wanted, we could say
"If @errnoval is not zero, its absolute value is fed to strerror" to let
people pass in both EIO and -EIO for the same output (something that
strerror() can't do, but our wrapper can) - but I don't know if that
convenience is a good thing.

>   * Format arguments like vsprintf().  The resulting message should be
>   * a single phrase, with no newline or trailing punctuation.
>   * Prepend the current location and append a newline.
>   * It's wrong to call this in a QMP monitor.  Use error_setg() there.
>   */
> -static void vreport(report_type type, const char *fmt, va_list ap)
> +static void vreport(report_type type, int errnoval,

Bikeshedding: Is 'err' or 'errval' a better name in terms of length and
legibility?

> +                    const char *fmt, va_list ap)
>  {
>      GTimeVal tv;
>      gchar *timestr;
> @@ -222,6 +224,11 @@ static void vreport(report_type type, const char *=
fmt, va_list ap)
>      }
> =20
>      error_vprintf(fmt, ap);
> +
> +    if (errnoval >=3D 0) {
> +        error_printf(": %s", strerror(errnoval));

Off-by-one.  You do NOT want to print strerror(0) (that results in
appending ": Success" or similar to what is supposed to be an error
message).

> +    }
> +
>      error_printf("\n");
>  }
> =20
> @@ -234,7 +241,7 @@ static void vreport(report_type type, const char *f=
mt, va_list ap)
>   */
>  void error_vreport(const char *fmt, va_list ap)
>  {
> -    vreport(REPORT_TYPE_ERROR, fmt, ap);
> +    vreport(REPORT_TYPE_ERROR, -1, fmt, ap);

Passing -1 to suppress the output feels awkward, especially if 0 can be
used for the same purpose and would then let us use -errno and errno
interchangeable by passing the absolute value to sterror.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AnnMCAGu7ES5vrbJ4hw9J1wfLnbjmV3wX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriC1UACgkQp6FrSiUn
Q2rNGwf/WVVDc+Qq7M42V99P/PhxffHhFHE5h0aAzImFjVdMsxFLJoUfQwHOKrrA
Ia8UGFjjTc6g1ZvP8C6bVKoZzuLO8w7c0fI/fOXR0bFrtzryYvlJRKSziar7g/Ef
+86GTSmQzW6D2OKxtpNTHhChvC/L5pMLOcTUeSTwtNBuSlnyH2BBPMAOhGzU2r8p
pszIFSg7CTegO9i4hatTrewDYMAic0zjJqeqpn8hCOIl2SPR0X+xVXMYsg60lbh0
bzKqVx75J2zJa4es+YhqppKcRS06Brk2mMQ+MyUc5fGVlK5sAS0UJGX8OszofND1
W3INWDaKhcgOSx/7b/i9qF5jNXfkhA==
=DJr+
-----END PGP SIGNATURE-----

--AnnMCAGu7ES5vrbJ4hw9J1wfLnbjmV3wX--
