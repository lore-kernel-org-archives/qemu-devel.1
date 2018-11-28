Received: from eggs.gnu.org ([2001:4830:134:3::10]:52959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1gRoKm-0002hA-FN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1gRo7a-0002nL-JB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:54:35 -0500
Received: from smtp.h3c.com ([60.191.123.56]:42844 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1gRo7Z-0002k9-Sk
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:54:30 -0500
From: Changlimin <changlimin@h3c.com>
Date: Wed, 28 Nov 2018 00:54:13 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572017854570C@H3CMLB12-EX.srv.huawei-3com.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] What will happen if guest write to a memory address
 which not exists in any kvm memory slot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

For a multiple cpu guest, during cpu 0 delete a memory sot then add it,
if cpu 1 write the memory address which belong to the deleted memory slot a=
nd not exist in PTE,
kvm_mmu_page_fault fail, then return the QEMU with the reason KVM_EXIT_MMIO=
,
QEMU will also fail, What will happen in Guest?

This is the trace of kvm_set_memory_region, slot 0 is often deleted then ad=
ded,
Maybe there is a memory write in guest after delete and before add.

# trace-bpfcc -I /usr/src/linux-headers-4.18.0-10-generic/include/uapi/linu=
x/kvm.h \
'p::kvm_set_memory_region(struct kvm *kvm, struct kvm_userspace_memory_regi=
on *mem), \
"slot %d addr %x size %x", mem->slot,mem->guest_phys_addr,mem->memory_size'

PID     TID     COMM            FUNC             -
8019    8019    qemu-system-x86 kvm_set_memory_region slot 0 addr 0 size 40=
000000
8019    8019    qemu-system-x86 kvm_set_memory_region slot 1 addr fffe0000 =
size 0
8019    8019    qemu-system-x86 kvm_set_memory_region slot 1 addr fffe0000 =
size 20000
8019    8019    qemu-system-x86 kvm_set_memory_region slot 0 addr 0 size 0
8019    8019    qemu-system-x86 kvm_set_memory_region slot 0 addr 0 size c0=
000
8019    8019    qemu-system-x86 kvm_set_memory_region slot 2 addr c0000 siz=
e 0
8019    8019    qemu-system-x86 kvm_set_memory_region slot 2 addr c0000 siz=
e 20000
8019    8019    qemu-system-x86 kvm_set_memory_region slot 3 addr e0000 siz=
e 0
8019    8019    qemu-system-x86 kvm_set_memory_region slot 3 addr e0000 siz=
e 20000
8019    8019    qemu-system-x86 kvm_set_memory_region slot 4 addr 100000 si=
ze 3ff00000
8019    8019    qemu-system-x86 kvm_set_memory_region slot 0 addr 0 size 0
8019    8019    qemu-system-x86 kvm_set_memory_region slot 0 addr 0 size a0=
000
