Received: from eggs.gnu.org ([209.51.188.92]:45277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQg-0002Ku-DI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQf-00076I-He
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:54 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Feb 2019 13:47:57 +0000
Message-Id: <20190212134758.10514-4-dgilbert@redhat.com>
In-Reply-To: <20190212134758.10514-1-dgilbert@redhat.com>
References: <20190212134758.10514-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] kvm: Add kvm_set_ioeventfd* traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Cc: qemu-trivial@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a couple of traces around the kvm_set_ioeventfd* calls.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 accel/kvm/kvm-all.c    | 3 +++
 accel/kvm/trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4e1de942ce..fd92b6f375 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -657,6 +657,8 @@ static int kvm_set_ioeventfd_mmio(int fd, hwaddr addr=
, uint32_t val,
         .fd =3D fd,
     };
=20
+    trace_kvm_set_ioeventfd_mmio(fd, (uint64_t)addr, val, assign, size,
+                                 datamatch);
     if (!kvm_enabled()) {
         return -ENOSYS;
     }
@@ -688,6 +690,7 @@ static int kvm_set_ioeventfd_pio(int fd, uint16_t add=
r, uint16_t val,
         .fd =3D fd,
     };
     int r;
+    trace_kvm_set_ioeventfd_pio(fd, addr, val, assign, size, datamatch);
     if (!kvm_enabled()) {
         return -ENOSYS;
     }
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 58e98efe5d..8841025d68 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -12,5 +12,7 @@ kvm_irqchip_commit_routes(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vect=
or %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
+kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign,=
 uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=3D0x%x assign:=
 %d size: %d match: %d"
+kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, =
uint32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size: =
%d match: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_a=
ddr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d fla=
gs=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D=
%d"
=20
--=20
2.20.1
