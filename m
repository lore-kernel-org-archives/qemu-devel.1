Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F425C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C672133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C672133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43577 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEUfm-0000ve-FZ
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 04:03:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUeA-0008N5-2o
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUe8-0008Ny-0J
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:22 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:33211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUe7-0008Mt-Hr
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:19 -0400
Received: from player779.ha.ovh.net (unknown [10.109.159.152])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id C12104E3E3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:01:16 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player779.ha.ovh.net (Postfix) with ESMTPSA id 7FE1148B8E83;
	Thu, 11 Apr 2019 08:01:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Apr 2019 10:00:03 +0200
Message-Id: <20190411080004.8690-6-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411080004.8690-1-clg@kaod.org>
References: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 17603445047195175910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
Subject: [Qemu-devel] [PATCH 5/6] memory_ldst: Add atomic ops for PTE updates
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411080003.HiATIjo13JgDih5w5TioaNun-EPCtndOa5GRBEB32KA@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

On some architectures, PTE updates for dirty and changed bits need
to be performed atomically. This adds a couple of address_space_cmpxchg*
helpers for that purpose.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/exec/memory_ldst.inc.h |  6 +++
 memory_ldst.inc.c              | 80 ++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.in=
c.h
index 272c20f02eae..f3cfa7e9a622 100644
--- a/include/exec/memory_ldst.inc.h
+++ b/include/exec/memory_ldst.inc.h
@@ -28,6 +28,12 @@ extern uint64_t glue(address_space_ldq, SUFFIX)(ARG1_D=
ECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+extern uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
+    MemTxResult *result);
+extern uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
+    MemTxResult *result);
 extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index acf865b900d7..1d58d2fea67d 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -320,6 +320,86 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_D=
ECL,
     RCU_READ_UNLOCK();
 }
=20
+/* This is meant to be used for atomic PTE updates under MT-TCG */
+uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
+    MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l =3D 4;
+    hwaddr addr1;
+    MemTxResult r;
+    uint8_t dirty_log_mask;
+
+    /* Must test result */
+    assert(result);
+
+    RCU_READ_LOCK();
+    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < 4 || !memory_access_is_direct(mr, true)) {
+        r =3D MEMTX_ERROR;
+    } else {
+        uint32_t orig =3D old;
+
+        ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
+        old =3D atomic_cmpxchg(ptr, orig, new);
+
+        if (old =3D=3D orig) {
+            dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
+            dirty_log_mask &=3D ~(1 << DIRTY_MEMORY_CODE);
+            cpu_physical_memory_set_dirty_range(memory_region_get_ram_ad=
dr(mr) +
+                                                addr, 4, dirty_log_mask)=
;
+        }
+        r =3D MEMTX_OK;
+    }
+    *result =3D r;
+    RCU_READ_UNLOCK();
+
+    return old;
+}
+
+#ifdef CONFIG_ATOMIC64
+/* This is meant to be used for atomic PTE updates under MT-TCG */
+uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
+    MemTxResult *result)
+{
+    uint8_t *ptr;
+    MemoryRegion *mr;
+    hwaddr l =3D 8;
+    hwaddr addr1;
+    MemTxResult r;
+    uint8_t dirty_log_mask;
+
+    /* Must test result */
+    assert(result);
+
+    RCU_READ_LOCK();
+    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
+    if (l < 8 || !memory_access_is_direct(mr, true)) {
+        r =3D MEMTX_ERROR;
+    } else {
+        uint32_t orig =3D old;
+
+        ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
+        old =3D atomic_cmpxchg(ptr, orig, new);
+
+        if (old =3D=3D orig) {
+            dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
+            dirty_log_mask &=3D ~(1 << DIRTY_MEMORY_CODE);
+            cpu_physical_memory_set_dirty_range(memory_region_get_ram_ad=
dr(mr) +
+                                                addr, 8, dirty_log_mask)=
;
+        }
+        r =3D MEMTX_OK;
+    }
+    *result =3D r;
+    RCU_READ_UNLOCK();
+
+    return old;
+}
+#endif /* CONFIG_ATOMIC64 */
+
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
--=20
2.20.1


