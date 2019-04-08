Received: from eggs.gnu.org ([209.51.188.92]:40352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZhi-0007af-TC
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZhh-0003JJ-UL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:13:14 -0400
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com>
Date: Mon, 8 Apr 2019 14:13:08 -0500
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG"
Subject: Re: [Qemu-devel] [PATCH 02/15] block/ssh: Do not report
 read/write/flush errors to the user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] block/ssh: Do not report
 read/write/flush errors to the user
References: <20190408083627.7479-1-armbru@redhat.com>
 <20190408083627.7479-3-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 3:36 AM, Markus Armbruster wrote:
> Callbacks ssh_co_readv(), ssh_co_writev(), ssh_co_flush() report
> errors to the user with error_printf().  They shouldn't, it's their
> caller's job.  Replace by a suitable trace point.
>=20
> Perhaps we should convert this part of the block driver interface to
> Error, so block drivers can pass more detail to their callers.  Not
> today.
>=20
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/ssh.c        | 36 ++++++++++++------------------------
>  block/trace-events |  3 +++
>  2 files changed, 15 insertions(+), 24 deletions(-)
>=20

> -static void GCC_FMT_ATTR(2, 3)
> -sftp_error_report(BDRVSSHState *s, const char *fs, ...)
> +static void sftp_error_trace(BDRVSSHState *s, const char *op)
>  {
> -    va_list args;
> +    char *ssh_err;
> +    int ssh_err_code;
> +    unsigned long sftp_err_code;
> =20
> -    va_start(args, fs);
> -    error_vprintf(fs, args);
> -
> -    if ((s)->sftp) {

The old code was conditional,

> -        char *ssh_err;
> -        int ssh_err_code;
> -        unsigned long sftp_err_code;
> -
> -        /* This is not an errno.  See <libssh2.h>. */
> -        ssh_err_code =3D libssh2_session_last_error(s->session,
> +    /* This is not an errno.  See <libssh2.h>. */
> +    ssh_err_code =3D libssh2_session_last_error(s->session,
>                                                    &ssh_err, NULL, 0);

Indentation looks off now.

> -        /* See <libssh2_sftp.h>. */
> -        sftp_err_code =3D libssh2_sftp_last_error((s)->sftp);
> +    /* See <libssh2_sftp.h>. */
> +    sftp_err_code =3D libssh2_sftp_last_error((s)->sftp);

but it appears the new code can call libssh2_sftp_last_error(NULL). Am I
missing something, or could that be a problem?

/me rescans the full file...

Okay, connect_to_ssh() won't succeed unless s->sftp is set, and it
appears that all callers to the trace function can only be reached if
connect succeeded.

Indentation fixup can be done by maintainer,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyrnUQACgkQp6FrSiUn
Q2pr/Af/TUGAGVBgPTDtDIgSINGV4EkLbuEJWbKpYLLhJqbIbcTRHP8gjpTVwSPd
SYRmcHyQqQ6bKpJ1X+bg4MONts/4iZRX2ns1TG634AYguTcYKh5VGPzHQJmhhTH/
ueM6+ezJRtzKWyL8f08aCxYVfZYsfgbw4Ae80I1QUlwhbeZpIU7l9UrijH5B5EDP
sf7Q2Q05bmaZKu30l/QEAwoTeM05Z6Sx3CWrdOE4f11Gc2ViXNKfHrBwkOi1nL5/
NboUwUm7T5ZX86lWctEgKeIRmj6/Hm9JN3CK/9pdiXHcMi/bes7nmCXa/ZoKZxvw
E4wJ0D7KNJ5fCdsLT4AbE+JA7qChmg==
=PH+N
-----END PGP SIGNATURE-----

--nnbR4IIvO4NjYRaGotPhRcCXk56pxtgKG--
