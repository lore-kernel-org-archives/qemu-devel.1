Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B53C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5916A2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+dzKW4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5916A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6sd-0006zx-EN
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6r5-0005aw-Lb
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6r4-0008Rf-1T
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3444O34SL/GwayCaA1FJTGfw9tPsEHVptGLpqLLVps=;
 b=O+dzKW4nf6KJLcp2jVn4/jC1SgYCqiJkJZ2ZtndHNPSDit1mCy0z5KOFJ+sGfHPjtGcizL
 FoRZlA9H12hQtBVBS97Z/DgR/JycRbYll17Ol5B9p0qpJgzlg2qqMddrAoPJqr2PeuU5Ti
 ERHqFOycIw2jZyLM35QoeQ7xCPC5eSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-FKw6ZQ1NP_WSPXdmjtvlGA-1; Tue, 19 May 2020 14:20:35 -0400
X-MC-Unique: FKw6ZQ1NP_WSPXdmjtvlGA-1
Received: by mail-wm1-f69.google.com with SMTP id m11so22600wml.5
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V3444O34SL/GwayCaA1FJTGfw9tPsEHVptGLpqLLVps=;
 b=S0pAzznZGvN0xKeBiA0/vQbauBxnTQ90h+hGsmt1dfmVcos6eVni5/aLaACJ+Rwg7Z
 L0YvxOG7CXfWRpRRfA4LwCLM1wUdo/ny2iVQjFXpOQZmHgXnOll2nlKouU24uZyVV7lx
 f4ba17Any8G2HlCShLPhDdYch4G5aK07Cf9oXjGU/gcjbiw/5Ta3mMYwml+QSYNdP8u2
 KvlVCXlUBaRG+HBEPfireNGqPftJD1EdDuLo3F+KMpET6/EFrl88u29TAIZmguc01keo
 VtKCVnIFQByGSirTpz/YXMtM9dJ3NBgvOi1Nggch4QTjplR+qtGaA4PVXdm0bNKW1n70
 HfXw==
X-Gm-Message-State: AOAM533hEQ9DkKSUyE4x9n0daV2ibKC2osdFfVazeDPG8yrwA5e5eAyk
 1hAhKAqDC1Ne9kvlO3PKYUnLQnsKWXGCi9iHtEXx/MoxWsCYEMENr2SDqmY70sPW6J7MmE0d3YB
 kkhclYUJAQ1JG5co=
X-Received: by 2002:adf:efd0:: with SMTP id i16mr154514wrp.315.1589912434373; 
 Tue, 19 May 2020 11:20:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzxFMNmnAohAJwiFmq5+zzYKMsSmligrMlyzGfPA7mYZcROJQarYLcSeIko27B4R2I8P5saA==
X-Received: by 2002:adf:efd0:: with SMTP id i16mr154423wrp.315.1589912433184; 
 Tue, 19 May 2020 11:20:33 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x17sm228372wrp.71.2020.05.19.11.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:20:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
Date: Tue, 19 May 2020 20:20:20 +0200
Message-Id: <20200519182024.14638-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200519182024.14638-1-philmd@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FW_CFG_DATA_GENERATOR allow any object to product
blob of data consumable by the fw_cfg device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 49 +++++++++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c         | 30 ++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 25d9307018..74b4790fae 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -9,11 +9,40 @@
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
@@ -263,6 +292,26 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
 void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
                          size_t len);
 
+/**
+ * fw_cfg_add_from_generator:
+ * @s: fw_cfg device being modified
+ * @filename: name of new fw_cfg file item
+ * @generator_id: name of object implementing FW_CFG_DATA_GENERATOR interface
+ * @errp: pointer to a NULL initialized error object
+ *
+ * Add a new NAMED fw_cfg item with the content generated from the
+ * @generator_id object. The data referenced by the starting pointer is copied
+ * into the data structure of the fw_cfg device.
+ * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
+ * will be used; also, a new entry will be added to the file directory
+ * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
+ * data size, and assigned selector key value.
+ *
+ * Returns: the size of the generated item data on success, -1 otherwise.
+ */
+ssize_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                                  const char *generator_id, Error **errp);
+
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_io(uint32_t iobase);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8dd50c2c72..e18cb074df 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1032,6 +1032,30 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
+ssize_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                                  const char *generator_id, Error **errp)
+{
+    FWCfgDataGeneratorClass *k;
+    Object *o;
+    size_t sz;
+
+    o = object_resolve_path_component(object_get_objects_root(), generator_id);
+    if (!o) {
+        error_setg(errp, "Cannot find object ID %s", generator_id);
+        return -1;
+    }
+    if (!object_dynamic_cast(o, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
+        error_setg(errp, "Object '%s' is not a fw_cfg-data-generator subclass",
+                         generator_id);
+        return -1;
+    }
+    k = FW_CFG_DATA_GENERATOR_GET_CLASS(o);
+    sz = k->get_length(o);
+    fw_cfg_add_file(s, filename, g_memdup(k->get_data(o), sz), sz);
+
+    return sz;
+}
+
 static void fw_cfg_machine_reset(void *opaque)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
@@ -1333,12 +1357,18 @@ static const TypeInfo fw_cfg_mem_info = {
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


