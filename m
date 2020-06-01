Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB72C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA1E206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTVqjw6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA1E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpQb-0006H1-QS
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMF-00076s-F9
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpME-0000Ns-Hs
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/o/THtE2RSubpyEUWJCf9lM0CuaOSo99HdMiFgkh+A=;
 b=PTVqjw6hlaD5Q8Ksg9QRc41eEKRwRN0+oI8Hm8x14MAVNRh8l9sltnHOQHqOmXapARsrez
 uwYkP5hH32ZShm+QPzoJhxV8ILrOXMhfwWx57HyvNmerQ2Fe2uxMq+bA73GM5wgqbXmkuM
 aUq4/mkayx7fkmLAi84YbXJmzM3wUWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-31sHn1kzNt-HmwhZX5IOdQ-1; Mon, 01 Jun 2020 14:40:19 -0400
X-MC-Unique: 31sHn1kzNt-HmwhZX5IOdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67718461;
 Mon,  1 Jun 2020 18:40:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1B121002383;
 Mon,  1 Jun 2020 18:40:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] hmp: Implement qom-get HMP command
Date: Mon,  1 Jun 2020 19:39:55 +0100
Message-Id: <20200601184004.272784-4-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 13:44:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This started off as Andreas Färber's implementation from
March 2015, but after feedback from Paolo and Markus it morphed into
using the json output which handles structs reasonably.

Use with qom-list to find the members of an object.

(qemu) qom-get /backend/console[0]/device/vga.rom[0] size
65536
(qemu) qom-get /machine smm
"auto"
(qemu) qom-get /machine rtc-time
{
    "tm_year": 120,
    "tm_sec": 51,
    "tm_hour": 9,
    "tm_min": 50,
    "tm_mon": 4,
    "tm_mday": 20
}
(qemu) qom-get /machine frob
Error: Property '.frob' not found

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200520151108.160598-2-dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx        | 14 ++++++++++++++
 include/monitor/hmp.h  |  1 +
 qom/qom-hmp-cmds.c     | 18 ++++++++++++++++++
 tests/qtest/test-hmp.c |  1 +
 4 files changed, 34 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f0f3974ad..250ddae54d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1790,6 +1790,20 @@ SRST
   Print QOM properties of object at location *path*
 ERST
 
+    {
+        .name       = "qom-get",
+        .args_type  = "path:s,property:s",
+        .params     = "path property",
+        .help       = "print QOM property",
+        .cmd        = hmp_qom_get,
+        .flags      = "p",
+    },
+
+SRST
+``qom-get`` *path* *property*
+  Print QOM property *property* of object at location *path*
+ERST
+
     {
         .name       = "qom-set",
         .args_type  = "path:s,property:s,value:s",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e33ca5a911..c986cfd28b 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -96,6 +96,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict);
 void hmp_info_numa(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
 void hmp_qom_list(Monitor *mon, const QDict *qdict);
+void hmp_qom_get(Monitor *mon, const QDict *qdict);
 void hmp_qom_set(Monitor *mon, const QDict *qdict);
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index cd08233a4c..a8b0a080c7 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -12,6 +12,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
 #include "qom/object.h"
 
 void hmp_qom_list(Monitor *mon, const QDict *qdict)
@@ -62,6 +64,22 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
+void hmp_qom_get(Monitor *mon, const QDict *qdict)
+{
+    const char *path = qdict_get_str(qdict, "path");
+    const char *property = qdict_get_str(qdict, "property");
+    Error *err = NULL;
+    QObject *obj = qmp_qom_get(path, property, &err);
+
+    if (err == NULL) {
+        QString *str = qobject_to_json_pretty(obj);
+        monitor_printf(mon, "%s\n", qstring_get_str(str));
+        qobject_unref(str);
+    }
+
+    hmp_handle_error(mon, err);
+}
+
 typedef struct QOMCompositionState {
     Monitor *mon;
     int indent;
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index f8aa5f92c5..b8b1271b9e 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -61,6 +61,7 @@ static const char *hmp_cmds[] = {
     "p $pc + 8",
     "qom-list /",
     "qom-set /machine initrd test",
+    "qom-get /machine initrd",
     "screendump /dev/null",
     "sendkey x",
     "singlestep on",
-- 
2.26.2


