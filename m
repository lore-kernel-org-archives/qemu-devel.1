Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A5E20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYBQZn5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A5E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUR5-0005jM-Hz
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAU-000236-5X
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAR-0001RD-FZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/OUN2Gm+Qv34d8XgHbVohMxvKK4pJQF7AYNg438zXs=;
 b=LYBQZn5uTeD56T72r6WFjwFckk2e+0lRVGYETy8UMlugEPwoTpvx+nlPLeFHVtevTFEpfG
 ey1C4ROHTGHechUh0xrYkQGos11gNDNLnXq+vnGHQtAH6Z8LBToyJn6GnTOGBdqIEiZNgi
 +ZJtiEjuGaj+VW3xs1lgBNHeunM9GXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-bOGQXV0CPkmpE-zG7cMWcg-1; Thu, 11 Jun 2020 15:47:12 -0400
X-MC-Unique: bOGQXV0CPkmpE-zG7cMWcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90F7D1940923;
 Thu, 11 Jun 2020 19:47:11 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4689610FD;
 Thu, 11 Jun 2020 19:47:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 105/115] target/i386: sev: Remove redundant cbitpos and
 reduced_phys_bits fields
Date: Thu, 11 Jun 2020 15:44:39 -0400
Message-Id: <20200611194449.31468-106-pbonzini@redhat.com>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Gibson <david@gibson.dropbear.id.au>

The SEVState structure has cbitpos and reduced_phys_bits fields which are
simply copied from the SevGuestState structure and never changed.  Now that
SEVState is embedded in SevGuestState we can just access the original copy
directly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200604064219.436242-7-david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9e8ab7b056..d25af37136 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -41,8 +41,6 @@ struct SEVState {
     uint8_t build_id;
     uint32_t policy;
     uint64_t me_mask;
-    uint32_t cbitpos;
-    uint32_t reduced_phys_bits;
     uint32_t handle;
     int sev_fd;
     SevState state;
@@ -378,13 +376,13 @@ sev_get_me_mask(void)
 uint32_t
 sev_get_cbit_position(void)
 {
-    return sev_guest ? sev_guest->state.cbitpos : 0;
+    return sev_guest ? sev_guest->cbitpos : 0;
 }
 
 uint32_t
 sev_get_reduced_phys_bits(void)
 {
-    return sev_guest ? sev_guest->state.reduced_phys_bits : 0;
+    return sev_guest ? sev_guest->reduced_phys_bits : 0;
 }
 
 SevInfo *
@@ -713,22 +711,19 @@ sev_guest_init(const char *id)
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
-    s->cbitpos = object_property_get_int(OBJECT(sev), "cbitpos", NULL);
-    if (host_cbitpos != s->cbitpos) {
+    if (host_cbitpos != sev->cbitpos) {
         error_report("%s: cbitpos check failed, host '%d' requested '%d'",
-                     __func__, host_cbitpos, s->cbitpos);
+                     __func__, host_cbitpos, sev->cbitpos);
         goto err;
     }
 
-    s->reduced_phys_bits = object_property_get_int(OBJECT(sev),
-                                        "reduced-phys-bits", NULL);
-    if (s->reduced_phys_bits < 1) {
+    if (sev->reduced_phys_bits < 1) {
         error_report("%s: reduced_phys_bits check failed, it should be >=1,"
-                     " requested '%d'", __func__, s->reduced_phys_bits);
+                     " requested '%d'", __func__, sev->reduced_phys_bits);
         goto err;
     }
 
-    s->me_mask = ~(1UL << s->cbitpos);
+    s->me_mask = ~(1UL << sev->cbitpos);
 
     devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
     s->sev_fd = open(devname, O_RDWR);
-- 
2.26.2



