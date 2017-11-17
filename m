Received: from eggs.gnu.org ([2001:4830:134:3::10]:49658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhit-0004Oj-3o
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFhis-0001ew-3V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:34:27 -0500
References: <20171113194857.13933-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <119e49f8-9dfb-ffb2-6301-ff581d6fb2b5@redhat.com>
Date: Fri, 17 Nov 2017 08:34:20 -0600
MIME-Version: 1.0
In-Reply-To: <20171113194857.13933-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KphEPpfptKJNlO8tL8RI2DbLjAl9uS2OC"
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Don't hard-disconnect
 on ESHUTDOWN from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KphEPpfptKJNlO8tL8RI2DbLjAl9uS2OC
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org
Message-ID: <119e49f8-9dfb-ffb2-6301-ff581d6fb2b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Don't hard-disconnect
 on ESHUTDOWN from server
References: <20171113194857.13933-1-eblake@redhat.com>
In-Reply-To: <20171113194857.13933-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 01:48 PM, Eric Blake wrote:
> The NBD spec says that a server may fail any transmission request
> with ESHUTDOWN when it is apparent that no further request from
> the client can be successfully honored.  The client is supposed
> to then initiate a soft shutdown (wait for all remaining in-flight
> requests to be answered, then send NBD_CMD_DISC).  However, since
> qemu's server never uses ESHUTDOWN errors, this code was mostly
> untested since its introduction in commit b6f5d3b5.
>=20
> More recently, I learned that nbdkit as the NBD server is able to
> send ESHUTDOWN errors, so I finally tested this code, and noticed
> that our client was special-casing ESHUTDOWN to cause a hard
> shutdown (immediate disconnect, with no NBD_CMD_DISC), but only
> if the server sends this error as a simple reply.  Further
> investigation found that commit d2febedb introduced a regression
> where structured replies behave differently than simple replies -
> but that the structured reply behavior is more in line with the
> spec (even if we still lack code in nbd-client.c to properly quit
> sending further requests).  So this patch reverts the portion of
> b6f5d3b5 that introduced an improper hard-disconnect special-case
> at the lower level, and leaves the future enhancement of a nicer
> soft-disconnect at the higher level for another day.
>=20
> CC: qemu-trivial@nongnu.org

I think I meant qemu-stable, not qemu-trivial.  At any rate, this is now
queued on my NBD tree for 2.11-rc2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KphEPpfptKJNlO8tL8RI2DbLjAl9uS2OC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloO82wACgkQp6FrSiUn
Q2pRFgf+JPNaMJVqISsX7coKfHm4oVlGfWaIrccaEdfpEzHHCflImdfyosZ3QH5l
dOwmDg5e/3N1Pvm+RqwRUqijlrLGdDEv2TOCglyXi/nQhHBX1YS2rz0o9qoyda7f
dalB2mKVtIELSvyzBYPzJSDVU+JdYbim3L0BGNRmcrjCmXasmEPfIeteiCR0gmXl
kS33MHCMlIhiYhEWvmYzgi4oOl4yE+Sp3zWTe+6MrGzU3bgAi4e1F6mbiVpGEB+X
BQoFfHLacKrRg6h45DgA0+50n4F97d5sco/son+dG1fEXRlFBxN7ByEabp5YOrgD
rSkZ2lvHO3vfnAJ0wsZNjznGC2z1aA==
=Rr7A
-----END PGP SIGNATURE-----

--KphEPpfptKJNlO8tL8RI2DbLjAl9uS2OC--
