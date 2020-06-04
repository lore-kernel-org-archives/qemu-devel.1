Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F8BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6995B207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pEQl3sSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6995B207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjhC-0001W1-Mk
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaH-00053Q-5I
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:37 -0400
Received: from ozlabs.org ([203.11.71.1]:39501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaF-0000nk-To
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6D1pVnz9sTT; Thu,  4 Jun 2020 16:42:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252948;
 bh=9XFgDESJPgFUKQthTa2aOPuUw2nAgG46DWdbRXnKPl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pEQl3sSY0uZ7j9qiCVm/NLY+yG2ezLFIxpurtxnqvuwZf0t1uHT+nYPvy5YYCnXsQ
 8LKdPZknYJawiyAPcovOz6fD1xqI+EOv7+wwPwXOA6OfYZkAfcyxQke1RTg/BPV3Kz
 bcyKLeYzu3G4UqO4ms172P8rnJx1DK9plSuSb0Es=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 9/9] target/i386: sev: Unify SEVState and SevGuestState
Date: Thu,  4 Jun 2020 16:42:19 +1000
Message-Id: <20200604064219.436242-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SEVState is contained with SevGuestState.  We've now fixed redundancies
and name conflicts, so there's no real point to the nested structure.  Just
move all the fields of SEVState into SevGuestState.

This eliminates the SEVState structure, which as a bonus removes the
confusion with the SevState enum.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c | 79 ++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 24e2dea9b8..d273174ad3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -35,18 +35,6 @@
 
 typedef struct SevGuestState SevGuestState;
 
-struct SEVState {
-    uint8_t api_major;
-    uint8_t api_minor;
-    uint8_t build_id;
-    uint64_t me_mask;
-    int sev_fd;
-    SevState state;
-    gchar *measurement;
-};
-
-typedef struct SEVState SEVState;
-
 /**
  * SevGuestState:
  *
@@ -70,7 +58,13 @@ struct SevGuestState {
 
     /* runtime state */
     uint32_t handle;
-    SEVState state;
+    uint8_t api_major;
+    uint8_t api_minor;
+    uint8_t build_id;
+    uint64_t me_mask;
+    int sev_fd;
+    SevState state;
+    gchar *measurement;
 };
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
@@ -158,7 +152,7 @@ static bool
 sev_check_state(const SevGuestState *sev, SevState state)
 {
     assert(sev);
-    return sev->state.state == state ? true : false;
+    return sev->state == state ? true : false;
 }
 
 static void
@@ -167,9 +161,9 @@ sev_set_guest_state(SevGuestState *sev, SevState new_state)
     assert(new_state < SEV_STATE__MAX);
     assert(sev);
 
-    trace_kvm_sev_change_state(SevState_str(sev->state.state),
+    trace_kvm_sev_change_state(SevState_str(sev->state),
                                SevState_str(new_state));
-    sev->state.state = new_state;
+    sev->state = new_state;
 }
 
 static void
@@ -368,7 +362,7 @@ sev_enabled(void)
 uint64_t
 sev_get_me_mask(void)
 {
-    return sev_guest ? sev_guest->state.me_mask : ~0;
+    return sev_guest ? sev_guest->me_mask : ~0;
 }
 
 uint32_t
@@ -392,11 +386,11 @@ sev_get_info(void)
     info->enabled = sev_enabled();
 
     if (info->enabled) {
-        info->api_major = sev_guest->state.api_major;
-        info->api_minor = sev_guest->state.api_minor;
-        info->build_id = sev_guest->state.build_id;
+        info->api_major = sev_guest->api_major;
+        info->api_minor = sev_guest->api_minor;
+        info->build_id = sev_guest->build_id;
         info->policy = sev_guest->policy;
-        info->state = sev_guest->state.state;
+        info->state = sev_guest->state;
         info->handle = sev_guest->handle;
     }
 
@@ -507,7 +501,6 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
 static int
 sev_launch_start(SevGuestState *sev)
 {
-    SEVState *s = &sev->state;
     gsize sz;
     int ret = 1;
     int fw_error, rc;
@@ -535,7 +528,7 @@ sev_launch_start(SevGuestState *sev)
     }
 
     trace_kvm_sev_launch_start(start->policy, session, dh_cert);
-    rc = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_START, start, &fw_error);
+    rc = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_START, start, &fw_error);
     if (rc < 0) {
         error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
                 __func__, ret, fw_error, fw_error_to_str(fw_error));
@@ -566,7 +559,7 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
     update.uaddr = (__u64)(unsigned long)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
-    ret = sev_ioctl(sev->state.sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
+    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
         error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
@@ -582,7 +575,6 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     SevGuestState *sev = sev_guest;
     int ret, error;
     guchar *data;
-    SEVState *s = &sev->state;
     struct kvm_sev_launch_measure *measurement;
 
     if (!sev_check_state(sev, SEV_STATE_LAUNCH_UPDATE)) {
@@ -592,7 +584,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     measurement = g_new0(struct kvm_sev_launch_measure, 1);
 
     /* query the measurement blob length */
-    ret = sev_ioctl(sev->state.sev_fd, KVM_SEV_LAUNCH_MEASURE,
+    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     measurement, &error);
     if (!measurement->len) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
@@ -604,7 +596,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     measurement->uaddr = (unsigned long)data;
 
     /* get the measurement blob */
-    ret = sev_ioctl(sev->state.sev_fd, KVM_SEV_LAUNCH_MEASURE,
+    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     measurement, &error);
     if (ret) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
@@ -615,8 +607,8 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     sev_set_guest_state(sev, SEV_STATE_LAUNCH_SECRET);
 
     /* encode the measurement value and emit the event */
-    s->measurement = g_base64_encode(data, measurement->len);
-    trace_kvm_sev_launch_measurement(s->measurement);
+    sev->measurement = g_base64_encode(data, measurement->len);
+    trace_kvm_sev_launch_measurement(sev->measurement);
 
 free_data:
     g_free(data);
@@ -628,8 +620,8 @@ char *
 sev_get_launch_measurement(void)
 {
     if (sev_guest &&
-        sev_guest->state.state >= SEV_STATE_LAUNCH_SECRET) {
-        return g_strdup(sev_guest->state.measurement);
+        sev_guest->state >= SEV_STATE_LAUNCH_SECRET) {
+        return g_strdup(sev_guest->measurement);
     }
 
     return NULL;
@@ -642,12 +634,11 @@ static Notifier sev_machine_done_notify = {
 static void
 sev_launch_finish(SevGuestState *sev)
 {
-    SEVState *s = &sev->state;
     int ret, error;
     Error *local_err = NULL;
 
     trace_kvm_sev_launch_finish();
-    ret = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
+    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
     if (ret) {
         error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
                      __func__, ret, error, fw_error_to_str(error));
@@ -683,7 +674,6 @@ void *
 sev_guest_init(const char *id)
 {
     SevGuestState *sev;
-    SEVState *s;
     char *devname;
     int ret, fw_error;
     uint32_t ebx;
@@ -698,8 +688,7 @@ sev_guest_init(const char *id)
     }
 
     sev_guest = sev;
-    s = &sev->state;
-    s->state = SEV_STATE_UNINIT;
+    sev->state = SEV_STATE_UNINIT;
 
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
@@ -716,20 +705,20 @@ sev_guest_init(const char *id)
         goto err;
     }
 
-    s->me_mask = ~(1UL << sev->cbitpos);
+    sev->me_mask = ~(1UL << sev->cbitpos);
 
     devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
-    s->sev_fd = open(devname, O_RDWR);
-    if (s->sev_fd < 0) {
+    sev->sev_fd = open(devname, O_RDWR);
+    if (sev->sev_fd < 0) {
         error_report("%s: Failed to open %s '%s'", __func__,
                      devname, strerror(errno));
     }
     g_free(devname);
-    if (s->sev_fd < 0) {
+    if (sev->sev_fd < 0) {
         goto err;
     }
 
-    ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
+    ret = sev_platform_ioctl(sev->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
     if (ret) {
         error_report("%s: failed to get platform status ret=%d "
@@ -737,12 +726,12 @@ sev_guest_init(const char *id)
                      fw_error_to_str(fw_error));
         goto err;
     }
-    s->build_id = status.build;
-    s->api_major = status.api_major;
-    s->api_minor = status.api_minor;
+    sev->build_id = status.build;
+    sev->api_major = status.api_major;
+    sev->api_minor = status.api_minor;
 
     trace_kvm_sev_init();
-    ret = sev_ioctl(s->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
+    ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
     if (ret) {
         error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
                      __func__, ret, fw_error, fw_error_to_str(fw_error));
-- 
2.26.2


