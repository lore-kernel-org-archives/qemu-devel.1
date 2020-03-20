Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7751C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6F520739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="po4vQ8Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6F520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFM16-0007uW-Lu
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <765dc71935420b8f517ffb72100e8b3fec8e4c9b@lizzy.crudebyte.com>)
 id 1jFLzy-0006bZ-IO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <765dc71935420b8f517ffb72100e8b3fec8e4c9b@lizzy.crudebyte.com>)
 id 1jFLzx-00048O-6z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:03:58 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <765dc71935420b8f517ffb72100e8b3fec8e4c9b@lizzy.crudebyte.com>)
 id 1jFLzx-0002qd-0B
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=waLIntpzbDuSwKzCLHhytuC1f3yRX6jYMW8l3WUmV68=; b=po4vQ
 8SdSuDFGht0NckrRMVXhFLITe49upClW+dFzkyLTvk/34VMic/VBk5B7pe7RAn0/O56n8jSeSOnGB
 ubKtRsGOUdDEQ5P0S4OK7J/Guj89J8rj9dw4SWZ9K/KTeIPcJoCVRhm9COJGVnG50uDZIxXIlUUa6
 Daz2of6+FF87hFEmKSZqINot09uktUGHEmzRpgt3TI4RbG9K2aN5aQ59BGz4e+1cXAbqvhMmhc6kh
 GORpGUDGuj7iUQ9S/JzpxkvIceiK/1war7p9vjnsqNPE8GCrL1tVdGY+AC5GxpssrxzmeXakULMiw
 /tE3ynUlP7dgCYRyqX8tbrZPkLx5g==;
Message-Id: <765dc71935420b8f517ffb72100e8b3fec8e4c9b.1584723662.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1584723662.git.qemu_oss@crudebyte.com>
References: <cover.1584723662.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 20 Mar 2020 17:48:53 +0100
Subject: [PATCH v2 2/4] qemu: capabilities: add QEMU_CAPS_VIRTFS_MULTIDEVS
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org,
    Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU 9pfs 'multidevs' option exists since QEMU 4.2, so just
set this capability based on that QEMU version.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 src/qemu/qemu_capabilities.c                      | 5 +++++
 src/qemu/qemu_capabilities.h                      | 1 +
 tests/qemucapabilitiesdata/caps_4.2.0.x86_64.xml  | 1 +
 tests/qemucapabilitiesdata/caps_5.0.0.aarch64.xml | 1 +
 tests/qemucapabilitiesdata/caps_5.0.0.x86_64.xml  | 1 +
 5 files changed, 9 insertions(+)

diff --git a/src/qemu/qemu_capabilities.c b/src/qemu/qemu_capabilities.c
index a95a60c36a..68b6e166e9 100644
--- a/src/qemu/qemu_capabilities.c
+++ b/src/qemu/qemu_capabilities.c
@@ -567,6 +567,7 @@ VIR_ENUM_IMPL(virQEMUCaps,
               "query-named-block-nodes.flat",
               "blockdev-snapshot.allow-write-only-overlay",
               "blockdev-reopen",
+              "virtfs-multidevs",
     );
 
 
@@ -4837,6 +4838,10 @@ virQEMUCapsInitQMPVersionCaps(virQEMUCapsPtr qemuCaps)
         ARCH_IS_PPC64(qemuCaps->arch)) {
         virQEMUCapsSet(qemuCaps, QEMU_CAPS_MACHINE_PSERIES_MAX_CPU_COMPAT);
     }
+
+    /* -virtfs multidevs option is supported since QEMU 4.2 */
+    if (qemuCaps->version >= 4002000)
+        virQEMUCapsSet(qemuCaps, QEMU_CAPS_VIRTFS_MULTIDEVS);
 }
 
 
diff --git a/src/qemu/qemu_capabilities.h b/src/qemu/qemu_capabilities.h
index f0961e273c..a6025312be 100644
--- a/src/qemu/qemu_capabilities.h
+++ b/src/qemu/qemu_capabilities.h
@@ -548,6 +548,7 @@ typedef enum { /* virQEMUCapsFlags grouping marker for syntax-check */
     QEMU_CAPS_QMP_QUERY_NAMED_BLOCK_NODES_FLAT, /* query-named-block-nodes supports the 'flat' option */
     QEMU_CAPS_BLOCKDEV_SNAPSHOT_ALLOW_WRITE_ONLY, /* blockdev-snapshot has the 'allow-write-only-overlay' feature */
     QEMU_CAPS_BLOCKDEV_REOPEN, /* 'blockdev-reopen' qmp command is supported */
+    QEMU_CAPS_VIRTFS_MULTIDEVS, /* -virtfs multidevs supported by virtio-9p */
 
     QEMU_CAPS_LAST /* this must always be the last item */
 } virQEMUCapsFlags;
diff --git a/tests/qemucapabilitiesdata/caps_4.2.0.x86_64.xml b/tests/qemucapabilitiesdata/caps_4.2.0.x86_64.xml
index 83e804ea36..d8b0de46cd 100644
--- a/tests/qemucapabilitiesdata/caps_4.2.0.x86_64.xml
+++ b/tests/qemucapabilitiesdata/caps_4.2.0.x86_64.xml
@@ -223,6 +223,7 @@
   <flag name='rng-builtin'/>
   <flag name='virtio-net.failover'/>
   <flag name='vhost-user-fs'/>
+  <flag name='virtfs-multidevs'/>
   <version>4002000</version>
   <kvmVersion>0</kvmVersion>
   <microcodeVersion>43100242</microcodeVersion>
diff --git a/tests/qemucapabilitiesdata/caps_5.0.0.aarch64.xml b/tests/qemucapabilitiesdata/caps_5.0.0.aarch64.xml
index e52c60607d..3a695fbe79 100644
--- a/tests/qemucapabilitiesdata/caps_5.0.0.aarch64.xml
+++ b/tests/qemucapabilitiesdata/caps_5.0.0.aarch64.xml
@@ -181,6 +181,7 @@
   <flag name='virtio-net.failover'/>
   <flag name='cpu.kvm-no-adjvtime'/>
   <flag name='vhost-user-fs'/>
+  <flag name='virtfs-multidevs'/>
   <version>4002050</version>
   <kvmVersion>0</kvmVersion>
   <microcodeVersion>61700241</microcodeVersion>
diff --git a/tests/qemucapabilitiesdata/caps_5.0.0.x86_64.xml b/tests/qemucapabilitiesdata/caps_5.0.0.x86_64.xml
index d773f7e356..95fa0813dd 100644
--- a/tests/qemucapabilitiesdata/caps_5.0.0.x86_64.xml
+++ b/tests/qemucapabilitiesdata/caps_5.0.0.x86_64.xml
@@ -226,6 +226,7 @@
   <flag name='vhost-user-fs'/>
   <flag name='query-named-block-nodes.flat'/>
   <flag name='blockdev-snapshot.allow-write-only-overlay'/>
+  <flag name='virtfs-multidevs'/>
   <version>4002050</version>
   <kvmVersion>0</kvmVersion>
   <microcodeVersion>43100241</microcodeVersion>
-- 
2.20.1


