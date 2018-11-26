Received: from eggs.gnu.org ([2001:4830:134:3::10]:45170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkP-00081Q-4K
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkO-0004Ng-Ba
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkO-0004IV-5m
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id v13so16769491wrw.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:44 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s139sm2412468wmd.3.2018.11.26.11.40.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Nov 2018 11:40:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:24 +0100
Message-Id: <1543261235-2834-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] migration: savevm: consult migration
 blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is really no difference between live migration and savevm, except
that savevm does not require bdrv_invalidate_cache to be implemented
by all disks.  However, it is unlikely that savevm is used with anything
except qcow2 disks, so the penalty is small and worth the improvement
in catching bad usage of savevm.

Only one place was taking care of savevm when adding a migration blocker,
and it can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/savevm.c | 4 ++++
 target/i386/kvm.c  | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ef707b8..1c49776 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2455,6 +2455,10 @@ int save_snapshot(const char *name, Error **errp)
     struct tm tm;
     AioContext *aio_context;
 
+    if (migration_is_blocked(errp)) {
+        return false;
+    }
+
     if (!replay_can_snapshot()) {
         error_setg(errp, "Record/replay does not allow making snapshot "
                    "right now. Try once more later.");
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 27dcca5..77e44b6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1265,7 +1265,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (!env->user_tsc_khz) {
         if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
             invtsc_mig_blocker == NULL) {
-            /* for migration */
             error_setg(&invtsc_mig_blocker,
                        "State blocked by non-migratable CPU device"
                        " (invtsc flag)");
@@ -1275,8 +1274,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 error_free(invtsc_mig_blocker);
                 return r;
             }
-            /* for savevm */
-            vmstate_x86_cpu.unmigratable = 1;
         }
     }
 
-- 
1.8.3.1
