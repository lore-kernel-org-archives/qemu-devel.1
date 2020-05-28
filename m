Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A7AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EFA2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fywnfw4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EFA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMOo-00035c-7J
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNo-0001k6-Cq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:31:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNn-0006ZN-5D
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590687111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kU2svaZnrFOGWDjc7Q+D6Mn9iKCVlh3hTcGdEw3fjr0=;
 b=fywnfw4wRYtz8A5jSno24mtRWWA7c5T43n+aDLK8BBfWkTRS0FsVRcpBNgI+fAE8CSB4nj
 wLQtqOVsgELhKOPkFhSYSZtnCHcsEx7s3g4zI5W1gqWaUIwmTjhyuWW/eL5eQk21JfrUka
 qsURc88AIrgZTeNhQkOLKvgzYLsaFsw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-JP-h2zBXPP6MA_jiWFArWQ-1; Thu, 28 May 2020 13:31:49 -0400
X-MC-Unique: JP-h2zBXPP6MA_jiWFArWQ-1
Received: by mail-wr1-f70.google.com with SMTP id e1so10389807wrm.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kU2svaZnrFOGWDjc7Q+D6Mn9iKCVlh3hTcGdEw3fjr0=;
 b=kHAADedlIxNxmOTdaM8bu6h9BvSE1glJW5PlPXo8sKVpx7uP1tgWnO1SeLA0SJf0F1
 3M8tI45IhmxLVdAUVjY/f2RVUqIVF1mbjPM8BXyTsHdi3yw+EboIdCmZeDdQYboS1G/H
 NbcI1XbymTe4Sn8hQoUmFwHQlJJxelpnoc07PjgwJ8wNH7goWIL8ErqUpzcjT5LwLfeR
 wt5Q//xnTHb8qN0vBdvVYU+RZQbMerXxTjHbXtHe/8VAIvqiMd/iI761VwvfGwH8sFvI
 fehJ70HflvUhS/pTIxP3dgiWiIyFZxvq6NPtDsJXPPl8NQul5ByyPnEPECBWhA5rZUci
 CBGg==
X-Gm-Message-State: AOAM532IjsvUA9n3fqCJuUZcXGxDnHOxrdIj9sfRQpvypOjZlRKYukII
 +i+/+RqxKNy4H9az3PVwqLyX+vN/kLWUuPI93qWCzorrGhbBY9VhUp/rNnDOsXi09uofUIrXCpg
 h1wU/H0CQfuld4Ko=
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr4393453wmf.100.1590687108468; 
 Thu, 28 May 2020 10:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzki1XaUYQYFBsTVxwEg48tCV2CFYEOyjBLGLVimwR1QQjXzmjdDGWM98ePxq7AkxCPi/NgpQ==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr4393431wmf.100.1590687108141; 
 Thu, 28 May 2020 10:31:48 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u4sm7321052wmb.48.2020.05.28.10.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:31:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
Date: Thu, 28 May 2020 19:31:37 +0200
Message-Id: <20200528173141.17495-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528173141.17495-1-philmd@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FW_CFG_DATA_GENERATOR allows any object to produce
blob of data consumable by the fw_cfg device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v7: addressed Laszlo's comments
- fixed typos in description
- return size_t instead of ssize_t; 0 for error
- do not use 1-letter variable names
- do not open-code 'fw_cfg-data-generator'
- cast g_memdup() size argument as 'guint'
- improved documentation
---
 docs/specs/fw_cfg.txt     |  9 ++++++-
 include/hw/nvram/fw_cfg.h | 52 +++++++++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c         | 31 +++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index 8f1ebc66fa..bc16daa38a 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -219,7 +219,7 @@ To check the result, read the "control" field:
 
 = Externally Provided Items =
 
-As of v2.4, "file" fw_cfg items (i.e., items with selector keys above
+Since v2.4, "file" fw_cfg items (i.e., items with selector keys above
 FW_CFG_FILE_FIRST, and with a corresponding entry in the fw_cfg file
 directory structure) may be inserted via the QEMU command line, using
 the following syntax:
@@ -230,6 +230,13 @@ Or
 
     -fw_cfg [name=]<item_name>,string=<string>
 
+Since v5.1, QEMU allows some objects to generate fw_cfg-specific content,
+the content is then associated with a "file" item using the 'gen_id' option
+in the command line, using the following syntax:
+
+    -object <generator-type>,id=<generated_id>,[generator-specific-options] \
+    -fw_cfg [name=]<item_name>,gen_id=<generated_id>
+
 See QEMU man page for more documentation.
 
 Using item_name with plain ASCII characters only is recommended.
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 25d9307018..8fbf2446c1 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -9,11 +9,43 @@
 #define TYPE_FW_CFG     "fw_cfg"
 #define TYPE_FW_CFG_IO  "fw_cfg_io"
 #define TYPE_FW_CFG_MEM "fw_cfg_mem"
+#define TYPE_FW_CFG_DATA_GENERATOR_INTERFACE "fw_cfg-data-generator"
 
 #define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
 #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
 #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
 
+#define FW_CFG_DATA_GENERATOR_CLASS(class) \
+    OBJECT_CLASS_CHECK(FWCfgDataGeneratorClass, (class), \
+                       TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
+#define FW_CFG_DATA_GENERATOR_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FWCfgDataGeneratorClass, (obj), \
+                     TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
+
+typedef struct FWCfgDataGeneratorClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+    /*< public >*/
+
+    /**
+     * get_data:
+     * @obj: the object implementing this interface
+     *
+     * Returns: pointer to start of the generated item data
+     *
+     * The returned pointer is a QObject weak reference, @obj owns
+     * the reference and may free it at any time in the future.
+     */
+    const void *(*get_data)(Object *obj);
+    /**
+     * get_length:
+     * @obj: the object implementing this interface
+     *
+     * Returns: the size of the generated item data in bytes
+     */
+    size_t (*get_length)(Object *obj);
+} FWCfgDataGeneratorClass;
+
 typedef struct fw_cfg_file FWCfgFile;
 
 #define FW_CFG_ORDER_OVERRIDE_VGA    70
@@ -263,6 +295,26 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
 void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
                          size_t len);
 
+/**
+ * fw_cfg_add_from_generator:
+ * @s: fw_cfg device being modified
+ * @filename: name of new fw_cfg file item
+ * @gen_id: name of object implementing FW_CFG_DATA_GENERATOR interface
+ * @errp: pointer to a NULL initialized error object
+ *
+ * Add a new NAMED fw_cfg item with the content generated from the
+ * @gen_id object. The data generated by the @gen_id object/ is copied
+ * into the data structure of the fw_cfg device.
+ * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
+ * will be used; also, a new entry will be added to the file directory
+ * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
+ * data size, and assigned selector key value.
+ *
+ * Returns: the size of the device tree image on success, or 0 on errors.
+ */
+size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                                 const char *gen_id, Error **errp);
+
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_io(uint32_t iobase);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8dd50c2c72..6d2fa13042 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1032,6 +1032,31 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
+size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                                 const char *gen_id, Error **errp)
+{
+    FWCfgDataGeneratorClass *klass;
+    Object *obj;
+    size_t size;
+
+    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
+    if (!obj) {
+        error_setg(errp, "Cannot find object ID %s", gen_id);
+        return 0;
+    }
+    if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
+        error_setg(errp, "Object '%s' is not a '%s' subclass",
+                   TYPE_FW_CFG_DATA_GENERATOR_INTERFACE, gen_id);
+        return 0;
+    }
+    klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
+    size = klass->get_length(obj);
+    fw_cfg_add_file(s, filename, g_memdup(klass->get_data(obj), (guint)size),
+                    size);
+
+    return size;
+}
+
 static void fw_cfg_machine_reset(void *opaque)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
@@ -1333,12 +1358,18 @@ static const TypeInfo fw_cfg_mem_info = {
     .class_init    = fw_cfg_mem_class_init,
 };
 
+static const TypeInfo fw_cfg_data_generator_interface_info = {
+    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(FWCfgDataGeneratorClass),
+};
 
 static void fw_cfg_register_types(void)
 {
     type_register_static(&fw_cfg_info);
     type_register_static(&fw_cfg_io_info);
     type_register_static(&fw_cfg_mem_info);
+    type_register_static(&fw_cfg_data_generator_interface_info);
 }
 
 type_init(fw_cfg_register_types)
-- 
2.21.3


