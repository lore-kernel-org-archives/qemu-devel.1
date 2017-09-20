Received: from eggs.gnu.org ([2001:4830:134:3::10]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAX-000260-PC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAW-00013r-Vl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:01 -0400
Date: Wed, 20 Sep 2017 13:34:17 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170920103417.kch7vp6dcn2bueqb@postretch>
References: <20170920101740.12490-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceqgzs4mlbxnzqij"
Content-Disposition: inline
In-Reply-To: <20170920101740.12490-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>


--ceqgzs4mlbxnzqij
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 11:17:40AM +0100, Stefan Hajnoczi wrote:
>Clear tg->any_timer_armed[] when throttling timers are destroyed during
>AioContext attach/detach.  Failure to do so causes throttling to hang
>because we believe the timer is already scheduled!
>
>The following was broken at least since QEMU 2.10.0 with -drive
>iops=3D100:
>
>  $ dd if=3D/dev/zero of=3D/dev/vdb oflag=3Ddirect count=3D1000
>  (qemu) stop
>  (qemu) cont
>  ...I/O is stuck...
>
>Reported-by: Yongxue Hong <yhong@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>


>v2:
> * Use timer_pending(tt->timers[i]) instead of token [Berto]
> * Fix s/destroy/destroyed/ typo [Eric]
>
> block/throttle-groups.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/block/throttle-groups.c b/block/throttle-groups.c
>index 6ba992c8d7..0a49f3c409 100644
>--- a/block/throttle-groups.c
>+++ b/block/throttle-groups.c
>@@ -592,6 +592,17 @@ void throttle_group_attach_aio_context(ThrottleGroupM=
ember *tgm,
> void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
> {
>     ThrottleTimers *tt =3D &tgm->throttle_timers;
>+    ThrottleGroup *tg =3D container_of(tgm->throttle_state, ThrottleGroup=
, ts);
>+
>+    qemu_mutex_lock(&tg->lock);
>+    if (timer_pending(tt->timers[0])) {
>+        tg->any_timer_armed[0] =3D false;
>+    }
>+    if (timer_pending(tt->timers[1])) {
>+        tg->any_timer_armed[1] =3D false;
>+    }
>+    qemu_mutex_unlock(&tg->lock);
>+
>     throttle_timers_detach_aio_context(tt);
>     tgm->aio_context =3D NULL;
> }
>--=20
>2.13.5
>
>

--ceqgzs4mlbxnzqij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnCRCkACgkQc2J8L2kN
9xDXHRAAlLDtKSVH9vf4nVJ1KsSHN0B18oB4PyDYZeTFZfURDz3E9IKv8nI0qFXN
D64eQgPLIZpuFXv90pplXy/gDGjfxOq8f1UVNRoPYYJQaPJKpiZsv6q2j57BbLtS
v9mYwbCXkNybIVsXrZ3+8gmLk01E/cGV5lJGbJp31rBIGakm6HygtxAg9+nnI2M+
V5IUdI4cs/dFsVXUub1rwHp9N5cAe4Di0vWtPvcpkyjC1Pl4kR1SAKqNdhEeZVGZ
NAuQFkgPeAsGeQpBPytb1QoPkbLW5iMWy7Xxl9p4FfFd+8H2UvINzA/lwg2WXWPQ
wtR2hKt1A63871lWBf3E3K/5zBcrAGsAEBqP/O4Qnc+YpEj7dWei8BWCbmsg6+9u
C9eaNiEVNXaGRK7XlsrcUIyhzP9eJfdFr4pG4d9d7O9eTNVjxZYBQ+YIpp1LtVh2
df+DxiTfU7WrR7VL7st5Qrdq088lW1QV3XXbDgVFTtjeM6+QCsyGuA+cITeyD5Vo
dM8i9nCt2mkkhWWUPiqhWNRAmh3laed1Q5XHzczA1CTjovSEzwbR/S/giJY0vJyu
lmyoxEDXRXTuAcVK2eUbcybmw/69OLO25oiQxWEcD9JSK5Tm86MvYMrcyxIc0uU5
3PRw2U4slfqHD2ehIvQ8pAQyTnMb4xj0S9Qaxu6zNckUPj+Em9k=
=fSh5
-----END PGP SIGNATURE-----

--ceqgzs4mlbxnzqij--
