Received: from eggs.gnu.org ([2001:4830:134:3::10]:41145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0Svw-0006WL-Rw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0Svv-0008VZ-Q5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:44:56 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
	<b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
	<a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
	<cdec3d7e-04c9-a5e3-d0e7-293e2c7633c8@virtuozzo.com>
	<ca5a605d-e548-5860-1e40-abcac6017683@virtuozzo.com>
	<ad2fa9f3-29b1-c00b-1e51-07604f0b45e0@redhat.com>
	<9c3e29b4-3ec9-4fd7-3d80-122f908d059f@virtuozzo.com>
	<d54f0fca-6680-cce3-571e-df80a377d48e@redhat.com>
	<8f9f485a-b3b0-f14a-20ed-86578a96644e@redhat.com>
	<f0100e4f-648a-e2d4-efcd-9549b62b35b1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27d79f8f-61df-9a7b-7bd7-2ac296070fb0@redhat.com>
Date: Fri, 6 Oct 2017 08:44:46 -0500
MIME-Version: 1.0
In-Reply-To: <f0100e4f-648a-e2d4-efcd-9549b62b35b1@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EBQlUMUd5EJpNmI1k0p0OdbhoKIHbvnac"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 8/8] nbd: Minimal structured
 read for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EBQlUMUd5EJpNmI1k0p0OdbhoKIHbvnac
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <27d79f8f-61df-9a7b-7bd7-2ac296070fb0@redhat.com>
Subject: Re: [Qemu-block] [PATCH 8/8] nbd: Minimal structured read for client
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
 <20170925135801.144261-9-vsementsov@virtuozzo.com>
 <b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
 <a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
 <cdec3d7e-04c9-a5e3-d0e7-293e2c7633c8@virtuozzo.com>
 <ca5a605d-e548-5860-1e40-abcac6017683@virtuozzo.com>
 <ad2fa9f3-29b1-c00b-1e51-07604f0b45e0@redhat.com>
 <9c3e29b4-3ec9-4fd7-3d80-122f908d059f@virtuozzo.com>
 <d54f0fca-6680-cce3-571e-df80a377d48e@redhat.com>
 <8f9f485a-b3b0-f14a-20ed-86578a96644e@redhat.com>
 <f0100e4f-648a-e2d4-efcd-9549b62b35b1@virtuozzo.com>
In-Reply-To: <f0100e4f-648a-e2d4-efcd-9549b62b35b1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2017 02:34 AM, Vladimir Sementsov-Ogievskiy wrote:

>> - if the chunk is NBD_REPLY_TYPE_NONE, there is no payload, and this
>> should be the final chunk, so the return to the caller can be the same=

>> as for old-style (return 1 if we had no earlier error packets, or the
>> saved negative value corresponding to the first error received)
>> - if the command is read, we can read the payload into qiov (saves
>> malloc'ing space for the reply only to copy it into the qiov), so we
>=20
> but here you said "This is putting a LOT of smarts directly into the
> receive routine"

About the only reason to justify putting smarts into the receive routine
is if it is the most common case, where the overhead of not
special-casing will penalize us.  READ happens to be a frequent command,
all other commands, like BLOCK_STATUS, will probably be infrequent.
Making READ malloc the result, only to then copy it into the qiov, is a
waste of time; no other structured command will pass a qiov.  So yeah,
maybe I'm stating things a bit differently than in my earlier messages,
but that's because I've now stated reasonings for why it is okay to
special-case READ with a qiov differently from all other commands (none
of which will pass a qiov to the receive routine).

Thanks for persisting with this, and I'm looking forward to the next
revision that you post; hopefully, by taking this discussion, we are
making sure that the design is solid.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EBQlUMUd5EJpNmI1k0p0OdbhoKIHbvnac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnXiM4ACgkQp6FrSiUn
Q2pdsQgAotp3X9/wn6dJNFaZ14oLogLiRkLaJQhbQWZ9GPxGq74bE7qFoKT5Zhky
MHcELtCA5dO7vF5Y1XCXxPOabspN7t0yOnfBzME+ExMNRyNFlMXtwIUB1Es/b4PP
mcG7ZuQWd20fuWaoEo5ZztLmmvCNoBTP6+8UaxkOKMZMJwfs1qkkIw4znOkAs+Wj
ZIn7YHCEV+ZPBOrLsYnZx7CSmUKbvbMtmKINmpsv2pdbRgQ1YoR+hgwJ0z5WkUZm
G6eDo7C83lPbXqsK4nFwXfv4cX/ehNKnSrLn+2HK3MNiA/XijEA67aqrxWC/G322
4NMgDwiUkykal6xc2ThHnPzzP3RnjA==
=XlH+
-----END PGP SIGNATURE-----

--EBQlUMUd5EJpNmI1k0p0OdbhoKIHbvnac--
