Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4t-0002NB-Hq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007DE-HE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:23 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4n-00079f-TR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wm0-x241.google.com with SMTP id y2-v6so3645858wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:17 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.04.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:04:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:41 +0200
Message-Id: <1534870966-9287-70-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 69/74] target/i386: update MPX flags when CPL
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9cad581..b572a8e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1515,6 +1515,8 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 int cpu_get_pic_interrupt(CPUX86State *s);
 /* MSDOS compatibility mode FPU exception support */
 void cpu_set_ferr(CPUX86State *s);
+/* mpx_helper.c */
+void cpu_sync_bndcs_hflags(CPUX86State *env);
 
 /* this function must always be used to load data in the segment
    cache: it synchronizes the hflags with the segment cache values */
@@ -1557,6 +1559,8 @@ static inline void cpu_x86_load_seg_cache(CPUX86State *env,
 #error HF_CPL_MASK is hardcoded
 #endif
             env->hflags = (env->hflags & ~HF_CPL_MASK) | cpl;
+            /* Possibly switch between BNDCFGS and BNDCFGU */
+            cpu_sync_bndcs_hflags(env);
         }
         new_hflags = (env->segs[R_SS].flags & DESC_B_MASK)
             >> (DESC_B_SHIFT - HF_SS32_SHIFT);
@@ -1889,9 +1893,6 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
  */
 void x86_cpu_change_kvm_default(const char *prop, const char *value);
 
-/* mpx_helper.c */
-void cpu_sync_bndcs_hflags(CPUX86State *env);
-
 /* Return name of 32-bit register, from a R_* constant */
 const char *get_register_name_32(unsigned int reg);
 
-- 
1.8.3.1
