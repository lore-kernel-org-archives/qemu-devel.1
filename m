Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470ABC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C5220739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YDS0Anm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C5220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFM06-0006Uk-87
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <db76c7042cf249ca51ef0269c824213eb73452b0@lizzy.crudebyte.com>)
 id 1jFLyz-0005VG-1i
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <db76c7042cf249ca51ef0269c824213eb73452b0@lizzy.crudebyte.com>)
 id 1jFLyx-0002qU-W2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:02:56 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <db76c7042cf249ca51ef0269c824213eb73452b0@lizzy.crudebyte.com>)
 id 1jFLyx-0001IN-Nr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=KPesT1KlQk2GePUADf96n6O82LMG+9/pKpM7fc0jnRU=; b=YDS0A
 nm83IqfBM4pYlm5HvgC8ljcE5CegmWfqlSPR5sKPCZKUNPgaNX8omsCGbZCrt+okHTQffOSmq6dZj
 LUZkOi7BKTYCXOyD+wZNlOnujgY+MB0AyKFRPvLnEVxaVMPEwdXD1YAu888TxmccSurxcu6en3h3z
 MmnY/TIoSFXYqGb0IcKg+33puUi9pp9DDZxSk1uTvNC+mWNvJClQgxAF7W1MHny7/KRLS7GdVXkM5
 pGKgBZNTwlTSQDfvO5a3exAqJG+dXbBpdwkXluzNqmN1dPhm9YIL7CgQuXyXYRzzwdwvv1LrBdLtH
 JhrU8vCplG4jYljU/uGx9JoUNRR+w==;
Message-Id: <db76c7042cf249ca51ef0269c824213eb73452b0.1584723663.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1584723662.git.qemu_oss@crudebyte.com>
References: <cover.1584723662.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 20 Mar 2020 17:54:32 +0100
Subject: [PATCH v2 4/4] qemu: add support for 'multidevs' option
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

This option prevents misbehaviours on guest if a qemu 9pfs export
contains multiple devices, due to the potential file ID collisions
this otherwise may cause.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 src/qemu/qemu_command.c |  7 +++++++
 src/qemu/qemu_domain.c  | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
index 9790c92cf8..7020e5448c 100644
--- a/src/qemu/qemu_command.c
+++ b/src/qemu/qemu_command.c
@@ -2632,6 +2632,13 @@ qemuBuildFSStr(virDomainFSDefPtr fs)
         } else if (fs->accessmode == VIR_DOMAIN_FS_ACCESSMODE_SQUASH) {
             virBufferAddLit(&opt, ",security_model=none");
         }
+        if (fs->multidevs == VIR_DOMAIN_FS_MULTIDEVS_REMAP) {
+            virBufferAddLit(&opt, ",multidevs=remap");
+        } else if (fs->multidevs == VIR_DOMAIN_FS_MULTIDEVS_FORBID) {
+            virBufferAddLit(&opt, ",multidevs=forbid");
+        } else if (fs->multidevs == VIR_DOMAIN_FS_MULTIDEVS_WARN) {
+            virBufferAddLit(&opt, ",multidevs=warn");
+        }
     } else if (fs->fsdriver == VIR_DOMAIN_FS_DRIVER_TYPE_HANDLE) {
         /* removed since qemu 4.0.0 see v3.1.0-29-g93aee84f57 */
         virBufferAddLit(&opt, "handle");
diff --git a/src/qemu/qemu_domain.c b/src/qemu/qemu_domain.c
index edc8ba2ddb..c54c64fadb 100644
--- a/src/qemu/qemu_domain.c
+++ b/src/qemu/qemu_domain.c
@@ -8529,6 +8529,13 @@ qemuDomainDeviceDefValidateFS(virDomainFSDefPtr fs,
                        _("only supports mount filesystem type"));
         return -1;
     }
+    if (fs->multidevs != VIR_DOMAIN_FS_MODEL_DEFAULT &&
+        !virQEMUCapsGet(qemuCaps, QEMU_CAPS_VIRTFS_MULTIDEVS))
+    {
+        virReportError(VIR_ERR_CONFIG_UNSUPPORTED, "%s",
+                       _("multidevs is not supported with this QEMU binary"));
+        return -1;
+    }
 
     switch ((virDomainFSDriverType) fs->fsdriver) {
     case VIR_DOMAIN_FS_DRIVER_TYPE_DEFAULT:
@@ -8581,6 +8588,11 @@ qemuDomainDeviceDefValidateFS(virDomainFSDefPtr fs,
                            _("virtiofs is not supported with this QEMU binary"));
             return -1;
         }
+        if (fs->multidevs != VIR_DOMAIN_FS_MULTIDEVS_DEFAULT) {
+            virReportError(VIR_ERR_CONFIG_UNSUPPORTED, "%s",
+                           _("virtiofs does not support multidevs"));
+            return -1;
+        }
         if (qemuDomainDefValidateVirtioFSSharedMemory(def) < 0)
             return -1;
         break;
-- 
2.20.1


