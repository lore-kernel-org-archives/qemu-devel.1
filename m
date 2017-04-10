Received: from eggs.gnu.org ([2001:4830:134:3::10]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxZjq-0004yB-HY
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxZjp-0008Mh-1K
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:52:14 -0400
Date: Mon, 10 Apr 2017 14:52:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410135203.GA20631@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
	<20170407113450.GO13602@stefanha-x1.localdomain>
	<CAOGPPbcf6bPXmVGFcw3niNznPx1BHsA=uR2G0sN=AV6xhWXMrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <CAOGPPbcf6bPXmVGFcw3niNznPx1BHsA=uR2G0sN=AV6xhWXMrA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] migration/block:limit the
 time used for block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 08, 2017 at 09:17:58PM +0800, 858585 jemmy wrote:
> On Fri, Apr 7, 2017 at 7:34 PM, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Fri, Apr 07, 2017 at 09:30:33AM +0800, 858585 jemmy wrote:
> >> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> >> > On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrot=
e:
> >> >
> >> > A proper solution is to refactor the synchronous code to make it
> >> > asynchronous.  This might require invoking the system call from a
> >> > thread pool worker.
> >> >
> >>
> >> yes, i agree with you, but this is a big change.
> >> I will try to find how to optimize this code, maybe need a long time.
> >>
> >> this patch is not a perfect solution, but can alleviate the problem.
> >
> > Let's try to understand the problem fully first.
> >
>=20
> when migrate the vm with high speed, i find vnc response slowly sometime.
> not only vnc response slowly, virsh console aslo response slowly sometime.
> and the guest os block io performance is also reduce.
>=20
> the bug can be reproduce by this command:
> virsh migrate-setspeed 165cf436-312f-47e7-90f2-f8aa63f34893 900
> virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
> --copy-storage-inc qemu+ssh://10.59.163.38/system
>=20
> and --copy-storage-all have no problem.
> virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
> --copy-storage-all qemu+ssh://10.59.163.38/system
>=20
> compare the difference between --copy-storage-inc and
> --copy-storage-all. i find out the reason is
> mig_save_device_bulk invoke bdrv_is_allocated, but bdrv_is_allocated
> is synchronous and maybe wait
> for a long time.
>=20
> i write this code to measure the time used by  brdrv_is_allocated()
>=20
>  279     static int max_time =3D 0;
>  280     int tmp;
>=20
>  288             clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
>  289             ret =3D bdrv_is_allocated(blk_bs(bb), cur_sector,
>  290                                     MAX_IS_ALLOCATED_SEARCH, &nr_sec=
tors);
>  291             clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
>  292
>  293
>  294             tmp =3D  (ts2.tv_sec - ts1.tv_sec)*1000000000L
>  295                            + (ts2.tv_nsec - ts1.tv_nsec);
>  296             if (tmp > max_time) {
>  297                max_time=3Dtmp;
>  298                fprintf(stderr, "max_time is %d\n", max_time);
>  299             }
>=20
> the test result is below:
>=20
>  max_time is 37014
>  max_time is 1075534
>  max_time is 17180913
>  max_time is 28586762
>  max_time is 49563584
>  max_time is 103085447
>  max_time is 110836833
>  max_time is 120331438
>=20
> bdrv_is_allocated is called after qemu_mutex_lock_iothread.
> and the main thread is also call qemu_mutex_lock_iothread.
> so cause the main thread maybe wait for a long time.
>=20
>    if (bmds->shared_base) {
>         qemu_mutex_lock_iothread();
>         aio_context_acquire(blk_get_aio_context(bb));
>         /* Skip unallocated sectors; intentionally treats failure as
>          * an allocated sector */
>         while (cur_sector < total_sectors &&
>                !bdrv_is_allocated(blk_bs(bb), cur_sector,
>                                   MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>             cur_sector +=3D nr_sectors;
>         }
>         aio_context_release(blk_get_aio_context(bb));
>         qemu_mutex_unlock_iothread();
>     }
>=20
> #0  0x00007f107322f264 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00007f107322a508 in _L_lock_854 () from /lib64/libpthread.so.0
> #2  0x00007f107322a3d7 in pthread_mutex_lock () from /lib64/libpthread.so=
=2E0
> #3  0x0000000000949ecb in qemu_mutex_lock (mutex=3D0xfc51a0) at
> util/qemu-thread-posix.c:60
> #4  0x0000000000459e58 in qemu_mutex_lock_iothread () at /root/qemu/cpus.=
c:1516
> #5  0x0000000000945322 in os_host_main_loop_wait (timeout=3D28911939) at
> util/main-loop.c:258
> #6  0x00000000009453f2 in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:517
> #7  0x00000000005c76b4 in main_loop () at vl.c:1898
> #8  0x00000000005ceb77 in main (argc=3D49, argv=3D0x7fff921182b8,
> envp=3D0x7fff92118448) at vl.c:4709

The following patch moves bdrv_is_allocated() into bb's AioContext.  It
will execute without blocking other I/O activity.

Compile-tested only.

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..a5572a4 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -263,6 +263,29 @@ static void blk_mig_read_cb(void *opaque, int ret)
     blk_mig_unlock();
 }

+typedef struct {
+    int64_t *total_sectors;
+    int64_t *cur_sector;
+    BlockBackend *bb;
+    QemuEvent event;
+} MigNextAllocatedClusterData;
+
+static void coroutine_fn mig_next_allocated_cluster(void *opaque)
+{
+    MigNextAllocatedClusterData *data =3D opaque;
+    int nr_sectors;
+
+    /* Skip unallocated sectors; intentionally treats failure as
+     * an allocated sector */
+    while (*data->cur_sector < *data->total_sectors &&
+           !bdrv_is_allocated(blk_bs(data->bb), *data->cur_sector,
+                              MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
+        *data->cur_sector +=3D nr_sectors;
+    }
+
+    qemu_event_set(&data->event);
+}
+
 /* Called with no lock taken.  */

 static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
@@ -274,17 +297,27 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDe=
vState *bmds)
     int nr_sectors;

     if (bmds->shared_base) {
+        /* Searching for the next allocated cluster can block.  Do it in a
+         * coroutine inside bb's AioContext.  That way we don't need to ho=
ld
+         * the global mutex while blocked.
+         */
+        AioContext *bb_ctx;
+        Coroutine *co;
+        MigNextAllocatedClusterData data =3D {
+            .cur_sector =3D &cur_sector,
+            .total_sectors =3D &total_sectors,
+            .bb =3D bb,
+        };
+
+        qemu_event_init(&data.event, false);
+
         qemu_mutex_lock_iothread();
-        aio_context_acquire(blk_get_aio_context(bb));
-        /* Skip unallocated sectors; intentionally treats failure as
-         * an allocated sector */
-        while (cur_sector < total_sectors &&
-               !bdrv_is_allocated(blk_bs(bb), cur_sector,
-                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
-            cur_sector +=3D nr_sectors;
-        }
-        aio_context_release(blk_get_aio_context(bb));
+        bb_ctx =3D blk_get_aio_context(bb);
         qemu_mutex_unlock_iothread();
+
+        co =3D qemu_coroutine_create(mig_next_allocated_cluster, &data);
+        aio_co_schedule(bb_ctx, co);
+        qemu_event_wait(&data.event);
     }
=20
     if (cur_sector >=3D total_sectors) {

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY644DAAoJEJykq7OBq3PIxqcH/iDjsBdEohMBM06V6Dv47CxL
3P56Gw936EdL2Q3OQDCIKQvprDHC/Yq/LBrtK/CznaIn3FnmAYeuGYBguERS0KjI
fRbzFfdF8hFkfSmv87iKpVSRtuLbJJI/VYhEiZA/BWw3KtbyZRYvm4EtGJuhidQ0
Og5pb3EB99bgwruCdqZqYg6fGmum/UWq8LWtxB3I2xB50sx+OxCxO3xxRYzDzflz
etrwB9n4E/60t1T9AE2O5s1vp56IVhyuHi033HEHzz1L+qLcMEwXx9BN1+15X1Hk
QLvnduK9orZtu/W5Mt1SZiHRpjfK9+7oygM9JH3jHFhfwBB4Q+nTchd1q/2SVmo=
=2Hw4
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
