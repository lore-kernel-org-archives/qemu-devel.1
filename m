Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0965FC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61652086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWZwjkzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61652086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYes-0000CQ-0k
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYdq-0007Fi-89
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:39:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYdo-0006P4-Gp
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595500795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULFq2sr1um0IElm/mRL00zDsTy/K+6mOuA39u/j/7RY=;
 b=bWZwjkzlYFaDXUMHdqUHS2DAGIZy/7jDGS2yjUVnjUFbYC6VQNZhJe+SLmMW6jsQdxbnz1
 EjfiULWfKHC0cEF9X5flpImintPkvf9nVuJc0M5PMawXI96/Qmq0CnZhERi4o5Or1Hr2CG
 GWO3YxjGFC3aS+8Q57r0S4fCATu590U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-OWB82MrHN-mpY5TNxKnYGw-1; Thu, 23 Jul 2020 06:39:52 -0400
X-MC-Unique: OWB82MrHN-mpY5TNxKnYGw-1
Received: by mail-wr1-f69.google.com with SMTP id c6so1257864wru.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ULFq2sr1um0IElm/mRL00zDsTy/K+6mOuA39u/j/7RY=;
 b=nW6Y+aVhbVfShFO5o196wepv5/K6nnSs0Fqs5xXN2CCqNWvcBqPX5JSedHjP8HWdjJ
 Zy8S3071NmFXkvtbFlx/A3ri4vDim5iDOanZkEs0SKcOOI96gGS6qvyaxgO4qdF1lxiD
 yshE8l9NVzHH5G72S55DdMxdIACaI8JhS+I4pLg7ko/yqRSN+9lr3SDEjfWxab+L+59s
 3o1Do6t8LS8k++Gru/i+8owQOQeWhQnrgVnX0+mgyi5i3+YtU336l1oATwdJkaegegAS
 p82aueVciKnOSTfv196r4EoYc+ZIlZc9r+8rIGiokY7xKnGyV92nPTZ8YgcqshD2zifo
 VHOg==
X-Gm-Message-State: AOAM530EoGYIhCNEmrLYI/hQ+kY4Os+ZpgFjk6Aegxc9vFMA1rvEgXat
 vCKvwGqi84D7OZipAb0yEb7cU+BxdjuzXZvwZ+PSQxgXJsVvlsRXEDeo9oWvJLwrAiaI+pAMWrK
 xI547oSZAkxp4Mes=
X-Received: by 2002:a5d:4649:: with SMTP id j9mr3294178wrs.270.1595500790930; 
 Thu, 23 Jul 2020 03:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykokyIPjm/nyNn0pza00qb9x5RadO7Y0dHihZom59dUZz4jf5QzH48Y7UTObicSnLJOG2y8g==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr3294166wrs.270.1595500790745; 
 Thu, 23 Jul 2020 03:39:50 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w12sm3458770wrm.79.2020.07.23.03.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 03:39:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 2/2] tpm: List the available TPM backends
Date: Thu, 23 Jul 2020 12:39:39 +0200
Message-Id: <20200723103939.19624-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200723103939.19624-1-philmd@redhat.com>
References: <20200723103939.19624-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When an incorrect backend is selected, tpm_display_backend_drivers()
is supposed to list the available backends. However the error is
directly propagated, and we never display the list. The user only
gets "Parameter 'type' expects a TPM backend type" error.

Convert the fprintf(stderr,) calls to error hints propagated with
the error.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Since v1:
- Use g_assert_not_reached after processing 'help' in tpm_config_parse
---
 tpm.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tpm.c b/tpm.c
index e36803a64d..f883340d1a 100644
--- a/tpm.c
+++ b/tpm.c
@@ -58,23 +58,21 @@ static int tpm_backend_drivers_count(void)
 }
 
 /*
- * Walk the list of available TPM backend drivers and display them on the
- * screen.
+ * Walk the list of available TPM backend drivers and list them as Error hint.
  */
-static void tpm_display_backend_drivers(void)
+static void tpm_list_backend_drivers_hint(Error **errp)
 {
     int i;
 
-    fprintf(stderr, "Supported TPM types (choose only one):\n");
+    error_append_hint(errp, "Supported TPM types (choose only one):\n");
 
     for (i = 0; i < TPM_TYPE__MAX; i++) {
         const TPMBackendClass *bc = tpm_be_find_by_type(i);
         if (!bc) {
             continue;
         }
-        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
+        error_append_hint(errp, "%12s   %s\n", TpmType_str(i), bc->desc);
     }
-    fprintf(stderr, "\n");
 }
 
 /*
@@ -97,6 +95,7 @@ TPMBackend *qemu_find_tpm_be(const char *id)
 
 static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 {
+    ERRP_GUARD();
     const char *value;
     const char *id;
     const TPMBackendClass *be;
@@ -122,7 +121,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     value = qemu_opt_get(opts, "type");
     if (!value) {
         error_setg(errp, QERR_MISSING_PARAMETER, "type");
-        tpm_display_backend_drivers();
+        tpm_list_backend_drivers_hint(errp);
         return 1;
     }
 
@@ -131,7 +130,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     if (be == NULL) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
                    "a TPM backend type");
-        tpm_display_backend_drivers();
+        tpm_list_backend_drivers_hint(errp);
         return 1;
     }
 
@@ -184,8 +183,8 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
     QemuOpts *opts;
 
     if (!strcmp(optarg, "help")) {
-        tpm_display_backend_drivers();
-        return -1;
+        tpm_list_backend_drivers_hint(&error_fatal);
+        g_assert_not_reached(); /* Using &error_fatal triggers exit(1). */
     }
     opts = qemu_opts_parse_noisily(opts_list, optarg, true);
     if (!opts) {
-- 
2.21.3


