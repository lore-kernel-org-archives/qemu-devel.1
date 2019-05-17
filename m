Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CB1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B58620578
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXa0-0004PV-GE
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:47:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXXz-0002uk-BA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXXy-0002NU-H7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRXXy-0002My-Bq
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B502FD4015
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 07:44:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6906217142;
	Fri, 17 May 2019 07:44:52 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 09:45:16 +0200
Message-Id: <1558079119-320634-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 17 May 2019 07:44:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/6] qmp: qmp_qom_list_properties(): ignore
 empty string options
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current QAPI semantics return empty "" string in case string property
value hasn't been set (i.e. NULL). Do not show initial value in this
case in "qom-list-properties" command output to reduce clutter.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qmp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/qmp.c b/qmp.c
index 8415541..463c7d4 100644
--- a/qmp.c
+++ b/qmp.c
@@ -41,6 +41,7 @@
 #include "qom/object_interfaces.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "qapi/qmp/qstring.h"
 
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -596,7 +597,16 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         if (obj) {
             info->q_default =
                 object_property_get_qobject(obj, info->name, NULL);
-            info->has_q_default = !!info->q_default;
+            if (info->q_default) {
+               if (qobject_type(info->q_default) == QTYPE_QSTRING) {
+                   QString *value = qobject_to(QString, info->q_default);
+                   if (!strcmp(qstring_get_str(value), "")) {
+                       qobject_unref(info->q_default);
+                       info->q_default = NULL;
+                   }
+               }
+               info->has_q_default = !!info->q_default;
+            }
         }
 
         entry = g_malloc0(sizeof(*entry));
-- 
2.7.4


