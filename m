Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6137C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B268420658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+nNIv90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B268420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpQu-0002rs-SA
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKM-0000rs-AR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKK-0006Ql-Ox
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKK-0006QL-KR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOGKKUJyqOA/pIW8E/HPAvIAT7gDZ6EfqKjI6X/TRUQ=;
 b=T+nNIv90V4V3alvUbR6ilmdkwzEB6EBbGlYqvBgyx1p/sbsn7ktpJAkMyqDfyufWppYKhU
 Ps/tz/u1Pnh8zyNK5emQMwDIpsrY6tQvxKy0W0ypQp8OboR9H1X7MoiaUfAHUE7oM4ZqA3
 f0TvIaHbKDohUIY7x9AB2agW7Xtx82U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-ni3qhOLKM12jpa-ykhwkaA-1; Fri, 13 Mar 2020 14:46:15 -0400
X-MC-Unique: ni3qhOLKM12jpa-ykhwkaA-1
Received: by mail-wm1-f72.google.com with SMTP id m4so3788573wmi.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RMwjrcmFmGA/nbjYq8IJWqr4XnFULjCpLFfZjdDbCRU=;
 b=YVBcqVG85e5MTlT72XD9c3dDGVfrPqTOgpj2fo6gX4TDvjY3RWKhXrOdPGjrqg2qss
 Ayu4CdX8PnAMaHCyjQ2EXGTGbQZaNexFTWXxxX8MORLjPOPBrv6shppBcZ/OwXxetq8S
 1VHlWI17tnsXmPitniesrbEUsNm03xfwzlKN0UMBSJdkrAgGlFrDmVW4ijnGkLMMKnst
 o8aT4nKUsSdLvppF7FEaNgE5Ik+h7l8y/ZGYQzG/UUNFvmAwG8znkHF0hOAZ8JLblqv2
 w9+fzLwIMPWJspQvZ5c7qe8v3VNfE9FqHLc5XRu2arq2wI+5GGHGgGwN+W8EM18gESlT
 XgNg==
X-Gm-Message-State: ANhLgQ0q45oYN+9za2J2lQ4TTZJJauVwCHSCKAdBMYHWKs7ipwCYdmkh
 8y8hGHk3L4UwQSC5hNd+VrilPuJ9jqhP1hmhq4EWD1ZBzcSlgtRM3MiJXJqsVJNv9w3yDbUUmpB
 KUa5Slbcyiz7Y49E=
X-Received: by 2002:a7b:c414:: with SMTP id k20mr12067212wmi.119.1584125174104; 
 Fri, 13 Mar 2020 11:46:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvqpAcuPSWbRcUFtvp6Zt4aRo0F64FIoda8WhgFUAYponvPcZhqmDwX64iSp2seewruU5d+/w==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr12067198wmi.119.1584125173898; 
 Fri, 13 Mar 2020 11:46:13 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s22sm16745849wmc.16.2020.03.13.11.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] hw/core/qdev-properties: Use qemu_strtol() in set_mac()
 handler
Date: Fri, 13 Mar 2020 19:45:59 +0100
Message-Id: <20200313184607.11792-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace strtol() by qemu_strtol() so checkpatch.pl won't complain
if we move this code later.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


