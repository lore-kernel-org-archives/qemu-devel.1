Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8972C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D442207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D442207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJkT-0001TU-Eh
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBJed-0006oN-4Z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBJeZ-00051Z-QO
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBJeZ-00051E-HT
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:12:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40ADD18C8919;
 Fri, 20 Sep 2019 14:12:54 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A24CC60C18;
 Fri, 20 Sep 2019 14:12:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace events
Date: Fri, 20 Sep 2019 16:12:48 +0200
Message-Id: <20190920141248.12887-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 20 Sep 2019 14:12:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the unassigned_access CPU hooks have been removed,
the unassigned_mem_read/write functions are only used for
debugging purpose.
Simplify by converting them to in-place trace events.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20190920125008.13604-1-peter.maydell@linaro.org>
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04668.html
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03705.html

I first wrote:

  These functions are declared using the CPUReadMemoryFunc/
  CPUWriteMemoryFunc prototypes. Since it is confusing to
  have such prototype only use for debugging, convert them
  to in-place trace events.

But it doesn't provide helpful information and is rather confusing.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 memory.c     | 24 +++---------------------
 trace-events |  2 ++
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/memory.c b/memory.c
index 93a05395cf..07e80a637a 100644
--- a/memory.c
+++ b/memory.c
@@ -35,8 +35,6 @@
 #include "hw/boards.h"
 #include "migration/vmstate.h"
=20
-//#define DEBUG_UNASSIGNED
-
 static unsigned memory_region_transaction_depth;
 static bool memory_region_update_pending;
 static bool ioeventfd_update_pending;
@@ -1272,23 +1270,6 @@ static void iommu_memory_region_initfn(Object *obj=
)
     mr->is_iommu =3D true;
 }
=20
-static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
-                                    unsigned size)
-{
-#ifdef DEBUG_UNASSIGNED
-    printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
-#endif
-    return 0;
-}
-
-static void unassigned_mem_write(void *opaque, hwaddr addr,
-                                 uint64_t val, unsigned size)
-{
-#ifdef DEBUG_UNASSIGNED
-    printf("Unassigned mem write " TARGET_FMT_plx " =3D 0x%"PRIx64"\n", =
addr, val);
-#endif
-}
-
 static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
                                    unsigned size, bool is_write,
                                    MemTxAttrs attrs)
@@ -1437,7 +1418,8 @@ MemTxResult memory_region_dispatch_read(MemoryRegio=
n *mr,
     MemTxResult r;
=20
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
-        *pval =3D unassigned_mem_read(mr, addr, size);
+        trace_memory_region_invalid_read(size, addr);
+        *pval =3D 0; /* FIXME now this value shouldn't be accessed in gu=
est */
         return MEMTX_DECODE_ERROR;
     }
=20
@@ -1481,7 +1463,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegi=
on *mr,
     unsigned size =3D memop_size(op);
=20
     if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
-        unassigned_mem_write(mr, addr, data, size);
+        trace_memory_region_invalid_write(size, addr, size << 1, data);
         return MEMTX_DECODE_ERROR;
     }
=20
diff --git a/trace-events b/trace-events
index 823a4ae64e..83dbeb4b46 100644
--- a/trace-events
+++ b/trace-events
@@ -62,6 +62,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uin=
t64_t value, unsigned siz
 memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, uns=
igned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PR=
Ix64" size %u"
+memory_region_invalid_read(unsigned size, uint64_t addr) "invalid read s=
ize %u addr 0x%"PRIx64
+memory_region_invalid_write(unsigned size, uint64_t addr, int fmt_width,=
 uint64_t value) "invalid write size %u addr 0x%"PRIx64" value 0x%0*"PRIx=
64
 flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
--=20
2.20.1


