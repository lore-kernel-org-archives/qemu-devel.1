Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8406FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9222072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hredRZhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9222072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIRU-0003gY-HA
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jiIQc-0003FX-RD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:07:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jiIQb-0002pT-8G
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591625223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E73iYbdemzWE1AkNOjHlNMnKmCrTX1tlgwbyjII/ias=;
 b=hredRZhp6gy4oI3fDjDkjt08mLhF661wA/F28iuewCW8hwNKx0yCTe9GXr24aGKrZqb+ui
 UsG8KwLhEisIRjI/PF+TEZdnOq/WiwST54aDqPHrtbue8LZoI4AGJWqeY+7eNgPd+BBY9F
 hgzALoq4l5PvO78LQblsbvXNYpUFXCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Wt7fFKz2O7KEQ-Dz3-euvg-1; Mon, 08 Jun 2020 10:06:57 -0400
X-MC-Unique: Wt7fFKz2O7KEQ-Dz3-euvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8061A1940926
 for <qemu-devel@nongnu.org>; Mon,  8 Jun 2020 14:06:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-136.ams2.redhat.com [10.36.113.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD9F97F4DF;
 Mon,  8 Jun 2020 14:06:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] hmp: Make json format optional for qom-set
Date: Mon,  8 Jun 2020 16:06:50 +0200
Message-Id: <20200608140650.91517-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 7d2ef6dcc1cf ("hmp: Simplify qom-set") switched to the json
parser, making it possible to specify complex types. However, with this
change it is no longer possible to specify proper sizes (e.g., 2G, 128M),
turning the interface harder to use for properties that consume sizes.

Let's switch back to the previous handling and allow to specify passing
json via the "-j" parameter.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

An alternative would be to teach the json parser about sizes. But I am not
completely sure if that is desirable.

I make excessive use of qom-set with size properties in virtio-mem.

---
 hmp-commands.hx    |  7 ++++---
 qom/qom-hmp-cmds.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 28256209b5..b44f220c3e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1806,9 +1806,10 @@ ERST
 
     {
         .name       = "qom-set",
-        .args_type  = "path:s,property:s,value:S",
-        .params     = "path property value",
-        .help       = "set QOM property",
+        .args_type  = "json:-j,path:s,property:s,value:s",
+        .params     = "[-j] path property value",
+        .help       = "set QOM property.\n\t\t\t"
+                      "-j: the property is specified in json format.",
         .cmd        = hmp_qom_set,
         .flags      = "p",
     },
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index f704b6949a..a794e62f0b 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -44,15 +44,27 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
 
 void hmp_qom_set(Monitor *mon, const QDict *qdict)
 {
+    const bool json = qdict_get_try_bool(qdict, "json", false);
     const char *path = qdict_get_str(qdict, "path");
     const char *property = qdict_get_str(qdict, "property");
     const char *value = qdict_get_str(qdict, "value");
     Error *err = NULL;
-    QObject *obj;
 
-    obj = qobject_from_json(value, &err);
-    if (err == NULL) {
-        qmp_qom_set(path, property, obj, &err);
+    if (!json) {
+        Object *obj = object_resolve_path(path, NULL);
+
+        if (!obj) {
+            error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Device '%s' not found", path);
+        } else {
+            object_property_parse(obj, value, property, &err);
+        }
+    } else {
+        QObject *obj = qobject_from_json(value, &err);
+
+        if (!err) {
+            qmp_qom_set(path, property, obj, &err);
+        }
     }
 
     hmp_handle_error(mon, err);
-- 
2.26.2


