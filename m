Received: from eggs.gnu.org ([2001:4830:134:3::10]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaV-0004fd-Dz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaS-0005b4-AZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49227
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVgaS-0005av-5Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DG35Jt064407
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:31 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpafm4kxc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:30 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 17:03:14 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 18:03:04 +0200
In-Reply-To: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499961789-127874-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 2/7] s390x/cpumodel: we are always in
 zarchitecture mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

In QEMU, a guest VCPU always started in and never was able to leave
z/Architecture mode. Now we have an architected way of showing this
condition.

The SIGP SET ARCHITECTURE instruction is simply rejected. Linux as guest
seems to not care about the return value, which is a good thing
The new handling is just like already being in z/Architecture mode.

We'll not try to fake absence of this facility, but still not indicate
the facility in case some strange CPU model turned z/Architecture off
completely (which doesn't work either way but let's us see how a
guest would react on a lack of this facility).

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c |  5 +++--
 target/s390x/kvm.c          | 38 +++++++++++---------------------------
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index e5a3f71..fa887d9 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -337,8 +337,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     int bit_nr;
 
     if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
-        /* z/Architecture is always active if around */
-        data[0] |= 0x20;
+        /* Features that are always active */
+        data[0] |= 0x20;  /* z/Architecture */
+        data[17] |= 0x20; /* Configuration-z-architectural-mode */
     }
 
     feat = find_first_bit(features, S390_FEAT_MAX);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 3a80f1f..8c6cc0a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1757,41 +1757,25 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
 {
     CPUState *cur_cs;
     S390CPU *cur_cpu;
+    bool all_stopped = true;
 
-    /* due to the BQL, we are the only active cpu */
     CPU_FOREACH(cur_cs) {
         cur_cpu = S390_CPU(cur_cs);
-        if (cur_cpu->env.sigp_order != 0) {
-            return SIGP_CC_BUSY;
+
+        if (cur_cpu == cpu) {
+            continue;
         }
-        cpu_synchronize_state(cur_cs);
-        /* all but the current one have to be stopped */
-        if (cur_cpu != cpu &&
-            s390_cpu_get_state(cur_cpu) != CPU_STATE_STOPPED) {
-            *status_reg &= 0xffffffff00000000ULL;
-            *status_reg |= SIGP_STAT_INCORRECT_STATE;
-            return SIGP_CC_STATUS_STORED;
+        if (s390_cpu_get_state(cur_cpu) != CPU_STATE_STOPPED) {
+            all_stopped = false;
         }
     }
 
-    switch (param & 0xff) {
-    case SIGP_MODE_ESA_S390:
-        /* not supported */
-        return SIGP_CC_NOT_OPERATIONAL;
-    case SIGP_MODE_Z_ARCH_TRANS_ALL_PSW:
-    case SIGP_MODE_Z_ARCH_TRANS_CUR_PSW:
-        CPU_FOREACH(cur_cs) {
-            cur_cpu = S390_CPU(cur_cs);
-            cur_cpu->env.pfault_token = -1UL;
-        }
-        break;
-    default:
-        *status_reg &= 0xffffffff00000000ULL;
-        *status_reg |= SIGP_STAT_INVALID_PARAMETER;
-        return SIGP_CC_STATUS_STORED;
-    }
+    *status_reg &= 0xffffffff00000000ULL;
 
-    return SIGP_CC_ORDER_CODE_ACCEPTED;
+    /* Reject set arch order, with czam we're always in z/Arch mode. */
+    *status_reg |= (all_stopped ? SIGP_STAT_INVALID_PARAMETER :
+                    SIGP_STAT_INCORRECT_STATE);
+    return SIGP_CC_STATUS_STORED;
 }
 
 static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
-- 
2.7.4
