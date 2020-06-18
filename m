Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07930C433ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC74F2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0LY/tmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC74F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlweh-0002iS-UM
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdI-0000xm-Vp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdG-0008SL-2Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvlpgC42AoWGYCBIeLo38FC+NaWg0tZy3hpeHXTCPNw=;
 b=e0LY/tmm0bhHirEWQKQkHBUrDIWD4CHu2je1eDcb0swcFiYrNJ5EHZ6QL72xshJDF3aouo
 3RSS9uRQYN5HttsaptqxJM2Q4QmcKozD0lYpK4adC2lKJ7CFeIiIDgDHxE61aNbLkK7Yty
 uQfWNioLs83IBv+Dpbbw6QXn6W/91O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-VxPUxL0DMh2c2eGg6LaCCw-1; Thu, 18 Jun 2020 11:39:11 -0400
X-MC-Unique: VxPUxL0DMh2c2eGg6LaCCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF8DB801504;
 Thu, 18 Jun 2020 15:39:09 +0000 (UTC)
Received: from localhost (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84A561E226B;
 Thu, 18 Jun 2020 15:39:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/7] s390x/css: Refactor the css_queue_crw() routine
Date: Thu, 18 Jun 2020 17:38:52 +0200
Message-Id: <20200618153854.271723-6-cohuck@redhat.com>
In-Reply-To: <20200618153854.271723-1-cohuck@redhat.com>
References: <20200618153854.271723-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Farman <farman@linux.ibm.com>

We have a use case (vfio-ccw) where a CRW is already built and
ready to use.  Rather than teasing out the components just to
reassemble it later, let's rework this code so we can queue a
fully-qualified CRW directly.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200505125757.98209-6-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 44 ++++++++++++++++++++++++++++--------------
 include/hw/s390x/css.h |  1 +
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a44faa3549b4..d1e365e3e63b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2170,30 +2170,23 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
     }
 }
 
-void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
-                   int chain, uint16_t rsid)
+void css_crw_add_to_queue(CRW crw)
 {
     CrwContainer *crw_cont;
 
-    trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
+    trace_css_crw((crw.flags & CRW_FLAGS_MASK_RSC) >> 8,
+                  crw.flags & CRW_FLAGS_MASK_ERC,
+                  crw.rsid,
+                  (crw.flags & CRW_FLAGS_MASK_C) ? "(chained)" : "");
+
     /* TODO: Maybe use a static crw pool? */
     crw_cont = g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost = true;
         return;
     }
-    crw_cont->crw.flags = (rsc << 8) | erc;
-    if (solicited) {
-        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
-    }
-    if (chain) {
-        crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
-    }
-    crw_cont->crw.rsid = rsid;
-    if (channel_subsys.crws_lost) {
-        crw_cont->crw.flags |= CRW_FLAGS_MASK_R;
-        channel_subsys.crws_lost = false;
-    }
+
+    crw_cont->crw = crw;
 
     QTAILQ_INSERT_TAIL(&channel_subsys.pending_crws, crw_cont, sibling);
 
@@ -2204,6 +2197,27 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
     }
 }
 
+void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
+                   int chain, uint16_t rsid)
+{
+    CRW crw;
+
+    crw.flags = (rsc << 8) | erc;
+    if (solicited) {
+        crw.flags |= CRW_FLAGS_MASK_S;
+    }
+    if (chain) {
+        crw.flags |= CRW_FLAGS_MASK_C;
+    }
+    crw.rsid = rsid;
+    if (channel_subsys.crws_lost) {
+        crw.flags |= CRW_FLAGS_MASK_R;
+        channel_subsys.crws_lost = false;
+    }
+
+    css_crw_add_to_queue(crw);
+}
+
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add)
 {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 7e3a5e743314..08c869ab0afc 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -205,6 +205,7 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
 void css_inject_io_interrupt(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
+void css_crw_add_to_queue(CRW crw);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
                    int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
-- 
2.25.4


