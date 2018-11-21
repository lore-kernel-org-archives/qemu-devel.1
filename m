Received: from eggs.gnu.org ([2001:4830:134:3::10]:57908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPX37-0008W2-SZ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gPX0p-0006d9-9W
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57770
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gPX0o-0006ab-2W
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:14:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wALI4KNU131771
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:14:04 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwae2ddu0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:14:03 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 21 Nov 2018 18:14:03 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Wed, 21 Nov 2018 16:13:45 -0200
In-Reply-To: <20181121181347.24035-1-farosas@linux.ibm.com>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
Message-Id: <20181121181347.24035-2-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/3] target/ppc: Add macro definitions
 for relocated interrupt vectors offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

The PowerISA prescribes that depending on the values of MSR_IR,
MSR_DR, MSR_HV and LPCR_AIL, the interrupt vectors might be relocated
by specific offsets.

This patch defines macros for these offsets so that they can be used
by another part of the code in a future patch.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/cpu.h         | 3 +++
 target/ppc/excp_helper.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ab68abe8a2..5147db4460 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2390,6 +2390,9 @@ enum {
     AIL_C000_0000_0000_4000 = 3,
 };
 
+#define AIL_0001_8000_OFFSET 0x18000
+#define AIL_C000_0000_0000_4000_OFFSET 0xc000000000004000ull
+
 /*****************************************************************************/
 
 #define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0ec7ae1ad4..49bdf7dd54 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -687,10 +687,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
         switch(ail) {
         case AIL_0001_8000:
-            vector |= 0x18000;
+            vector |= AIL_0001_8000_OFFSET;
             break;
         case AIL_C000_0000_0000_4000:
-            vector |= 0xc000000000004000ull;
+            vector |= AIL_C000_0000_0000_4000_OFFSET;
             break;
         default:
             cpu_abort(cs, "Invalid AIL combination %d\n", ail);
-- 
2.17.1
