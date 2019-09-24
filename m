Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF2C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD37F207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD37F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm8u-0001Eq-VB
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks2-0000Gc-Kx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkry-0001V8-It
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrx-0001UL-VY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC0B31918649;
 Tue, 24 Sep 2019 13:28:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 376985D9CA;
 Tue, 24 Sep 2019 13:28:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B54D91136425; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/25] qapi: Improve source file read error handling
Date: Tue, 24 Sep 2019 15:28:30 +0200
Message-Id: <20190924132830.15835-26-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 24 Sep 2019 13:28:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qap-gen.py crashes when it can't open the main schema file, and when
it can't read from any schema file.  Lazy.

Change QAPISchema.__init__() to take a file name instead of a file
object.  Move the open code from _include() to __init__(), so it's
used for the main schema file, too.

Move the read into the try for good measure, and rephrase the error
message.

Reporting open or read failure for the main schema file needs a
QAPISourceInfo representing "no source".  Make QAPISourceInfo cope
with fname=3DNone.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                | 46 +++++++++++++++------------
 tests/qapi-schema/include-no-file.err |  2 +-
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c38e7cf27d..0c169a640e 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -53,7 +53,12 @@ class QAPISourceInfo(object):
         return info
=20
     def loc(self):
-        return '%s:%d' % (self.fname, self.line)
+        if self.fname is None:
+            return sys.argv[0]
+        ret =3D self.fname
+        if self.line is not None:
+            ret +=3D ':%d' % self.line
+        return ret
=20
     def in_defn(self):
         if self.defn_name:
@@ -382,14 +387,26 @@ class QAPIDoc(object):
=20
 class QAPISchemaParser(object):
=20
-    def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
-        self.fname =3D fp.name
-        previously_included.append(os.path.abspath(fp.name))
-        self.src =3D fp.read()
+    def __init__(self, fname, previously_included=3D[], incl_info=3DNone=
):
+        previously_included.append(os.path.abspath(fname))
+
+        try:
+            if sys.version_info[0] >=3D 3:
+                fp =3D open(fname, 'r', encoding=3D'utf-8')
+            else:
+                fp =3D open(fname, 'r')
+            self.src =3D fp.read()
+        except IOError as e:
+            raise QAPISemError(incl_info or QAPISourceInfo(None, None, N=
one),
+                               "can't read %s file '%s': %s"
+                               % ("include" if incl_info else "schema",
+                                  fname,
+                                  e.strerror))
+
         if self.src =3D=3D '' or self.src[-1] !=3D '\n':
             self.src +=3D '\n'
         self.cursor =3D 0
-        self.info =3D QAPISourceInfo(self.fname, 1, incl_info)
+        self.info =3D QAPISourceInfo(fname, 1, incl_info)
         self.line_pos =3D 0
         self.exprs =3D []
         self.docs =3D []
@@ -413,7 +430,7 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "value of 'include' must be a str=
ing")
-                incl_fname =3D os.path.join(os.path.dirname(self.fname),
+                incl_fname =3D os.path.join(os.path.dirname(fname),
                                           include)
                 self.exprs.append({'expr': {'include': incl_fname},
                                    'info': info})
@@ -465,14 +482,7 @@ class QAPISchemaParser(object):
         if incl_abs_fname in previously_included:
             return None
=20
-        try:
-            if sys.version_info[0] >=3D 3:
-                fobj =3D open(incl_fname, 'r', encoding=3D'utf-8')
-            else:
-                fobj =3D open(incl_fname, 'r')
-        except IOError as e:
-            raise QAPISemError(info, "%s: %s" % (e.strerror, incl_fname)=
)
-        return QAPISchemaParser(fobj, previously_included, info)
+        return QAPISchemaParser(incl_fname, previously_included, info)
=20
     def _pragma(self, name, value, info):
         global doc_required, returns_whitelist, name_case_whitelist
@@ -1723,11 +1733,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
 class QAPISchema(object):
     def __init__(self, fname):
         self.fname =3D fname
-        if sys.version_info[0] >=3D 3:
-            f =3D open(fname, 'r', encoding=3D'utf-8')
-        else:
-            f =3D open(fname, 'r')
-        parser =3D QAPISchemaParser(f)
+        parser =3D QAPISchemaParser(fname)
         exprs =3D check_exprs(parser.exprs)
         self.docs =3D parser.docs
         self._entity_list =3D []
diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/in=
clude-no-file.err
index e42bcf4bc1..0a6c6bb4a9 100644
--- a/tests/qapi-schema/include-no-file.err
+++ b/tests/qapi-schema/include-no-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-no-file.json:1: No such file or directory: tes=
ts/qapi-schema/include-no-file-sub.json
+tests/qapi-schema/include-no-file.json:1: can't read include file 'tests=
/qapi-schema/include-no-file-sub.json': No such file or directory
--=20
2.21.0


