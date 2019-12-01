Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0DBC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35FB20833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/oTHgBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35FB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNbr-00031B-8M
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGw-0003w3-VH
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNGu-0002J3-S8
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:20:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNGs-0002Ho-S7
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0468PUF7tkGjn96jhD5CFLL/A1QwCQJIwdkQ4/TYVww=;
 b=f/oTHgBofl+Bc82rGBIQqwZHcpMKjw5EF0DV+NlTvuq8Vdsl3/qYdLrBtC0dHOpncqSjKW
 FOQ/eAcCslWuDjtzweYJuKS17RCRPunFZox2hLFN0SXDb2qpUVcUhlYWqXNLopUSYfgajU
 xurnbc/8YiYoSbehk22pnFT97eodhsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-1_y1pa0SOYucZhp59aQw1A-1; Sun, 01 Dec 2019 06:20:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E52980183C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:20:05 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67D0D19C58;
 Sun,  1 Dec 2019 11:20:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/26] qdev: use object_property_help()
Date: Sun,  1 Dec 2019 15:15:31 +0400
Message-Id: <20191201111531.1136947-27-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1_y1pa0SOYucZhp59aQw1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
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
index e6b112eb0a..5a09031e53 100644
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
2.24.0


