Received: from eggs.gnu.org ([2001:4830:134:3::10]:59212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOgU-0006TD-9m
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOgR-0006sW-6N
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duOgQ-0006r1-TE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:59:51 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-2-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <810ee791-fecd-c0b7-fefd-66a78c2de925@redhat.com>
Date: Tue, 19 Sep 2017 14:59:37 -0500
MIME-Version: 1.0
In-Reply-To: <1505375436-28439-2-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jfmbqRSkXpscpgX0pmvqWoWQfs9BeQrRG"
Subject: Re: [Qemu-devel] [RFC 01/15] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jfmbqRSkXpscpgX0pmvqWoWQfs9BeQrRG
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <810ee791-fecd-c0b7-fefd-66a78c2de925@redhat.com>
Subject: Re: [RFC 01/15] char-io: fix possible race on IOWatchPoll
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 02:50 AM, Peter Xu wrote:
> This is not a problem if we are only having one single loop thread like=

> before.  However, after per-monitor thread is introduced, this is not
> true any more, and the race can happen.
>=20
> The race can be triggered with "make check -j8" sometimes:
>=20
>   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
>   io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
>=20
> This patch keeps the reference for the watch object when creating in
> io_add_watch_poll(), so that the object will never be released in the
> context main loop, especially when the context loop is running in
> another standalone thread.  Meanwhile, when we want to remove the watch=

> object, we always first detach the watch object from its owner context,=

> then we continue with the cleanup.
>=20
> Without this patch, calling io_remove_watch_poll() in main loop thread
> is not thread-safe, since the other per-monitor thread may be modifying=

> the watch object at the same time.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

> +     * Let's blame the glib bug mentioned in commit 2b3167 (again) for=


That 6-char commit id may become ambiguous soon (it's still rare to see
ambiguity with an 8-char id, although I've seen it more in recent times
than in the past; and git itself has moved from a 7-char default
abbreviation length in the 2.0 days to what is now a 10-char default
abbreviation in 2.13.5).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jfmbqRSkXpscpgX0pmvqWoWQfs9BeQrRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBdyoACgkQp6FrSiUn
Q2rpSwf+K/lV0xk1C//lDwQ2L4Lp5Z8+ptl1VTmlaUfc1KrJtHVhHtQm4/xc1k0T
5u7zmhcK2dyvuvfIVkryfwKCXU8qibiO8c53KYJ4LA5Fhm39qYeboH0hGQGA+Qyi
Gtak18B5I8sS/3Ys7Wxub2SSody+3X/MzOZqpuaSGJte+6cys+c/AiiaeTBHtqVh
3OwGqvbizkuw0ELa7azodl8ry0yXTwgIXaU1MZPM+QaFErO0Akua0LWaGhZRqf+u
QCuud2wXn01em8UqKixuNU9+kzoP0M1q4IvZz/T/k9lDOlUnrqqNCHjpIJaxOvcN
/mFfEzi7QZeLhJLRwLK1boPkiX0qDw==
=11b2
-----END PGP SIGNATURE-----

--jfmbqRSkXpscpgX0pmvqWoWQfs9BeQrRG--
