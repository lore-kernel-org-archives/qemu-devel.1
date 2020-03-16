Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD57C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7977205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Su1olYXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7977205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeF1-0005kb-9C
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdLr-0008DR-9x
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdLp-00046D-61
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdLp-00044B-1A
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jznyG6ZwK2HqBmm0XWTDAnNXPpietF898ys70w4PLHk=;
 b=Su1olYXksk3/ivw8SeEMoD8lsZluSD0O8RLOLVPAVASNZXSyGrApHkvo23Fsmgg3BxzR5U
 KLZdeIblREKundgO5WXjVlpqbs1+6HSADwUFtqARF6saTypppT8w7b7lwB/8hO3xvcuJCY
 j92Yceoy5vMAJBwxhHVHoyYFxzEdftg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-lG9mLbDeNnOgNNSjR1vUTA-1; Sun, 15 Mar 2020 20:11:21 -0400
X-MC-Unique: lG9mLbDeNnOgNNSjR1vUTA-1
Received: by mail-wr1-f69.google.com with SMTP id t10so1852435wrp.15
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjkIxsGDVLhIoi2wxX81/gLAzGZQZKT/spQLce8K0hQ=;
 b=Iyufo3tsX7LDDKcBe/kKTYGGq1mYJWOFnSgTISK66CglK3c5XOfiCkv4qYkbV6iDsk
 033twQPQWbjsQJqbzB3ZASMQwCVlrsKjqTKeqOQKY8idPyIc5bcHhfnRptpOL3vimzMm
 1wLH8d1qOzc9F7bjO4gCjZBAT6HMCS1FK16TC1Dz+INx9FBrXWqNUtsJhLG3G19ioPPH
 SSbOwPq0BRRMPa2ZED+dI53QRfN9WYn+TdhWLkiW6802H0mj+wWaQ/BeHIXcsPqaLjW8
 YVX6/Km+YXGQbCVwujdeWFOCg3m9YfAHgmhrDn3qnAKzd+s/pjMeldhZno/CzjVD3XvH
 rkIw==
X-Gm-Message-State: ANhLgQ1HyJxwRnGeTU5FTrSWhJ9g2wZCOdiuYpy72wz4mVTGBGbLQMQJ
 r44pxGp0gtsNYLRvzNst0nPd60Ck9XrHCuwXsp0oNE6HLwuLO4vqhyv1kr6HIfoEJUdzyFARokz
 EYj9D0i0J0FJmEaw=
X-Received: by 2002:a1c:6605:: with SMTP id a5mr24393043wmc.32.1584317479913; 
 Sun, 15 Mar 2020 17:11:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuo0cRj+iuolTs3FlbHkV8ErFMyIFtT512xgxL4hi8D0xSKaiNthiT2j73tAx6df9E9vsCwHw==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr24393015wmc.32.1584317479669; 
 Sun, 15 Mar 2020 17:11:19 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id f15sm16109952wrt.9.2020.03.15.17.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] hw/core/qdev-properties: Use qemu_strtol() in
 set_mac() handler
Date: Mon, 16 Mar 2020 01:11:03 +0100
Message-Id: <20200316001111.31004-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Comment we added input validation (rth)
---
 hw/core/qdev-properties.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 59380ed761..48e4c98cf0 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "net/net.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
@@ -532,7 +533,8 @@ static void set_mac(Object *obj, Visitor *v, const char=
 *name, void *opaque,
     MACAddr *mac =3D qdev_get_prop_ptr(dev, prop);
     Error *local_err =3D NULL;
     int i, pos;
-    char *str, *p;
+    char *str;
+    const char *p;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -546,6 +548,8 @@ static void set_mac(Object *obj, Visitor *v, const char=
 *name, void *opaque,
     }
=20
     for (i =3D 0, pos =3D 0; i < 6; i++, pos +=3D 3) {
+        long val;
+
         if (!qemu_isxdigit(str[pos])) {
             goto inval;
         }
@@ -561,7 +565,10 @@ static void set_mac(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
                 goto inval;
             }
         }
-        mac->a[i] =3D strtol(str+pos, &p, 16);
+        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
+            goto inval;
+        }
+        mac->a[i] =3D val;
     }
     g_free(str);
     return;
--=20
2.21.1


