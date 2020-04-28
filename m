Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1BC206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2BQ+Az7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1BC206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTH8-00013v-9H
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTF6-0006Qu-5Q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBi-0000rI-Mq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:37:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41627
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBi-0000qP-1z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q57vFmnq8vysdyK3hyJSd0l6biSyZOiDdtWz9F5CtFI=;
 b=d2BQ+Az7W9uU0d6U6pG9rZiQYUUM1XHLRYCkzXygymdt4TGK9MCeMx6/lx3cQBjQsPxOpO
 +MYqmZz5E14utSsKn29iAWaGKzf0iCNOa+sUugGe4TkctjqgGFKcRpzc0u5j7h3Sk+NtoH
 jKJ4p65SeQoEMJgU6hrlQWpRN3bCZz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-IL1afLM9NsyAlR9Got2T0A-1; Tue, 28 Apr 2020 12:34:22 -0400
X-MC-Unique: IL1afLM9NsyAlR9Got2T0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78E6189581A
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC225E021;
 Tue, 28 Apr 2020 16:34:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A2BE11358C0; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/17] qom: Change object_property_get_uint16List() to match
 its doc
Date: Tue, 28 Apr 2020 18:34:06 +0200
Message-Id: <20200428163419.4483-5-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h       | 4 ++--
 hw/core/machine-qmp-cmds.c | 6 +++---
 qom/object.c               | 9 +++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ccfa82e33d..5d1ed672c3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1331,8 +1331,8 @@ int object_property_get_enum(Object *obj, const char =
*name,
  * undefined if an error occurs (including when the property value is not
  * an list of integers).
  */
-void object_property_get_uint16List(Object *obj, const char *name,
-                                    uint16List **list, Error **errp);
+uint16List *object_property_get_uint16List(Object *obj, const char *name,
+                                           Error **errp);
=20
 /**
  * object_property_set:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index eed5aeb2f7..f3a28035fc 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -325,9 +325,9 @@ static int query_memdev(Object *obj, void *opaque)
                                                     "policy",
                                                     "HostMemPolicy",
                                                     &error_abort);
-        object_property_get_uint16List(obj, "host-nodes",
-                                       &m->value->host_nodes,
-                                       &error_abort);
+        m->value->host_nodes =3D object_property_get_uint16List(obj,
+                                                              "host-nodes"=
,
+                                                              &error_abort=
);
=20
         m->next =3D *list;
         *list =3D m;
diff --git a/qom/object.c b/qom/object.c
index 9c74749193..ddb021db21 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1559,10 +1559,11 @@ int object_property_get_enum(Object *obj, const cha=
r *name,
     return ret;
 }
=20
-void object_property_get_uint16List(Object *obj, const char *name,
-                                    uint16List **list, Error **errp)
+uint16List *object_property_get_uint16List(Object *obj, const char *name,
+                                           Error **errp)
 {
     Error *err =3D NULL;
+    uint16List *list =3D NULL;
     Visitor *v;
     char *str;
=20
@@ -1575,11 +1576,11 @@ void object_property_get_uint16List(Object *obj, co=
nst char *name,
     visit_complete(v, &str);
     visit_free(v);
     v =3D string_input_visitor_new(str);
-    visit_type_uint16List(v, NULL, list, errp);
-
+    visit_type_uint16List(v, NULL, &list, errp);
     g_free(str);
 out:
     visit_free(v);
+    return list;
 }
=20
 void object_property_parse(Object *obj, const char *string,
--=20
2.21.1


