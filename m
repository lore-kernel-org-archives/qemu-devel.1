Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFJuI-000089-Ah
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFJuH-0000bI-Do
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:36:22 -0400
References: <20170527030421.28366-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5978b99-f827-db0f-4e0b-b72e871529f0@redhat.com>
Date: Mon, 29 May 2017 07:36:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170527030421.28366-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Fx1ahHidujJXnuEnRfj1UrJQuXqdkklS"
Subject: Re: [Qemu-devel] [PATCH] nbd: Fully initialize client in case of
 failed negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Fx1ahHidujJXnuEnRfj1UrJQuXqdkklS
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <f5978b99-f827-db0f-4e0b-b72e871529f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: Fully initialize client in case of
 failed negotiation
References: <20170527030421.28366-1-eblake@redhat.com>
In-Reply-To: <20170527030421.28366-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 10:04 PM, Eric Blake wrote:
> If a non-NBD client connects to qemu-nbd, we would end up with
> a SIGSEGV in nbd_cilent_put() because we were trying to
> unregister the client's association to the export, even though
> we skipped inserting the client into that list.  Easy trigger
> in two terminals:
>=20
> $ qemu-nbd -p 30001 --format=3Draw file
> $ nmap 127.0.0.1 -p 30001
>=20

> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1451614
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> I'm planning to run a bisect to see which patch actually introduced
> the problem, but wanted to post the patch first to get review started.

Looks like the problem of split initialization has existed since at
least 2.6; commit 1a6245a split up the QTAILQ_INSERT_TAIL and
nbd_export_get as part of refactoring to create nbd_co_client_start.
But even trying the commit before that, I still got a different
assertion failure:
qemu-nbd: nbd/server.c:521: nbd_client_put: Assertion `client->closing'
failed.

Going all the way back to 2.5 worked, but 2.6 was far enough back that I
didn't want to bisect further which commit first broke probes from nmap.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6Fx1ahHidujJXnuEnRfj1UrJQuXqdkklS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLBW8AAoJEKeha0olJ0Nq9QsH/1pYSgkN+4vlP4mP/YnQYrWo
Jd9UKy6z5f+rdM+HAENJr7zxpL3JoEmODtrWEoZfkKuC87ALNZckSAGiHXj607FD
wDB0ans0fzc1x37zNUfmOOmKiBWWQfieRLql6UJNypjx6nWQeOz/XTZyvEasv/xW
JwbEzpNmylht5X1WGjcSdknxpmJFAPmW9vNIfjI8qwaS/QjwzKiE98QJ3b+tSsm0
8mDq8e6J477ecDVN5IJGh/hV73mi8e0uJ+L27CBGvq+/q75nyT40svzroT70RQ5p
lWFelJuUP+qw1Eax0cOt8+OUKgHQYaCOPasuSwbe5wT9kXQc50d/ZkjiuHe787g=
=24qQ
-----END PGP SIGNATURE-----

--6Fx1ahHidujJXnuEnRfj1UrJQuXqdkklS--
