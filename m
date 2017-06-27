Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgek-0003tA-VM
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgeh-0001u0-SC
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPgeh-0001rp-Ii
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05C34C0587FA
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 02:55:06 +0000 (UTC)
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
	<1490860207-8302-4-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d9cb505-1f1f-8d34-d4bb-dc38f2f1dff7@redhat.com>
Date: Mon, 26 Jun 2017 21:55:04 -0500
MIME-Version: 1.0
In-Reply-To: <1490860207-8302-4-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6bUTKj2CUG5hTWCMX8731fWpLdHmFu54u"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6bUTKj2CUG5hTWCMX8731fWpLdHmFu54u
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <5d9cb505-1f1f-8d34-d4bb-dc38f2f1dff7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests: Add a tester for HMP commands
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
 <1490860207-8302-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1490860207-8302-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 02:50 AM, Thomas Huth wrote:
> HMP commands do not get any automatic testing yet, so on certain
> QEMU machines, some HMP commands were causing crashes in the past.
> Thus we should test HMP commands in our test suite, too, to avoid
> that such problems creep in again in the future.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

> +static const char *hmp_cmds[] =3D {
> +    "boot_set ndc",

> +/* Run through the list of pre-defined commands */
> +static void test_commands(void)
> +{
> +    char *response;
> +    int i;
> +
> +    for (i =3D 0; hmp_cmds[i] !=3D NULL; i++) {
> +        if (verbose) {
> +            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
> +        }
> +        response =3D hmp(hmp_cmds[i]);

I failed to notice this sooner, but hmp() is passing its first arg as a
format string through a printf family.  If hmp_cmds[i] ever gets
modified to include something with a %, it will misbehave.  Better is to
use hmp("%s", variable).

I've patched it locally as part of rebasing my work on avoiding dynamic
JSON format strings, if no one beats me to a fix (my series also adds
the gcc format attribute tag, so that the compiler catches any further
mismatches in hmp() format vs. arguments).

> +    while (*info) {
> +        /* Extract the info command, ignore parameters and description=
 */
> +        g_assert(strncmp(info, "info ", 5) =3D=3D 0);
> +        endp =3D strchr(&info[5], ' ');
> +        g_assert(endp !=3D NULL);
> +        *endp =3D '\0';
> +        /* Now run the info command */
> +        if (verbose) {
> +            fprintf(stderr, "\t%s\n", info);
> +        }
> +        resp =3D hmp(info);

Another instance.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6bUTKj2CUG5hTWCMX8731fWpLdHmFu54u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUckIAAoJEKeha0olJ0Nqi+UIAKTdmS7e5serM0v+wR/RJ1Ot
CDURUf3iuWllk3wbCNGk3DVum2X1vpA1hRgN54+01ehMXK+6/e4TwF8ghkQy02NJ
XaFAUkyK2IENDjp4YAIOsk0AKgQpjYJKF47RRio7V/piwlycyz4qvfKC6M7K8qvU
VKlQr+yLs6ONqBLbMsuUllH7FILfQ3NdvtbaI+bxlEfFTJIW6aI+bNaloE0idSM9
Whs+FZmoLVoya5de/XBXnlccJf5VZFZQXhGhmD2P8tJUV/6FWuFGAOdjcAV1w5tD
aSjfHS+VIeB2BoJbUrg2E9NeR5TQ40QIuRX9yPy3PT5NesneJknrJjji7Wh9z+4=
=hlYm
-----END PGP SIGNATURE-----

--6bUTKj2CUG5hTWCMX8731fWpLdHmFu54u--
