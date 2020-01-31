Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF6C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BE920663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DuoRkdED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BE920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixPVz-0008Uz-JD
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUq-0006b5-Qo
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUp-0000NV-OC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:40 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54387 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixPUp-0000KF-DW; Fri, 31 Jan 2020 01:09:39 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4886Hs0FW1z9sRh; Fri, 31 Jan 2020 17:09:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580450969;
 bh=WQAj6rnhkHrN1qnR0hnpwhKAM67m8dgKt8Vo6en0Quc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DuoRkdED8r2l/DkJZ01foge6zcja/wz3I6ON94EVlTGJIMS30vAVNiJMF9bFZv8h4
 x728rE4+vZYg72iNgupMJSKCqQeIKxnirClrc3Sat6eSAO6jKoJ+iUO6r+dLsRYush
 /W9kSpVNBO3pJdwkfGYzGcaOOmpClOsYx7QIp6LQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/34] target/ppc: Clarify the meaning of return values in
 kvm_handle_debug
Date: Fri, 31 Jan 2020 17:08:55 +1100
Message-Id: <20200131060924.147449-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131060924.147449-1-david@gibson.dropbear.id.au>
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 Leonardo Bras <leonardo@ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fabiano Rosas <farosas@linux.ibm.com>

The kvm_handle_debug function can return 0 to go back into the guest
or return 1 to notify the gdbstub thread and pass control to GDB.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Message-Id: <20200110151344.278471-2-farosas@linux.ibm.com>
Tested-by: Leonardo Bras <leonardo@ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 06fd0cc162..c05dde5985 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -53,6 +53,9 @@
=20
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
=20
+#define DEBUG_RETURN_GUEST 0
+#define DEBUG_RETURN_GDB   1
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
     KVM_CAP_LAST_INFO
 };
@@ -1564,7 +1567,7 @@ void kvm_arch_update_guest_debug(CPUState *cs, stru=
ct kvm_guest_debug *dbg)
 static int kvm_handle_hw_breakpoint(CPUState *cs,
                                     struct kvm_debug_exit_arch *arch_inf=
o)
 {
-    int handle =3D 0;
+    int handle =3D DEBUG_RETURN_GUEST;
     int n;
     int flag =3D 0;
=20
@@ -1572,13 +1575,13 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
         if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
             n =3D find_hw_breakpoint(arch_info->address, GDB_BREAKPOINT_=
HW);
             if (n >=3D 0) {
-                handle =3D 1;
+                handle =3D DEBUG_RETURN_GDB;
             }
         } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
                                         KVMPPC_DEBUG_WATCH_WRITE)) {
             n =3D find_hw_watchpoint(arch_info->address,  &flag);
             if (n >=3D 0) {
-                handle =3D 1;
+                handle =3D DEBUG_RETURN_GDB;
                 cs->watchpoint_hit =3D &hw_watchpoint;
                 hw_watchpoint.vaddr =3D hw_debug_points[n].addr;
                 hw_watchpoint.flags =3D flag;
@@ -1590,12 +1593,12 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
=20
 static int kvm_handle_singlestep(void)
 {
-    return 1;
+    return DEBUG_RETURN_GDB;
 }
=20
 static int kvm_handle_sw_breakpoint(void)
 {
-    return 1;
+    return DEBUG_RETURN_GDB;
 }
=20
 static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
@@ -1647,7 +1650,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct=
 kvm_run *run)
     env->error_code =3D POWERPC_EXCP_INVAL;
     ppc_cpu_do_interrupt(cs);
=20
-    return 0;
+    return DEBUG_RETURN_GUEST;
 }
=20
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
--=20
2.24.1


