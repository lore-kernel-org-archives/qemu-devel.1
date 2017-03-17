Received: from eggs.gnu.org ([2001:4830:134:3::10]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1covAM-00077p-1A
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1covAK-0007IY-Kt
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:55:50 -0400
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:34876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1covAK-0007IQ-EU
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:55:48 -0400
Received: by mail-vk0-x22a.google.com with SMTP id x75so44056481vke.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:55:48 -0700 (PDT)
MIME-Version: 1.0
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Fri, 17 Mar 2017 09:55:06 -0700
Message-ID: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Assertion failure taking external snapshot with virtio
 drive + iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

I'm running into the same problem taking an external snapshot with a
virtio-blk drive with iothread, so it's not specific to virtio-scsi.
Run a Linux guest on qemu master

  qemu-system-x86_64 -nographic -enable-kvm -monitor
telnet:0.0.0.0:1234,server,nowait -m 1024 -object
iothread,id=iothread1 -drive file=/x/drive.qcow2,if=none,id=drive0
-device virtio-blk-pci,iothread=iothread1,drive=drive0

Then in the monitor

  snapshot_blkdev drive0 /x/snap1.qcow2

qemu bombs with

  qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
aio_enable_external: Assertion `ctx->external_disable_cnt > 0' failed.

whereas without the iothread the assertion failure does not occur.

--Ed

On Thu, Mar 16, 2017 at 5:26 PM, Ed Swierk <eswierk@skyportsystems.com> wrote:
> With this change on top of 2.9.0-rc0, I am able to boot a Linux guest
> from a virtio-scsi drive with an iothread, e.g.
>
>   qemu-system-x86_64 -nographic -enable-kvm -monitor
> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
> iothread,id=iothread1 -device
> virtio-scsi-pci,iothread=iothread1,id=scsi0 -drive
> file=/x/drive.qcow2,format=qcow2,if=none,id=drive0,cache=directsync,aio=native
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
>
> I didn't have much luck bisecting the bug, since about 200 commits
> prior to 2.9.0-rc0 qemu bombs immediately on boot, and after that I
> get the assertion addressed by your patch. I have to go farther back
> to find a working version.
>
> Any help would be appreciated.
>
> --Ed
