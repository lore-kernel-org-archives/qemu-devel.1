Received: from eggs.gnu.org ([2001:4830:134:3::10]:38060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgIAs-00055O-Ls
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 18:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgIAr-0003Ao-1n
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 18:12:58 -0400
References: <20170811023759.26390-1-eblake@redhat.com>
	<20170811023759.26390-2-eblake@redhat.com>
	<29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
	<7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
	<c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
	<325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
	<d48ab0e7-6ccf-8823-dab9-c5350f95b239@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8754399-cbe6-325c-cb4e-07e47fd08cf0@redhat.com>
Date: Fri, 11 Aug 2017 17:12:47 -0500
MIME-Version: 1.0
In-Reply-To: <d48ab0e7-6ccf-8823-dab9-c5350f95b239@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rbNWBuNK87KXdMf1uHBTPE0L4UiwJwRnR"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server
 is detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rbNWBuNK87KXdMf1uHBTPE0L4UiwJwRnR
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <d8754399-cbe6-325c-cb4e-07e47fd08cf0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server is
 detected
References: <20170811023759.26390-1-eblake@redhat.com>
 <20170811023759.26390-2-eblake@redhat.com>
 <29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
 <7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
 <c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
 <325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
 <d48ab0e7-6ccf-8823-dab9-c5350f95b239@redhat.com>
In-Reply-To: <d48ab0e7-6ccf-8823-dab9-c5350f95b239@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 03:01 PM, Eric Blake wrote:
> On 08/11/2017 02:41 PM, Eric Blake wrote:
>>> Hmm, was it correct even before your patch? Is it safe to enter a cor=
outine
>>> (which we've scheduled by nbd_recv_coroutines_enter_all()), which is
>>> actually
>>> yielded inside nbd_rwv (not our yield in nbd_co_receive_reply)?
>>
>> I'm honestly not sure how to answer the question. In my testing, I was=

>> unable to catch a coroutine yielding inside of nbd_rwv();
>=20
> Single stepping through nbd_rwv(), I see that I/O is performed by
> sendmsg(), which either gets the message sent or, because of nonblockin=
g
> mode, fails with EAGAIN, which gets turned into QIO_CHANNEL_ERR_BLOCK
> and indeed a call to qemu_channel_yield() within nbd_rwv() - but it's
> timing sensitive, so I still haven't been able to provoke this scenario=

> using gdb.

With this compiled into the client:

diff --git i/nbd/common.c w/nbd/common.c
index a2f28f2eec..f10e991eed 100644
--- i/nbd/common.c
+++ w/nbd/common.c
@@ -36,6 +36,10 @@ ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov,
size_t niov, size_t length,

     while (nlocal_iov > 0) {
         ssize_t len;
+        static int hack;
+        if (hack) {
+            len =3D QIO_CHANNEL_ERR_BLOCK;
+        } else
         if (do_read) {
             len =3D qio_channel_readv(ioc, local_iov, nlocal_iov, errp);=

         } else {

I was able to set a breakpoint in gdb to temporarily manipulate 'hack'
at the right moment, in order to trigger what would happen if a
nbd_rwv() hit EAGAIN.  And sadly, I got a segfault using my patches,
because the last reference to ioc had been cleared in the meantime.


Program received signal SIGSEGV, Segmentation fault.
0x000055555562ee94 in object_class_dynamic_cast_assert
(class=3D0x555555d9d1b0,
    typename=3D0x5555556c856d "qio-channel", file=3D0x5555556c8560
"io/channel.c",
    line=3D75, func=3D0x5555556c8670 <__func__.21506> "qio_channel_writev=
_full")
    at qom/object.c:705
705	    trace_object_class_dynamic_cast_assert(class ? class->type->name
: "(null)",


#0  0x000055555562ee94 in object_class_dynamic_cast_assert (
    class=3D0x555555d9d1b0, typename=3D0x5555556c856d "qio-channel",
    file=3D0x5555556c8560 "io/channel.c", line=3D75,
    func=3D0x5555556c8670 <__func__.21506> "qio_channel_writev_full")
    at qom/object.c:705
#1  0x000055555562312d in qio_channel_writev_full (ioc=3D0x555555d9bde0,
    iov=3D0x555555d9ec90, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at
io/channel.c:75
#2  0x0000555555623233 in qio_channel_writev (ioc=3D0x555555d9bde0,
    iov=3D0x555555d9ec90, niov=3D1, errp=3D0x0) at io/channel.c:102
#3  0x0000555555603590 in nbd_rwv (ioc=3D0x555555d9bde0, iov=3D0x555555d9=
ecd0,
    niov=3D1, length=3D1048576, do_read=3Dfalse, errp=3D0x0) at nbd/commo=
n.c:46
#4  0x00005555555ebcca in nbd_co_send_request (bs=3D0x555555d94260,
    request=3D0x7fffda2819f0, qiov=3D0x555555d9ee88) at block/nbd-client.=
c:152


My next test is whether incrementing the ref-count to s->ioc for the
duration of nbd_co_send_request() is adequate to protect against this
problem:

diff --git i/block/nbd-client.c w/block/nbd-client.c
index 28b10f3fa2..cb0c4ebedf 100644
--- i/block/nbd-client.c
+++ w/block/nbd-client.c
@@ -147,6 +147,11 @@ static int nbd_co_send_request(BlockDriverState *bs,=

         return -EPIPE;
     }

+    /*
+     * Make sure ioc stays live, even if another coroutine decides to
+     * kill the connection because of a server error.
+     */
+    object_ref(OBJECT(ioc));
     if (qiov) {
         qio_channel_set_cork(ioc, true);
         rc =3D nbd_send_request(ioc, request);
@@ -161,6 +166,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
     } else {
         rc =3D nbd_send_request(ioc, request);
     }
+    object_unref(OBJECT(ioc));
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
 }

and that got further, only to crash at:

(gdb) c
Continuing.
readv failed: Input/output error
aio_write failed: Input/output error
qemu-io: block/block-backend.c:1211: blk_aio_write_entry: Assertion
`!rwco->qiov || rwco->qiov->size =3D=3D acb->bytes' failed.

where rwco->qiov->size was garbage.

At this point, while I still think it might be possible to come up with
a less-invasive  solution than your v2 patch, I'm also at the point
where I want the bug fixed rather than me wallowing around trying to
debug coroutine interactions; and thus I'm leaning towards your v2 patch
as being more likely to be robust in the face of concurrency (it's not
killing ioc while other coroutines still exist, so much as just making
sure that every yield point checks if the kill switch has been triggered
for a short-circuit exit).  So I will probably be taking your version
and creating a pull request for -rc3 on Monday.  (Before I fully ack
your version, though, I _will_ be hammering at it under gdb the same way
I hammered at mine)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rbNWBuNK87KXdMf1uHBTPE0L4UiwJwRnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmOK98ACgkQp6FrSiUn
Q2rjhwf+KPpJpShBfw56tfmOY8hYzSGKIg6s9Me6Mxq/wcJfF6gtp6MWbn/XzX8f
tqRLDjrjDxc8qIEzMTVc8uTUSbABbaYsfv5b95d5KwHT8uQSNU8UnPpl1S3BMtzr
Pna36dSFcVL6EfM1N2IgvX8V5LcfuP2Fdmp/mCloF9FAMa4tRY5jdFk8bZh9zYyE
dTiJo5v2n2IXfQ1gKz6YszjyAO58UguJmI7FUv/Zq9N/0BaTi2FrcsZs1JtHjVXb
B637u9y5z9o4GP8I2M7A+lqUO1PHLfoUZ7Q+P79j9K2ggFuzCoduoBXnefFlARJx
+8joz3KG+aFy+tZ9QvSm70b58ZIqIg==
=SoOG
-----END PGP SIGNATURE-----

--rbNWBuNK87KXdMf1uHBTPE0L4UiwJwRnR--
