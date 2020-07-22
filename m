Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72144C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4D120771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxDQ23RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4D120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCrU-0001XX-EO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyCqk-0000KU-Pj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:23:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyCqj-0007yO-4Y
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595417028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrbqFvmIKnjyDf9/OryLKH0ntyIN25/qYYjTu4IPCmw=;
 b=bxDQ23RV5vzebvmMLlCUZ9RDMQZ2gSZKmMst0IonetVKLIdZcj8M8jIZHY04SHfEuXZ0/B
 P3OU1oMZ9L7WN7NlWjmAxpUuywrKOn7NzfvnNlLJG2TUoXNoY8WRcX+/Q35ArnO3jZjGsR
 dwsTVnZZQh2BjJjxP6IUNukg3XurtJk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-9XEKb-NTOQuMQ8H6or0aUA-1; Wed, 22 Jul 2020 07:23:46 -0400
X-MC-Unique: 9XEKb-NTOQuMQ8H6or0aUA-1
Received: by mail-ej1-f71.google.com with SMTP id cf15so887304ejb.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yrbqFvmIKnjyDf9/OryLKH0ntyIN25/qYYjTu4IPCmw=;
 b=ltW/eRJgrWxMW2jM7yO+OpKOe9seV3Xtgyo/BDZgdQ0WFj+pwugWrgBXUcUQixTGuB
 m+OKr6sPzDF7lLbBCPIpaSDEBb8Iboa/Ls/4nUawnbcqh3y8AZG+hU+C4RmEUe/W7Vaj
 evESj1aWXKUlizuzcywf90BKWiFoSw5F8fYHO4cAFStJVtkOkldaVeATTHBT2g9p0riB
 UQL3nHyCcpdOcAHS8JdLcVu2RtR1finpqFbXV7NUqAA2G62bIt4QIKuG/8QUR0rI57S3
 oWZYVPqziHOBWm9v/6B/ZRACbvVVKkhUu+WSVe/7ASY2H9NwSvNwU37f5ZuPOqIYvA3U
 GXPg==
X-Gm-Message-State: AOAM532FxvdWBwObZT95SEF+HJ4go2X1e0WdeY2euQk1rR5U58sKdkYi
 BNRJtFTmeHnuXemqy/N9Roa5suHqNTPulNnq5Bt/ajf0fF180uJqHEIDAjRoSNxBWizO/OmuFFj
 OaqmEW8XBBG+TA/w=
X-Received: by 2002:a17:906:a84d:: with SMTP id
 dx13mr28187838ejb.246.1595417025320; 
 Wed, 22 Jul 2020 04:23:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7AK71tp9g4bDc/z5K5txCzOy7B3/ZYdvnKwBw8s5iWKkcuWCw434qEx20qvm0tsDWL2faaw==
X-Received: by 2002:a17:906:a84d:: with SMTP id
 dx13mr28187820ejb.246.1595417025123; 
 Wed, 22 Jul 2020 04:23:45 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id jo25sm18530650ejb.116.2020.07.22.04.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:23:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1 2/2] tpm: List the available TPM backends
Date: Wed, 22 Jul 2020 13:23:33 +0200
Message-Id: <20200722112333.29966-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200722112333.29966-1-philmd@redhat.com>
References: <20200722112333.29966-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
RFC because this is now odd in tpm_config_parse():

  tpm_list_backend_drivers_hint(&error_fatal);
  return -1;
---
 tpm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tpm.c b/tpm.c
index e36803a64d..358566cb10 100644
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
 
@@ -184,7 +183,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
     QemuOpts *opts;
 
     if (!strcmp(optarg, "help")) {
-        tpm_display_backend_drivers();
+        tpm_list_backend_drivers_hint(&error_fatal);
         return -1;
     }
     opts = qemu_opts_parse_noisily(opts_list, optarg, true);
-- 
2.21.3


