Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E0C06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E8720665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E8720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJZk-0003K6-7W
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hiJRp-0004vI-IB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hiJRo-0002yP-Ik
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hiJRo-0002xr-CZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFD273082E3F
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 14:07:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 928B17D5CF;
 Tue,  2 Jul 2019 14:07:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 10:07:44 -0400
Message-Id: <20190702140745.27767-2-imammedo@redhat.com>
In-Reply-To: <20190702140745.27767-1-imammedo@redhat.com>
References: <CAFEAcA8Jnh=tu8s08Fu6n0sSmJJuVOx7YxyTR_ni5yW3DdMFkQ@mail.gmail.com>
 <20190702140745.27767-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 14:07:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] numa: allow memory-less nodes when using
 memdev as backend
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU fails to start if memory-less node is present when memdev
is used
  qemu-system-x86_64 -object memory-backend-ram,id=ram0,size=128M \
                     -numa node -numa node,memdev=ram0
with error:
  "memdev option must be specified for either all or no nodes"

which works as expected if legacy 'mem' is used.

Fix check to make memory-less nodes valid when memdev option is used
but still disallow mix of mem and memdev options.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/numa.c b/numa.c
index 91a29138a2..cdef332773 100644
--- a/numa.c
+++ b/numa.c
@@ -48,7 +48,8 @@ QemuOptsList qemu_numa_opts = {
     .desc = { { 0 } } /* validated with OptsVisitor */
 };
 
-static int have_memdevs = -1;
+static int have_memdevs;
+static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
@@ -105,17 +106,11 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         }
     }
 
-    if (node->has_mem && node->has_memdev) {
-        error_setg(errp, "cannot specify both mem= and memdev=");
-        return;
-    }
-
-    if (have_memdevs == -1) {
-        have_memdevs = node->has_memdev;
-    }
-    if (node->has_memdev != have_memdevs) {
-        error_setg(errp, "memdev option must be specified for either "
-                   "all or no nodes");
+    have_memdevs = have_memdevs ? : node->has_memdev;
+    have_mem = have_mem ? : node->has_mem;
+    if ((node->has_mem && have_memdevs) || (node->has_memdev && have_mem)) {
+        error_setg(errp, "numa configuration should use either mem= or memdev=,"
+                   "mixing both is not allowed");
         return;
     }
 
-- 
2.18.1


