Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BED20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fskc0Ul5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BED20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUTv-0001Eu-82
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAW-000265-3r
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAT-0001Rx-Pj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b51M9KztetPMSGfaOOWNQjB7fE1LQXN0ycQf577nQoE=;
 b=Fskc0Ul5QiUScZmhtn1yJPezK1rRkHNClmzt684E8zrC5P5Ae6l0YcDshBBoG6ZTZ3XVT0
 ZjhYl/5FSssU+AL9g5kZzMHXSxMxHW9+Tb7y+lqJWcyUWiU4Df5E1y+v6EbEgJzta3u7jg
 HnLloZ3xiSUAv5LH9GWI4zmX5oU7rv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-rCM9AFaaOjum2dlsqQ8hqQ-1; Thu, 11 Jun 2020 15:47:15 -0400
X-MC-Unique: rCM9AFaaOjum2dlsqQ8hqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA8B3A0BEB;
 Thu, 11 Jun 2020 19:47:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 498DD60CD3;
 Thu, 11 Jun 2020 19:47:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 108/115] target/i386: sev: Unify SEVState and SevGuestState
Date: Thu, 11 Jun 2020 15:44:42 -0400
Message-Id: <20200611194449.31468-109-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

SEVState is contained with SevGuestState.  We've now fixed redundancies
and name conflicts, so there's no real point to the nested structure.  Just
move all the fields of SEVState into SevGuestState.

This eliminates the SEVState structure, which as a bonus removes the
confusion with the SevState enum.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200604064219.436242-10-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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



