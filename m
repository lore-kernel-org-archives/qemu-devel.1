Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1872FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E1320720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGgHacX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E1320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUS4-0007LJ-0k
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAU-00024J-T0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAS-0001RO-0h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LYwErl+pjehaD/v6IjJrKIbuSevbP1X5aYkjdO9wfo=;
 b=AGgHacX0Hirla6oUR7AAPSmTCOpSRe7kAl/1gjytOeac1VtFNQj7p2M9liKbA8iiTeGQT6
 GBq9dAPLPeZvzyLLoUce4Q4WcP4oBoBMcn0Q402hy08Ih97TV+mgS53JY/mp/KInSCD+JW
 mWUuaC78ZPSnX65wC/louz1hDOV3R/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-PfAqDDAwOz2odoyl91YKWg-1; Thu, 11 Jun 2020 15:47:10 -0400
X-MC-Unique: PfAqDDAwOz2odoyl91YKWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D522A194092A;
 Thu, 11 Jun 2020 19:47:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34C7260CC0;
 Thu, 11 Jun 2020 19:47:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 103/115] target/i386: sev: Embed SEVState in SevGuestState
Date: Thu, 11 Jun 2020 15:44:37 -0400
Message-Id: <20200611194449.31468-104-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Currently SevGuestState contains only configuration information.  For
runtime state another non-QOM struct SEVState is allocated separately.

Simplify things by instead embedding the SEVState structure in
SevGuestState.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200604064219.436242-5-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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



