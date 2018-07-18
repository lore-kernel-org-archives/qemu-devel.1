Received: from eggs.gnu.org ([2001:4830:134:3::10]:38324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1ffrYW-0007fh-Q9
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1ffrYS-0000Sh-Rs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:52:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1ffrYS-0000Rp-Kq
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:52:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id r1-v6so2395898pgp.11
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 11:52:04 -0700 (PDT)
Date: Wed, 18 Jul 2018 11:52:02 -0700
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-ID: <20180718185202.GA24700@breakout>
References: <e16f10f5-b113-5ebe-51e9-c379ca34193d@linux.ibm.com>
	<20180717205212.GA9580@breakout>
	<c39e6566-78bb-cfe9-f0df-c6cc6ec2ad29@linux.ibm.com>
	<bdbb9588-a913-c449-415b-34a25fcbde9e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdbb9588-a913-c449-415b-34a25fcbde9e@linux.ibm.com>
Subject: Re: [Qemu-devel] [BUG?] aio_get_linux_aio: Assertion
 `ctx->linux_aio' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On 18.07.2018 [11:10:27 -0400], Farhan Ali wrote:
> 
> 
> On 07/18/2018 09:42 AM, Farhan Ali wrote:
> > 
> > 
> > On 07/17/2018 04:52 PM, Nishanth Aravamudan wrote:
> > > iiuc, this possibly implies AIO was not actually used previously on this
> > > guest (it might have silently been falling back to threaded IO?). I
> > > don't have access to s390x, but would it be possible to run qemu under
> > > gdb and see if aio_setup_linux_aio is being called at all (I think it
> > > might not be, but I'm not sure why), and if so, if it's for the context
> > > in question?
> > > 
> > > If it's not being called first, could you see what callpath is calling
> > > aio_get_linux_aio when this assertion trips?
> > > 
> > > Thanks!
> > > -Nish
> > 
> > 
> > Hi Nishant,
> > 
> >  From the coredump of the guest this is the call trace that calls
> > aio_get_linux_aio:
> > 
> > 
> > Stack trace of thread 145158:
> > #0  0x000003ff94dbe274 raise (libc.so.6)
> > #1  0x000003ff94da39a8 abort (libc.so.6)
> > #2  0x000003ff94db62ce __assert_fail_base (libc.so.6)
> > #3  0x000003ff94db634c __assert_fail (libc.so.6)
> > #4  0x000002aa20db067a aio_get_linux_aio (qemu-system-s390x)
> > #5  0x000002aa20d229a8 raw_aio_plug (qemu-system-s390x)
> > #6  0x000002aa20d309ee bdrv_io_plug (qemu-system-s390x)
> > #7  0x000002aa20b5a8ea virtio_blk_handle_vq (qemu-system-s390x)
> > #8  0x000002aa20db2f6e aio_dispatch_handlers (qemu-system-s390x)
> > #9  0x000002aa20db3c34 aio_poll (qemu-system-s390x)
> > #10 0x000002aa20be32a2 iothread_run (qemu-system-s390x)
> > #11 0x000003ff94f879a8 start_thread (libpthread.so.0)
> > #12 0x000003ff94e797ee thread_start (libc.so.6)
> > 
> > 
> > Thanks for taking a look and responding.
> > 
> > Thanks
> > Farhan
> > 
> > 
> > 
> 
> Trying to debug a little further, the block device in this case is a "host
> device". And looking at your commit carefully you use the
> bdrv_attach_aio_context callback to setup a Linux AioContext.
> 
> For some reason the "host device" struct (BlockDriver bdrv_host_device in
> block/file-posix.c) does not have a bdrv_attach_aio_context defined.
> So a simple change of adding the callback to the struct solves the issue and
> the guest starts fine.
> 
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 28824aa..b8d59fb 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3135,6 +3135,7 @@ static BlockDriver bdrv_host_device = {
>      .bdrv_refresh_limits = raw_refresh_limits,
>      .bdrv_io_plug = raw_aio_plug,
>      .bdrv_io_unplug = raw_aio_unplug,
> +    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> 
>      .bdrv_co_truncate       = raw_co_truncate,
>      .bdrv_getlength    = raw_getlength,
> 
> 
> 
> I am not too familiar with block device code in QEMU, so not sure if
> this is the right fix or if there are some underlying problems.

Oh this is quite embarassing! I only added the bdrv_attach_aio_context
callback for the file-backed device. Your fix is definitely corect for
host device. Let me make sure there weren't any others missed and I will
send out a properly formatted patch. Thank you for the quick testing and
turnaround!

-Nish
