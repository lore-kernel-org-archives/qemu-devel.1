Received: from eggs.gnu.org ([2001:4830:134:3::10]:39233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKqBO-00056v-2e
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKqBM-0007Em-92
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:04:50 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKqBL-0007Ef-Uv
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:04:48 -0400
Received: by mail-wr0-x242.google.com with SMTP id u101so32755089wrc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:04:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1497346256-10073-1-git-send-email-gi-oh.kim@profitbricks.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a016e14-d3c7-1bd3-a6db-753b87005609@redhat.com>
Date: Tue, 13 Jun 2017 20:04:43 +0200
MIME-Version: 1.0
In-Reply-To: <1497346256-10073-1-git-send-email-gi-oh.kim@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: drain block before cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gioh Kim <gi-oh.kim@profitbricks.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org



On 13/06/2017 11:30, Gioh Kim wrote:
> Hi,
> 
> I'd like to report one use-after-free problem which is found by AddressSanitizer.
> My company provides virtualization server with Qemu-2.7.
> If customer commands Disk hot-unplug on Web-based application,
> the application sends "device_del" and "drive_del" commands to qemu process via QMP.
> It usually works fine.
> But I found a corner case like following.
> 1. Customer commands Disk hot-unplug via Web-based application.
> 2. The application sends "device_del" that sometimes takes unpredictable time.
> 3. There are some inflight IOs
> 4. Customer does reboot or shutdown the guest OS
> 4. Qemu process generates segfault.
> 
> If a disk is unplugged with "device_del" and "drive_del" commands,
> qemu does not generate problem. But if only "device_del" command are finished and
> guest os reboots, qemu generates segfault.
> I can reproduce that case easily with following commands
> 1. generate heavy IO on disk in Guest OS
> 2. run "device_del" on the qemu monitor
> 3. run "system_reboot" on the qemu monitor
> 
> According to AdressSanitizer, VirtQueue is freed by virtio_cleanup but dereferenced
> by asynchronous request. I think asynchronous requests should be finished
> before virtio_cleanup, so I added blk_drain() before virtio_cleanup.

Hi Gioh,

this was fixed in QEMU 2.8 by commit c611c76417 ("virtio: add
MemoryListener to cache ring translations", 2017-02-17).

Even though the MemoryRegionCache mechanism is currently not caching
anything (commit 90c4fe5fc5, "exec: revert MemoryRegionCache",
2017-04-03), the virtio bugfix remains.

Your patch looks good as a workaround for QEMU 2.7.

Paolo

> Following is configure options I used to build qemu with AddressSanitizer.
> ./configure --target-list=x86_64-softmmu --extra-cflags="-fsanitize=address -fno-omit-frame-pointer" --enable-debug
> 
> Following is the report of AddressSanitizer.
> 
> ------------------------------------- 8< ----------------------------------------
> ==8801==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8801==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffc984da000; bottom 0x7fa524363000; size: 0x005774177000 (375609847808)
> False positive error reports may follow
> For details see http://code.google.com/p/address-sanitizer/issues/detail?id=189
> =================================================================
> ==8801==ERROR: AddressSanitizer: heap-use-after-free on address 0x7fa5240ab82c at pc 0x55ccd7bffb76 bp 0x7fa524364590 sp 0x7fa524364580
> READ of size 2 at 0x7fa5240ab82c thread T0
>     #0 0x55ccd7bffb75 in virtqueue_fill /home/gohkim/work/tools/qemu/hw/virtio/virtio.c:284
>     #1 0x55ccd7bffe46 in virtqueue_push /home/gohkim/work/tools/qemu/hw/virtio/virtio.c:308
>     #2 0x55ccd7b66c74 in virtio_blk_req_complete /home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:58
>     #3 0x55ccd7b67154 in virtio_blk_rw_complete /home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:121
>     #4 0x55ccd83852b9 in blk_aio_complete block/block-backend.c:923
>     #5 0x55ccd8385a73 in blk_aio_write_entry block/block-backend.c:984
>     #6 0x55ccd84c7d68 in coroutine_trampoline util/coroutine-ucontext.c:78
>     #7 0x7fa5702d45cf  (/lib/x86_64-linux-gnu/libc.so.6+0x495cf)
> 
> 0x7fa5240ab82c is located 44 bytes inside of 131072-byte region [0x7fa5240ab800,0x7fa5240cb800)
> freed by thread T0 here:
>     #0 0x7fa573f876aa in __interceptor_free (/usr/lib/x86_64-linux-gnu/libasan.so.2+0x986aa)
>     #1 0x55ccd7c07fa4 in virtio_cleanup /home/gohkim/work/tools/qemu/hw/virtio/virtio.c:1678
>     #2 0x55ccd7b6c585 in virtio_blk_device_unrealize /home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:948
>     #3 0x55ccd7c09734 in virtio_device_unrealize /home/gohkim/work/tools/qemu/hw/virtio/virtio.c:1950
>     #4 0x55ccd7eb9bb7 in device_set_realized hw/core/qdev.c:964
>     #5 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #6 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #7 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #8 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #9 0x55ccd7ec1395 in bus_set_realized hw/core/bus.c:181
>     #10 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #11 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #12 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #13 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #14 0x55ccd7eb9a8a in device_set_realized hw/core/qdev.c:956
>     #15 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #16 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #17 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #18 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #19 0x55ccd7eba820 in device_unparent hw/core/qdev.c:1099
>     #20 0x55ccd82bf50b in object_finalize_child_property qom/object.c:1362
>     #21 0x55ccd82bb3c6 in object_property_del_child qom/object.c:422
>     #22 0x55ccd82bb601 in object_unparent qom/object.c:441
>     #23 0x55ccd7e221f1 in acpi_pcihp_eject_slot hw/acpi/pcihp.c:139
>     #24 0x55ccd7e22301 in acpi_pcihp_update_hotplug_bus hw/acpi/pcihp.c:152
>     #25 0x55ccd7e22600 in acpi_pcihp_update hw/acpi/pcihp.c:176
>     #26 0x55ccd7e22628 in acpi_pcihp_reset hw/acpi/pcihp.c:182
>     #27 0x55ccd7e1fc10 in piix4_reset hw/acpi/piix4.c:363
>     #28 0x55ccd7da4ebd in qemu_devices_reset /home/gohkim/work/tools/qemu/vl.c:1713
>     #29 0x55ccd7c28354 in pc_machine_reset /home/gohkim/work/tools/qemu/hw/i386/pc.c:2178
> 
> previously allocated by thread T0 here:
>     #0 0x7fa573f87b49 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.2+0x98b49)
>     #1 0x7fa5718575d0 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4f5d0)
>     #2 0x55ccd7b6bfa5 in virtio_blk_device_realize /home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:910
>     #3 0x55ccd7c09500 in virtio_device_realize /home/gohkim/work/tools/qemu/hw/virtio/virtio.c:1927
>     #4 0x55ccd7eb9690 in device_set_realized hw/core/qdev.c:918
>     #5 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #6 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #7 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #8 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #9 0x55ccd81b1b5c in virtio_blk_pci_realize hw/virtio/virtio-pci.c:1897
>     #10 0x55ccd81b14df in virtio_pci_realize hw/virtio/virtio-pci.c:1799
>     #11 0x55ccd805e2c5 in pci_qdev_realize hw/pci/pci.c:1966
>     #12 0x55ccd81b17db in virtio_pci_dc_realize hw/virtio/virtio-pci.c:1852
>     #13 0x55ccd7eb9690 in device_set_realized hw/core/qdev.c:918
>     #14 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #15 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #16 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #17 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #18 0x55ccd7d8141e in qdev_device_add /home/gohkim/work/tools/qemu/qdev-monitor.c:618
>     #19 0x55ccd7dab462 in device_init_func /home/gohkim/work/tools/qemu/vl.c:2316
>     #20 0x55ccd84bd18c in qemu_opts_foreach util/qemu-option.c:1116
>     #21 0x55ccd7db2bdb in main /home/gohkim/work/tools/qemu/vl.c:4507
>     #22 0x7fa5702ababf in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x20abf)
> 
> SUMMARY: AddressSanitizer: heap-use-after-free /home/gohkim/work/tools/qemu/hw/virtio/virtio.c:284 virtqueue_fill
> Shadow bytes around the buggy address:
>   0x0ff52480d6b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> =>0x0ff52480d700: fd fd fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d710: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d720: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d730: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d740: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d750: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07 
>   Heap left redzone:       fa
>   Heap right redzone:      fb
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack partial redzone:   f4
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
> ==8801==ABORTING
> 
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> ---
>  hw/block/virtio-blk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 331d766..cc39934 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -939,6 +939,8 @@ static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
>      virtio_blk_data_plane_destroy(s->dataplane);
>      s->dataplane = NULL;
>      qemu_del_vm_change_state_handler(s->change);
> +    if (blk_bs(s->blk) && bdrv_requests_pending((blk_bs(s->blk))))
> +        blk_drain(s->blk);
>      blockdev_mark_auto_del(s->blk);
>      virtio_cleanup(vdev);
>  }
> 
