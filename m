Received: from eggs.gnu.org ([209.51.188.92]:36143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj0DW-0006il-KR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj0DV-0004sn-Im
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:15:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj0DV-0004pS-8U
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:15:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so8402437wmc.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 03:15:41 -0800 (PST)
References: <20190111020849.22674-1-liq3ea@gmail.com>
	<20190111020849.22674-3-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <92ec4604-bacf-b9f1-9ab6-034e41bc58b0@redhat.com>
Date: Mon, 14 Jan 2019 12:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190111020849.22674-3-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] nvme: ensure the num_queues is not
 zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi Li,

On 1/11/19 3:08 AM, Li Qiang wrote:
> When it is zero, it causes segv. Backtrack:
> Thread 5 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.

Can you add the relevant part of the command line you used here?

> [Switching to Thread 0x7fffc6c17700 (LWP 51808)]
> 0x0000555555acbd90 in nvme_start_ctrl (n=0x6240000c8100) at hw/block/nvme.c:820
> warning: Source file is more recent than executable.

^ drop this line

> 820         if (unlikely(n->cq[0])) {
> (gdb) bt
> 0  0x0000555555acbd90 in nvme_start_ctrl (n=0x6240000c8100) at hw/block/nvme.c:820
> 1  0x0000555555accdbc in nvme_write_bar (n=0x6240000c8100, offset=20, data=4587521, size=4) at hw/block/nvme.c:964
> 2  0x0000555555acdd2b in nvme_mmio_write (opaque=0x6240000c8100, addr=20, data=4587521, size=4) at hw/block/nvme.c:1158
> 3  0x00005555558973ed in memory_region_write_accessor (mr=0x6240000c89e0, addr=20, value=0x7fffc6c14428, size=4, shift=0, mask=4294967295, attrs=...) at /home/liqiang02/qemu-upstream/qemu/memory.c:500
> 4  0x0000555555897600 in access_with_adjusted_size (addr=20, value=0x7fffc6c14428, size=4, access_size_min=2, access_size_max=8, access_fn=0x555555897304 <memory_region_write_accessor>, mr=0x6240000c89e0, attrs=...) at /home/liqiang02/qemu-upstream/qemu/memory.c:566
> 5  0x000055555589a200 in memory_region_dispatch_write (mr=0x6240000c89e0, addr=20, data=4587521, size=4, attrs=...) at /home/liqiang02/qemu-upstream/qemu/memory.c:1442
> 6  0x0000555555835151 in flatview_write_continue (fv=0x6060000e6fc0, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4, addr1=20, l=4, mr=0x6240000c89e0) at /home/liqiang02/qemu-upstream/qemu/exec.c:3233
> 7  0x000055555583529b in flatview_write (fv=0x6060000e6fc0, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4) at /home/liqiang02/qemu-upstream/qemu/exec.c:3272
> 8  0x00005555558355a1 in address_space_write (as=0x55555683ade0 <address_space_memory>, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4) at /home/liqiang02/qemu-upstream/qemu/exec.c:3362
> 9  0x00005555558355f2 in address_space_rw (as=0x55555683ade0 <address_space_memory>, addr=4273930260, attrs=..., buf=0x7fffc8a18028 "\001", len=4, is_write=true) at /home/liqiang02/qemu-upstream/qemu/exec.c:3373
> 10 0x00005555558b66ac in kvm_cpu_exec (cpu=0x631000014800) at /home/liqiang02/qemu-upstream/qemu/accel/kvm/kvm-all.c:2031
> 11 0x000055555587c3ac in qemu_kvm_cpu_thread_fn (arg=0x631000014800) at /home/liqiang02/qemu-upstream/qemu/cpus.c:1277
> 12 0x0000555555e54ae6 in qemu_thread_start (args=0x60300002c170) at util/qemu-thread-posix.c:504
> 13 0x00007fffdadbd494 in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
> 14 0x00007fffdaaffacf in clone () from /lib/x86_64-linux-gnu/libc.so.6
> (gdb) q
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/block/nvme.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f206391e8e..0ded74fa9a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1223,6 +1223,11 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>          error_setg(errp, "serial property not set");
>          return;
>      }
> +
> +    if (!n->num_queues) {
> +        error_setg(errp, "num_queues can't be zero");
> +        return;
> +    }

I'd add this as the first check, to avoid the blk_getlength() call.

>      blkconf_blocksizes(&n->conf);
>      if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
>                                         false, errp)) {
> 

With command line comment:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
