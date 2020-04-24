Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA3C55194
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C5A20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTERLUlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C5A20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRu8N-0000MT-3r
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw6-0005lC-3l
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw3-0002FX-N5
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtw3-0002CV-6y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZGh1VRdSb0WLd0ve8k2eIZ69HGOaNSTJcy03Z6W6YM=;
 b=ZTERLUlJe+ViN/ifJA/lYqz/NogJDxh1dalhl8tx3Jp+O8dejLT7tkxK9a9Rd6B6UbFWWB
 Xv2pVqveRAxgkIT8KwuABfLfJrXHq41YylGmLFlX7suThwUolN35MQfN2eMt6arNB8kHhe
 1UYDLWVxj/9ZZKS3QRAAgZfeH2+M+zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-V38DvYHtNKK42K9lQv_vUw-1; Fri, 24 Apr 2020 04:43:44 -0400
X-MC-Unique: V38DvYHtNKK42K9lQv_vUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A41107ACF2;
 Fri, 24 Apr 2020 08:43:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65FC86084A;
 Fri, 24 Apr 2020 08:43:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B38C11358CC; Fri, 24 Apr 2020 10:43:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/15] qapi: Generate simpler marshalling code when no
 arguments
Date: Fri, 24 Apr 2020 10:43:38 +0200
Message-Id: <20200424084338.26803-16-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
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

When command FOO has no arguments, its generated qmp_marshal_FOO() is
a bit confusing.  Make it simpler:

     visit_start_struct(v, NULL, NULL, 0, &err);
     if (err) {
         goto out;
     }
-
-    if (!err) {
-        visit_check_struct(v, &err);
-    }
+    visit_check_struct(v, &err);
     visit_end_struct(v, NULL);
     if (err) {
         goto out;
     }

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index f545903567..6809b0fb6e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -115,14 +115,10 @@ def gen_marshal(name, arg_type, boxed, ret_type):
                      c_type=3Dret_type.c_type())
=20
     if have_args:
-        visit_members =3D ('visit_type_%s_members(v, &arg, &err);'
-                         % arg_type.c_name())
         ret +=3D mcgen('''
     %(c_name)s arg =3D {0};
 ''',
                      c_name=3Darg_type.c_name())
-    else:
-        visit_members =3D ''
=20
     ret +=3D mcgen('''
=20
@@ -131,16 +127,27 @@ def gen_marshal(name, arg_type, boxed, ret_type):
     if (err) {
         goto out;
     }
-    %(visit_members)s
+''')
+
+    if have_args:
+        ret +=3D mcgen('''
+    visit_type_%(c_arg_type)s_members(v, &arg, &err);
     if (!err) {
         visit_check_struct(v, &err);
     }
+''',
+                     c_arg_type=3Darg_type.c_name())
+    else:
+        ret +=3D mcgen('''
+    visit_check_struct(v, &err);
+''')
+
+    ret +=3D mcgen('''
     visit_end_struct(v, NULL);
     if (err) {
         goto out;
     }
-''',
-                 visit_members=3Dvisit_members)
+''')
=20
     ret +=3D gen_call(name, arg_type, boxed, ret_type)
=20
@@ -151,20 +158,21 @@ out:
     visit_free(v);
 ''')
=20
-    if have_args:
-        visit_members =3D ('visit_type_%s_members(v, &arg, NULL);'
-                         % arg_type.c_name())
-    else:
-        visit_members =3D ''
-
     ret +=3D mcgen('''
     v =3D qapi_dealloc_visitor_new();
     visit_start_struct(v, NULL, NULL, 0, NULL);
-    %(visit_members)s
+''')
+
+    if have_args:
+        ret +=3D mcgen('''
+    visit_type_%(c_arg_type)s_members(v, &arg, NULL);
+''',
+                     c_arg_type=3Darg_type.c_name())
+
+    ret +=3D mcgen('''
     visit_end_struct(v, NULL);
     visit_free(v);
-''',
-                 visit_members=3Dvisit_members)
+''')
=20
     ret +=3D mcgen('''
 }
--=20
2.21.1


