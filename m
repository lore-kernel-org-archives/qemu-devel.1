Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F556208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoWUQVAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F556208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlczK-0007tm-An
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwg-0003Vk-5I
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwe-000898-ES
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgBUu7f9j9KFwMQkF7KC5sDJH2HYE9E300NSJ5oiq0o=;
 b=BoWUQVAPdZ4Bb3kgmk5fOloVJ4ki+s3DJqzNFgMzexASDvm/suR9k8+9OYdioqIkKgszAj
 4tkb/VXpM1u2C4YVmegYK7AnQPeIkrgpUbtyalFPxx5s/AHHoTOK2RPpgZLzCXKfMVFbvB
 6oc0sBSZNOfQAV1PXpz5z4Mbnm2IokQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-1Yx84jjRMcmLazj3N1FWhw-1; Wed, 17 Jun 2020 14:37:50 -0400
X-MC-Unique: 1Yx84jjRMcmLazj3N1FWhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3C80107ACF3;
 Wed, 17 Jun 2020 18:37:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A2825EE0E;
 Wed, 17 Jun 2020 18:37:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 03/12] hmp: Make json format optional for qom-set
Date: Wed, 17 Jun 2020 19:37:24 +0100
Message-Id: <20200617183733.186168-4-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20200610075153.33892-1-david@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx    |  7 ++++---
 qom/qom-hmp-cmds.c | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 28256209b5..60f395c276 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1806,9 +1806,10 @@ ERST
 
     {
         .name       = "qom-set",
-        .args_type  = "path:s,property:s,value:S",
-        .params     = "path property value",
-        .help       = "set QOM property",
+        .args_type  = "json:-j,path:s,property:s,value:S",
+        .params     = "[-j] path property value",
+        .help       = "set QOM property.\n\t\t\t"
+                      "-j: the value is specified in json format.",
         .cmd        = hmp_qom_set,
         .flags      = "p",
     },
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 158e2d7409..b0abe84cb1 100644
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


