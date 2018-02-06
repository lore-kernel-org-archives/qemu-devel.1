Received: from eggs.gnu.org ([2001:4830:134:3::10]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ii-0005Ed-8E
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8id-0007vB-5x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8id-0007uw-0V
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEKR6131195
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:50 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyfvm6ywx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:50 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:49 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:22 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-2-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 01/54] target/i386: Fix handling of VEX prefixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

In commit e3af7c788b73a6495eb9d94992ef11f6ad6f3c56 we
replaced direct calls to to cpu_ld*_code() with calls
to the x86_ld*_code() wrappers which incorporate an
advance of s->pc. Unfortunately we didn't notice that
in one place the old code was deliberately not incrementing
s->pc:

@@ -4501,7 +4528,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             static const int pp_prefix[4] = {
                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
             };
-            int vex3, vex2 = cpu_ldub_code(env, s->pc);
+            int vex3, vex2 = x86_ldub_code(env, s);

             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,

This meant we were mishandling this set of instructions.
Remove the manual advance of s->pc for the "is VEX" case
(which is now done by x86_ldub_code()) and instead rewind
PC in the case where we decide that this isn't really VEX.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
Message-Id: <1513163959-17545-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cfcca361d77142f25fb1128755084cf91faa4db7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 088a9d9766..ed5b69d6af 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4547,9 +4547,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
                    otherwise the instruction is LES or LDS.  */
+                s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
                 break;
             }
-            s->pc++;
 
             /* 4.1.1-4.1.3: No preceding lock, 66, f2, f3, or rex prefixes. */
             if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ
-- 
2.11.0
