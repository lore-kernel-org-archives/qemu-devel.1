Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E7B206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcz/SQVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E7B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpNS-0000Fn-76
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMG-00078A-Vx
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMG-0000Oh-5z
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHxVtPOwk8X0Lkxcx8Zs8dDT9uchBKr/fFeliKyqXPo=;
 b=gcz/SQVdRWCXAlRIG/R0Hc5aKXwvDlj7++qMJGMTAARQ4pGbEFmFiy3Cl/SR0/fw6htfxj
 VDQ/ifGsGKXRtqolRwoWAaqQBFQed7pihf6lg7XDWxU49rvd8hFa68CCEUTuEq/dW6uMLJ
 5gRDRlfUgPhqP35b1ti3U1cI47iTjzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-prLSYnmGOhu21cJ0x68CbA-1; Mon, 01 Jun 2020 14:40:21 -0400
X-MC-Unique: prLSYnmGOhu21cJ0x68CbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3928B835B42;
 Mon,  1 Jun 2020 18:40:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E7610016DA;
 Mon,  1 Jun 2020 18:40:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] hmp: Simplify qom-set
Date: Mon,  1 Jun 2020 19:39:56 +0100
Message-Id: <20200601184004.272784-5-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 11:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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

Simplify qom_set by making it use qmp_qom_set and the JSON parser.

(qemu) qom-get /machine smm
"auto"
(qemu) qom-set /machine smm "auto"

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200520151108.160598-3-dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  With 's'->'S' type change suggested by Paolo and Markus
---
 hmp-commands.hx    |  2 +-
 qom/qom-hmp-cmds.c | 16 +++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 250ddae54d..28256209b5 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1806,7 +1806,7 @@ ERST
 
     {
         .name       = "qom-set",
-        .args_type  = "path:s,property:s,value:s",
+        .args_type  = "path:s,property:s,value:S",
         .params     = "path property value",
         .help       = "set QOM property",
         .cmd        = hmp_qom_set,
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index a8b0a080c7..f704b6949a 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -48,19 +48,13 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
     const char *property = qdict_get_str(qdict, "property");
     const char *value = qdict_get_str(qdict, "value");
     Error *err = NULL;
-    bool ambiguous = false;
-    Object *obj;
+    QObject *obj;
 
-    obj = object_resolve_path(path, &ambiguous);
-    if (obj == NULL) {
-        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
-                  "Device '%s' not found", path);
-    } else {
-        if (ambiguous) {
-            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
-        }
-        object_property_parse(obj, value, property, &err);
+    obj = qobject_from_json(value, &err);
+    if (err == NULL) {
+        qmp_qom_set(path, property, obj, &err);
     }
+
     hmp_handle_error(mon, err);
 }
 
-- 
2.26.2


