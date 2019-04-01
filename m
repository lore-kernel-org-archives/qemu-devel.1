Received: from eggs.gnu.org ([209.51.188.92]:40811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44X-0001K5-5Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44V-0003NW-8O
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44U-0003BY-Mx
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rPs122274
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:59 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8pqx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:57 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:54 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:59 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-26-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 25/97] i386: Disable TOPOEXT by default on
 "-cpu host"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Enabling TOPOEXT is always allowed, but it can't be enabled
blindly by "-cpu host" because it may make guests crash if the
rest of the cache topology information isn't provided or isn't
consistent.

This addresses the bug reported at:
https://bugzilla.redhat.com/show_bug.cgi?id=1613277

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180809221852.15285-1-ehabkost@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 7210a02c58572b2686a3a8d610c6628f87864aed)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 723e02221e..3ac627978f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -849,6 +849,12 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid_eax = 0x80000001, .cpuid_reg = R_ECX,
         .tcg_features = TCG_EXT3_FEATURES,
+        /*
+         * TOPOEXT is always allowed but can't be enabled blindly by
+         * "-cpu host", as it requires consistent cache topology info
+         * to be provided so it doesn't confuse guests.
+         */
+        .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
     [FEAT_C000_0001_EDX] = {
         .feat_names = {
-- 
2.17.1
