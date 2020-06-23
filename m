Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FC5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40800206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoRZTxUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40800206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmkq-0001B6-DQ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmi3-0005Zb-Pr
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmi1-0003hB-PD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592933265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZXsJGMtxQbTmLRduHZwl5Kzulm7zv7lmzMMcaa1r5Q=;
 b=aoRZTxUWNqt58TRqHIWFNKKVS+EvuzlZ6UFmPnAmYEkblENUvndjGVxO1O+WZCBM1oIvl5
 Okaww2gzcstZRfM2MvD9ugi/nS7WnizTsAge0OKgouCtMuBSZXNx6adCC1qM8Gu0Xt2FX+
 asQMjdSbJautc9NMdJUdVQhp7kyyrks=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-ZnsUwoogNOC0rP5rrUqcSg-1; Tue, 23 Jun 2020 13:27:43 -0400
X-MC-Unique: ZnsUwoogNOC0rP5rrUqcSg-1
Received: by mail-wr1-f71.google.com with SMTP id f5so16256269wrv.22
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DZXsJGMtxQbTmLRduHZwl5Kzulm7zv7lmzMMcaa1r5Q=;
 b=Tip4LztqJukQGROBrVHHpS1r+UE+iEYY2QCC5K9JhkGy+gon47qfUAkYshrFkG10Fi
 C6h4k3Uv526PY9WbCH5u6kXW5CYPcMryBzvIVfEAgd0UPWOdT+fQB5CnjIkOQNvy1trP
 4243d4+TGI19dm8U29sLw3GfEybjSsKQrRG7TvCavQbMQqj60Nwa4y6Jhbm0I4SPxRnl
 iU/mrySx5Srf9lDgsor1dGOHsO0CCOVmdIPsnUxjQSkCs3ZT5dtLqnt6lPrUCZ3sj/LB
 yTObmxaF6IKt7JMc/6ErgckooY89LjmwQfx92RLgcg1sj5DGS0TxGetCzziHrfAmh9Bp
 E5Xw==
X-Gm-Message-State: AOAM531M7pcIhyzDVnlo5aDeTaEqF5XckBxJzUE/JiDTT4mTepq+bYLq
 Yl+aGuJ33S2z1lvBMvC/XwWKvP+Gx36WDL2p+C6UhV1kqHIt4y279xEdFXeDTS5upyl1cm5IlQ8
 0C16b+GOMXbqHtOc=
X-Received: by 2002:a5d:5389:: with SMTP id d9mr27798814wrv.77.1592933262247; 
 Tue, 23 Jun 2020 10:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxumqHKtuQBc9o/O3WjP5jFJ1dVzNrPWibTpfNDkMg2VkgtB1MkbX/lpx+0Eu1s2viRbmFNLw==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr27798796wrv.77.1592933262045; 
 Tue, 23 Jun 2020 10:27:42 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm4478171wmi.35.2020.06.23.10.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:27:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 3/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
Date: Tue, 23 Jun 2020 19:27:24 +0200
Message-Id: <20200623172726.21040-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623172726.21040-1-philmd@redhat.com>
References: <20200623172726.21040-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'gen_id' argument refers to a QOM object able to produce
data consumable by the fw_cfg device. The producer object must
implement the FW_CFG_DATA_GENERATOR interface.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 softmmu/vl.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index f669c06ede..a587261f34 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -489,6 +489,11 @@ static QemuOptsList qemu_fw_cfg_opts = {
             .name = "string",
             .type = QEMU_OPT_STRING,
             .help = "Sets content of the blob to be inserted from a string",
+        }, {
+            .name = "gen_id",
+            .type = QEMU_OPT_STRING,
+            .help = "Sets id of the object generating the fw_cfg blob "
+                    "to be inserted",
         },
         { /* end of list */ }
     },
@@ -2020,7 +2025,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
 {
     gchar *buf;
     size_t size;
-    const char *name, *file, *str;
+    const char *name, *file, *str, *gen_id;
     FWCfgState *fw_cfg = (FWCfgState *) opaque;
 
     if (fw_cfg == NULL) {
@@ -2030,14 +2035,13 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     name = qemu_opt_get(opts, "name");
     file = qemu_opt_get(opts, "file");
     str = qemu_opt_get(opts, "string");
+    gen_id = qemu_opt_get(opts, "gen_id");
 
-    /* we need name and either a file or the content string */
-    if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)))) {
-        error_setg(errp, "invalid argument(s)");
-        return -1;
-    }
-    if (nonempty_str(file) && nonempty_str(str)) {
-        error_setg(errp, "file and string are mutually exclusive");
+    /* we need the name, and exactly one of: file, content string, gen_id */
+    if (!nonempty_str(name) ||
+        nonempty_str(file) + nonempty_str(str) + nonempty_str(gen_id) != 1) {
+        error_setg(errp, "name, plus exactly one of file,"
+                         " string and gen_id, are needed");
         return -1;
     }
     if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
@@ -2052,6 +2056,15 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     if (nonempty_str(str)) {
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
+    } else if (nonempty_str(gen_id)) {
+        Error *local_err = NULL;
+
+        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+        return 0;
     } else {
         GError *err = NULL;
         if (!g_file_get_contents(file, &buf, &size, &err)) {
-- 
2.21.3


