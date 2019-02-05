Received: from eggs.gnu.org ([209.51.188.92]:34452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gr9YG-0004nZ-UR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gr9YF-00046M-7Q
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:50:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gr9YE-000415-Aq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:50:47 -0500
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Tue,  5 Feb 2019 17:50:18 -0500
Message-Id: <cover.1549406119.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [PATCH] Do not update coalesced IO range in the case
 of NOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi,

I noticed the following backtrace while launching upstream QEMU with
virtio devices.

#0  0x00007fffdf7292c7 in raise () at /lib64/libc.so.6
#1  0x00007fffdf72a9b8 in abort () at /lib64/libc.so.6
#2  0x000055555589a0c5 in kvm_mem_ioeventfd_add (listener=0x555556946ac8, section=0x7ffdc5ff8140, match_data=false, data=0, e=0x7ffdd422e078) at /home/upstream/qemu/accel/kvm/kvm-all.c:866
#3  0x000055555587e3a3 in address_space_add_del_ioeventfds (as=0x5555567c92c0 <address_space_memory>, fds_new=0x7ffdb4000e40, fds_new_nb=1, fds_old=0x0, fds_old_nb=0) at /home/upstream/qemu/memory.c:793
#4  0x000055555587e6ca in address_space_update_ioeventfds (as=0x5555567c92c0 <address_space_memory>) at /home/upstream/qemu/memory.c:843
#5  0x000055555587f5db in memory_region_transaction_commit () at /home/upstream/qemu/memory.c:1094
#6  0x00005555558825df in memory_region_add_eventfd (mr=0x5555576216d0, addr=0, size=0, match_data=false, data=0, e=0x7ffdd422e078) at /home/upstream/qemu/memory.c:2303
#7  0x0000555555c155b2 in virtio_pci_ioeventfd_assign (d=0x555557620a00, notifier=0x7ffdd422e078, n=0, assign=true) at /home/upstream/qemu/hw/virtio/virtio-pci.c:243
#8  0x0000555555c136d6 in virtio_bus_set_host_notifier (bus=0x555557628af8, n=0, assign=true) at /home/upstream/qemu/hw/virtio/virtio-bus.c:283
#9  0x00005555558fa4c4 in virtio_scsi_vring_init (s=0x555557628b70, vq=0x7ffdd422e010, n=0, fn=0x5555558fa2c3 <virtio_scsi_data_plane_handle_ctrl>) at /home/upstream/qemu/hw/scsi/virtio-scsi-dataplane.c:98
#10 0x00005555558fa78f in virtio_scsi_dataplane_start (vdev=0x555557628b70) at /home/upstream/qemu/hw/scsi/virtio-scsi-dataplane.c:151
#11 0x0000555555c133f4 in virtio_bus_start_ioeventfd (bus=0x555557628af8) at /home/upstream/qemu/hw/virtio/virtio-bus.c:223
#12 0x0000555555c15739 in virtio_pci_start_ioeventfd (proxy=0x555557620a00) at /home/upstream/qemu/hw/virtio/virtio-pci.c:282
#13 0x0000555555c17b75 in virtio_pci_common_write (opaque=0x555557620a00, addr=20, val=15, size=1) at /home/upstream/qemu/hw/virtio/virtio-pci.c:1233
#14 0x000055555587d1f4 in memory_region_write_accessor (mr=0x5555576213d0, addr=20, value=0x7ffdc5ff8638, size=1, shift=0, mask=255, attrs=...) at /home/upstream/qemu/memory.c:502
#15 0x000055555587d3fe in access_with_adjusted_size (addr=20, value=0x7ffdc5ff8638, size=1, access_size_min=1, access_size_max=4, access_fn=0x55555587d114 <memory_region_write_accessor>, mr=0x5555576213d0, attrs=...) at /home/upstream/qemu/memory.c:568
#16 0x000055555588056c in memory_region_dispatch_write (mr=0x5555576213d0, addr=20, data=15, size=1, attrs=...) at /home/upstream/qemu/memory.c:1499
#17 0x00005555558157f9 in flatview_write_continue (fv=0x7ffdbc0008f0, addr=4261412884, attrs=..., buf=0x7ffff7e6b028 "\017?", len=1, addr1=20, l=1, mr=0x5555576213d0) at /home/upstream/qemu/exec.c:3249
#18 0x0000555555815958 in flatview_write (fv=0x7ffdbc0008f0, addr=4261412884, attrs=..., buf=0x7ffff7e6b028 "\017?", len=1) at /home/upstream/qemu/exec.c:3288
#19 0x0000555555815c78 in address_space_write (as=0x5555567c92c0 <address_space_memory>, addr=4261412884, attrs=..., buf=0x7ffff7e6b028 "\017?", len=1) at /home/upstream/qemu/exec.c:3378
#20 0x0000555555815cc9 in address_space_rw (as=0x5555567c92c0 <address_space_memory>, addr=4261412884, attrs=..., buf=0x7ffff7e6b028 "\017?", len=1, is_write=true) at /home/upstream/qemu/exec.c:3389
#21 0x000055555589ca60 in kvm_cpu_exec (cpu=0x555556aa5e70) at /home/upstream/qemu/accel/kvm/kvm-all.c:2031
#22 0x000055555586094d in qemu_kvm_cpu_thread_fn (arg=0x555556aa5e70) at /home/upstream/qemu/cpus.c:1281
#23 0x0000555555e02022 in qemu_thread_start (args=0x555556ac8560) at /home/upstream/qemu/util/qemu-thread-posix.c:502
#24 0x00007fffdfac7dd5 in start_thread () at /lib64/libpthread.so.0
#25 0x00007fffdf7f0f6d in clone () at /lib64/libc.so.6


This bug was introduced by commit
3ac7d43a6fbb ("memory: update coalesced_range on transaction_commit")

Reviewing the above patch, it was found that we don't need to add/del
coalesced IO region in the case where the same FlatRanges are
present in the old and new FlatViews. The additional calls to add/del
coalesced IO regions affect the "dev_count" & "ioeventfd_count"
counters in kvm_io_bus data structure, resulting in the following
check to fail in the kernel. This is the cause of the above backtrace.

kvm_io_bus_register_dev():
if (bus->dev_count - bus->ioeventfd_count > NR_IOBUS_DEVS - 1)
    return -ENOSPC;

Avoiding coalesced IO region update in the case of NOP fixes this issue.

Jagannathan Raman (1):
  memory: Do not update coalesced IO range in the case of NOP

 memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
1.8.3.1
