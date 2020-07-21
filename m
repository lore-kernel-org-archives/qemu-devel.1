Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0369EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C401E2065D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2INHMld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C401E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsBw-00023j-1N
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxsB8-0000qE-QU
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:19:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxsB6-0002Yv-UF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595337568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slnBaHZH7RjZQ9zu7SmPTVcYqTCxR+5a/lczq5nqiSU=;
 b=I2INHMldr2CRtyW8mAm1AU94aEGX/PdX0GwkmEJ9Q9hTWTX5da5J9ipykz2YG3hp8M9U2T
 +bxi95SzAVeyyTGTheIyXxlSl/6gkMGaYGEyUrMQQiaYZYqt5y1qmzvSoXcTouW9yRjY8I
 nXqFpSxBDVXk3e+iQpynp+5+rZVMdW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-1y1GD8KkOJqhXZxkfQwwpg-1; Tue, 21 Jul 2020 09:19:26 -0400
X-MC-Unique: 1y1GD8KkOJqhXZxkfQwwpg-1
Received: by mail-wm1-f71.google.com with SMTP id f74so1042846wmf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=slnBaHZH7RjZQ9zu7SmPTVcYqTCxR+5a/lczq5nqiSU=;
 b=ah7SM3jE/wNY858lkWiJu+cjQLru6zR7u/WW3o48KziaEB7F5TRh01nBOLWJXPInnJ
 Ga1qAB+zR7OiYmSMHxqtVJsX/Fk4Aq5y+Ia182gJwE++obFOBbLaDea4xJGvZaqUhGP4
 odwxQ+4XywUAF9+tr5jdcy+JyXp907uRthy4Vr/Wf5H69TGIUSj/Eu/eUIsxCZo5RbZx
 XJa6IQiWdAUmdH0bSnqC8aqTou1KaYldtVya75e+Nb6LPGpq+0oRBcfK0ypnOlr2UCgN
 BCkA4n7rAEg5RKkScmTLlvoVGmCPtkVo6AtHL75K3vI/bF4vJgkbiqDSq0T28bsamt8b
 J+JQ==
X-Gm-Message-State: AOAM533ZHCGoZNnkQetXaBkl0H6LNxZ+3yBcbekywhfpzQ2+vDANYJ7O
 HOZOMF6aAZ20ywIksEC5TOdTs9xaPiUxUtMw/UordXL4GSja0vUujS/J1YXHI9dQEkDjF2FSDAT
 G+FzmrVEpmbCU4rg=
X-Received: by 2002:a5d:440e:: with SMTP id z14mr8705181wrq.422.1595337564326; 
 Tue, 21 Jul 2020 06:19:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQzANuNahHEu5xiRJbMHfrkEr7i1X4IB7M5AB1xYuJS/AfjqXVsFYE7isbe9GJXzVeM6Cf8A==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr8705159wrq.422.1595337564129; 
 Tue, 21 Jul 2020 06:19:24 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x9sm3417164wmk.45.2020.07.21.06.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 06:19:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/nvram/fw_cfg: Let fw_cfg_add_from_generator()
 return boolean value
Date: Tue, 21 Jul 2020 15:19:11 +0200
Message-Id: <20200721131911.27380-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200721131911.27380-1-philmd@redhat.com>
References: <20200721131911.27380-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
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

It's the call of fw_cfg_add_from_generator():

        Error *local_err = NULL;

        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
        if (local_err) {
            error_propagate(errp, local_err);
            return -1;
        }
        return 0;

If it fails, parse_fw_cfg() sets an error and returns 0, which is
wrong. Harmless, because the only caller passes &error_fatal.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: Coverity CID 1430396: 'Constant' variable guards dead code (DEADCODE)
Fixes: 6552d87c48 ("softmmu/vl: Let -fw_cfg option take a 'gen_id' argument")
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Added impact assessment (Markus)
---
 include/hw/nvram/fw_cfg.h |  4 +++-
 hw/nvram/fw_cfg.c         | 10 ++++++----
 softmmu/vl.c              |  6 +-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index bbcf405649..f190c428e8 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -304,8 +304,10 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
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
index dfa1f2012a..f3a4728288 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1032,7 +1032,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
-void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
+bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
                                const char *gen_id, Error **errp)
 {
     FWCfgDataGeneratorClass *klass;
@@ -1043,20 +1043,22 @@ void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
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
     if (!array) {
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


