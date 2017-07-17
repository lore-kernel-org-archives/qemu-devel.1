Received: from eggs.gnu.org ([2001:4830:134:3::10]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1dWwTi-0002Pg-AA
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1dWwTf-0000z8-0y
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:13:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1dWwTd-0000u0-Tz
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:13:42 -0400
From: "Xulei (Stone)" <stone.xulei@huawei.com>
Date: Mon, 17 Jul 2017 03:13:05 +0000
Message-ID: <8E78D212B8C25246BE4CE7EA0E645FE501066958@dggemi503-mbs.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Question] Seabios HANGs when mmio wirte in a nested
 vmware host wtih virito-scsi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios <seabios@seabios.org>, qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: kevin <kevin@koconnor.net>, pbonzini <pbonzini@redhat.com>, jasowang <jasowang@redhat.com>, kraxel <kraxel@redhat.com>, mst <mst@redhat.com>, xiaoguangrong <xiaoguangrong@tencent.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

Hello all,
Recently, I met a werid question when i run a VM in the following platfrom:

Vmware Vsphere 6.0/6.5
   |-- centos 7.3 nested VM (with qemu 2.8, kmod 4.4.11, seabios 1.10)
        |-- VM (with virtio-scsi controller, modern mode)

VM MUST hang in seabios when try to mmio write during virtio-scsi init.
I  deeply analyze the code, and i found that:

Seabios calltrace:
scsi_drive_setup
   |-- cdb_get_inquiry
        |-- virtio_scsi_process_op
             |-- vring_kick
                  |-- writew  (hang here, mmio write, never return...)

Kmod calltrace:
handle_EPT_MISCONFIG
    |--kvm_io_bus_write
        |-- kvm_iodevice_write (fast mmio through ioeventfd to trigger qemu=
)
             |-- vcpu_run
                  |-- vcpu_enter_guest

Qemu calltrace:
os_host_main_loop_wait
      |--glib_pollfds_poll
          |-- aio_dispatch
               |-- vritio_scsi_handle_cmd_vq
                   |--virtio_scsi_pop_req
                       |-- virtqueue_pop
                            |--virtio_queue_empty

Then, kmod falls in infinite loop in handle EPT_MISCONFIG.
As far as i know, when kvm enters guest after handling EPT_MISCONFIG, seabi=
os should return
from mmio write and wait for virtio backend(qemu) to handle this mmio writi=
ng.
What puzzles me:
1) i can not understand why kvm runs in infinite loop and seabios does not =
return from writew.
2) kvm nested kvm is ok. But vmware nested kvm is not ok. This problem has =
anything related
    with vmware?

Looking forward for directions...

Attached Kmod ftrace:
       CPU 0/KVM-9435  [008] .... 241968.479572: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479573: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479573: kvm_entry: vcpu 0
       CPU 0/KVM-9435  [008] .... 241968.479583: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479589: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479589: kvm_entry: vcpu 0
       CPU 0/KVM-9435  [008] .... 241968.479599: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479600: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479601: kvm_entry: vcpu 0
       CPU 0/KVM-9435  [008] .... 241968.479610: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479616: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479617: kvm_entry: vcpu 0
       CPU 0/KVM-9435  [008] .... 241968.479627: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479628: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479628: kvm_entry: vcpu 0
       CPU 0/KVM-9435  [008] .... 241968.479638: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479644: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479644: kvm_entry: vcpu 0
       CPU 0/KVM-9435  [008] .... 241968.479655: kvm_exit: reason EPT_MISCO=
NFIG rip 0xee696 info 0 0
       CPU 0/KVM-9435  [008] .... 241968.479656: kvm_fast_mmio: fast mmio a=
t gpa 0xfe003008
       CPU 0/KVM-9435  [008] d... 241968.479656: kvm_entry: vcpu 0

________________________________
