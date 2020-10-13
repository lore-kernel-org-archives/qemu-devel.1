Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E977F208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VI0KECSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E977F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSI8h-0000U1-VN
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyM-0005VW-3l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyH-0006Di-65
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ZVTw23lH6UgX7hwjWL1WRAG4e767IZDw2HbVcVmiCXU=;
 b=VI0KECShro1awm+q8WHSJ4TmvWuzXs1FxESzXxmIC7WsTwrrEeN6GlN7r7+FUZdmQUcDRF
 qL49xVfAgWY4wPYU0TfmXwulfQWGvpeK90njvLht0srek6VGtqYMWndHseGulMIhxjF5bo
 7MGsm34ZvbIwaBizuY62EkWuvtJwjA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Xk668mutOGCry6RL1BFPIg-1; Tue, 13 Oct 2020 06:55:54 -0400
X-MC-Unique: Xk668mutOGCry6RL1BFPIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A000C86ABCE;
 Tue, 13 Oct 2020 10:55:53 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDC76EF41;
 Tue, 13 Oct 2020 10:55:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/23] softmmu/vl: Be less verbose about missing KVM when
 running the qtests
Date: Tue, 13 Oct 2020 12:55:12 +0200
Message-Id: <20201013105527.20088-9-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the qtests use "-accel kvm -accel tcg" to run real guest code.
This causes some error messages when kvm is not available. We do not
really care about these messages since the fallback to tcg is expected
here. So let's silence them to avoid that they spoil the output of
the tests.

Unfortunately, we can not use the qtest_enabled() wrapper in this case,
since the qtest accelerator itself is not initialized. Thus we have to
test for the qtest_chrdev variable instead.

Message-Id: <20200710085020.28222-1-thuth@redhat.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 softmmu/vl.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5a11a62f78..254ee5e525 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -165,8 +165,9 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
 bool wakeup_suspend_enabled;
-
 int icount_align_option;
+static const char *qtest_chrdev;
+static const char *qtest_log;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
  * little-endian "wire format" described in the SMBIOS 2.6 specification.
@@ -2713,10 +2714,15 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     AccelClass *ac = accel_find(acc);
     AccelState *accel;
     int ret;
+    bool qtest_with_kvm;
+
+    qtest_with_kvm = g_str_equal(acc, "kvm") && qtest_chrdev != NULL;
 
     if (!ac) {
         *p_init_failed = true;
-        error_report("invalid accelerator %s", acc);
+        if (!qtest_with_kvm) {
+            error_report("invalid accelerator %s", acc);
+        }
         return 0;
     }
     accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
@@ -2728,8 +2734,9 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     ret = accel_init_machine(accel, current_machine);
     if (ret < 0) {
         *p_init_failed = true;
-        error_report("failed to initialize %s: %s",
-                     acc, strerror(-ret));
+        if (!qtest_with_kvm || ret != -ENOENT) {
+            error_report("failed to initialize %s: %s", acc, strerror(-ret));
+        }
         return 0;
     }
 
@@ -2800,7 +2807,7 @@ static void configure_accelerators(const char *progname)
         exit(1);
     }
 
-    if (init_failed) {
+    if (init_failed && !qtest_chrdev) {
         AccelClass *ac = ACCEL_GET_CLASS(current_accel());
         error_report("falling back to %s", ac->name);
     }
@@ -2870,8 +2877,6 @@ void qemu_init(int argc, char **argv, char **envp)
     MachineClass *machine_class;
     const char *cpu_option;
     const char *vga_model = NULL;
-    const char *qtest_chrdev = NULL;
-    const char *qtest_log = NULL;
     const char *incoming = NULL;
     bool userconfig = true;
     bool nographic = false;
-- 
2.18.2


