Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE27CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52B12075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crVINwPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52B12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6sd-00070B-V3
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6r6-0005cu-Qm
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6r5-0008Rv-VT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXKHm9sEGpzJKmFxobEwS5Bkzi/fbuyVBY253GTU/xE=;
 b=crVINwPcV+drVuE0Iqgz6jyK9qNwtce7pr+0DMxnhzXCiVzPvdYzf8lmMqsrDdPv4dPeLU
 e3CGsMOJQVyHZzrOwDJAOhxACDnIyK23K4NnXRZXcGiInuqeiJi+4SBdJ1sHGrwWXElEKu
 Z+gD0KfTf0uRLa+iDd0n+S07npVkOiw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Lqm4HskPM9mGERR6Qd2JZA-1; Tue, 19 May 2020 14:20:41 -0400
X-MC-Unique: Lqm4HskPM9mGERR6Qd2JZA-1
Received: by mail-wr1-f70.google.com with SMTP id u5so183061wrt.22
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AXKHm9sEGpzJKmFxobEwS5Bkzi/fbuyVBY253GTU/xE=;
 b=XAGAwkchuVtCkDV6b6UgpkgysmEnkmqkgoJogEN0UCqjiDJwcG9Il/dNnv2wiRcuNl
 akYA6kv1KVUcbDCWN1E3YbJNjVWVN8DJU1FKHDHEBn1AmvQpGHYwO71O6cCxdcBPUW2U
 F/G8343Jq5lo1kSaXAqF1kFjdmVUQVMDwWHMPCq8ok1fDCIZxhOBI4HCWAR/3OU4k1je
 8lplgaEGcfZC5KW0DJgUB30QhjmlnqAgI1MyFVv4bcmJzwLdRXPj8MFQQVUI0chEf4JX
 E1QsLsLMjmWNjJTG7Wkn8mrlvGU0dZplrcad82B5VBil9XoT0vQFxsh4sfUzi6ekdVum
 AHrg==
X-Gm-Message-State: AOAM533KxWWZhwgmjEVlirhaB6Qsm456BeEBUXGqnEM8WmwoMcINYcvz
 ExdLh0NGPRdf5XFMW8LpO2BfZVpTjRT3kqimzwTNGCiFqheltPZki8D9BpTMH9p2R65+DXWRAGM
 lBuThOhVkEAQbRK8=
X-Received: by 2002:a5d:6087:: with SMTP id w7mr226338wrt.158.1589912439530;
 Tue, 19 May 2020 11:20:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk4B8l3Ki5y6mp56jyDKGFOGMBcO9XVVp+fzi7K9ZMNWIFEf8jSQ1K1qE5TDyWsWVL9ba51g==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr226320wrt.158.1589912439375;
 Tue, 19 May 2020 11:20:39 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q144sm581286wme.0.2020.05.19.11.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:20:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/5] softmmu/vl: Let -fw_cfg option take a 'blob_id'
 argument
Date: Tue, 19 May 2020 20:20:21 +0200
Message-Id: <20200519182024.14638-3-philmd@redhat.com>
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

The 'blob_id' argument refers to a QOM object able to produce
data consumable by the fw_cfg device. The producer object must
implement the FW_CFG_DATA_GENERATOR interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 softmmu/vl.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index ae5451bc23..f76c53ad2e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -489,6 +489,10 @@ static QemuOptsList qemu_fw_cfg_opts = {
             .name = "string",
             .type = QEMU_OPT_STRING,
             .help = "Sets content of the blob to be inserted from a string",
+        }, {
+            .name = "blob_id",
+            .type = QEMU_OPT_STRING,
+            .help = "Sets id of the object generating fw_cfg blob to be used",
         },
         { /* end of list */ }
     },
@@ -2020,7 +2024,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
 {
     gchar *buf;
     size_t size;
-    const char *name, *file, *str;
+    const char *name, *file, *str, *blob_id;
     FWCfgState *fw_cfg = (FWCfgState *) opaque;
 
     if (fw_cfg == NULL) {
@@ -2030,14 +2034,17 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     name = qemu_opt_get(opts, "name");
     file = qemu_opt_get(opts, "file");
     str = qemu_opt_get(opts, "string");
+    blob_id = qemu_opt_get(opts, "blob_id");
 
     /* we need name and either a file or the content string */
-    if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)))) {
+    if (!(nonempty_str(name)
+          && (nonempty_str(file) || nonempty_str(str) || nonempty_str(blob_id)))
+         ) {
         error_setg(errp, "invalid argument(s)");
         return -1;
     }
-    if (nonempty_str(file) && nonempty_str(str)) {
-        error_setg(errp, "file and string are mutually exclusive");
+    if (nonempty_str(file) && nonempty_str(str) && nonempty_str(blob_id)) {
+        error_setg(errp, "file, string and blob_id are mutually exclusive");
         return -1;
     }
     if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
@@ -2052,6 +2059,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     if (nonempty_str(str)) {
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
+    } else if (nonempty_str(blob_id)) {
+        return fw_cfg_add_from_generator(fw_cfg, name, blob_id, errp);
     } else {
         GError *err = NULL;
         if (!g_file_get_contents(file, &buf, &size, &err)) {
-- 
2.21.3


