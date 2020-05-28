Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465CCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16136207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs1Cw86y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16136207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMOo-00034j-5Q
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNp-0001l9-N7
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:31:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeMNo-0006a0-PQ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590687115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNWcMMGvcPsGIqzvnJg0g/df4+AMY8fbfR6SYbmn6mQ=;
 b=hs1Cw86y/TC3Vuv7QJCyeoG1IxIpevXkacLLEasNJOXzGT9OJ0RpRQ8OQkFaYPN4SSuZNd
 GIop8i6hm0xHgb/p0UnBtpLjBccKjK8o0cNh3B76hJMJfKLUXyMZQM/LtcWHv8Nyol1a9M
 +rFpSuJf/gRpEplvqfEu+T2FTKZdglo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-j3Sab-S_PbqY20_qhVCLRQ-1; Thu, 28 May 2020 13:31:54 -0400
X-MC-Unique: j3Sab-S_PbqY20_qhVCLRQ-1
Received: by mail-wr1-f72.google.com with SMTP id w4so7203577wrl.13
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pNWcMMGvcPsGIqzvnJg0g/df4+AMY8fbfR6SYbmn6mQ=;
 b=Q7Puw/RYO0FakxJ/8lJSLXMX5O7Lk3xTgUFIleyothuHk99AoqE9BGNgPSCCXl058e
 78J1kCpFBoaSiDalrHPgEGnx2wQRCwXJV6Kd0sZWygOle8e+E7M0zXRY8dwkEaxwqnDS
 BbTf8GldzatFqMOtxaEo83DxdrID+iSnUhR3uSIU0kXWnwyKxKrfP00MHvrKBl8zSf30
 tTTz9KnwT04mRzlQiNvDU0bGQCQPfx5B643KDEPqCnY/vNdAUigoDk5frV3NF0FgONjS
 rBAvsGiugR1Ee6C/gw9PDnkQEMFb0SqG+cGrseP8rnXLPMekrz66/dFigtSELKotzwCp
 eMRg==
X-Gm-Message-State: AOAM531zJL77WrhJI4LosxVkQU4bnAmH+wbM54I1nlCVeWYvceG5xoEL
 sGD2jtVblkDqSthdVvzrtOPtsyBomMItg8M/WwXM6pUmR/OoHmg/IAGu8P2a4nG3LgOqVqr+kGX
 5E4GcXCjb+Jv3dI8=
X-Received: by 2002:a05:6000:1292:: with SMTP id
 f18mr4606425wrx.208.1590687112989; 
 Thu, 28 May 2020 10:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO2PL3PDOqvmlVAOsQOD8a0pCjdbrwzn8ZaEdr/CRUizS2/QXcJqOpuhKQ3iQYfr4QOivhGA==
X-Received: by 2002:a05:6000:1292:: with SMTP id
 f18mr4606412wrx.208.1590687112757; 
 Thu, 28 May 2020 10:31:52 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h7sm7784915wml.24.2020.05.28.10.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 10:31:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
Date: Thu, 28 May 2020 19:31:38 +0200
Message-Id: <20200528173141.17495-3-philmd@redhat.com>
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

The 'gen_id' argument refers to a QOM object able to produce
data consumable by the fw_cfg device. The producer object must
implement the FW_CFG_DATA_GENERATOR interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v7:
- renamed 'blob_id' -> 'gen_id' (danpb)
- update comment in code (lersek)
- fixed CODING_STYLE (lersek)
- use Laszlo's if (SUM(options)) != 1 { error } form
---
 softmmu/vl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index ae5451bc23..cdb1d187ed 100644
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
+          nonempty_str(file) + nonempty_str(str) + nonempty_str(gen_id) != 1) {
+        error_setg(errp, "name, plus exactly one of file,"
+                         " string and gen_id, are needed");
         return -1;
     }
     if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
@@ -2052,6 +2056,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     if (nonempty_str(str)) {
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
+    } else if (nonempty_str(gen_id)) {
+        return fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
     } else {
         GError *err = NULL;
         if (!g_file_get_contents(file, &buf, &size, &err)) {
-- 
2.21.3


