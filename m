Received: from eggs.gnu.org ([2001:4830:134:3::10]:46959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOiH1-0006G3-OM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOi4g-00035S-66
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:50:43 -0500
Date: Mon, 19 Nov 2018 12:50:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181119115032.GD8066@localhost.localdomain>
References: <20181107121319.GC14842@redhat.com>
	<20181107143628.GG8125@redhat.com>
	<CAMRbyyuFGVtNWF9LKoi0n6_r5Gr4j8LetbAMd0L_5cKMif9LjQ@mail.gmail.com>
	<20181107172737.GB4721@linux.fritz.box>
	<CAMRbyys2XVgjPx9HteGP8c6R5rPM=n86m30kfEG6a0+c-jLZ4g@mail.gmail.com>
	<CAMRbyytm2qY6ucuaMSAXaw=BhjG9BGoyU_6Xi_YC+fzBaP754Q@mail.gmail.com>
	<CAMRbyyubqi1QgpDcnxrObVLfzRYODeHfz5qbYfjoeda4SgsbMw@mail.gmail.com>
	<20181116152604.GB5066@localhost.localdomain>
	<CAMRbyytf-NU3QgYoqbTvNR1f-FfA9DxRzUb+-oZGx=34qFXi5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyytf-NU3QgYoqbTvNR1f-FfA9DxRzUb+-oZGx=34qFXi5g@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] Change in qemu 2.12 causes qemu-img
 convert to NBD to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>

Am 17.11.2018 um 21:59 hat Nir Soffer geschrieben:
> On Fri, Nov 16, 2018 at 5:26 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
> > Am 15.11.2018 um 23:27 hat Nir Soffer geschrieben:
> > > On Sun, Nov 11, 2018 at 6:11 PM Nir Soffer <nsoffer@redhat.com> wrote:
> > >
> > > > On Wed, Nov 7, 2018 at 7:55 PM Nir Soffer <nsoffer@redhat.com> wrote:
> > > >
> > > >> On Wed, Nov 7, 2018 at 7:27 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > >>
> > > >>> Am 07.11.2018 um 15:56 hat Nir Soffer geschrieben:
> > > >>> > Wed, Nov 7, 2018 at 4:36 PM Richard W.M. Jones <rjones@redhat.com>
> > > >>> wrote:
> > > >>> >
> > > >>> > > Another thing I tried was to change the NBD server (nbdkit) so
> > that
> > > >>> it
> > > >>> > > doesn't advertise zero support to the client:
> > > >>> > >
> > > >>> > >   $ nbdkit --filter=log --filter=nozero memory size=6G
> > > >>> logfile=/tmp/log \
> > > >>> > >       --run './qemu-img convert ./fedora-28.img -n $nbd'
> > > >>> > >   $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' |
> > uniq
> > > >>> -c
> > > >>> > >    2154 Write
> > > >>> > >
> > > >>> > > Not surprisingly no zero commands are issued.  The size of the
> > write
> > > >>> > > commands is very uneven -- it appears to be send one command per
> > > >>> block
> > > >>> > > of zeroes or data.
> > > >>> > >
> > > >>> > > Nir: If we could get information from imageio about whether
> > zeroing
> > > >>> is
> > > >>> > > implemented efficiently or not by the backend, we could change
> > > >>> > > virt-v2v / nbdkit to advertise this back to qemu.
> > > >>> >
> > > >>> > There is no way to detect the capability, ioctl(BLKZEROOUT) always
> > > >>> > succeeds, falling back to manual zeroing in the kernel silently
> > > >>> >
> > > >>> > Even if we could, sending zero on the wire from qemu may be even
> > > >>> > slower, and it looks like qemu send even more requests in this case
> > > >>> > (2154 vs ~1300).
> > > >>> >
> > > >>> > Looks like this optimization in qemu side leads to worse
> > performance,
> > > >>> > so it should not be enabled by default.
> > > >>>
> > > >>> Well, that's overgeneralising your case a bit. If the backend does
> > > >>> support efficient zero writes (which file systems, the most common
> > case,
> > > >>> generally do), doing one big write_zeroes request at the start can
> > > >>> improve performance quite a bit.
> > > >>>
> > > >>> It seems the problem is that we can't really know whether the
> > operation
> > > >>> will be efficient because the backends generally don't tell us. Maybe
> > > >>> NBD could introduce a flag for this, but in the general case it
> > appears
> > > >>> to me that we'll have to have a command line option.
> > > >>>
> > > >>> However, I'm curious what your exact use case and the backend used
> > in it
> > > >>> is? Can something be improved there to actually get efficient zero
> > > >>> writes and get even better performance than by just disabling the big
> > > >>> zero write?
> > > >>
> > > >>
> > > >> The backend is some NetApp storage connected via FC. I don't have
> > > >> more info on this. We get zero rate of about 1G/s on this storage,
> > which
> > > >> is quite slow compared with other storage we tested.
> > > >>
> > > >> One option we check now is if this is the kernel silent fallback to
> > manual
> > > >> zeroing when the server advertise wrong value of write_same_max_bytes.
> > > >>
> > > >
> > > > We eliminated this using blkdiscard. This is what we get on with this
> > > > storage
> > > > zeroing 100G LV:
> > > >
> > > > for i in 1 2 4 8 16 32; do time blkdiscard -z -p ${i}m
> > > >
> > /dev/6e1d84f9-f939-46e9-b108-0427a08c280c/2d5c06ce-6536-4b3c-a7b6-13c6d8e55ade;
> > > > done
> > > >
> > > > real 4m50.851s
> > > > user 0m0.065s
> > > > sys 0m1.482s
> > > >
> > > > real 4m30.504s
> > > > user 0m0.047s
> > > > sys 0m0.870s
> > > >
> > > > real 4m19.443s
> > > > user 0m0.029s
> > > > sys 0m0.508s
> > > >
> > > > real 4m13.016s
> > > > user 0m0.020s
> > > > sys 0m0.284s
> > > >
> > > > real 2m45.888s
> > > > user 0m0.011s
> > > > sys 0m0.162s
> > > >
> > > > real 2m10.153s
> > > > user 0m0.003s
> > > > sys 0m0.100s
> > > >
> > > > We are investigating why we get low throughput on this server, and also
> > > > will check
> > > > several other servers.
> > > >
> > > > Having a command line option to control this behavior sounds good. I
> > don't
> > > >> have enough data to tell what should be the default, but I think the
> > safe
> > > >> way would be to keep old behavior.
> > > >>
> > > >
> > > > We file this bug:
> > > > https://bugzilla.redhat.com/1648622
> > > >
> > >
> > > More data from even slower storage - zeroing 10G lv on Kaminario K2
> > >
> > > # time blkdiscard -z -p 32m /dev/test_vg/test_lv2
> > >
> > > real    50m12.425s
> > > user    0m0.018s
> > > sys     2m6.785s
> > >
> > > Maybe something is wrong with this storage, since we see this:
> > >
> > > # grep -s "" /sys/block/dm-29/queue/* | grep write_same_max_bytes
> > > /sys/block/dm-29/queue/write_same_max_bytes:512
> > >
> > > Since BLKZEROOUT always fallback to manual slow zeroing silently,
> > > maybe we can disable the aggressive pre-zero of the entire device
> > > for block devices, and keep this optimization for files when fallocate()
> > > is supported?
> >
> > I'm not sure what the detour through NBD changes, but qemu-img directly
> > on a block device doesn't use BLKZEROOUT first, but
> > FALLOC_FL_PUNCH_HOLE.
> 
> 
> Looking at block/file-posix.c (83c496599cc04926ecbc3e47a37debaa3e38b686)
> we don't use PUNCH_HOLE for block devices:
> 
> 1472     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
> 1473         return handle_aiocb_write_zeroes_block(aiocb);
> 1474     }
> 
> qemu uses BLKZEROOUT, which is not guaranteed to be fast on storage side,
> and even worse fallback silently to manual zero if storage does not support
> WRITE_SAME.

We only get there as a fallback. The normal path for supported zero
writes is like this:

1. convert_do_copy()
2. blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP)
3. bdrv_make_zero(blk->root, flags)
4. a. bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL)
      Skip the zero write if the block is already zero
      Why don't we hit this path with NBD?
   b. bdrv_pwrite_zeroes(child, offset, bytes, flags)
5. bdrv_prwv_co(BDRV_REQ_ZERO_WRITE | flags)
   flags is now BDRV_REQ_ZERO_WRITE | BDRV_REQ_MAY_UNMAP
6. bdrv_co_pwritev()
   bdrv_co_do_zero_pwritev()
7. bdrv_aligned_pwritev(BDRV_REQ_ZERO_WRITE | BDRV_REQ_MAY_UNMAP)
8. bdrv_co_do_pwrite_zeroes(BDRV_REQ_ZERO_WRITE | BDRV_REQ_MAY_UNMAP)
9. drv->bdrv_co_pwrite_zeroes(flags & bs->supported_zero_flags)
   file-posix: bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP

10. raw_co_pwrite_zeroes(BDRV_REQ_MAY_UNMAP=
11. paio_submit_co(QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD)
12. aio_worker()
13. handle_aiocb_write_zeroes_unmap()
14. do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                 aiocb->aio_offset, aiocb->aio_nbytes);

Only if this fails, we try other methods. And without the
BDRV_REQ_MAY_UNMAP flag, we would immediately try BLKZEROOUT.

> Maybe we can add a flag that avoids anything that
> > could be slow, such as BLKZEROOUT, as a fallback (and also the slow
> > emulation that QEMU itself would do if all kernel calls fail).
> >
> 
> But the issue here is not how qemu-img handles this case, but how NBD
> server can handle it. NBD may support zeroing, but there is no way to tell
> if zeroing is going to be fast, since the backend writing zeros to storage
> has the same limits of qemu-img.

I suppose we could add the same flag to NBD (write zeroes, but only if
it's efficient). But first we need to solve the local case because NBD
will always build on that.

> So I think we need to fix the performance regression in 2.12 by enabling
> pre-zero of entire disk only if FALLOCATE_FL_PUNCH_HOLE can be used
> and only if it can be used without a fallback to slow zero method.
> 
> Enabling this optimization for anything else requires changing the
> entire stack (storage, kernel, NBD protocol) to support reporting fast
> zero capability or limit zero to fast operations.

Yes, I agree.

Kevin
