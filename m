Received: from eggs.gnu.org ([2001:4830:134:3::10]:49852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2Mb-0001fD-Vj
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2MY-0007Z3-Vk
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:59:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ch2MY-0007YT-MS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:59:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68123552CE
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 22:59:50 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23b73461-af6e-2ee2-7b93-723275d61d0e@redhat.com>
Date: Thu, 23 Feb 2017 16:59:47 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aLmr5KuWmLU47gbXKbWUSnNKc9pe4BIbp"
Subject: Re: [Qemu-devel] [PATCH 02/21] libqtest: Work around a "QMP wants a
 newline" bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aLmr5KuWmLU47gbXKbWUSnNKc9pe4BIbp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <23b73461-af6e-2ee2-7b93-723275d61d0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/21] libqtest: Work around a "QMP wants a
 newline" bug
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:44 PM, Markus Armbruster wrote:
> The next commit is going to add a test that calls qmp("null").
> Curiously, this hangs.  Here's why.
>=20
> qmp_fd_sendv() doesn't send newlines.  Not even when @fmt contains
> some.  At first glance, the QMP parser seems to be fine with that.
> However, it turns out that it fails to react to input until it sees
> either a newline, an object or an array.  To reproduce, feed to a QMP
> monitor like this:
>=20

>=20
> Work around this QMP bug by having qmp_fd_sendv() append a newline.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20

> +++ b/tests/libqtest.c
> @@ -442,14 +442,20 @@ void qmp_fd_sendv(int fd, const char *fmt, va_lis=
t ap)
>      if (qobj) {
>          int log =3D getenv("QTEST_LOG") !=3D NULL;
>          QString *qstr =3D qobject_to_json(qobj);
> -        const char *str =3D qstring_get_str(qstr);
> -        size_t size =3D qstring_get_length(qstr);
> +        const char *str;
> +
> +        /*
> +         * BUG: QMP doesn't react to input until it sees a newline, an=

> +         * object, or an array.  Work-around: give it a newline.
> +         */
> +        qstring_append_chr(qstr, '\n');
> +        str =3D qstring_get_str(qstr);
> =20
>          if (log) {
>              fprintf(stderr, "%s", str);

Bonus - the log now has newlines, too :)

>          }
>          /* Send QMP request */
> -        socket_send(fd, str, size);
> +        socket_send(fd, str, qstring_get_length(qstr));

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aLmr5KuWmLU47gbXKbWUSnNKc9pe4BIbp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYr2ljAAoJEKeha0olJ0Nqk48H/1Ux/EQN97jU+L8/Fu+iFa9g
7epLB8BJ/Oq3h7CCkRRiI2wQ55ysIiSDA77YFGhjOOg8uTkXWyiLI2n1BLBP9TBg
gZl3R0L3psRJNXDqtrGJstoYhvpe8334MWzGX++DfJGpzNIhRAaSHcNDCAkvY0KS
VNqoups0mH75SijUm1nzm7B+xZeSxgzgP0H/C02Py5yCHtusa04IPcJCXUAlY4lL
zbR7Pi9hpBCzetWLX3Y9RdX23SQJup52eWdpaCVM0AlqvyV96/7pokvnko9kb6dj
8qrFyNSJKcVW2fEmVb1JdjRM4Mx2twBy1j4AnimdN2g1Z7LsQmMGxdf3jDOzRBA=
=CqYX
-----END PGP SIGNATURE-----

--aLmr5KuWmLU47gbXKbWUSnNKc9pe4BIbp--
