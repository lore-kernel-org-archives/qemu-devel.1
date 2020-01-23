Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC56DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771E320704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+Y7okPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771E320704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug50-0002rs-VI
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuf-0001oe-BT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucue-0001R0-8r
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucud-0001Qd-W4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIJKW7r6m3lfEsrrQFwr4hlFi3X2sjt8/eoVtOOO/2M=;
 b=c+Y7okPdE25gXeYvJdk/Em0B0Sfn3SbzLQc5LDeH/BxWlX0OeFlj+9kEwJIVob0Se2DWkO
 Mzl/yEwPzJIaPNL8H7JCA5NR9ki6/xRnE4+L6vVLO65p4s5GNArYpGQkSvjSZwkyTeqaxu
 jvFLTRTmzXTpcL1+/Z3IMjjg4qp0+io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-JvTf-q1pOWO2_vnm09GUrQ-1; Thu, 23 Jan 2020 08:52:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3159199116
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:45 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FE871CB;
 Thu, 23 Jan 2020 13:52:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/59] qdev: use object_property_help()
Date: Thu, 23 Jan 2020 14:50:46 +0100
Message-Id: <1579787449-27599-57-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JvTf-q1pOWO2_vnm09GUrQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Use the common function introduced earlier, and report default value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-27-marcandre.lureau@redhat.com>
[Sort the properties, following what is done for -object ...,help. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qdev-monitor.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index c929262..8ce71a2 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -37,6 +37,7 @@
 #include "sysemu/sysemu.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
+#include "qemu/cutils.h"
=20
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -256,6 +257,8 @@ int qdev_device_help(QemuOpts *opts)
     const char *driver;
     ObjectPropertyInfoList *prop_list;
     ObjectPropertyInfoList *prop;
+    GPtrArray *array;
+    int i;
=20
     driver =3D qemu_opt_get(opts, "driver");
     if (driver && is_help_option(driver)) {
@@ -285,19 +288,20 @@ int qdev_device_help(QemuOpts *opts)
     } else {
         qemu_printf("There are no options for %s.\n", driver);
     }
+    array =3D g_ptr_array_new();
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
-    }
-
+        g_ptr_array_add(array,
+                        object_property_help(prop->value->name,
+                                             prop->value->type,
+                                             prop->value->default_value,
+                                             prop->value->description));
+    }
+    g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
+    for (i =3D 0; i < array->len; i++) {
+        printf("%s\n", (char *)array->pdata[i]);
+    }
+    g_ptr_array_set_free_func(array, g_free);
+    g_ptr_array_free(array, true);
     qapi_free_ObjectPropertyInfoList(prop_list);
     return 1;
=20
--=20
1.8.3.1



