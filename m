Received: from eggs.gnu.org ([2001:4830:134:3::10]:39983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degXo-00020Q-IA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degXj-0006h7-GK
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:50:00 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-5-vsementsov@virtuozzo.com>
	<20170807082320.GB18259@redhat.com>
	<d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84afeffb-14ae-d066-3d2a-0067e9e9d1ca@redhat.com>
Date: Mon, 7 Aug 2017 06:49:40 -0500
MIME-Version: 1.0
In-Reply-To: <d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iK9WoWgedGfB5TkT04VL4RdUOi0GQbjsm"
Subject: Re: [Qemu-devel] [PATCH 04/17] nbd/client: fix nbd_send_request to
 return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iK9WoWgedGfB5TkT04VL4RdUOi0GQbjsm
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <84afeffb-14ae-d066-3d2a-0067e9e9d1ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] nbd/client: fix nbd_send_request to
 return int
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-5-vsementsov@virtuozzo.com>
 <20170807082320.GB18259@redhat.com>
 <d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
In-Reply-To: <d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 03:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.08.2017 11:23, Daniel P. Berrange wrote:
>> On Fri, Aug 04, 2017 at 06:14:27PM +0300, Vladimir Sementsov-Ogievskiy=

>> wrote:
>>> Fix nbd_send_request to return int, as it returns a return value
>>> of nbd_write (which is int), and the only user of nbd_send_request's
>>> return value (nbd_co_send_request) consider it as int too.
>> The real problem here is the return value of nbd_write() - it should b=
e
>> a ssize_t, not an int, since it is propagating the return value of
>> nbd_rwv() which is ssize_t.
>=20
> It was changed in f5d406fe86bb (sent in May)
> The discussion actually was started half a year ago:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00825.html
>=20
>=20
>> Basically all functions that do I/O and
>> return the number of bytes read/written should be ssize_t - any use of=

>> int is a bug.

If returning the size matters, then yes, not using ssize_t is a bug.
But if all we need is to know whether an entire expected length was read
(and treat ANY partial read the same as failure), then a mere int
becomes enough to encode the results.

Where I'm less certain is whether this change in semantics simplifies
later patches, or loses information that might have been useful.  But
intuitively, ANY encounter of EOF means that NBD needs to quit trying to
talk to the other end of the socket, whether or not the EOF occurred on
a nice message boundary; and the rest of the protocol is strongly tied
to messages, where we don't act until we have read the entire expected
message; so if a later patch is indeed simpler by not returning bytes
read, this patch might be okay.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iK9WoWgedGfB5TkT04VL4RdUOi0GQbjsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIU9QACgkQp6FrSiUn
Q2r6Hgf+K8yA8ogee9A/+8vpvX4j1guxPjB5tQW2owWRhYv1mKyE6YpyPWWlSFUj
By5OBv/8PsGLtgf0Ey6fooKAaUC6acVb8BBsxqtFtPna0EPAhs8kZLeef6S7ZNEz
b3fZncS1jb1gZHuN3EgPizbW6GYesUexMR6bcaNo0OYpmloibatHnLeUjq4DU0ni
mdpjT885FExJScqYWVCivKVX4xD5sj/QB2rlZancPGvs3Mca/sMy63M4lVU4wqoo
Bsos+S/pfs+Q08r+6AR70gvevvKOWpIpgcKkj62ID2MO26AnpawFZAa6gJW4Jagu
IDSVkaHLYqyjWR+DVP7DDXa41SYZfw==
=MXhx
-----END PGP SIGNATURE-----

--iK9WoWgedGfB5TkT04VL4RdUOi0GQbjsm--
