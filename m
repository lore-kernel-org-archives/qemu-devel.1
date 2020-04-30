Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3FDC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426F02082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJM3JfdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426F02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1sX-0008Fo-DO
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n4-00052L-Tp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n0-0002eb-BR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1my-0002cy-W3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KD90dyIMpy9OaK0yZDfAdkS9ulbqfJFdljZihL68srM=;
 b=SJM3JfdPOn2gjgNoyhSrPrQCJVOCoRBdoBbeWOCCSlTMibd2rMc33HwobpLJGgobBWzUxV
 4Huk65SDYfB+SMHKouF/DBIAACOvQ/JyD8oAFxX9GIeve7vt96Wzal/Re7MtmioQjyPfGi
 PxODLCm4QCWiWMEli8ggfZa6urw7YVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-uxjhuYEbNBSX58WPvsC1xw-1; Thu, 30 Apr 2020 01:31:09 -0400
X-MC-Unique: uxjhuYEbNBSX58WPvsC1xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28CC38014D9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED96B5C1D0;
 Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3E9111358C7; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] qapi: Assert incomplete object occurs only in dealloc
 visitor
Date: Thu, 30 Apr 2020 07:30:55 +0200
Message-Id: <20200430053104.32204-12-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200424084338.26803-7-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 2 ++
 include/qapi/visitor.h       | 5 +++++
 qapi/qapi-visit-core.c       | 5 +++++
 scripts/qapi/visit.py        | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 1967adfa92..c6dd1891c3 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1446,6 +1446,8 @@ Example:
             goto out;
         }
         if (!*obj) {
+            /* incomplete */
+            assert(visit_is_dealloc(v));
             goto out_obj;
         }
         visit_type_UserDefOne_members(v, *obj, &err);
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


