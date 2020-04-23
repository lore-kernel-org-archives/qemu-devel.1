Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FCC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B136520728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjulT+HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B136520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReMy-0005WI-JS
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHn-000650-Hh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHT-000269-IP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jReHS-000204-1z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+38xZMcsmrlkiHJa+s7iGaz9zjdOxAOUCjVLXhzS9k=;
 b=SjulT+HTvZn/WqJHXuFnPWO7WCz9WNjZGqGWMwCK68OnYtlg6GHa0WlV956tDLw2GEYtiE
 p/j74QqsjUS2lJvfM2ZabZzHOWWCCUo6tupfkPCgQjZugU00aCkDcinxBiZ6aIg85xVjEL
 Ju9UZvUWOugB/EdPuz1ofO19A0NTdPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-x1k_HhMjMV6G8YhMD5rScA-1; Thu, 23 Apr 2020 12:00:40 -0400
X-MC-Unique: x1k_HhMjMV6G8YhMD5rScA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B070E106B245;
 Thu, 23 Apr 2020 16:00:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7964A60635;
 Thu, 23 Apr 2020 16:00:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6711811358C2; Thu, 23 Apr 2020 18:00:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/13] qapi: Assert incomplete object occurs only in dealloc
 visitor
Date: Thu, 23 Apr 2020 18:00:29 +0200
Message-Id: <20200423160036.7048-7-armbru@redhat.com>
In-Reply-To: <20200423160036.7048-1-armbru@redhat.com>
References: <20200423160036.7048-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/visitor.h | 5 +++++
 qapi/qapi-visit-core.c | 5 +++++
 scripts/qapi/visit.py  | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index a425ea514c..2d40d2fe0f 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -479,6 +479,11 @@ void visit_type_enum(Visitor *v, const char *name, int=
 *obj,
  */
 bool visit_is_input(Visitor *v);
=20
+/*
+ * Check if visitor is a dealloc visitor.
+ */
+bool visit_is_dealloc(Visitor *v);
+
 /*** Visiting built-in types ***/
=20
 /*
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 5365561b07..d4aac206cf 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -142,6 +142,11 @@ bool visit_is_input(Visitor *v)
     return v->type =3D=3D VISITOR_INPUT;
 }
=20
+bool visit_is_dealloc(Visitor *v)
+{
+    return v->type =3D=3D VISITOR_DEALLOC;
+}
+
 void visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **er=
rp)
 {
     assert(obj);
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 23d9194aa4..e3467b770b 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -189,6 +189,8 @@ void visit_type_%(c_name)s(Visitor *v, const char *name=
, %(c_name)s **obj, Error
         goto out;
     }
     if (!*obj) {
+        /* incomplete */
+        assert(visit_is_dealloc(v));
         goto out_obj;
     }
     switch ((*obj)->type) {
@@ -260,6 +262,8 @@ void visit_type_%(c_name)s(Visitor *v, const char *name=
, %(c_name)s **obj, Error
         goto out;
     }
     if (!*obj) {
+        /* incomplete */
+        assert(visit_is_dealloc(v));
         goto out_obj;
     }
     visit_type_%(c_name)s_members(v, *obj, &err);
--=20
2.21.1


