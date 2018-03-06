Received: from eggs.gnu.org ([2001:4830:134:3::10]:50374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1et6Ip-0004Ox-Mi
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1et6Il-00082N-Pj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42008
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1et6Il-00082G-Kd
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w266dkI8071231
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 01:42:18 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghgh820we-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 01:42:18 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 06:42:16 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue,  6 Mar 2018 12:12:09 +0530
In-Reply-To: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
References: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20180306064210.26157-2-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH risu 2/3] ppc64.risu: Fix pattern for load qword
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, joserz@linux.vnet.ibm.com
Cc: nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, qemu-devel@nongnu.org

The pattern for the Load Quadword (lq) instruction is fixed.

If rtp is 0 or 12, the instruction will overwrite r0, r1 or
r12, r13 respectively. However, r1 is the stack frame pointer
and r13 is the thread pointer. So, overwriting them can cause
a crash. This is avoided by putting a constraint to prevent
rtp from being 0 or 12.

For a given effective address (ea), this instruction loads
two dwords from ea and ea+8. However, if ea is the start
address of the current stack frame, then the value of the
back chain dword from the previous stack frame, which is at
ea+8, is loaded on to one of the registers. This can cause
a mismatch as the addresses may vary across the master and
the apprentice instances. This is avoided by always adding
8 to the offset used for calculating the ea.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 ppc64.risu | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ppc64.risu b/ppc64.risu
index 13b95ac..2018103 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -1050,8 +1050,8 @@ LHZX PPC64LE 011111 rt:5 ra:5 rb:5 01000101110 \
 
 # format:DQ book:I page:59 v2.03 lq Load Qword
 LQ PPC64LE 111000 rtp:5 ra:5 imm:12 0000 \
-!constraints { $rtp % 2 == 0 && $ra != 1 && $ra != 13 && $ra != 0 && $ra != $rtp && $imm <= 2032; } \
-!memory { reg_plus_imm($ra, $imm << 4); }
+!constraints { $rtp % 2 == 0 && $rtp != 0 && $rtp != 12 && $ra != 1 && $ra != 13 && $ra != 0 && $ra != $rtp && $imm <= 2032; } \
+!memory { reg_plus_imm($ra, ($imm << 4) + 8); }
 
 # format:X book:I page:65 v:P1 lswi Load String Word Immediate
 LSWI PPC64LE 011111 rt:5 ra:5 rb:5 10010101010 \
-- 
2.14.3
