Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55BAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F5D20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LNlximYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcIy-0006nF-J4
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7N-0003Hz-FT; Wed, 20 May 2020 23:43:37 -0400
Received: from ozlabs.org ([203.11.71.1]:41131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbc7M-0003YT-8D; Wed, 20 May 2020 23:43:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SFnt57zsz9sVF; Thu, 21 May 2020 13:43:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590032594;
 bh=eup3iyYUWnuqB9PIhUENkDwPcTYFDbBI7Pm2SOCB26g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LNlximYBa0hlzRkqewPUvqQcL4/R29JENQCQDo/w2gabH//RHCoafExY6olBai97u
 dBQwRafjSrUt1N7sGl4TCztWSHVjBRgZF3YIvdHrb5leAvrL2fd0eMZZRQFV5J5kPj
 /BTpeFjCzuO4WBH9PcgTwAQYVEQ4Kou+DlBjYV8c=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, brijesh.singh@amd.com, frankja@linux.ibm.com,
 dgilbert@redhat.com, pair@us.ibm.com
Subject: [RFC v2 16/18] guest memory protection: Add Error ** to
 GuestMemoryProtection::kvm_init
Date: Thu, 21 May 2020 13:43:02 +1000
Message-Id: <20200521034304.340040-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521034304.340040-1-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows failures to be reported richly and idiomatically.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 accel/kvm/kvm-all.c                    |  4 +++-
 include/exec/guest-memory-protection.h |  2 +-
 target/i386/sev.c                      | 31 +++++++++++++-------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1b10e94222..4011699736 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2079,9 +2079,11 @@ static int kvm_init(MachineState *ms)
     if (ms->gmpo) {
         GuestMemoryProtectionClass *gmpc =
             GUEST_MEMORY_PROTECTION_GET_CLASS(ms->gmpo);
+        Error *local_err = NULL;
 
-        ret = gmpc->kvm_init(ms->gmpo);
+        ret = gmpc->kvm_init(ms->gmpo, &local_err);
         if (ret < 0) {
+            error_report_err(local_err);
             goto err;
         }
     }
diff --git a/include/exec/guest-memory-protection.h b/include/exec/guest-memory-protection.h
index 7d959b4910..2a88475136 100644
--- a/include/exec/guest-memory-protection.h
+++ b/include/exec/guest-memory-protection.h
@@ -32,7 +32,7 @@ typedef struct GuestMemoryProtection GuestMemoryProtection;
 typedef struct GuestMemoryProtectionClass {
     InterfaceClass parent;
 
-    int (*kvm_init)(GuestMemoryProtection *);
+    int (*kvm_init)(GuestMemoryProtection *, Error **);
     int (*encrypt_data)(GuestMemoryProtection *, uint8_t *, uint64_t);
 } GuestMemoryProtectionClass;
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 60e9d8c735..6a56ec203b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -617,7 +617,7 @@ sev_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
-static int sev_kvm_init(GuestMemoryProtection *gmpo)
+static int sev_kvm_init(GuestMemoryProtection *gmpo, Error **errp)
 {
     SevGuestState *sev = SEV_GUEST(gmpo);
     char *devname;
@@ -633,14 +633,14 @@ static int sev_kvm_init(GuestMemoryProtection *gmpo)
     host_cbitpos = ebx & 0x3f;
 
     if (host_cbitpos != sev->cbitpos) {
-        error_report("%s: cbitpos check failed, host '%d' requested '%d'",
-                     __func__, host_cbitpos, sev->cbitpos);
+        error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
+                   __func__, host_cbitpos, sev->cbitpos);
         goto err;
     }
 
     if (sev->reduced_phys_bits < 1) {
-        error_report("%s: reduced_phys_bits check failed, it should be >=1,"
-                     " requested '%d'", __func__, sev->reduced_phys_bits);
+        error_setg(errp, "%s: reduced_phys_bits check failed, it should be >=1,"
+                   " requested '%d'", __func__, sev->reduced_phys_bits);
         goto err;
     }
 
@@ -649,20 +649,19 @@ static int sev_kvm_init(GuestMemoryProtection *gmpo)
     devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
     sev->sev_fd = open(devname, O_RDWR);
     if (sev->sev_fd < 0) {
-        error_report("%s: Failed to open %s '%s'", __func__,
-                     devname, strerror(errno));
-    }
-    g_free(devname);
-    if (sev->sev_fd < 0) {
+        error_setg(errp, "%s: Failed to open %s '%s'", __func__,
+                   devname, strerror(errno));
+        g_free(devname);
         goto err;
     }
+    g_free(devname);
 
     ret = sev_platform_ioctl(sev->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
     if (ret) {
-        error_report("%s: failed to get platform status ret=%d "
-                     "fw_error='%d: %s'", __func__, ret, fw_error,
-                     fw_error_to_str(fw_error));
+        error_setg(errp, "%s: failed to get platform status ret=%d "
+                   "fw_error='%d: %s'", __func__, ret, fw_error,
+                   fw_error_to_str(fw_error));
         goto err;
     }
     sev->build_id = status.build;
@@ -672,14 +671,14 @@ static int sev_kvm_init(GuestMemoryProtection *gmpo)
     trace_kvm_sev_init();
     ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
     if (ret) {
-        error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
-                     __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
+                   __func__, ret, fw_error, fw_error_to_str(fw_error));
         goto err;
     }
 
     ret = sev_launch_start(sev);
     if (ret) {
-        error_report("%s: failed to create encryption context", __func__);
+        error_setg(errp, "%s: failed to create encryption context", __func__);
         goto err;
     }
 
-- 
2.26.2


