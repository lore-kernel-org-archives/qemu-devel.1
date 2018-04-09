Received: from eggs.gnu.org ([2001:4830:134:3::10]:34263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5XW5-0005j0-Bg
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5XW2-0005HJ-5x
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:11:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47490 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5XW1-0005H1-W4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 043A5401CC41
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 14:11:22 +0000 (UTC)
References: <20180409083956.1780-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <564c6882-bc07-c8e1-2739-f56fad53fc4c@redhat.com>
Date: Mon, 9 Apr 2018 09:11:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180409083956.1780-1-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fPRRZ2U8h9ILtB9iaSoWvj1ouf1Xg14vx"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] iothread: workaround glib bug
 which hangs qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fPRRZ2U8h9ILtB9iaSoWvj1ouf1Xg14vx
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <564c6882-bc07-c8e1-2739-f56fad53fc4c@redhat.com>
Subject: Re: [PATCH for-2.12 v2] iothread: workaround glib bug which hangs
 qmp-test
References: <20180409083956.1780-1-peterx@redhat.com>
In-Reply-To: <20180409083956.1780-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2018 03:39 AM, Peter Xu wrote:
> Free the AIO context earlier than the GMainContext (if we have) to
> workaround a glib2 bug that GSource context pointer is not cleared even=

> if the context has already been destroyed (while it should).
>=20
> The patch itself only changed the order to destroy the objects, no
> functional change at all. Without this workaround, we can encounter
> qmp-test hang with oob (and possibly any other use case when iothread i=
s
> used with GMainContexts):
>=20

> The glib2 bug is fixed in commit 26056558b ("gmain: allow
> g_source_get_context() on destroyed sources", 2012-07-30), the first
> good version is glib2 2.33.10. So this error will be encountered before=

> any glib version older than 2.33.10 (not including). Since we are still=

> supporting even older glib versions, we may want this workaround.

Grammar is awkward; I'd suggest:

=2E..the first good version is glib2 2.33.10.  But we still support
building with glib as old as 2.28, so we need the workaround.

>=20
> Let's make sure we destroy the GSources first before its owner context
> until we drop support for glibs older than 2.33.10.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - verified the root cause of the bug, and enhance commit message and
>   comments correspondingly

Reviewed-by: Eric Blake <eblake@redhat.com>

If Stefan is happy with your improved commit message, I'll queue this
for -rc3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fPRRZ2U8h9ILtB9iaSoWvj1ouf1Xg14vx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrLdIQACgkQp6FrSiUn
Q2r9cAf/WA2DgYEkeuuHobwRby6G7nk/fhs68Th/3n/EF6x4YFuJxfomS00yOnSm
qwIjcw4aZJbgwWGIQM7j9EXyPREh8F5RysmBl/rnEWekHRABZNd6fglNLFIRLICR
USReqeGBMul+QCGwlfsCuMikOqgAamyqZeI98gtSO78DREJWXs4Q5nWpyC7iEjJA
2xe/mJGDGsR/9kYkgQXj8c0DYMzz4hfj0tJR0zduM4KVT1LkNrWTnRcPr1JKGFN9
pidHTPMFr4bP+riyVfWzlb7z6pwjOsk9aLSySqVfdmHO/TfvZc37+yy6OQEm16Es
FoXJXaZzUrJtQ4zBmj9eNAsPlDKLtA==
=a6LE
-----END PGP SIGNATURE-----

--fPRRZ2U8h9ILtB9iaSoWvj1ouf1Xg14vx--
