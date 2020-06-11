Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B01A2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPdn/vmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B01A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTye-0003cn-Ub
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAT-00021o-El
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAQ-0001R0-IN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bi/K7EoFa5VhHkEuUhS0oQiIWt1B3Y4tZYBeByfoKKE=;
 b=TPdn/vmFkEdM7KIcClZXBgg1COfuN4DbR8Bg55AIzMa/gumKj+04/CQoS7ybiMALbIqTLL
 5RYAsnKlkmZhbhq8kwe0P5D0A7qhyi+K7ugGASy/hAFndWoPZkolLN8oKPXyQF2wEJ38qR
 dqaTqzB4uor33qv6dTHsdM6agOkGjas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-IGkmISY1MTqg0QKNJHaYRQ-1; Thu, 11 Jun 2020 15:47:11 -0400
X-MC-Unique: IGkmISY1MTqg0QKNJHaYRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B38BD801503;
 Thu, 11 Jun 2020 19:47:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1278760CC0;
 Thu, 11 Jun 2020 19:47:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 104/115] target/i386: sev: Partial cleanup to sev_state global
Date: Thu, 11 Jun 2020 15:44:38 -0400
Message-Id: <20200611194449.31468-105-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

The SEV code uses a pretty ugly global to access its internal state.  Now
that SEVState is embedded in SevGuestState, we can avoid accessing it via
the global in some cases.  In the remaining cases use a new global
referencing the containing SevGuestState which will simplify some future
transformations.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200604064219.436242-6-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 92 ++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b4ab9720d6..9e8ab7b056 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -80,7 +80,7 @@ struct SevGuestState {
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
-static SEVState *sev_state;
+static SevGuestState *sev_guest;
 static Error *sev_mig_blocker;
 
 static const char *const sev_fw_errlist[] = {
@@ -159,21 +159,21 @@ fw_error_to_str(int code)
 }
 
 static bool
-sev_check_state(SevState state)
+sev_check_state(const SevGuestState *sev, SevState state)
 {
-    assert(sev_state);
-    return sev_state->state == state ? true : false;
+    assert(sev);
+    return sev->state.state == state ? true : false;
 }
 
 static void
-sev_set_guest_state(SevState new_state)
+sev_set_guest_state(SevGuestState *sev, SevState new_state)
 {
     assert(new_state < SEV_STATE__MAX);
-    assert(sev_state);
+    assert(sev);
 
-    trace_kvm_sev_change_state(SevState_str(sev_state->state),
+    trace_kvm_sev_change_state(SevState_str(sev->state.state),
                                SevState_str(new_state));
-    sev_state->state = new_state;
+    sev->state.state = new_state;
 }
 
 static void
@@ -366,25 +366,25 @@ lookup_sev_guest_info(const char *id)
 bool
 sev_enabled(void)
 {
-    return sev_state ? true : false;
+    return !!sev_guest;
 }
 
 uint64_t
 sev_get_me_mask(void)
 {
-    return sev_state ? sev_state->me_mask : ~0;
+    return sev_guest ? sev_guest->state.me_mask : ~0;
 }
 
 uint32_t
 sev_get_cbit_position(void)
 {
-    return sev_state ? sev_state->cbitpos : 0;
+    return sev_guest ? sev_guest->state.cbitpos : 0;
 }
 
 uint32_t
 sev_get_reduced_phys_bits(void)
 {
-    return sev_state ? sev_state->reduced_phys_bits : 0;
+    return sev_guest ? sev_guest->state.reduced_phys_bits : 0;
 }
 
 SevInfo *
@@ -393,15 +393,15 @@ sev_get_info(void)
     SevInfo *info;
 
     info = g_new0(SevInfo, 1);
-    info->enabled = sev_state ? true : false;
+    info->enabled = sev_enabled();
 
     if (info->enabled) {
-        info->api_major = sev_state->api_major;
-        info->api_minor = sev_state->api_minor;
-        info->build_id = sev_state->build_id;
-        info->policy = sev_state->policy;
-        info->state = sev_state->state;
-        info->handle = sev_state->handle;
+        info->api_major = sev_guest->state.api_major;
+        info->api_minor = sev_guest->state.api_minor;
+        info->build_id = sev_guest->state.build_id;
+        info->policy = sev_guest->state.policy;
+        info->state = sev_guest->state.state;
+        info->handle = sev_guest->state.handle;
     }
 
     return info;
@@ -550,7 +550,7 @@ sev_launch_start(SevGuestState *sev)
 
     object_property_set_int(OBJECT(sev), start->handle, "handle",
                             &error_abort);
-    sev_set_guest_state(SEV_STATE_LAUNCH_UPDATE);
+    sev_set_guest_state(sev, SEV_STATE_LAUNCH_UPDATE);
     s->handle = start->handle;
     s->policy = start->policy;
     ret = 0;
@@ -563,7 +563,7 @@ out:
 }
 
 static int
-sev_launch_update_data(uint8_t *addr, uint64_t len)
+sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -575,7 +575,7 @@ sev_launch_update_data(uint8_t *addr, uint64_t len)
     update.uaddr = (__u64)(unsigned long)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
-    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
+    ret = sev_ioctl(sev->state.sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
         error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
@@ -588,19 +588,20 @@ sev_launch_update_data(uint8_t *addr, uint64_t len)
 static void
 sev_launch_get_measure(Notifier *notifier, void *unused)
 {
+    SevGuestState *sev = sev_guest;
     int ret, error;
     guchar *data;
-    SEVState *s = sev_state;
+    SEVState *s = &sev->state;
     struct kvm_sev_launch_measure *measurement;
 
-    if (!sev_check_state(SEV_STATE_LAUNCH_UPDATE)) {
+    if (!sev_check_state(sev, SEV_STATE_LAUNCH_UPDATE)) {
         return;
     }
 
     measurement = g_new0(struct kvm_sev_launch_measure, 1);
 
     /* query the measurement blob length */
-    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_MEASURE,
+    ret = sev_ioctl(sev->state.sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     measurement, &error);
     if (!measurement->len) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
@@ -612,7 +613,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     measurement->uaddr = (unsigned long)data;
 
     /* get the measurement blob */
-    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_MEASURE,
+    ret = sev_ioctl(sev->state.sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     measurement, &error);
     if (ret) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
@@ -620,7 +621,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
         goto free_data;
     }
 
-    sev_set_guest_state(SEV_STATE_LAUNCH_SECRET);
+    sev_set_guest_state(sev, SEV_STATE_LAUNCH_SECRET);
 
     /* encode the measurement value and emit the event */
     s->measurement = g_base64_encode(data, measurement->len);
@@ -635,9 +636,9 @@ free_measurement:
 char *
 sev_get_launch_measurement(void)
 {
-    if (sev_state &&
-        sev_state->state >= SEV_STATE_LAUNCH_SECRET) {
-        return g_strdup(sev_state->measurement);
+    if (sev_guest &&
+        sev_guest->state.state >= SEV_STATE_LAUNCH_SECRET) {
+        return g_strdup(sev_guest->state.measurement);
     }
 
     return NULL;
@@ -648,20 +649,21 @@ static Notifier sev_machine_done_notify = {
 };
 
 static void
-sev_launch_finish(SEVState *s)
+sev_launch_finish(SevGuestState *sev)
 {
+    SEVState *s = &sev->state;
     int ret, error;
     Error *local_err = NULL;
 
     trace_kvm_sev_launch_finish();
-    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
+    ret = sev_ioctl(s->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
     if (ret) {
         error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
                      __func__, ret, error, fw_error_to_str(error));
         exit(1);
     }
 
-    sev_set_guest_state(SEV_STATE_RUNNING);
+    sev_set_guest_state(sev, SEV_STATE_RUNNING);
 
     /* add migration blocker */
     error_setg(&sev_mig_blocker,
@@ -677,11 +679,11 @@ sev_launch_finish(SEVState *s)
 static void
 sev_vm_state_change(void *opaque, int running, RunState state)
 {
-    SEVState *s = opaque;
+    SevGuestState *sev = opaque;
 
     if (running) {
-        if (!sev_check_state(SEV_STATE_RUNNING)) {
-            sev_launch_finish(s);
+        if (!sev_check_state(sev, SEV_STATE_RUNNING)) {
+            sev_launch_finish(sev);
         }
     }
 }
@@ -704,7 +706,8 @@ sev_guest_init(const char *id)
         goto err;
     }
 
-    sev_state = s = &sev->state;
+    sev_guest = sev;
+    s = &sev->state;
     s->state = SEV_STATE_UNINIT;
 
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
@@ -766,23 +769,24 @@ sev_guest_init(const char *id)
 
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
-    qemu_add_vm_change_state_handler(sev_vm_state_change, s);
+    qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
 
-    return s;
+    return sev;
 err:
-    g_free(sev_state);
-    sev_state = NULL;
+    sev_guest = NULL;
     return NULL;
 }
 
 int
 sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
 {
-    assert(handle);
+    SevGuestState *sev = handle;
+
+    assert(sev);
 
     /* if SEV is in update state then encrypt the data else do nothing */
-    if (sev_check_state(SEV_STATE_LAUNCH_UPDATE)) {
-        return sev_launch_update_data(ptr, len);
+    if (sev_check_state(sev, SEV_STATE_LAUNCH_UPDATE)) {
+        return sev_launch_update_data(sev, ptr, len);
     }
 
     return 0;
-- 
2.26.2



