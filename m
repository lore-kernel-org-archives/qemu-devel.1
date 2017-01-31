Received: from eggs.gnu.org ([2001:4830:134:3::10]:50095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnn-0000MJ-PS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnm-0001Uw-UM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:51 -0500
Date: Tue, 31 Jan 2017 10:20:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131102035.GA18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 00/21] new backup architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:43PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> This is a new architecture for backup. It solves some current problems:
> 1. intersecting requests: for now at request start we wait for all inters=
ecting requests, which means that
>     a. we may wait even for unrelated to our request clusters
>     b. not full async: if we are going to copy clusters 1,2,3,4, when 2 a=
nd 4 are in flight, why should we wait for 2 and 4 to be fully copied? Why =
not to start 1 and 3 in parallel with 2 and 4?
>=20
> 2. notifier request is internally synchronous: if notifier starts copying=
 clusters 1,2,3,4, they will be copied one by one in synchronous loop.
>=20
> 3. notifier wait full copying of corresponding clusters (when actually it=
 may wait only for _read_ operations to be finished)

Please include benchmark results since this is a performance
optimization.  I think this new level of complexity is worth it because
it should be possible to achieve significantly higher throughput, but
data is still necessary.

The cover letter mentions spawning 24 coroutines.  Did you compare the
memory footprint against the old backup architecture?  Sometimes users
complain when they notice QEMU using significantly more memory than in
previous versions.  If there's a good justification or a way to minimize
the impact then it's fine, but please check.

Stefan

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkGTzAAoJEJykq7OBq3PI+KEH/151YV4VYeUWRpSbA2V4iYPC
p9nRnKqvxaoUNfZFAQSgSn1D7RGv5IiRO3Sc40iZKABEI3dKZ9Tz0xu+VO5xr6uF
+SwjMiAkdC0jqz4grkOVk/ylGoAjRyGomqr45LQojbeuQfTX9PxC0EWW1eQfAgKH
CFvdJHpYJpZyiPAVK/k8ZkA22v+wex8AIYaV7/tMcXosxjggxJFnKLgMikb6Vj72
X8PvevM0/dc7Cv3GDbycoXBVxqMwMUNyfs9wGuqhF7DShb4yKX4ahRkHaFXVBeEZ
3cpLnWJQbYpfG/lWjBKoz576O7JVgIIpXEPY3W6UAOQdWoppJoUOdGYgRvt35+s=
=TxNC
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
