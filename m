Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C71C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B636920888
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP3plTw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B636920888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfSd-00014V-NG
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJA-0006S8-Cg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJ6-00075A-4B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl78dpgTJZ8P1IU2c4DK1V5IhL26LnKDU3IyXovKRpw=;
 b=NP3plTw1tDzj+O1mStNLyQVq23AY4FEr8rF75Bi2H75v+qXPcELab6rqag6KxmPMaBbTVF
 VYfgaGDIV3m9f3zxQyAAn2VCUF8Zmq/hVqQujXlh08IP0M+3gPdtHD5eVDktWU8Gf7ih57
 avpjWT78uyca6sgJX8BajXkNr1qIDg0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-MEkr7VhZOD-XS0D0XOmD3A-1; Wed, 30 Sep 2020 12:50:04 -0400
X-MC-Unique: MEkr7VhZOD-XS0D0XOmD3A-1
Received: by mail-wm1-f71.google.com with SMTP id b14so62170wmj.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dl78dpgTJZ8P1IU2c4DK1V5IhL26LnKDU3IyXovKRpw=;
 b=etltMwy0ClM/CYLNs9Wv/qP1PcSOyHNdYAnq6peIUVWAR2d7omr6+2km5/yG47Wsw/
 ZImHacVy1RfePVhotrj8/pp9dImFRjwrYrlXlBhIrfPIjw2+XSDsA+5iBdAwWgIMJd7y
 F3q5QuJ/4j0GSjcuOb8x3dn9udpMhO30LxLLtf0gPA+YXB901mFNZDVIaOnHXEk/SQ3h
 E3g2BKI+BX3F9ujRIvo2w8GNNwPfpJdzASSJoN9h9/G9dydpyBA2M0cVDThvbBkeXoio
 XTgFFH2/BS8at72vod6G0gu9kWG89t9xXnVv0Dsk81KxQBWGX/QEyyDcOf9hTRdJ45Y6
 uE+g==
X-Gm-Message-State: AOAM530Dv5SuZ7Ew6ZxGYDgT/SyKZnKT7N2lcV/6vCi+dUSOPfU9XpcU
 jwBB97Xn6Q7HwGb63TXV0f7zUjkh6LnNtgSz8McyVwfFzy9xIJ53lmVntZQiD41Rtx9okqrvM4N
 j3kur31PxwcN6SX4=
X-Received: by 2002:adf:e989:: with SMTP id h9mr4427117wrm.38.1601484602505;
 Wed, 30 Sep 2020 09:50:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt+AAkhoSapD0U322SGxeUJSceXYggA4RujouPo6flOPJ8NY2arJl7TWHL+kJM6S21FBhBtQ==
X-Received: by 2002:adf:e989:: with SMTP id h9mr4427080wrm.38.1601484602158;
 Wed, 30 Sep 2020 09:50:02 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u12sm4001266wrt.81.2020.09.30.09.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 02/11] hw/core/qdev-properties: Use qemu_strtol() in
 set_mac() handler
Date: Wed, 30 Sep 2020 18:49:40 +0200
Message-Id: <20200930164949.1425294-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MACAddr structure contains an array of uint8_t. Previously
if a value was out of the [0..255] range, it was silently casted
and no input validation was done.
Replace strtol() by qemu_strtol() -- so checkpatch.pl won't
complain if we move this code later -- and return EINVAL if the
input is invalid.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 343c824da0..080ba319a1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "net/net.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
@@ -524,7 +525,8 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
     Property *prop = opaque;
     MACAddr *mac = qdev_get_prop_ptr(dev, prop);
     int i, pos;
-    char *str, *p;
+    char *str;
+    const char *p;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -536,6 +538,8 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
     }
 
     for (i = 0, pos = 0; i < 6; i++, pos += 3) {
+        long val;
+
         if (!qemu_isxdigit(str[pos])) {
             goto inval;
         }
@@ -551,7 +555,10 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                 goto inval;
             }
         }
-        mac->a[i] = strtol(str+pos, &p, 16);
+        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
+            goto inval;
+        }
+        mac->a[i] = val;
     }
     g_free(str);
     return;
-- 
2.26.2


