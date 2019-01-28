Received: from eggs.gnu.org ([209.51.188.92]:47857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1goDHv-00086v-9d
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1goDHu-0001QI-DG
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:13:47 -0500
References: <20180920161958.27453-1-kwolf@redhat.com>
	<20180920161958.27453-14-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d4de9cce-c8fb-b400-202b-fcec821fd804@redhat.com>
Date: Mon, 28 Jan 2019 21:13:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180920161958.27453-14-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ueLmHCJvMWBbKbw98r9rUMMQrmFvdCreR"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 13/19] block: Remove
 aio_poll() in bdrv_drain_poll variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, slp@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ueLmHCJvMWBbKbw98r9rUMMQrmFvdCreR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, slp@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Message-ID: <d4de9cce-c8fb-b400-202b-fcec821fd804@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 13/19] block: Remove aio_poll() in
 bdrv_drain_poll variants
References: <20180920161958.27453-1-kwolf@redhat.com>
 <20180920161958.27453-14-kwolf@redhat.com>
In-Reply-To: <20180920161958.27453-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.09.18 18:19, Kevin Wolf wrote:
> bdrv_drain_poll_top_level() was buggy because it didn't release the
> AioContext lock of the node to be drained before calling aio_poll().
> This way, callbacks called by aio_poll() would possibly take the lock a=

> second time and run into a deadlock with a nested AIO_WAIT_WHILE() call=
=2E
>=20
> However, it turns out that the aio_poll() call isn't actually needed an=
y
> more. It was introduced in commit 91af091f923, which is effectively
> reverted by this patch. The cases it was supposed to fix are now covere=
d
> by bdrv_drain_poll(), which waits for block jobs to reach a quiescent
> state.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 8 --------
>  1 file changed, 8 deletions(-)

Hm...  While looking at iotest 129 (which I think is broken because it
tries to use BB-level throttling which doesn't do anything for the
mirror job), I noticed this:

$ x86_64-softmmu/qemu-system-x86_64 \
    -object throttle-group,id=3Dtg0 \
    -drive node-name=3Dnode0,driver=3Dthrottle,\
throttle-group=3Dtg0,file.driver=3Dqcow2,file.file.driver=3Dfile,\
file.file.filename=3D/tmp/src.qcow2 -qmp stdio \
<<EOF
{"execute":"qmp_capabilities"}
{"execute":"drive-mirror","arguments":{"device":"node0",
 "target":"/tmp/tgt.qcow2","sync":"full","format":"qcow2",
  "mode":"absolute-paths","job-id":"mirror-job0"}}
{"execute":"block-job-cancel",
 "arguments":{"device":"mirror-job0","force":true}}
{"execute":"quit"}
EOF

[...]
qemu-system-x86_64: block/block-backend.c:2211: blk_root_drained_end:
Assertion `blk->quiesce_counter' failed.
[1]    2722 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64
-object throttle-group,id=3Dtg0 -drive  -qmp

(Which worked before commit 4cf077b59fc73eec29f8b7d082919dbb278bdc86,
i.e. this one.)

Max


--ueLmHCJvMWBbKbw98r9rUMMQrmFvdCreR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxPYlsACgkQ9AfbAGHV
z0BTzQf+MQSs8MEh4ZQKYKwWXmXPaYjnWbW9fGm2G/xid8nJgDq6UqkUS2fG/SYl
KAXGXJjgFiLYykpkZ9kT1vEulogW1RipmrHOIdHeaH/5hF+FBn/xfxxmg2WZK+DE
IRBLugXdw2vSz0EBr70FM2di4fEdG3rnUj4xiJlh00YoYK6DiMEzubPSkW608t9A
zoOi1K0bZDPwRWSZzlZqfdcTCeXClPCrZ8z9cPi8HWa8Fpw4DIJKw0+mM9JBufyz
POzOA0n6MADD42ORchInUwoI2GR6zHt83E3NMoe3i1vf5CmjobeC8krFHnSxJurI
wJCoRnhLntxrmIEpQzezcmnujvGUEw==
=9lrJ
-----END PGP SIGNATURE-----

--ueLmHCJvMWBbKbw98r9rUMMQrmFvdCreR--
