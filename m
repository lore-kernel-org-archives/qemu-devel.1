Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1843C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F538207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gRX9Jh7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F538207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjek-0005Ax-RF
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaH-00053E-30
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:37 -0400
Received: from ozlabs.org ([203.11.71.1]:47113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaF-0000nb-K6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6C6VYJz9sTS; Thu,  4 Jun 2020 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252947;
 bh=b1j6omAe9XgeHM0BU9Jzn1mQzx20+TzZhGytbq8GQGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gRX9Jh7MSl7vyOAgfoVU75W9xanJaVUgxHP4WJ5TidKstxubzfpWzPu+y92n2aSZC
 YNMRRf+MuOMMxTqnzUrYPQs/6US3C1JFd1F/ds/juomKHD7IlOZhdR2zuqV3A3/Itk
 h8VNAQpm1RJZMiWoUMkSmzcMDdvzQ9jUPFneVk/A=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 5/9] target/i386: sev: Partial cleanup to sev_state global
Date: Thu,  4 Jun 2020 16:42:15 +1000
Message-Id: <20200604064219.436242-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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

The SEV code uses a pretty ugly global to access its internal state.  Now
that SEVState is embedded in SevGuestState, we can avoid accessing it via
the global in some cases.  In the remaining cases use a new global
referencing the containing SevGuestState which will simplify some future
transformations.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


