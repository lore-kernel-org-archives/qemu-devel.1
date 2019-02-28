Received: from eggs.gnu.org ([209.51.188.92]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzHvA-0000JX-L3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzHuv-0000Zt-SD
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:23:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gzHuv-0000Za-Ax
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:23:49 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Feb 2019 10:23:45 +0100
Message-Id: <20190228092345.16294-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target-i386: add kvm stubs to user-mode
 emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>

The CPUID code will call kvm_arch_get_supported_cpuid() and, even though
it is undef kvm_enabled() so it never runs for user-mode emulators,
sometimes clang will not optimize it out at -O0.

That could be considered a compiler bug, however at -O0 we give it
a pass and just add the stubs.

Reported-by: Kamil Rytarowski <n54@gmx.com>
Tested-by: Kamil Rytarowski <n54@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index cb9c265525..48e0c28434 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -3,10 +3,10 @@ obj-$(CONFIG_TCG) +=3D translate.o
 obj-$(CONFIG_TCG) +=3D bpt_helper.o cc_helper.o excp_helper.o fpu_helper=
.o
 obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o mpx_helpe=
r.o
 obj-$(CONFIG_TCG) +=3D seg_helper.o smm_helper.o svm_helper.o
+obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y +=3D machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) +=3D kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
 obj-$(CONFIG_HYPERV) +=3D hyperv.o
 obj-$(call lnot,$(CONFIG_HYPERV)) +=3D hyperv-stub.o
 ifeq ($(CONFIG_WIN32),y)
--=20
2.20.1
