Received: from eggs.gnu.org ([2001:4830:134:3::10]:45632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAuGM-000140-8M
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAuGI-0007u6-RQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:01:42 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 12 Oct 2018 12:01:01 +0200
Message-Id: <20181012100101.29058-9-cohuck@redhat.com>
In-Reply-To: <20181012100101.29058-1-cohuck@redhat.com>
References: <20181012100101.29058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] hw/s390x: Include the tod-qemu also for
 builds with --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The device is required for running qtests, see hw/s390x/tod.c:

void s390_init_tod(void)
{
    Object *obj;

    if (kvm_enabled()) {
        obj = object_new(TYPE_KVM_S390_TOD);
    } else {
        obj = object_new(TYPE_QEMU_S390_TOD);
    }
    [...]
  }

During qtests, we're running without kvm, so TYPE_QEMU_S390_TOD is
required to avoid that QEMU aborts here.

Fixes: 8046f374a6 ("s390x/tod: factor out TOD into separate device")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1539264723-741-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 49cae2f5c4..ca68806e44 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -26,8 +26,8 @@ obj-$(call lnot,$(CONFIG_PCI)) += s390-pci-stub.o
 obj-y += s390-skeys.o
 obj-y += s390-stattrib.o
 obj-y += tod.o
+obj-y += tod-qemu.o
 obj-$(CONFIG_KVM) += tod-kvm.o
-obj-$(CONFIG_TCG) += tod-qemu.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
-- 
2.14.4
