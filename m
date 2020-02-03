Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F0C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E65C2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bEn1NXF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV2P-0002vM-P8
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxM-0002Lw-BV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxL-0002WT-2U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:36 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40295 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxK-0002Ts-Nf; Mon, 03 Feb 2020 01:11:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBm3PN7z9sSG; Mon,  3 Feb 2020 17:11:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710288;
 bh=WQAj6rnhkHrN1qnR0hnpwhKAM67m8dgKt8Vo6en0Quc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bEn1NXF8o/xTCtuhRyK6e+j2lmcK038YRaI0Mw0YFfRjm9OdoCJKbaXa+R77+E83T
 hXcAdZ/CpIXhrwOwHs8h11bSqdMTEx70lKuc4mgC4NzNahIxPq1JgGV3B+KQrs1m3u
 1e/ldnEo9RmH3M7XRAyl2Avv6jutxWhgTdZH+Q6o=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/35] target/ppc: Clarify the meaning of return values in
 kvm_handle_debug
Date: Mon,  3 Feb 2020 17:10:53 +1100
Message-Id: <20200203061123.59150-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
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


