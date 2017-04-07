Received: from eggs.gnu.org ([2001:4830:134:3::10]:36621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwS8p-0006XZ-EP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwS8o-0002KJ-9N
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:33:23 -0400
Date: Fri, 7 Apr 2017 12:33:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407113312.GN13602@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7cT1SUwsqXggVRO"
Content-Disposition: inline
In-Reply-To: <CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>


--H7cT1SUwsqXggVRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 09:30:33AM +0800, 858585 jemmy wrote:
> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
> >> From: Lidong Chen <lidongchen@tencent.com>
> >>
> >> when migration with high speed, mig_save_device_bulk invoke
> >> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
> >> this patch limit the time used for bdrv_is_allocated.
> >
> > bdrv_is_allocated() is supposed to yield back to the event loop if it
> > needs to block.  If your VNC session is experiencing jitter then it's
> > probably because a system call in the bdrv_is_allocated() code path is
> > synchronous when it should be asynchronous.
> >
> > You could try to identify the system call using strace -f -T.  In the
> > output you'll see the duration of each system call.  I guess there is a
> > file I/O system call that is taking noticable amounts of time.
>=20
> yes, i find the reason where bdrv_is_allocated needs to block.
>=20
> the mainly reason is caused by qemu_co_mutex_lock invoked by
> qcow2_co_get_block_status.
>     qemu_co_mutex_lock(&s->lock);
>     ret =3D qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
>                                    &cluster_offset);
>     qemu_co_mutex_unlock(&s->lock);
>=20
> other reason is caused by l2_load invoked by
> qcow2_get_cluster_offset.
>=20
>     /* load the l2 table in memory */
>=20
>     ret =3D l2_load(bs, l2_offset, &l2_table);
>     if (ret < 0) {
>         return ret;
>     }

The migration thread is holding the QEMU global mutex, the AioContext,
and the qcow2 s->lock while the L2 table is read from disk.

The QEMU global mutex is needed for block layer operations that touch
the global drives list.  bdrv_is_allocated() can be called without the
global mutex.

The VNC server's file descriptor is not in the BDS AioContext.
Therefore it can be processed while the migration thread holds the
AioContext and qcow2 s->lock.

Does the following patch solve the problem?

diff --git a/migration/block.c b/migration/block.c
index 7734ff7..072fc20 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -276,6 +276,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevS=
tate *bmds)
     if (bmds->shared_base) {
         qemu_mutex_lock_iothread();
         aio_context_acquire(blk_get_aio_context(bb));
+        qemu_mutex_unlock_iothread();
         /* Skip unallocated sectors; intentionally treats failure as
          * an allocated sector */
         while (cur_sector < total_sectors &&
@@ -283,6 +284,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevS=
tate *bmds)
                                   MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
             cur_sector +=3D nr_sectors;
         }
+        qemu_mutex_lock_iothread();
         aio_context_release(blk_get_aio_context(bb));
         qemu_mutex_unlock_iothread();
     }


--H7cT1SUwsqXggVRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY53j4AAoJEJykq7OBq3PIaIUH/ix5o4AjVx4W4utyZruykqPA
N25czkZpc7rzrA3qa9l4KZEKNqGh10huIN/MtaEI32CTWLq+8ZbxtLvb1bbvGn4b
4Fdbg6t4/H9xZOGRrsSQCXl3hWUj6kLpXWWhHSqyLq2M4CftpFWY5RUVdjd0TF9R
8EoQfneuHfr4J/JbqrgqQyhdCx7DVvIF5WqIu3m4krDUo9BUD4n0IqXGmVStTL1m
fd7NdQrkaQoqiUvMCBQAhcR0D5wAgs8VDUS0joY/NW308sBfhd6sRNoQmNXbtUbs
eCwedeZO7WFGN2RVawXNUAkPn4CcKSnvfwy72pSlcvPph2wkd+gOt+knJJsKpuY=
=8heB
-----END PGP SIGNATURE-----

--H7cT1SUwsqXggVRO--
