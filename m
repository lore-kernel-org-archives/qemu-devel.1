Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B50C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56061206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fSHI6dow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56061206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjay-0006NO-LB
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaD-0004yJ-Pa
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaB-0000mp-GQ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6C3x7Pz9sTG; Thu,  4 Jun 2020 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252947;
 bh=FTQ7m07v8BgK5bUbT3s95D7yiqpW26UZ7gLCPq5T3cE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fSHI6dowy1vZ5HgJ2QyUL2dmuIuYY4wabE4Pboo2LlWo7MDaqalZSV0SM3OR5EDvN
 UZkXidm9G7lmDVEQYWx2E/DvXAPr4ib/8FWiZTvmP2URX6zqML7Z+nn2B4vjsexQEb
 /LDmLxKggVyii1b6s5uTJPPcHOmAitjzFqK/m8TU=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 4/9] target/i386: sev: Embed SEVState in SevGuestState
Date: Thu,  4 Jun 2020 16:42:14 +1000
Message-Id: <20200604064219.436242-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently SevGuestState contains only configuration information.  For
runtime state another non-QOM struct SEVState is allocated separately.

Simplify things by instead embedding the SEVState structure in
SevGuestState.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/i386/sev.c | 54 +++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b6ed719fb5..b4ab9720d6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -35,6 +35,22 @@
 
 typedef struct SevGuestState SevGuestState;
 
+struct SEVState {
+    uint8_t api_major;
+    uint8_t api_minor;
+    uint8_t build_id;
+    uint32_t policy;
+    uint64_t me_mask;
+    uint32_t cbitpos;
+    uint32_t reduced_phys_bits;
+    uint32_t handle;
+    int sev_fd;
+    SevState state;
+    gchar *measurement;
+};
+
+typedef struct SEVState SEVState;
+
 /**
  * SevGuestState:
  *
@@ -48,6 +64,7 @@ typedef struct SevGuestState SevGuestState;
 struct SevGuestState {
     Object parent_obj;
 
+    /* configuration parameters */
     char *sev_device;
     uint32_t policy;
     uint32_t handle;
@@ -55,25 +72,11 @@ struct SevGuestState {
     char *session_file;
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
-};
 
-struct SEVState {
-    SevGuestState *sev_info;
-    uint8_t api_major;
-    uint8_t api_minor;
-    uint8_t build_id;
-    uint32_t policy;
-    uint64_t me_mask;
-    uint32_t cbitpos;
-    uint32_t reduced_phys_bits;
-    uint32_t handle;
-    int sev_fd;
-    SevState state;
-    gchar *measurement;
+    /* runtime state */
+    SEVState state;
 };
 
-typedef struct SEVState SEVState;
-
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
@@ -506,12 +509,12 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
 }
 
 static int
-sev_launch_start(SEVState *s)
+sev_launch_start(SevGuestState *sev)
 {
+    SEVState *s = &sev->state;
     gsize sz;
     int ret = 1;
     int fw_error, rc;
-    SevGuestState *sev = s->sev_info;
     struct kvm_sev_launch_start *start;
     guchar *session = NULL, *dh_cert = NULL;
 
@@ -686,6 +689,7 @@ sev_vm_state_change(void *opaque, int running, RunState state)
 void *
 sev_guest_init(const char *id)
 {
+    SevGuestState *sev;
     SEVState *s;
     char *devname;
     int ret, fw_error;
@@ -693,27 +697,27 @@ sev_guest_init(const char *id)
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
-    sev_state = s = g_new0(SEVState, 1);
-    s->sev_info = lookup_sev_guest_info(id);
-    if (!s->sev_info) {
+    sev = lookup_sev_guest_info(id);
+    if (!sev) {
         error_report("%s: '%s' is not a valid '%s' object",
                      __func__, id, TYPE_SEV_GUEST);
         goto err;
     }
 
+    sev_state = s = &sev->state;
     s->state = SEV_STATE_UNINIT;
 
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
-    s->cbitpos = object_property_get_int(OBJECT(s->sev_info), "cbitpos", NULL);
+    s->cbitpos = object_property_get_int(OBJECT(sev), "cbitpos", NULL);
     if (host_cbitpos != s->cbitpos) {
         error_report("%s: cbitpos check failed, host '%d' requested '%d'",
                      __func__, host_cbitpos, s->cbitpos);
         goto err;
     }
 
-    s->reduced_phys_bits = object_property_get_int(OBJECT(s->sev_info),
+    s->reduced_phys_bits = object_property_get_int(OBJECT(sev),
                                         "reduced-phys-bits", NULL);
     if (s->reduced_phys_bits < 1) {
         error_report("%s: reduced_phys_bits check failed, it should be >=1,"
@@ -723,7 +727,7 @@ sev_guest_init(const char *id)
 
     s->me_mask = ~(1UL << s->cbitpos);
 
-    devname = object_property_get_str(OBJECT(s->sev_info), "sev-device", NULL);
+    devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
     s->sev_fd = open(devname, O_RDWR);
     if (s->sev_fd < 0) {
         error_report("%s: Failed to open %s '%s'", __func__,
@@ -754,7 +758,7 @@ sev_guest_init(const char *id)
         goto err;
     }
 
-    ret = sev_launch_start(s);
+    ret = sev_launch_start(sev);
     if (ret) {
         error_report("%s: failed to create encryption context", __func__);
         goto err;
-- 
2.26.2


