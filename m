Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800CB207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUdzf4ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800CB207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtokY-0006Wg-Kq
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtojm-0005ff-HV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:50:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtojk-0007od-RV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594371028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type;
 bh=rZ3yeXUflsE6CBniuyPz6PS4FYtZkwSWg/vG1Xwgv+0=;
 b=XUdzf4NDNUFNq/GxJQsQqboaLg8Mol/e/VYtKm5t6qR6gkZ09ksMeMUBvyBqU23XEBTagR
 kIq0nAmGNy6s2ndnpAThHbFRPGLj0QsO0FznzyCDHwzQ0aIx4lARQDtb+cdrWZc9RAQRud
 KzWy/AtvrgtYyjQW4bfzywm7X1f2Fw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-ZrlJe5RTO9qVt_12bsamag-1; Fri, 10 Jul 2020 04:50:25 -0400
X-MC-Unique: ZrlJe5RTO9qVt_12bsamag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 304B110059B2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:50:24 +0000 (UTC)
Received: from thuth.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 511C65C1BD;
 Fri, 10 Jul 2020 08:50:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] softmmu/vl: Be less verbose about missing KVM when running
 the qtests
Date: Fri, 10 Jul 2020 10:50:20 +0200
Message-Id: <20200710085020.28222-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 softmmu/vl.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3f58ffd4dc..0066f50fb2 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -164,8 +164,9 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
 bool wakeup_suspend_enabled;
-
 int icount_align_option;
+static const char *qtest_chrdev;
+static const char *qtest_log;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
  * little-endian "wire format" described in the SMBIOS 2.6 specification.
@@ -2693,10 +2694,15 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
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
@@ -2708,8 +2714,9 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
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
 
@@ -2780,7 +2787,7 @@ static void configure_accelerators(const char *progname)
         exit(1);
     }
 
-    if (init_failed) {
+    if (init_failed && !qtest_chrdev) {
         AccelClass *ac = ACCEL_GET_CLASS(current_accel());
         error_report("falling back to %s", ac->name);
     }
@@ -2830,8 +2837,6 @@ void qemu_init(int argc, char **argv, char **envp)
     MachineClass *machine_class;
     const char *cpu_option;
     const char *vga_model = NULL;
-    const char *qtest_chrdev = NULL;
-    const char *qtest_log = NULL;
     const char *incoming = NULL;
     bool userconfig = true;
     bool nographic = false;
-- 
2.18.1


