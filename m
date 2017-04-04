Received: from eggs.gnu.org ([2001:4830:134:3::10]:58378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvPqG-0006lH-Ij
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cvPqC-0008Jt-Mq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:53:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cvPqC-0008J2-DP
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:53:52 -0400
Date: Tue, 4 Apr 2017 16:53:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170404145348.GD4536@noname.str.redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
	<d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.04.2017 um 16:04 hat Paolo Bonzini geschrieben:
> On 04/04/2017 14:16, Kevin Wolf wrote:
> > Just not requesting the
> > write permission initially if runstate_check(RUN_STATE_INMIGRATE) is
> > easy. But we need to find a place to actually request it later, after
> > the mirror has completed, and before the VM is running.
>=20
> Isn't there already a bdrv_invalidate_cache_all or something like that
> called when the VM is started?

bdrv_invalidate_cache_all() is different in two aspects.

First, it starts at the BDS level and propagates down to children, but
not up to the parents, where the permissions are set.

Second, bdrv_invalidate_cache_all() is called immediately when migration
completes. This is before the NBD server is shut down, so we can't
actually request write permissions at this point yet.

> Having to touch all devices would be ugly.  Maybe some permissions could
> be marked as "deferred".

Yes, BlockDevOps for it wasn't that great an idea.

We have a common function blkconf_apply_backend_options() that sets the
permissions for any devices that we care about with storage migration.
This function can be changed not to do this during incoming migration,
and then we would need a way to find the BlockConf later when trying to
resume the VM. Failing that, we could try to make it register a notifier
or something.

Or we could mark BlockBackends as "enforce permissions only after
migration has completed" and do this for all BlockBackends of devices.

> The big question is how this fits into release management.  We have
> another important regression from the op blocker work and only a week
> to go before the last rc.  Are we going to delay 2.9 arbitrarily?  Are
> we going to shorten the 2.10 development period correspondingly?  (I
> vote yes and yes, FWIW).

Which is the other regression?

Kevin

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY47N8AAoJEH8JsnLIjy/WUrMP/2+E8JWm/6qrdCA6/UzUFEqK
VggFyswRWi6T5ux/Pt17zJoloq4Whyqm0PflA8N6heN4dAW+UhEXeAaHpvcjGrgK
DVg7LWmfQ7BNsqwgHE69poIe4g3OHGW3C1l0WLBD/WqarYXF+GqGk9J8BxyqqJDj
8iMuePxie5Qx260IoSwavFqsoaQGCTlDadxJqBjqYuKibFY6gB8n7ezg7c8eMN4x
J6w/gtmGbdFDyvWRU95TydUbtefDhLaVVxfL1IK93w9YL20Puo6zbfOzMRewQeAA
PKbu59xl0s7dRPC//HpybWPz++rHLe01MWwn5jBzEMmQZz5hixob3LNMH6HWnebh
9KIlHCza1MEiWrudSb6ik7DJr0+Je02b5EQYYgjyVXVKcXG7NXPakqRJrxWlQSIu
lPkSKYxqYMcP+hSqkUZUM2+RDuFuZ1qiflikp62P6oXk7JsNF7PxOTl6QqP5lR3P
5ugAmn5oxIC9u/50btZrOiSFbzDgYJ3dO6aeU0afbqzYgcs9MO45wodzPfHdQMWZ
izsrPUoJrMAKRla87vpkhi6+m71E5tBWemaXKWWNTQM4NCeCjZtGAPG09BVbd+Z2
t6IiM7Zb74rxpCdO4K1d1/VlSqhC2waTrEKLRtyKGYWuBGQO+7FWhaRZiYH6rzvq
4/z12zktbpuLB4nE5j4k
=zPbP
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
