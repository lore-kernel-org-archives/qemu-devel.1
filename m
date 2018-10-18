Received: from eggs.gnu.org ([2001:4830:134:3::10]:57522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD5ij-0004XE-Q6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD5ig-0000Js-ET
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:40:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD5ig-0000JC-3C
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:39:58 -0400
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-3-xiaoguangrong@tencent.com>
	<873d9b11-3643-28d1-e7d8-44657402fa56@redhat.com>
	<fb967d04-d189-5bc4-4747-27ad8342d526@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eccc2932-0d2f-aca5-5425-d4a04e080d2b@redhat.com>
Date: Thu, 18 Oct 2018 12:39:46 +0200
MIME-Version: 1.0
In-Reply-To: <fb967d04-d189-5bc4-4747-27ad8342d526@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, "Emilio G. Cota" <cota@braap.org>

On 18/10/2018 11:30, Xiao Guangrong wrote:
> Beside that... i think we get the chance to remove ptr_ring gracefully,
> as the bitmap can indicate the ownership of the request as well. If
> the bit is 1 (supposing all bits are 1 on default), only the user can
> operate it, the bit will be cleared after the user fills the info
> to the request. After that, the thread sees the bit is cleared, then
> it gets the ownership and finishes the request, then sets bit in
> the bitmap. The ownership is returned to the user again.

Yes, even better. :)

> One thing may be disadvantage is, it can't differentiate the case if th=
e
> request is empty or contains the result which need the user call
> threads_wait_done(), that will slow threads_wait_done() a little as it
> need check all requests, but it is not a big deal as
> 1) at the point needing flush, it's high possible that all most request=
s
> =C2=A0=C2=A0 have been used.
> 2) the total number of requests is going to be very small.

threads_wait_done only needs to check bitmap_equal for the two bitmaps,
no?  (I'm not sure if, with the code below, it would be bitmap_equal or
"all bits are different", i.e. xor is all ones.  But it's a trivial chang=
e).

>=20
> It is illustrated by following code by combining the "flip" bitmaps:
>=20
> struct Threads {
> =C2=A0=C2=A0 ......
>=20
> =C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0 * the bit in these two bitmaps indicates the index o=
f the requests
> =C2=A0=C2=A0=C2=A0 * respectively. If it's the same, the request is own=
ed by the user,
> =C2=A0=C2=A0=C2=A0 * i.e, only the use can use the request. Otherwise, =
it is owned by
> =C2=A0=C2=A0=C2=A0 * the thread.
> =C2=A0=C2=A0=C2=A0 */
>=20
> =C2=A0=C2=A0 /* after the user fills the request, the bit is flipped. *=
/
> =C2=A0=C2=A0 unsigned long *request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_=
BYTES);
>=20
> =C2=A0=C2=A0 /* after handles the request, the thread flips the bit. */
> =C2=A0=C2=A0 unsigned long *request_done_bitmap QEMU_ALIGNED(SMP_CACHE_=
BYTES);
> }

Note that the pointers need not be aligned, because they are only read.
 It's the data that should be aligned instead (qemu_memalign to allocate
it).

> threads_submit_request_prepare()
> {
> =C2=A0=C2=A0=C2=A0=C2=A0request_done_bitmap =3D READ_ONCE(threads->requ=
est_done_bitmap);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result_bitmap =3D bitmap_xor=
(&request_done_bitmap,
> threads->request_fill_bitmap);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0index =3D find_first_zero_bit(current-thread-to=
-request-index,
> &result_bitmap);

find_next_zero_bit.

> =C2=A0=C2=A0=C2=A0=C2=A0/* make sure we get the data the thread written=
. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_rmb();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread_request_done(requests=
[index]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> }
>=20
> threads_submit_request_commit()
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* make sure the user have f=
illed the request before we make it
> be viable to the threads. */
> =C2=A0=C2=A0=C2=A0=C2=A0smp_wmb();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0/* after that, the thread can handle the reques=
t. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_change_bit(request-to=
-index, threads->request_fill_bitmap);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ......
> }
>=20
> In the thread, it does:
> thread_run()
> {
> =C2=A0=C2=A0=C2=A0=C2=A0index_start =3D threads->requests + itself->ind=
ex *
> threads->thread_ring_size;
> =C2=A0=C2=A0=C2=A0=C2=A0index_end =3D index_start + threads->thread_rin=
g_size;
>=20
> loop:
> =C2=A0=C2=A0=C2=A0=C2=A0request_fill_bitmap =3D READ_ONCE(threads->requ=
est_fill_bitmap);
> =C2=A0=C2=A0=C2=A0=C2=A0request_done_bitmap =3D READ_ONCE(threads->requ=
est_done_bitmap);

No need for READ_ONCE (atomic_read in QEMU), as the pointers are never
written.  Technically READ_ONCE _would_ be needed in bitmap_xor.  Either
just ignore the issue or write a find_{equal,different}_bit yourself in
util/threads.c, so that it can use atomic_read.

> =C2=A0=C2=A0=C2=A0=C2=A0result_bitmap =3D bitmap_xor(&request_fill_bitm=
ap, &request_done_bitmap);
> =C2=A0=C2=A0=C2=A0=C2=A0index =3D find_first_bit_set(&result_bitmap, .s=
tart =3D index_start,
> .end =3D index_end);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * paired with smp_wmb(=
) in threads_submit_request_commit to
> make sure the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * thread can get data =
filled by the user.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0smp_rmb();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0request =3D threads->requests[index];
> =C2=A0=C2=A0=C2=A0=C2=A0thread_request_handler(request);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * updating the request=
 is viable before flip the bitmap, paired
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with smp_rmb() in th=
reads_submit_request_prepare().
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0smp_wmb();

No need for smp_wmb before atomic_xor.

> =C2=A0=C2=A0=C2=A0=C2=A0bitmap_change_bit_atomic(&threads->request_done=
_bitmap, index);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ......
> }
