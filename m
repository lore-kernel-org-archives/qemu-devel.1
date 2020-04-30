Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929BC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0743E2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAopRQ+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0743E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1wH-0005lo-2r
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n8-00059k-G9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n2-0002fx-Sz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1n0-0002e4-OB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTeYY/2zWkS/LajjUmcOEsOU2wLdljAZWbBCzrdyw1M=;
 b=gAopRQ+2EifQqoO9oJ2veBN/kha2CWR38YPlAIqMTjoRArjM9IikbczeZ9FKtAOMnki9vG
 InQLsOSjAsovyicnkAsEKJTxjwWdjN6ydo1QbPjHHHKgCQN98ZgZZUOz9kTpF1Joi85s1v
 Vf+s5zHmDYNBe8TJCD/cQfGJY+F74ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-oxq5NITFNXSr2EFeIwIRGQ-1; Thu, 30 Apr 2020 01:31:10 -0400
X-MC-Unique: oxq5NITFNXSr2EFeIwIRGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FC128005B7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F87D5D9F1;
 Thu, 30 Apr 2020 05:31:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 195E311358D0; Thu, 30 Apr 2020 07:31:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] qapi: Disallow qmp_marshal_FOO(NULL, ...)
Date: Thu, 30 Apr 2020 07:31:03 +0200
Message-Id: <20200430053104.32204-20-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

For QMP commands without arguments, gen_marshal() laboriously
generates a qmp_marshal_FOO() that copes with null @args.  Turns
there's just one caller that passes null instead of an empty QDict.
Adjust that caller, and simplify gen_marshal().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200424084338.26803-15-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt |  2 +-
 monitor/qmp.c                |  5 ++++-
 scripts/qapi/commands.py     | 26 ++------------------------
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c6dd1891c3..a7794ef658 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1579,8 +1579,8 @@ Example:
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp)
     {
         Error *err =3D NULL;
-        UserDefOne *retval;
         Visitor *v;
+        UserDefOne *retval;
         q_obj_my_command_arg arg =3D {0};
=20
         v =3D qobject_input_visitor_new(QOBJECT(args));
diff --git a/monitor/qmp.c b/monitor/qmp.c
index f89e7daf27..d433ceae5b 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -322,9 +322,12 @@ static QDict *qmp_greeting(MonitorQMP *mon)
 {
     QList *cap_list =3D qlist_new();
     QObject *ver =3D NULL;
+    QDict *args;
     QMPCapability cap;
=20
-    qmp_marshal_query_version(NULL, &ver, NULL);
+    args =3D qdict_new();
+    qmp_marshal_query_version(args, &ver, NULL);
+    qobject_unref(args);
=20
     for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
         if (mon->capab_offered[cap]) {
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index bc30876c88..f545903567 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -104,6 +104,7 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 %(proto)s
 {
     Error *err =3D NULL;
+    Visitor *v;
 ''',
                 proto=3Dbuild_marshal_proto(name))
=20
@@ -117,21 +118,14 @@ def gen_marshal(name, arg_type, boxed, ret_type):
         visit_members =3D ('visit_type_%s_members(v, &arg, &err);'
                          % arg_type.c_name())
         ret +=3D mcgen('''
-    Visitor *v;
     %(c_name)s arg =3D {0};
-
 ''',
                      c_name=3Darg_type.c_name())
     else:
         visit_members =3D ''
-        ret +=3D mcgen('''
-    Visitor *v =3D NULL;
-
-    if (args) {
-''')
-        push_indent()
=20
     ret +=3D mcgen('''
+
     v =3D qobject_input_visitor_new(QOBJECT(args));
     visit_start_struct(v, NULL, NULL, 0, &err);
     if (err) {
@@ -148,12 +142,6 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 ''',
                  visit_members=3Dvisit_members)
=20
-    if not have_args:
-        pop_indent()
-        ret +=3D mcgen('''
-    }
-''')
-
     ret +=3D gen_call(name, arg_type, boxed, ret_type)
=20
     ret +=3D mcgen('''
@@ -168,10 +156,6 @@ out:
                          % arg_type.c_name())
     else:
         visit_members =3D ''
-        ret +=3D mcgen('''
-    if (args) {
-''')
-        push_indent()
=20
     ret +=3D mcgen('''
     v =3D qapi_dealloc_visitor_new();
@@ -182,12 +166,6 @@ out:
 ''',
                  visit_members=3Dvisit_members)
=20
-    if not have_args:
-        pop_indent()
-        ret +=3D mcgen('''
-    }
-''')
-
     ret +=3D mcgen('''
 }
 ''')
--=20
2.21.1


