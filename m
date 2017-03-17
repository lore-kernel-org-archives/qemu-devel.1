Received: from eggs.gnu.org ([2001:4830:134:3::10]:57393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1col8z-0005hF-1F
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1col8x-0006fu-1r
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:13:45 -0400
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1col8w-0006fj-Rh
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:13:42 -0400
Received: by mail-ua0-x236.google.com with SMTP id f54so38824801uaa.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:13:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317060240.GC13125@lemon.lan>
References: <20170314153626.16989-1-famz@redhat.com>
	<20170314153626.16989-3-famz@redhat.com>
	<CAO_EM_=JBe-xiBOZvcdhsjP-x5tSd9Dap+WPbViFDRhfZF3jOg@mail.gmail.com>
	<20170317060240.GC13125@lemon.lan>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 16 Mar 2017 23:13:41 -0700
Message-ID: <CAO_EM_nThbbBJ5c8bOJsmukT4j3scW7hyeoS-rsLK7aYQ2rh5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Fix acquire/release in
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mar 16, 2017 23:02, "Fam Zheng" <famz@redhat.com> wrote:

On Thu, 03/16 17:26, Ed Swierk wrote:
> On Tue, Mar 14, 2017 at 8:36 AM, Fam Zheng <famz@redhat.com> wrote:
> > After the AioContext lock push down, there is a race between
> > virtio_scsi_dataplane_start and those "assert(s->ctx &&
> > s->dataplane_started)", because the latter doesn't isn't wrapped in
> > aio_context_acquire.
> >
> > Reproducer is simply booting a Fedora guest with an empty
> > virtio-scsi-dataplane controller:
> >
> >     qemu-system-x86_64 \
> >       -drive if=none,id=root,format=raw,file=Fedora-Cloud-Base-25-1.3.x86_64.raw
\
> >       -device virtio-scsi \
> >       -device scsi-disk,drive=root,bootindex=1 \
> >       -object iothread,id=io \
> >       -device virtio-scsi-pci,iothread=io \
> >       -net user,hostfwd=tcp::10022-:22 -net nic,model=virtio -m 2048 \
> >       --enable-kvm
> >
> > Fix this by moving acquire/release pairs from virtio_scsi_handle_*_vq to
> > their callers - and wrap the broken assertions in.
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
>
> With this change on top of 2.9.0-rc0, I am able to boot a Linux guest
> from a virtio-scsi drive with an iothread, e.g.
>
>   qemu-system-x86_64 -nographic -enable-kvm -monitor
> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
> iothread,id=iothread1 -device
> virtio-scsi-pci,iothread=iothread1,id=scsi0 -drive
> file=/x/drive.qcow2,format=qcow2,if=none,id=drive0,cache=
directsync,aio=native
> -device scsi-hd,drive=drive0,bootindex=1
>
> But when I try to take a snapshot by running this in the monitor
>
>   snapshot_blkdev drive0 /x/snap1.qcow2
>
> qemu bombs with
>
>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.
>
> This does not occur if I don't use the iothread.
>
> I instrumented the code a bit, printing the value of bs,
> bdrv_get_aio_context(bs), and
> bdrv_get_aio_context(bs)->external_disable_cnt before and after
> aio_{disable,enable}_external() in bdrv_drained_{begin,end}().
>
> Without the iothread, nested calls to these functions cause the
> counter to increase and decrease as you'd expect, and the context is
> the same in each call.
>
> bdrv_drained_begin 0 bs=0x7fe9f5ad65a0 ctx=0x7fe9f5abc7b0 cnt=0
> bdrv_drained_begin 1 bs=0x7fe9f5ad65a0 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_begin 0 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_begin 1 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=3
> bdrv_drained_end 0 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=3
> bdrv_drained_end 1 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_begin 0 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_begin 1 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=3
> bdrv_drained_end 0 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=3
> bdrv_drained_end 1 bs=0x7fe9f67cfde0 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_begin 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 0 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=2
> bdrv_drained_end 1 bs=0x7fe9f5d12a00 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_end 0 bs=0x7fe9f5ad65a0 ctx=0x7fe9f5abc7b0 cnt=1
> bdrv_drained_end 1 bs=0x7fe9f5ad65a0 ctx=0x7fe9f5abc7b0 cnt=0
>
> But with the iothread, there are at least two different context
> pointers, and there is one extra call to bdrv_drained_end() without a
> matching bdrv_drained_begin(). That last call comes from
> external_snapshot_clean().
>
> bdrv_drained_begin 0 bs=0x7fe4437545c0 ctx=0x7fe443749a00 cnt=0
> bdrv_drained_begin 1 bs=0x7fe4437545c0 ctx=0x7fe443749a00 cnt=1
> bdrv_drained_begin 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_begin 0 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_begin 1 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=2
> bdrv_drained_end 0 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=2
> bdrv_drained_end 1 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_begin 0 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_begin 1 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=2
> bdrv_drained_end 0 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=2
> bdrv_drained_end 1 bs=0x7fe44444de20 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 0 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=0
> bdrv_drained_begin 1 bs=0x7fe443990a00 ctx=0x7fe44373a7b0 cnt=1
> bdrv_drained_end 0 bs=0x7fe443990a00 ctx=0x7fe443749a00 cnt=1
> bdrv_drained_end 1 bs=0x7fe443990a00 ctx=0x7fe443749a00 cnt=0
> bdrv_drained_end 0 bs=0x7fe4437545c0 ctx=0x7fe443749a00 cnt=0
> qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.

This may indeed come from the left-behind virtio_scsi_release() you pointed
out,
I'll fix it in v3 and please see if it helps.

Fam


I tried that, but the 'ctx->external_disable_cnt > 0' assertion still
occurs.

--Ed
