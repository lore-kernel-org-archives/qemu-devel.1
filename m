Received: from eggs.gnu.org ([2001:4830:134:3::10]:51836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gi-oh.kim@profitbricks.com>) id 1dL9Ne-00027U-Fs
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gi-oh.kim@profitbricks.com>) id 1dL9Nc-0004Bm-Js
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:34:46 -0400
Received: from mail-yb0-x230.google.com ([2607:f8b0:4002:c09::230]:35033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gi-oh.kim@profitbricks.com>)
	id 1dL9Nc-0004BO-CJ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:34:44 -0400
Received: by mail-yb0-x230.google.com with SMTP id f192so817184yba.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:34:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614092044.GB27294@stefanha-x1.localdomain>
References: <1497350121-15256-1-git-send-email-gi-oh.kim@profitbricks.com>
	<20170614092044.GB27294@stefanha-x1.localdomain>
From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Wed, 14 Jun 2017 16:34:02 +0200
Message-ID: <CAJX1YtYFqCF6QXXegb3tyK8TofF_KQh+ziWYiH2G8MDviijsOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] virtio-blk: drain block before cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org

On Wed, Jun 14, 2017 at 11:20 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jun 13, 2017 at 12:35:21PM +0200, Gioh Kim wrote:
>> I'd like to report one use-after-free problem which is found by AddressSanitizer.
>> My company provides virtualization server with Qemu-2.7.
>
> I have tried the following but was unable to reproduce a segfault.
> Please reproduce this issue with qemu.git/master and post the steps:

I'm sorry that I wrote ambiguously.
The problem was only by Qemu-2.7 that is qemu.git/stable-2.7 branch.


>
>   $ qemu -M accel=kvm -cpu host -m 1G \
>          -drive if=none,id=drive0,file=test.img,format=raw \
>          -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0 \
>          -drive if=none,id=drive1,file.driver=null-co,file.read-zeroes=on,file.latency-ns=5000000000,format=raw \
>          -device virtio-blk-pci,drive=drive1,id=virtio-blk-pci1 \
>          -d trace:virtio_blk_\*
>

I executed qemu with following command.

~/work/tools/qemu/x86_64-softmmu/qemu-system-x86_64 -M accel=kvm -cpu
host -m 1024 -name pb-pserver \
-monitor telnet:0.0.0.0:9400,server,nowait -rtc base=utc \
-vnc 0.0.0.0:0 \
-drive if=none,id=drive0,file=./debian8.2-pserver.img,format=raw \
-device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0 \
-d trace:virtio_blk_\*

And I reproduced the problem with following sequence.

1. on Qemu-monitor
(qemu) drive_add 0
if=none,id=drive1,file.driver=null-co,file.read-zeroes=on,file.latency-ns=5000000000,format=raw
OK
(qemu) device_add virtio-blk-pci,drive=drive1,id=virtio-blk-pci1

2. on Guest OS
# cat test.fio
[global]
ioengine=libaio
direct=1
time_based=1
bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
iodepth=128
numjobs=8
[job]
rw=randrw
filename=/dev/vdb
runtime=300

# fio test.fio

3. on Qemu-monitor (just after running fio)
(qemu) device_del virtio-blk-pci1
(qemu) system_reset
(qemu) Connection closed by foreign host.  ===> qemu crash


Following is the result of Qemu tracing.

16589@1497450077.404638:virtio_blk_handle_read req 0x611000295d00
sector 166143 nsectors 2
16589@1497450077.404644:virtio_blk_handle_write req 0x611000295bc0
sector 982238 nsectors 64
16589@1497450077.404743:virtio_blk_handle_read req 0x611000295a80
sector 143935 nsectors 8
16589@1497450077.404790:virtio_blk_handle_read req 0x611000295940
sector 1296105 nsectors 16
16589@1497450077.404795:virtio_blk_handle_read req 0x611000295800
sector 1901728 nsectors 16
16589@1497450077.404800:virtio_blk_handle_write req 0x6110002956c0
sector 1420489 nsectors 32
16589@1497450077.404930:virtio_blk_handle_read req 0x611000295580
sector 1422639 nsectors 1
16589@1497450077.404978:virtio_blk_handle_write req 0x611000295440
sector 841715 nsectors 2
16589@1497450077.405026:virtio_blk_handle_read req 0x611000295300
sector 1336979 nsectors 4
16589@1497450077.405075:virtio_blk_handle_read req 0x6110002951c0
sector 1374935 nsectors 16
16589@1497450077.405080:virtio_blk_handle_read req 0x611000295080
sector 826570 nsectors 4
16589@1497450077.405087:virtio_blk_handle_write req 0x611000294f40
sector 1999130 nsectors 16
16589@1497450077.405219:virtio_blk_handle_write req 0x611000294e00
sector 1978172 nsectors 32
16589@1497450077.405224:virtio_blk_handle_read req 0x611000294cc0
sector 1175666 nsectors 1
16589@1497450077.405309:virtio_blk_handle_write req 0x611000294b80
sector 1021650 nsectors 32
16589@1497450077.405357:virtio_blk_handle_write req 0x611000294a40
sector 1723841 nsectors 2
16589@1497450077.405362:virtio_blk_handle_write req 0x611000294900
sector 350119 nsectors 1
16589@1497450077.405367:virtio_blk_handle_read req 0x6110002947c0
sector 1101456 nsectors 2
16589@1497450077.405499:virtio_blk_handle_read req 0x611000294680
sector 721850 nsectors 2
16589@1497450081.580154:virtio_blk_handle_read req 0x61200004a8c0
sector 13127272 nsectors 32
16589@1497450081.580313:virtio_blk_rw_complete req 0x61200004a8c0 ret 0
16589@1497450081.580319:virtio_blk_req_complete req 0x61200004a8c0 status 0
16589@1497450081.580458:virtio_blk_handle_read req 0x613000052ec0
sector 13127304 nsectors 48
16589@1497450081.580595:virtio_blk_rw_complete req 0x613000052ec0 ret 0
16589@1497450081.580602:virtio_blk_req_complete req 0x613000052ec0 status 0
16589@1497450081.619777:virtio_blk_rw_complete req 0x611000279100 ret 0
16589@1497450081.619796:virtio_blk_req_complete req 0x611000279100 status 0
16589@1497450082.400075:virtio_blk_rw_complete req 0x611000276180 ret 0
16589@1497450082.400094:virtio_blk_req_complete req 0x611000276180 status 0
=================================================================
==16589==ERROR: AddressSanitizer: heap-use-after-free on address
0x7fee77ec982c at pc 0x55fa17e13a95 bp 0x7fee72bb3590 sp
0x7fee72bb3580
READ of size 2 at 0x7fee77ec982c thread T0
    #0 0x55fa17e13a94 in virtqueue_fill
/home/gohkim/work/tools/qemu/hw/virtio/virtio.c:284
    #1 0x55fa17e13d65 in virtqueue_push
/home/gohkim/work/tools/qemu/hw/virtio/virtio.c:308
    #2 0x55fa17d7ac24 in virtio_blk_req_complete
/home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:58
    #3 0x55fa17d7b104 in virtio_blk_rw_complete
/home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:121
    #4 0x55fa185991d8 in blk_aio_complete block/block-backend.c:923
    #5 0x55fa1859974a in blk_aio_read_entry block/block-backend.c:973
    #6 0x55fa186dbc87 in coroutine_trampoline util/coroutine-ucontext.c:78
    #7 0x7feec21ac5cf  (/lib/x86_64-linux-gnu/libc.so.6+0x495cf)

0x7fee77ec982c is located 44 bytes inside of 131072-byte region
[0x7fee77ec9800,0x7fee77ee9800)
freed by thread T0 here:
    #0 0x7feec5e5f6aa in __interceptor_free
(/usr/lib/x86_64-linux-gnu/libasan.so.2+0x986aa)
    #1 0x55fa17e1bec3 in virtio_cleanup
/home/gohkim/work/tools/qemu/hw/virtio/virtio.c:1678
    #2 0x55fa17d804a4 in virtio_blk_device_unrealize
/home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:943
    #3 0x55fa17e1d653 in virtio_device_unrealize
/home/gohkim/work/tools/qemu/hw/virtio/virtio.c:1950
    #4 0x55fa180cdad6 in device_set_realized hw/core/qdev.c:964
    #5 0x55fa184d5b0e in property_set_bool qom/object.c:1853
    #6 0x55fa184d2454 in object_property_set qom/object.c:1087
    #7 0x55fa184d846e in object_property_set_qobject qom/qom-qobject.c:27
    #8 0x55fa184d272f in object_property_set_bool qom/object.c:1156
    #9 0x55fa180d52b4 in bus_set_realized hw/core/bus.c:181
    #10 0x55fa184d5b0e in property_set_bool qom/object.c:1853
    #11 0x55fa184d2454 in object_property_set qom/object.c:1087
    #12 0x55fa184d846e in object_property_set_qobject qom/qom-qobject.c:27
    #13 0x55fa184d272f in object_property_set_bool qom/object.c:1156
    #14 0x55fa180cd9a9 in device_set_realized hw/core/qdev.c:956
    #15 0x55fa184d5b0e in property_set_bool qom/object.c:1853
    #16 0x55fa184d2454 in object_property_set qom/object.c:1087
    #17 0x55fa184d846e in object_property_set_qobject qom/qom-qobject.c:27
    #18 0x55fa184d272f in object_property_set_bool qom/object.c:1156
    #19 0x55fa180ce73f in device_unparent hw/core/qdev.c:1099
    #20 0x55fa184d342a in object_finalize_child_property qom/object.c:1362
    #21 0x55fa184cf2e5 in object_property_del_child qom/object.c:422
    #22 0x55fa184cf520 in object_unparent qom/object.c:441
    #23 0x55fa18036110 in acpi_pcihp_eject_slot hw/acpi/pcihp.c:139
    #24 0x55fa18036220 in acpi_pcihp_update_hotplug_bus hw/acpi/pcihp.c:152
    #25 0x55fa1803651f in acpi_pcihp_update hw/acpi/pcihp.c:176
    #26 0x55fa18036547 in acpi_pcihp_reset hw/acpi/pcihp.c:182
    #27 0x55fa18033b2f in piix4_reset hw/acpi/piix4.c:363
    #28 0x55fa17fb8ddc in qemu_devices_reset
/home/gohkim/work/tools/qemu/vl.c:1713
    #29 0x55fa17e3c273 in pc_machine_reset
/home/gohkim/work/tools/qemu/hw/i386/pc.c:2178

previously allocated by thread T0 here:
    #0 0x7feec5e5fb49 in __interceptor_calloc
(/usr/lib/x86_64-linux-gnu/libasan.so.2+0x98b49)
    #1 0x7feec372f5d0 in g_malloc0
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4f5d0)
    #2 0x55fa17d7ff55 in virtio_blk_device_realize
/home/gohkim/work/tools/qemu/hw/block/virtio-blk.c:910
    #3 0x55fa17e1d41f in virtio_device_realize
/home/gohkim/work/tools/qemu/hw/virtio/virtio.c:1927
    #4 0x55fa180cd5af in device_set_realized hw/core/qdev.c:918
    #5 0x55fa184d5b0e in property_set_bool qom/object.c:1853
    #6 0x55fa184d2454 in object_property_set qom/object.c:1087
    #7 0x55fa184d846e in object_property_set_qobject qom/qom-qobject.c:27
    #8 0x55fa184d272f in object_property_set_bool qom/object.c:1156
    #9 0x55fa183c5a7b in virtio_blk_pci_realize hw/virtio/virtio-pci.c:1897
    #10 0x55fa183c53fe in virtio_pci_realize hw/virtio/virtio-pci.c:1799
    #11 0x55fa182721e4 in pci_qdev_realize hw/pci/pci.c:1966
    #12 0x55fa183c56fa in virtio_pci_dc_realize hw/virtio/virtio-pci.c:1852
    #13 0x55fa180cd5af in device_set_realized hw/core/qdev.c:918
    #14 0x55fa184d5b0e in property_set_bool qom/object.c:1853
    #15 0x55fa184d2454 in object_property_set qom/object.c:1087
    #16 0x55fa184d846e in object_property_set_qobject qom/qom-qobject.c:27
    #17 0x55fa184d272f in object_property_set_bool qom/object.c:1156
    #18 0x55fa17f9533d in qdev_device_add
/home/gohkim/work/tools/qemu/qdev-monitor.c:618
    #19 0x55fa17f962e2 in qmp_device_add
/home/gohkim/work/tools/qemu/qdev-monitor.c:795
    #20 0x55fa17ff29e7 in hmp_device_add /home/gohkim/work/tools/qemu/hmp.c:1600
    #21 0x55fa17d0eb75 in handle_hmp_command
/home/gohkim/work/tools/qemu/monitor.c:2957
    #22 0x55fa17d13252 in monitor_command_cb
/home/gohkim/work/tools/qemu/monitor.c:4025
    #23 0x55fa186d6cd1 in readline_handle_byte util/readline.c:393
    #24 0x55fa17d1316f in monitor_read
/home/gohkim/work/tools/qemu/monitor.c:4008
    #25 0x55fa17f99836 in qemu_chr_be_write_impl
/home/gohkim/work/tools/qemu/qemu-char.c:387
    #26 0x55fa17f99903 in qemu_chr_be_write
/home/gohkim/work/tools/qemu/qemu-char.c:399
    #27 0x55fa17fa3c57 in tcp_chr_read
/home/gohkim/work/tools/qemu/qemu-char.c:2933
    #28 0x55fa18613bbd in qio_channel_fd_source_dispatch io/channel-watch.c:84
    #29 0x7feec3729ea9 in g_main_context_dispatch
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x49ea9)

SUMMARY: AddressSanitizer: heap-use-after-free
/home/gohkim/work/tools/qemu/hw/virtio/virtio.c:284 virtqueue_fill
Shadow bytes around the buggy address:
  0x0ffe4efd12b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffe4efd12c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffe4efd12d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffe4efd12e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0ffe4efd12f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=>0x0ffe4efd1300: fd fd fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd
  0x0ffe4efd1310: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ffe4efd1320: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ffe4efd1330: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ffe4efd1340: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ffe4efd1350: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
==16589==ABORTING

-- 
Best regards,
Gi-Oh Kim
TEL: 0176 2697 8962
