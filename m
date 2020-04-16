Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAE6C352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89ECA2223D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNYnYPqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ECA2223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6Y1-0002vF-Jy
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jP6XC-0001hH-JO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jP6X3-0000wW-5w
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:34:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jP6X3-0000vw-2Y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587051264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/e4HZ5FjcATpoVm8EALcBpBG3D1OZisEdd5bGNhT8WM=;
 b=JNYnYPqUclH47xhGwoQKdkWuvWpDGLNXHba+ZqO6KYBVHGHgul7etfClq7HB61CNcY5jeh
 vkY2rUITXnbMigZU6r1ED0tHCAPpwKNoPlnAcbEeTxTeo2XUAHHHvtMwVwFpKd/TtmTQll
 nX4+97xyIFk1mIvNlZagJjbOvPHlOEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-JgHnbMk2O6Ow3DO3K1bsgg-1; Thu, 16 Apr 2020 11:34:22 -0400
X-MC-Unique: JgHnbMk2O6Ow3DO3K1bsgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80FC813FD;
 Thu, 16 Apr 2020 15:34:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-109.ams2.redhat.com
 [10.36.113.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9077B28D02;
 Thu, 16 Apr 2020 15:34:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] qemu-storage-daemon: Fix non-string --object properties
Date: Thu, 16 Apr 2020 17:34:04 +0200
Message-Id: <20200416153404.15389-3-kwolf@redhat.com>
In-Reply-To: <20200416153404.15389-1-kwolf@redhat.com>
References: <20200416153404.15389-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 coiby.xu@gmail.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After processing the option string with the keyval parser, we get a
QDict that contains only strings. This QDict must be fed to a keyval
visitor which converts the strings into the right data types.

qmp_object_add(), however, uses the normal QObject input visitor, which
expects a QDict where all properties already have the QType that matches
the data type required by the QOM object type.

Change the --object implementation in qemu-storage-daemon so that it
doesn't call qmp_object_add(), but calls user_creatable_add_dict()
directly instead and pass it a new keyval boolean that decides which
visitor must be used.

Reported-by: Coiby Xu <coiby.xu@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qom/object_interfaces.h | 6 +++++-
 qemu-storage-daemon.c           | 4 +---
 qom/object_interfaces.c         | 8 ++++++--
 qom/qom-qmp-cmds.c              | 2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interface=
s.h
index a0037968a4..65172120fa 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -90,6 +90,10 @@ Object *user_creatable_add_type(const char *type, const =
char *id,
 /**
  * user_creatable_add_dict:
  * @qdict: the object definition
+ * @keyval: if true, use a keyval visitor for processing @qdict (i.e.
+ *          assume that all @qdict values are strings); otherwise, use
+ *          the normal QObject visitor (i.e. assume all @qdict values
+ *          have the QType expected by the QOM object type)
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Create an instance of the user creatable object that is defined by
@@ -97,7 +101,7 @@ Object *user_creatable_add_type(const char *type, const =
char *id,
  * ID from the key 'id'. The remaining entries in @qdict are used to
  * initialize the object properties.
  */
-void user_creatable_add_dict(QDict *qdict, Error **errp);
+void user_creatable_add_dict(QDict *qdict, bool keyval, Error **errp);
=20
 /**
  * user_creatable_add_opts:
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index dd128978cc..9e7adfe3a6 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -278,7 +278,6 @@ static void process_options(int argc, char *argv[])
                 QemuOpts *opts;
                 const char *type;
                 QDict *args;
-                QObject *ret_data =3D NULL;
=20
                 /* FIXME The keyval parser rejects 'help' arguments, so we=
 must
                  * unconditionall try QemuOpts first. */
@@ -291,9 +290,8 @@ static void process_options(int argc, char *argv[])
                 qemu_opts_del(opts);
=20
                 args =3D keyval_parse(optarg, "qom-type", &error_fatal);
-                qmp_object_add(args, &ret_data, &error_fatal);
+                user_creatable_add_dict(args, true, &error_fatal);
                 qobject_unref(args);
-                qobject_unref(ret_data);
                 break;
             }
         default:
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 739e3e5172..bc36f96e47 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -106,7 +106,7 @@ out:
     return obj;
 }
=20
-void user_creatable_add_dict(QDict *qdict, Error **errp)
+void user_creatable_add_dict(QDict *qdict, bool keyval, Error **errp)
 {
     Visitor *v;
     Object *obj;
@@ -127,7 +127,11 @@ void user_creatable_add_dict(QDict *qdict, Error **err=
p)
     }
     qdict_del(qdict, "id");
=20
-    v =3D qobject_input_visitor_new(QOBJECT(qdict));
+    if (keyval) {
+        v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    } else {
+        v =3D qobject_input_visitor_new(QOBJECT(qdict));
+    }
     obj =3D user_creatable_add_type(type, id, qdict, v, errp);
     visit_free(v);
     object_unref(obj);
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 35db44b50e..c5249e44d0 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -263,7 +263,7 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, E=
rror **errp)
         qobject_unref(pdict);
     }
=20
-    user_creatable_add_dict(qdict, errp);
+    user_creatable_add_dict(qdict, false, errp);
 }
=20
 void qmp_object_del(const char *id, Error **errp)
--=20
2.20.1


