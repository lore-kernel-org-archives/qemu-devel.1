Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB224C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF9122CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF9122CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34cl-0000bb-1D
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i34Wk-0003cm-IW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i34Wj-0002mJ-20
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i34Wi-0002l8-Mi
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41BDD4E93D;
 Wed, 28 Aug 2019 20:26:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DAE8196B2;
 Wed, 28 Aug 2019 20:26:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 776BB1165612; Wed, 28 Aug 2019 22:26:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 22:26:36 +0200
Message-Id: <20190828202641.24752-5-armbru@redhat.com>
In-Reply-To: <20190828202641.24752-1-armbru@redhat.com>
References: <20190828202641.24752-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 28 Aug 2019 20:26:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/9] qapi: Outlaw control characters in strings
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

RFC 8259 on string contents:

   All Unicode characters may be placed within the quotation marks,
   except for the characters that MUST be escaped: quotation mark,
   reverse solidus, and the control characters (U+0000 through
   U+001F).

The QAPI schema parser accepts both less and more than JSON: it
accepts only ASCII (less), and accepts control characters other than
LF (new line) unescaped.

Make it accept strictly less: require control characters to be
escaped.  All of them, even DEL, because treating DEL different than
other control characters feels wrong.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/string-control.json | 2 ++
 scripts/qapi/common.py                | 3 +++
 tests/Makefile.include                | 1 +
 tests/qapi-schema/string-control.err  | 1 +
 tests/qapi-schema/string-control.exit | 1 +
 tests/qapi-schema/string-control.out  | 0
 6 files changed, 8 insertions(+)
 create mode 100644 tests/qapi-schema/string-control.json
 create mode 100644 tests/qapi-schema/string-control.err
 create mode 100644 tests/qapi-schema/string-control.exit
 create mode 100644 tests/qapi-schema/string-control.out

diff --git a/tests/qapi-schema/string-control.json b/tests/qapi-schema/st=
ring-control.json
new file mode 100644
index 0000000000..a14be4659a
--- /dev/null
+++ b/tests/qapi-schema/string-control.json
@@ -0,0 +1,2 @@
+# control characters in strings
+{ 'command': '=7F=0C' }
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c54c148263..d8c47ac2ac 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -564,6 +564,9 @@ class QAPISchemaParser(object):
                     elif ch =3D=3D "'":
                         self.val =3D string
                         return
+                    elif ord(ch) < 32 or ch =3D=3D '\x7f':
+                        raise QAPIParseError(self,
+                                             'Control character in strin=
g')
                     else:
                         string +=3D ch
             elif self.src.startswith('true', self.pos):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49684fd4f4..543bac6f93 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -452,6 +452,7 @@ qapi-schema +=3D returns-array-bad.json
 qapi-schema +=3D returns-dict.json
 qapi-schema +=3D returns-unknown.json
 qapi-schema +=3D returns-whitelist.json
+qapi-schema +=3D string-control.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
diff --git a/tests/qapi-schema/string-control.err b/tests/qapi-schema/str=
ing-control.err
new file mode 100644
index 0000000000..30a9d57d57
--- /dev/null
+++ b/tests/qapi-schema/string-control.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-control.json:2:14: Control character in string
diff --git a/tests/qapi-schema/string-control.exit b/tests/qapi-schema/st=
ring-control.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/string-control.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/string-control.out b/tests/qapi-schema/str=
ing-control.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.21.0


