Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53701C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F77E206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymy6n6Sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F77E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmit-0006Zo-6h
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmi0-0005UU-2o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29201
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmhy-0003fS-4g
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592933261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ta8fofB145HRjeBtGSzkFXoaX65FKHWgqbBS1sayKBY=;
 b=Ymy6n6SjKe9o39pNB8vmyKqZeS8xBeWD94lOyg9hXC9tsx5PSb8J1xa1Y5kD8rH28wv9Hh
 umfVTMxLyiVTxf6BJnfV03aMfvXQTBkWPYHJ9ZVly+EcH7Vnx/tYHcj+uP6bX4HyCXn6Xw
 njYOdpVfrk6Ilbs6R6VglnlBvvL7Wtg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-5N5sT3TMNLacBn_rSA-BeA-1; Tue, 23 Jun 2020 13:27:39 -0400
X-MC-Unique: 5N5sT3TMNLacBn_rSA-BeA-1
Received: by mail-wr1-f69.google.com with SMTP id b14so16082132wrp.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ta8fofB145HRjeBtGSzkFXoaX65FKHWgqbBS1sayKBY=;
 b=r5v883vQxLBPwoZsEtqJGyOrG7KWa9tlK9B7+ZiArBkbJBWU76rXeUUWDxYWn2us+T
 KoXhUZqRC8xhpOw846ax4c+HTkgLKiNYQVrX8yAKvfn7MfDkMxast26+t00pU4Sfu51y
 cGOzrGEKKO86uKqdzgcgALQ/dRdO5XAmODl2npm4pU30oT7noKqnFh/MqiW7W21pLKRr
 igWdshjOyiw1JVSrFG/pD3ZQtrWw+ZHtX9LQPZxQFFTsMt4dyPxPuaQ9oL/L3/iU9xoV
 TYfTnK+vCG6CdGTkXosClaiPn9JqX9p80moMUm2Wdt/jEusAm8L+gYdZZ/pmcL9njMb8
 p80A==
X-Gm-Message-State: AOAM532pn8FLrcOguHmMFtSnCZ9A5A0lU9NM5VZ6aX9lmeOcMN3hEutW
 syT+0XV6d3THvnEQMmQp80dwOpF8U+QP2mS4HARTrjjfGLkHbzohLYLdwPba9z5KX02c936vcA/
 w7rgStK7iO20HAkM=
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr15034643wrt.293.1592933257745; 
 Tue, 23 Jun 2020 10:27:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKVtzcje9Rl+nWeaIqgypC+gP91BnSfn6lyOE8wHED7ZK5aMEBo+K9/2v65CiLwoQMupfuUw==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr15034618wrt.293.1592933257496; 
 Tue, 23 Jun 2020 10:27:37 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v66sm4819101wme.13.2020.06.23.10.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:27:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 2/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
Date: Tue, 23 Jun 2020 19:27:23 +0200
Message-Id: <20200623172726.21040-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623172726.21040-1-philmd@redhat.com>
References: <20200623172726.21040-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FW_CFG_DATA_GENERATOR allows any object to produce
blob of data consumable by the fw_cfg device.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/specs/fw_cfg.txt     |  9 +++++++-
 include/hw/nvram/fw_cfg.h | 43 +++++++++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c         | 35 +++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)

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
index 25d9307018..11feae3177 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -9,11 +9,36 @@
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
+     * @errp: pointer to a NULL-initialized error object
+     *
+     * Returns: reference to a byte array containing the data.
+     * The caller should release the reference when no longer
+     * required.
+     */
+    GByteArray *(*get_data)(Object *obj, Error **errp);
+} FWCfgDataGeneratorClass;
+
 typedef struct fw_cfg_file FWCfgFile;
 
 #define FW_CFG_ORDER_OVERRIDE_VGA    70
@@ -263,6 +288,24 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
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
+ * @gen_id object. The data generated by the @gen_id object is copied
+ * into the data structure of the fw_cfg device.
+ * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
+ * will be used; also, a new entry will be added to the file directory
+ * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
+ * data size, and assigned selector key value.
+ */
+void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                               const char *gen_id, Error **errp);
+
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_io(uint32_t iobase);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0408a31f8e..694722b212 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1032,6 +1032,35 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
+void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                               const char *gen_id, Error **errp)
+{
+    FWCfgDataGeneratorClass *klass;
+    Error *local_err = NULL;
+    GByteArray *array;
+    Object *obj;
+    gsize size;
+
+    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
+    if (!obj) {
+        error_setg(errp, "Cannot find object ID '%s'", gen_id);
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
+        error_setg(errp, "Object ID '%s' is not a '%s' subclass",
+                   gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
+        return;
+    }
+    klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
+    array = klass->get_data(obj, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    size = array->len;
+    fw_cfg_add_file(s, filename, g_byte_array_free(array, TRUE), size);
+}
+
 static void fw_cfg_machine_reset(void *opaque)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
@@ -1333,12 +1362,18 @@ static const TypeInfo fw_cfg_mem_info = {
     .class_init    = fw_cfg_mem_class_init,
 };
 
+static const TypeInfo fw_cfg_data_generator_interface_info = {
+    .parent = TYPE_INTERFACE,
+    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
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


