Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A44FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BF320720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwLAhIXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BF320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTkU-0003Qg-Bw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT91-00085A-S1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8w-00016F-Og
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnVW+q5k7WUlLd05tyYL72pgIZMJJCUmWa0BR/hltaI=;
 b=PwLAhIXD+gdW7+mBeYDtcaN3Eesv1fGpZoas6ReH+xpQikpXW8ikCqt44CuuNlQv9FlaiE
 sFr5ps0Po8tijvIf5f3b8hjB9oQ+ML/Qeg/HFpcddFgmaQ/zvSarTItDm/KpMtl8r99OB3
 bQE9hxwEVcblo3CXhNvybez3zvChgXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-sq-fFeQ_P-2D24g8a4vIsg-1; Thu, 11 Jun 2020 15:45:09 -0400
X-MC-Unique: sq-fFeQ_P-2D24g8a4vIsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7719A0C00;
 Thu, 11 Jun 2020 19:45:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A4E660CD3;
 Thu, 11 Jun 2020 19:45:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 017/115] hyperv: expose API to determine if synic is enabled
Date: Thu, 11 Jun 2020 15:43:11 -0400
Message-Id: <20200611194449.31468-18-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20200424123444.3481728-2-arilou@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c         | 8 ++++++++
 include/hw/hyperv/hyperv.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 4b11f7a76b..a3933c34c6 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -38,6 +38,13 @@ typedef struct SynICState {
 #define TYPE_SYNIC "hyperv-synic"
 #define SYNIC(obj) OBJECT_CHECK(SynICState, (obj), TYPE_SYNIC)
 
+static bool synic_enabled;
+
+bool hyperv_is_synic_enabled(void)
+{
+    return synic_enabled;
+}
+
 static SynICState *get_synic(CPUState *cs)
 {
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
@@ -134,6 +141,7 @@ void hyperv_synic_add(CPUState *cs)
     object_property_add_child(OBJECT(cs), "synic", obj);
     object_unref(obj);
     object_property_set_bool(obj, true, "realized", &error_abort);
+    synic_enabled = true;
 }
 
 void hyperv_synic_reset(CPUState *cs)
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 597381cb01..a63ee0003c 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -79,5 +79,6 @@ void hyperv_synic_add(CPUState *cs);
 void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
+bool hyperv_is_synic_enabled(void);
 
 #endif
-- 
2.26.2



