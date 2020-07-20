Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BED6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E882070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMc7dzMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E882070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxV1n-00059S-KF
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxV12-0004YG-3T
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:35:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30120
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxV0y-0004L2-Vc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595248527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q/uhV1U5q10/8WUWYa5p5ciKHqrkEZEYzCIG0nzeD5A=;
 b=cMc7dzMDrD8Uamz2viARky2lTAl3VunVMRnr76iy0fYwjcfsZoMdBoOKTNn6MFbP6zEjuj
 3JRlA+3IQ7g5og3+PYvAbOu6mdALEnCgLNjMPc7iQjfAwSWVPy+HYn83OWKt8PF/5WWGHb
 a17IiE0kBWXdzeG+LYQ7IWQV8LVljOI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-FLe4qvYuOP-aBYCIxltH6w-1; Mon, 20 Jul 2020 08:35:26 -0400
X-MC-Unique: FLe4qvYuOP-aBYCIxltH6w-1
Received: by mail-wr1-f69.google.com with SMTP id j16so12100486wrw.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q/uhV1U5q10/8WUWYa5p5ciKHqrkEZEYzCIG0nzeD5A=;
 b=uTZlrUzJ7GQjKAuWaGOdIqv0EAy2KH+WPRt+dcU3JJQE+a6JG3+DItkv+syd85vUf3
 LxCDP4o7CkTXTl8fy2z31ih/SFTMd6VNwUUjepfD9F5cfA2/jFUx+G6vN7LA30RFcXKP
 3UYOWsVczZ2+2/hllulgfWJSW9/8iZyh/Nsnvy3n/+1WCUoAwOWQpwr/EPTmFQneDRcP
 bSaKv3UNuRpc+l5yOdbNq6lB6RkNnkUwAlgh0+lAIVTgcicXW2mDO4dD6NtbPZokyBEv
 FsaPXCCvlToOxUeHs8gjpPERHJhjB76Zv1Rs0215s7zc97YZ/5kUhegP7rqyrTw0sLIo
 UK4A==
X-Gm-Message-State: AOAM532Jt+v2P6gXDUFDMEmO9J2CKGtI9xEh/wn/48QqqK0VW/9t/Yg6
 dIadkqrte2Ch4JIeG5+AvFTFspWHU1ScyW2OtE5xa4Uf3B9g5w6XaxaDXnHP/BqWtQncjO3MC34
 xuVQWSrBvdK0nLXw=
X-Received: by 2002:a5d:420b:: with SMTP id n11mr21866548wrq.91.1595248524339; 
 Mon, 20 Jul 2020 05:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcCuRbtZGREE6l53fO4mel3G4he9151rB2DO02N0MpoX2lWgCw/3PDWvnLVmflJUgwUuVLQA==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr21866526wrq.91.1595248524112; 
 Mon, 20 Jul 2020 05:35:24 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m4sm31503282wmi.48.2020.07.20.05.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:35:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] hw/nvram/fw_cfg: Let fw_cfg_add_from_generator()
 return boolean value
Date: Mon, 20 Jul 2020 14:35:21 +0200
Message-Id: <20200720123521.8135-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commits b6d7e9b66f..a43770df5d simplified the error propagation.
Similarly to commit 6fd5bef10b "qom: Make functions taking Error**
return bool, not void", let fw_cfg_add_from_generator() return a
boolean value, not void.
This allow to simplify parse_fw_cfg() and fixes the error handling
issue reported by Coverity (CID 1430396):

  In parse_fw_cfg():

    Variable assigned once to a constant guards dead code.

    Local variable local_err is assigned only once, to a constant
    value, making it effectively constant throughout its scope.
    If this is not the intent, examine the logic to see if there
    is a missing assignment that would make local_err not remain
    constant.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: Coverity CID 1430396: 'Constant' variable guards dead code (DEADCODE)
Fixes: 6552d87c48 ("softmmu/vl: Let -fw_cfg option take a 'gen_id' argument")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/nvram/fw_cfg.h |  4 +++-
 hw/nvram/fw_cfg.c         | 10 ++++++----
 softmmu/vl.c              |  6 +-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 11feae3177..d90857f092 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -302,8 +302,10 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  * will be used; also, a new entry will be added to the file directory
  * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
  * data size, and assigned selector key value.
+ *
+ * Returns: %true on success, %false on error.
  */
-void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
                                const char *gen_id, Error **errp);
 
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3b1811d3bf..c88aec4341 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1032,7 +1032,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
-void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
                                const char *gen_id, Error **errp)
 {
     ERRP_GUARD();
@@ -1044,20 +1044,22 @@ void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
     obj = object_resolve_path_component(object_get_objects_root(), gen_id);
     if (!obj) {
         error_setg(errp, "Cannot find object ID '%s'", gen_id);
-        return;
+        return false;
     }
     if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
         error_setg(errp, "Object ID '%s' is not a '%s' subclass",
                    gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
-        return;
+        return false;
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
     array = klass->get_data(obj, errp);
     if (*errp) {
-        return;
+        return false;
     }
     size = array->len;
     fw_cfg_add_file(s, filename, g_byte_array_free(array, TRUE), size);
+
+    return true;
 }
 
 static void fw_cfg_machine_reset(void *opaque)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f476ef89ed..3416241557 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2070,11 +2070,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else if (nonempty_str(gen_id)) {
-        Error *local_err = NULL;
-
-        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp)) {
             return -1;
         }
         return 0;
-- 
2.21.3


