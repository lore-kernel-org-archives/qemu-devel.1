Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597ACC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DDB2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQwx7rqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DDB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlugi-0003A4-Ag
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVk-0007fB-IO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluVi-0005s8-UX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqfJNiWKmwLpVNKhcLugZJD0VA27CJTpg935USOUFCM=;
 b=bQwx7rqriioTByLd5Fg7+tf+XYCSCYzZtAZc3uJsJ0+2kHwBejs2WFcTqtnZlmqLyfd4jW
 3giMa7bQjQMiF0Rd+TR5YL/Jv/MJVwe+hfMv1+eSs5ZGd7lT8DOn88PfXL4AE5AWDhU0kT
 lPi2/NaGQxiYu3EYqB+RT0VxYwS+z94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-_CicEZpHOEOLF_JuABCn9w-1; Thu, 18 Jun 2020 09:23:16 -0400
X-MC-Unique: _CicEZpHOEOLF_JuABCn9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE6E980F5C1;
 Thu, 18 Jun 2020 13:23:14 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9495BAC4;
 Thu, 18 Jun 2020 13:23:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 25/33] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Date: Thu, 18 Jun 2020 21:21:40 +0800
Message-Id: <1592486508-6135-26-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

To be able to convert compare_chr_send to a coroutine in the
next commit, use qemu_co_sleep_ns if in coroutine.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 chardev/char.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index ea06c5f..e305129 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -38,6 +38,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/id.h"
+#include "qemu/coroutine.h"
 
 #include "chardev/char-mux.h"
 
@@ -119,7 +120,11 @@ static int qemu_chr_write_buffer(Chardev *s,
     retry:
         res = cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno == EAGAIN && write_all) {
-            g_usleep(100);
+            if (qemu_in_coroutine()) {
+                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+            } else {
+                g_usleep(100);
+            }
             goto retry;
         }
 
-- 
2.5.0


