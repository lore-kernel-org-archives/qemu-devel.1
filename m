Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35196C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B2422B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDiFy2/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B2422B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSgr-0008HQ-98
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jxSeR-0005X8-BY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:04:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jxSeO-0007ug-U9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595239439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=soYWbjBNfE0Nqrqy0uff7UQUaeakj2qiATbwInnQ+Gw=;
 b=IDiFy2/XbiJIZiYatIW9gtoaSuw8zw7/pam7CI0vo5Rjfv78JlyH3/EA6gNeGs0Jn3baSH
 rAIzQUVRUzAfZlbbMAJawNVPtp5+/KR0yC1qVwonsNH9mubOU5znFUALEKLMtO+qJK4+Vx
 yCuSVWmcTELdwAJkwdQoOEzG/oMRZQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-vRor3VlENQWOsjHn8wRV6Q-1; Mon, 20 Jul 2020 06:03:58 -0400
X-MC-Unique: vRor3VlENQWOsjHn8wRV6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EEA7108B
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 10:03:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA18F797FC;
 Mon, 20 Jul 2020 10:03:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC3E79DA0; Mon, 20 Jul 2020 12:03:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] qxl: fix modular builds with dtrace
Date: Mon, 20 Jul 2020 12:03:50 +0200
Message-Id: <20200720100352.2477-2-kraxel@redhat.com>
In-Reply-To: <20200720100352.2477-1-kraxel@redhat.com>
References: <20200720100352.2477-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:16:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Checking the enable/disable state of tracepoints via
trace_event_get_state_backends() does not work for modules.

qxl checks the state for a small optimization (avoid g_strndup
call in case log_buf will not be used anyway), so we can just
drop that check for modular builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index d5627119ec62..11871340e75d 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1762,7 +1762,16 @@ async_common:
         qxl_set_mode(d, val, 0);
         break;
     case QXL_IO_LOG:
+#ifdef CONFIG_MODULES
+        /*
+         * FIXME
+         * trace_event_get_state_backends() does not work for modules,
+         * it leads to "undefined symbol: qemu_qxl_io_log_semaphore"
+         */
+        if (true) {
+#else
         if (trace_event_get_state_backends(TRACE_QXL_IO_LOG) || d->guestdebug) {
+#endif
             /* We cannot trust the guest to NUL terminate d->ram->log_buf */
             char *log_buf = g_strndup((const char *)d->ram->log_buf,
                                       sizeof(d->ram->log_buf));
-- 
2.18.4


