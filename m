Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A71C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826FD20774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8lLRtuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826FD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii1J-0005Sl-Km
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihiv-00037W-LW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihit-0008Ok-0l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7KKw2pGhHpcq2vaHVr3DbY7ovZEHCjbON0vPfb4Nxw=;
 b=G8lLRtuKZpr0c3kWJ98daHiYJ4mhONimtZsAjHOzIRDp/bRMK8o5F/NYRBviuzSUOScKFw
 O8CAmbEIdGj/on6Anb36D1cvc/khwZ3KzyP4rcv90Gqj6mKq48WFDzwceeGRzqMku8/9/U
 5qfCAv51oGk5KmH2wlYh6ZONoAsQmUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-hx4txmz1MNaKYB2JfkzK9Q-1; Tue, 09 Jun 2020 13:07:36 -0400
X-MC-Unique: hx4txmz1MNaKYB2JfkzK9Q-1
Received: by mail-wr1-f70.google.com with SMTP id d6so8843975wrn.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g7KKw2pGhHpcq2vaHVr3DbY7ovZEHCjbON0vPfb4Nxw=;
 b=TyKdtoHk8axNqKu+Hl+8m6UFM78IxgQVIHcdThzWm5mThAS7g+8O48JORkKB0mPsVd
 IPAqvJJQnciwzvehjrdw8siweQx+DdiKEQopLjMuWY8dr4fTkb70Kl5czHo29LuxNXA9
 JLOBEtv5khVdZRrNSAJL9rStlXJgnsV4ura1Ulc6Iza2lnMnpQd1t8+HKmUG15Ac03Yu
 6Y8DUvCy2mAhe4KmSFUiJulgl1dianCtbYFRu4p/B5OLlklQqATvvZ5H1AHESPgc8hXB
 T+AvssgFjmJdGhCowkUhf20tH4zdf8p2rn2JGA3m4ZZ5+UAoIWwkRa58XS4VpeaCnirX
 Nz6A==
X-Gm-Message-State: AOAM533AXk2bO0/KbsoRJ5rgLDuIO30yrVFu+EVCici+hipLda8BLzZT
 1QghZTwNakBChIsxxmearb8XMpG5/hAMuMVBtXcIwvpj9gfDp89snv3c1vXT0/N+fPtjhIP3ar9
 /dXyXJ8nwIlxB5nM=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr5356579wmg.52.1591722454835; 
 Tue, 09 Jun 2020 10:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDIYBs6UyjJOoNb85q8sSQXAJRD1JwKK3k7wtY8Uj2xGTQ/S39+x0kg9ede9RWNRgFfg/iZQ==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr5356549wmg.52.1591722454487; 
 Tue, 09 Jun 2020 10:07:34 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f11sm4164505wrj.2.2020.06.09.10.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:07:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v8 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
Date: Tue,  9 Jun 2020 19:07:23 +0200
Message-Id: <20200609170727.9977-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609170727.9977-1-philmd@redhat.com>
References: <20200609170727.9977-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FW_CFG_DATA_GENERATOR allows any object to produce
blob of data consumable by the fw_cfg device.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v8: addressed Laszlo's comments
- fixed copy/paste typos
- corrected fmt arguments order
- do not call fw_cfg_add_file() if get_length() returned 0
---
 docs/specs/fw_cfg.txt     |  9 ++++++-
 include/hw/nvram/fw_cfg.h | 52 +++++++++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c         | 36 +++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

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
index 25d9307018..ca69666847 100644
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
+ * @gen_id object. The data generated by the @gen_id object is copied
+ * into the data structure of the fw_cfg device.
+ * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
+ * will be used; also, a new entry will be added to the file directory
+ * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
+ * data size, and assigned selector key value.
+ *
+ * Returns: the size of the generated item data on success, or 0 on errors.
+ */
+size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+                                 const char *gen_id, Error **errp);
+
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_io(uint32_t iobase);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8dd50c2c72..84578e83aa 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1032,6 +1032,36 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
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
+        error_setg(errp, "Cannot find object ID '%s'", gen_id);
+        return 0;
+    }
+    if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
+        error_setg(errp, "Object ID '%s' is not a '%s' subclass",
+                   gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
+        return 0;
+    }
+    klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
+    size = klass->get_length(obj);
+    if (size == 0) {
+        error_setg(errp, "Object ID '%s' failed to generate fw_cfg data",
+                   gen_id);
+        return 0;
+    }
+    fw_cfg_add_file(s, filename, g_memdup(klass->get_data(obj), (guint)size),
+                    size);
+
+    return size;
+}
+
 static void fw_cfg_machine_reset(void *opaque)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
@@ -1333,12 +1363,18 @@ static const TypeInfo fw_cfg_mem_info = {
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


