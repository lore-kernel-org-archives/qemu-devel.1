Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBABC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17ABD2080D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2AJ3lWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ABD2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwgc-0006qc-8c
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwKM-0003ZS-DW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwKL-0001hK-EN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwKL-0001fX-AJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmE0fiHTjIoEI6lwpSgMBvCV5rm6OSSW8lc15jyXCUE=;
 b=g2AJ3lWNdyE+7yUh6DYKJSg6vFpotMcGx6YH3x3doXMm3cO1yNVatiHREo7mafy/VIG53M
 LgtqpFo8BsVczstUtXd9FBcsN5jCo5iGnfL7PUQLc4lFCAV8kXEhoLZQcX5SlsPrFUimx7
 nxLBusU03aewgOjUBNb0df9JikSUkB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-l_KfNcYmP2SAsV237nK_sA-1; Fri, 10 Jan 2020 10:35:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF1B8024CD
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:35:54 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D30E272B4;
 Fri, 10 Jan 2020 15:35:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/26] qdev: use object_property_help()
Date: Fri, 10 Jan 2020 19:30:39 +0400
Message-Id: <20200110153039.1379601-27-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: l_KfNcYmP2SAsV237nK_sA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the common function introduced earlier, and report default value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qdev-monitor.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 3465a1e2d0..0f83770e02 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -286,16 +286,11 @@ int qdev_device_help(QemuOpts *opts)
         qemu_printf("There are no options for %s.\n", driver);
     }
     for (prop =3D prop_list; prop; prop =3D prop->next) {
-        int len;
-        qemu_printf("  %s=3D<%s>%n", prop->value->name, prop->value->type,=
 &len);
-        if (prop->value->has_description) {
-            if (len < 24) {
-                qemu_printf("%*s", 24 - len, "");
-            }
-            qemu_printf(" - %s\n", prop->value->description);
-        } else {
-            qemu_printf("\n");
-        }
+        g_autofree char *help =3D object_property_help(prop->value->name,
+                                                     prop->value->type,
+                                                     prop->value->default_=
value,
+                                                     prop->value->descript=
ion);
+        qemu_printf("%s\n", help);
     }
=20
     qapi_free_ObjectPropertyInfoList(prop_list);
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


