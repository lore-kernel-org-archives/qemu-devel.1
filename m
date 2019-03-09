Received: from eggs.gnu.org ([209.51.188.92]:47312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0003t7-Q9
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0000Vz-0f
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:34 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wic-0000Og-BW
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:32 -0500
Received: by mail-wr1-x42a.google.com with SMTP id o9so448323wrv.9
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id 11sm5252294wmg.27.2019.03.08.23.48.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Mar 2019 23:48:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:00 +0100
Message-Id: <1552117698-12355-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/25] target-i386: add kvm stubs to user-mode
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
