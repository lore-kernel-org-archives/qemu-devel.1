Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evqLz-0004oC-QM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evqLy-0003AP-MZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:16:59 -0400
References: <152090675906.39.6932440748522025318@71c20359a636>
	<2ccc79fb-1454-85db-5e31-c18a67a32b7c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f63c2e9a-a52f-e028-8bd7-50ea9d3310f9@redhat.com>
Date: Tue, 13 Mar 2018 15:16:35 -0500
MIME-Version: 1.0
In-Reply-To: <2ccc79fb-1454-85db-5e31-c18a67a32b7c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, vsementsov@virtuozzo.com
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com

On 03/12/2018 10:11 PM, Eric Blake wrote:

>>
>=20
>> =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block/nbd-client.o
>> =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block/sheepdog.o
>> /var/tmp/patchew-tester-tmp-erqpie2w/src/block/nbd-client.c: In=20
>> function =E2=80=98nbd_client_co_block_status=E2=80=99:
>> /var/tmp/patchew-tester-tmp-erqpie2w/src/block/nbd-client.c:890:15:=20
>> error: =E2=80=98extent.flags=E2=80=99 may be used uninitialized in thi=
s function=20
>> [-Werror=3Dmaybe-uninitialized]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent extent;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~
>> /var/tmp/patchew-tester-tmp-erqpie2w/src/block/nbd-client.c:925:19:=20
>> error: =E2=80=98extent.length=E2=80=99 may be used uninitialized in th=
is function=20
>> [-Werror=3Dmaybe-uninitialized]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pnum =3D extent.length;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ~~~~~~^~~~~~~
>=20
> May be a false positive where the compiler merely can't see through the=
=20
> logic, or it might be a real bug; but I suspect either way that the=20
> solution is to initialize this (I'm guessing patch 5), as in:
>=20
> NBDExtent extent =3D { 0 };

Not a sufficient fix - it's probably a real bug in that extent is never=20
initialized if the NBD_FOREACH_REPLY_CHUNK() loop in=20
nbd_co_receive_blockstatus_reply() never encounters an=20
NBD_REPLY_TYPE_BLOCK_STATUS chunk.  A malicious server could just reply=20
with NBD_REPLY_TYPE_NONE (no status reported after all), but the block=20
layer contract requires us to make progress or return an error.  So, if=20
the server didn't give us any extents, we need to turn it into an error=20
even if the server did not.

>=20
> Will squash that in when I get to that part of the review.
>=20

And I forgot to do it before the pull request v1, oops.  Here's what I'm=20
squashing in for v2:

diff --git i/block/nbd-client.c w/block/nbd-client.c
index be160052cb1..486d73f1c63 100644
--- i/block/nbd-client.c
+++ w/block/nbd-client.c
@@ -694,6 +694,7 @@ static int=20
nbd_co_receive_blockstatus_reply(NBDClientSession *s,
      Error *local_err =3D NULL;
      bool received =3D false;

+    extent->length =3D 0;
      NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
                              NULL, &reply, &payload)
      {
@@ -734,6 +735,13 @@ static int=20
nbd_co_receive_blockstatus_reply(NBDClientSession *s,
          payload =3D NULL;
      }

+    if (!extent->length && !iter.err) {
+        error_setg(&iter.err,
+                   "Server did not reply with any status extents");
+        if (!iter.ret) {
+            iter.ret =3D -EIO;
+        }
+    }
      error_propagate(errp, iter.err);
      return iter.ret;
  }
@@ -919,6 +927,7 @@ int coroutine_fn=20
nbd_client_co_block_status(BlockDriverState *bs,
          return ret;
      }

+    assert(extent.length);
      *pnum =3D extent.length;
      return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
             (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
