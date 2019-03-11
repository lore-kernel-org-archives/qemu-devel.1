Received: from eggs.gnu.org ([209.51.188.92]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODW-00072B-BZ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODU-00031a-DR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODS-0002uF-FP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id g18so2542773wru.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:49 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e12sm6484836wrs.91.2019.03.11.09.55.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 09:55:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:13 +0100
Message-Id: <1552323335-46779-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/31] target-i386: add kvm stubs to
 user-mode emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
index cb9c265..48e0c28 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -3,10 +3,10 @@ obj-$(CONFIG_TCG) += translate.o
 obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
 obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
+obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-$(CONFIG_HYPERV) += hyperv.o
 obj-$(call lnot,$(CONFIG_HYPERV)) += hyperv-stub.o
 ifeq ($(CONFIG_WIN32),y)
-- 
1.8.3.1
