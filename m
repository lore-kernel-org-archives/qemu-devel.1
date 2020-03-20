Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0C6C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2364620739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cQXO7vK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2364620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLwh-0003F9-Ai
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <680df3de98cf66c7637fec5274761b535b9f4918@lizzy.crudebyte.com>)
 id 1jFLw1-0002n5-Mi
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <680df3de98cf66c7637fec5274761b535b9f4918@lizzy.crudebyte.com>)
 id 1jFLvz-0007Z2-Q8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:59:53 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:53895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <680df3de98cf66c7637fec5274761b535b9f4918@lizzy.crudebyte.com>)
 id 1jFLvz-0007FB-AW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=aSFPumI060vrsGGcam3KjHjMgS6gIvm9ZtHfi26NJs8=; b=cQXO7
 vK6ab9eDWETUGmfOuQKuFBGkqN5twrZXWMNV+DxbaaLMESY0zdXzEgJDSdV4TX1JqUJ03AyxL8EZm
 1b87zJXMqYe39W5+bpBEtBN6TJclv/ues21sEVyFMjEyJmKNFLJT9G8bTd9Nspsq8daYEzyRW5ii6
 4VQA0ywfuOtawV/jRG8vpRq9LIhJNtB+pmkbCDK6yWLoC7Ozan/uh3U8uuYfWGzE7jZuDjPk2ytzZ
 HHWN6Rgg6AByIbkaP2cEAhDuO0a9cNL9JLeY8tZFRsAHUhvRM2Rh/oTdNGPRqD/YLxLuD33hwpvGb
 PYep29VbE+46TIyeG0uZNPnstiw0w==;
Message-Id: <680df3de98cf66c7637fec5274761b535b9f4918.1584723662.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1584723662.git.qemu_oss@crudebyte.com>
References: <cover.1584723662.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 20 Mar 2020 17:51:35 +0100
Subject: [PATCH v2 3/4] conf: add 'multidevs' option
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

Introduce new 'multidevs' option for filesystem.

  <filesystem type='mount' accessmode='mapped' multidevs='remap'>
    <source dir='/path'/>
    <target dir='mount_tag'>
  </filesystem>

This option prevents misbehaviours on guest if a qemu 9pfs export
contains multiple devices, due to the potential file ID collisions
this otherwise may cause.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 docs/formatdomain.html.in     | 40 ++++++++++++++++++++++++++++++++++-
 docs/schemas/domaincommon.rng | 10 +++++++++
 src/conf/domain_conf.c        | 29 +++++++++++++++++++++++++
 src/conf/domain_conf.h        | 13 ++++++++++++
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/docs/formatdomain.html.in b/docs/formatdomain.html.in
index cc2c671c14..13c506988b 100644
--- a/docs/formatdomain.html.in
+++ b/docs/formatdomain.html.in
@@ -3967,7 +3967,7 @@
     &lt;source name='my-vm-template'/&gt;
     &lt;target dir='/'/&gt;
   &lt;/filesystem&gt;
-  &lt;filesystem type='mount' accessmode='passthrough'&gt;
+  &lt;filesystem type='mount' accessmode='passthrough' multidevs='remap'&gt;
     &lt;driver type='path' wrpolicy='immediate'/&gt;
     &lt;source dir='/export/to/guest'/&gt;
     &lt;target dir='/import/from/host'/&gt;
@@ -4092,6 +4092,44 @@
       for more details.
       </p>
 
+      <p>
+      The filesystem element has an optional attribute <code>multidevs</code>
+      which specifies how to deal with a filesystem export containing more than
+      one device, in order to avoid file ID collisions on guest when using 9pfs
+      (<span class="since">since 6.2.0, requires QEMU 4.2</span>).
+      This attribute is not available for virtiofs. The possible values are:
+      </p>
+
+        <dl>
+        <dt><code>default</code></dt>
+        <dd>
+        Use QEMU's default setting (which currently is <code>warn</code>).
+        </dd>
+        <dt><code>remap</code></dt>
+        <dd>
+        This setting allows guest to access multiple devices per export without
+        encountering misbehaviours. Inode numbers from host are automatically
+        remapped on guest to actively prevent file ID collisions if guest
+        accesses one export containing multiple devices.
+        </dd>
+        <dt><code>forbid</code></dt>
+        <dd>
+        Only allow to access one device per export by guest. Attempts to access
+        additional devices on the same export will cause the individual
+        filesystem access by guest to fail with an error and being logged (once)
+        as error on host side.
+        </dd>
+        <dt><code>warn</code></dt>
+        <dd>
+        This setting resembles the behaviour of 9pfs prior to QEMU 4.2, that is
+        no action is performed to prevent any potential file ID collisions if an
+        export contains multiple devices, with the only exception: a warning is
+        logged (once) on host side now. This setting may lead to misbehaviours
+        on guest side if more than one device is exported per export, due to the
+        potential file ID collisions this may cause on guest side in that case.
+        </dd>
+        </dl>
+
       </dd>
 
       <p>
diff --git a/docs/schemas/domaincommon.rng b/docs/schemas/domaincommon.rng
index 6805420451..9b37740e30 100644
--- a/docs/schemas/domaincommon.rng
+++ b/docs/schemas/domaincommon.rng
@@ -2676,6 +2676,16 @@
             </choice>
           </attribute>
         </optional>
+        <optional>
+          <attribute name="multidevs">
+            <choice>
+              <value>default</value>
+              <value>remap</value>
+              <value>forbid</value>
+              <value>warn</value>
+            </choice>
+          </attribute>
+        </optional>
         <optional>
           <element name='readonly'>
             <empty/>
diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
index 71535f53f5..6a9a7dd0bb 100644
--- a/src/conf/domain_conf.c
+++ b/src/conf/domain_conf.c
@@ -501,6 +501,14 @@ VIR_ENUM_IMPL(virDomainFSModel,
               "virtio-non-transitional",
 );
 
+VIR_ENUM_IMPL(virDomainFSMultidevs,
+              VIR_DOMAIN_FS_MULTIDEVS_LAST,
+              "default",
+              "remap",
+              "forbid",
+              "warn",
+);
+
 VIR_ENUM_IMPL(virDomainFSCacheMode,
               VIR_DOMAIN_FS_CACHE_MODE_LAST,
               "default",
@@ -11376,6 +11384,7 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
     g_autofree char *usage = NULL;
     g_autofree char *units = NULL;
     g_autofree char *model = NULL;
+    g_autofree char *multidevs = NULL;
 
     ctxt->node = node;
 
@@ -11414,6 +11423,17 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
         }
     }
 
+    multidevs = virXMLPropString(node, "multidevs");
+    if (multidevs) {
+        if ((def->multidevs = virDomainFSMultidevsTypeFromString(multidevs)) < 0) {
+            virReportError(VIR_ERR_CONFIG_UNSUPPORTED,
+                           _("unknown multidevs '%s'"), multidevs);
+            goto error;
+        }
+    } else {
+        def->multidevs = VIR_DOMAIN_FS_MULTIDEVS_DEFAULT;
+    }
+
     if (virDomainParseScaledValue("./space_hard_limit[1]",
                                   NULL, ctxt, &def->space_hard_limit,
                                   1, ULLONG_MAX, false) < 0)
@@ -25397,6 +25417,7 @@ virDomainFSDefFormat(virBufferPtr buf,
     const char *accessmode = virDomainFSAccessModeTypeToString(def->accessmode);
     const char *fsdriver = virDomainFSDriverTypeToString(def->fsdriver);
     const char *wrpolicy = virDomainFSWrpolicyTypeToString(def->wrpolicy);
+    const char *multidevs = virDomainFSMultidevsTypeToString(def->multidevs);
     const char *src = def->src->path;
     g_auto(virBuffer) driverAttrBuf = VIR_BUFFER_INITIALIZER;
     g_auto(virBuffer) driverBuf = VIR_BUFFER_INIT_CHILD(buf);
@@ -25415,6 +25436,12 @@ virDomainFSDefFormat(virBufferPtr buf,
         return -1;
     }
 
+    if (!multidevs) {
+        virReportError(VIR_ERR_INTERNAL_ERROR,
+                       _("unexpected multidevs %d"), def->multidevs);
+        return -1;
+    }
+
     virBufferAsprintf(buf,
                       "<filesystem type='%s' accessmode='%s'",
                       type, accessmode);
@@ -25422,6 +25449,8 @@ virDomainFSDefFormat(virBufferPtr buf,
         virBufferAsprintf(buf, " model='%s'",
                           virDomainFSModelTypeToString(def->model));
     }
+    if (def->multidevs)
+        virBufferAsprintf(buf, " multidevs='%s'", multidevs);
     virBufferAddLit(buf, ">\n");
 
     virBufferAdjustIndent(buf, 2);
diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
index 91b776c28a..23b7924781 100644
--- a/src/conf/domain_conf.h
+++ b/src/conf/domain_conf.h
@@ -796,6 +796,18 @@ typedef enum {
     VIR_DOMAIN_FS_WRPOLICY_LAST
 } virDomainFSWrpolicy;
 
+/* How to handle exports containing multiple devices. */
+typedef enum {
+    VIR_DOMAIN_FS_MULTIDEVS_DEFAULT = 0, /* Use QEMU's default setting */
+    VIR_DOMAIN_FS_MULTIDEVS_REMAP, /* Remap inodes from host to guest */
+    VIR_DOMAIN_FS_MULTIDEVS_FORBID, /* Prohibit more than one device */
+    VIR_DOMAIN_FS_MULTIDEVS_WARN, /* Just log a warning if multiple devices */
+
+    VIR_DOMAIN_FS_MULTIDEVS_LAST
+} virDomainFSMultidevs;
+
+VIR_ENUM_DECL(virDomainFSMultidevs);
+
 typedef enum {
     VIR_DOMAIN_FS_MODEL_DEFAULT = 0,
     VIR_DOMAIN_FS_MODEL_VIRTIO,
@@ -820,6 +832,7 @@ struct _virDomainFSDef {
     int wrpolicy; /* enum virDomainFSWrpolicy */
     int format; /* virStorageFileFormat */
     int model; /* virDomainFSModel */
+    int multidevs; /* virDomainFSMultidevs */
     unsigned long long usage; /* in bytes */
     virStorageSourcePtr src;
     char *dst;
-- 
2.20.1


