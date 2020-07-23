Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1978820737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5UQgGMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1978820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZtQ-0001AB-AH
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZsE-0008Kc-12
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:58:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZsB-0005c8-8A
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595505530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWByrtXUfMC9fPTEoUOwUKTeawlwbfM2K3tH2Dg6T8Y=;
 b=d5UQgGMk/WReR/vrKRtpITwiOFJBkqJJG1UoZeIYnPl/3z0y/TefXYU8Ncahd0qXaf5oNf
 XwZqjDj5yFh52X7aSRIqOYYTHzjGzFW41d9zieioMu+lHc30diQ7BM+iB4zMVQYZo2vjBi
 bPKlOtmRU1v4Udj0d6WSs+ztKdGG4RU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-oUUzFpIlPnGW_ghz9_UmfA-1; Thu, 23 Jul 2020 07:58:48 -0400
X-MC-Unique: oUUzFpIlPnGW_ghz9_UmfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A541891271;
 Thu, 23 Jul 2020 11:58:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 544E26931D;
 Thu, 23 Jul 2020 11:58:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E71F4111CA27; Thu, 23 Jul 2020 13:58:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 1/2] Revert "tpm: Clean up error reporting in
 tpm_init_tpmdev()"
Date: Thu, 23 Jul 2020 13:58:44 +0200
Message-Id: <20200723115845.1865886-2-armbru@redhat.com>
In-Reply-To: <20200723115845.1865886-1-armbru@redhat.com>
References: <20200723115845.1865886-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: philmd@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit d10e05f15d5c3dd5e5cc59c5dfff460d89d48580.

We report some -tpmdev failures, but then continue as if all was fine.
Reproducer:

    $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chardev null,id=tpm0 -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
    qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: tpm chardev 'chrtpm' not found.
    qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: Could not cleanly shutdown the TPM: No such file or directory
    QEMU 5.0.90 monitor - type 'help' for more information
    (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=tpm0: Property 'tpm-tis.tpmdev' can't find value 'tpm0'
    $ echo $?
    1

This is a regression caused by commit d10e05f15d "tpm: Clean up error
reporting in tpm_init_tpmdev()".  It's incomplete: be->create(opts)
continues to use error_report(), and we don't set an error when it
fails.

I figure converting the create() methods to Error would make some
sense, but I'm not sure it's worth the effort right now.  Revert the
broken commit instead, and add a comment to tpm_init_tpmdev().

Straightforward conflict in tpm.c resolved.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/tpm.h |  2 +-
 softmmu/vl.c         |  4 +++-
 stubs/tpm.c          |  3 ++-
 tpm.c                | 30 +++++++++++++++++++++---------
 4 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 03fb25941c..730c61ac97 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -16,7 +16,7 @@
 #include "qom/object.h"
 
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
-void tpm_init(void);
+int tpm_init(void);
 void tpm_cleanup(void);
 
 typedef enum TPMVersion {
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f476ef89ed..2c06cf0513 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4262,7 +4262,9 @@ void qemu_init(int argc, char **argv, char **envp)
                       user_creatable_add_opts_foreach,
                       object_create_delayed, &error_fatal);
 
-    tpm_init();
+    if (tpm_init() < 0) {
+        exit(1);
+    }
 
     blk_mig_init();
     ram_mig_init();
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 66c99d667d..9bded191d9 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -10,8 +10,9 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 
-void tpm_init(void)
+int tpm_init(void)
 {
+    return 0;
 }
 
 void tpm_cleanup(void)
diff --git a/tpm.c b/tpm.c
index fe03b24858..f6045bb6da 100644
--- a/tpm.c
+++ b/tpm.c
@@ -81,26 +81,33 @@ TPMBackend *qemu_find_tpm_be(const char *id)
 
 static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 {
+    /*
+     * Use of error_report() in a function with an Error ** parameter
+     * is suspicious.  It is okay here.  The parameter only exists to
+     * make the function usable with qemu_opts_foreach().  It is not
+     * actually used.
+     */
     const char *value;
     const char *id;
     const TPMBackendClass *be;
     TPMBackend *drv;
+    Error *local_err = NULL;
     int i;
 
     if (!QLIST_EMPTY(&tpm_backends)) {
-        error_setg(errp, "Only one TPM is allowed.");
+        error_report("Only one TPM is allowed.");
         return 1;
     }
 
     id = qemu_opts_id(opts);
     if (id == NULL) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        error_report(QERR_MISSING_PARAMETER, "id");
         return 1;
     }
 
     value = qemu_opt_get(opts, "type");
     if (!value) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "type");
+        error_report(QERR_MISSING_PARAMETER, "type");
         tpm_display_backend_drivers();
         return 1;
     }
@@ -108,14 +115,15 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
     be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
     if (be == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
-                   "a TPM backend type");
+        error_report(QERR_INVALID_PARAMETER_VALUE,
+                     "type", "a TPM backend type");
         tpm_display_backend_drivers();
         return 1;
     }
 
     /* validate backend specific opts */
-    if (!qemu_opts_validate(opts, be->opts, errp)) {
+    if (!qemu_opts_validate(opts, be->opts, &local_err)) {
+        error_report_err(local_err);
         return 1;
     }
 
@@ -148,10 +156,14 @@ void tpm_cleanup(void)
  * Initialize the TPM. Process the tpmdev command line options describing the
  * TPM backend.
  */
-void tpm_init(void)
+int tpm_init(void)
 {
-    qemu_opts_foreach(qemu_find_opts("tpmdev"),
-                      tpm_init_tpmdev, NULL, &error_fatal);
+    if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
+                          tpm_init_tpmdev, NULL, NULL)) {
+        return -1;
+    }
+
+    return 0;
 }
 
 /*
-- 
2.26.2


