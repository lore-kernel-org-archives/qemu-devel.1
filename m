Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99056C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7223A20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7223A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zri-0001hN-Bg
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmO-0004kJ-Ig
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmM-0007hw-LE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmM-0007hU-Du
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAA58309BF1C;
 Tue, 10 Sep 2019 06:37:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C4405C226;
 Tue, 10 Sep 2019 06:37:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3418611655F4; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:14 +0200
Message-Id: <20190910063724.28470-7-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 10 Sep 2019 06:37:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/16] qapi: Restrict strings to printable
 ASCII
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

RFC 8259 on string contents:

   All Unicode characters may be placed within the quotation marks,
   except for the characters that MUST be escaped: quotation mark,
   reverse solidus, and the control characters (U+0000 through
   U+001F).

The QAPI schema parser accepts both less and more than JSON: it
accepts only ASCII with \u (less), and accepts control characters
other than LF (new line) unescaped.  How it treats unescaped non-ASCII
input differs between Python 2 and Python 3.

Make it accept strictly less: require printable ASCII.  Drop support
for \b, \f, \n, \r, \t.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 25 ++++++-------------
 tests/Makefile.include                        |  3 ++-
 tests/qapi-schema/string-code-point-127.err   |  1 +
 ...de-str.exit =3D> string-code-point-127.exit} |  0
 tests/qapi-schema/string-code-point-127.json  |  2 ++
 ...code-str.out =3D> string-code-point-127.out} |  0
 tests/qapi-schema/string-code-point-31.err    |  1 +
 tests/qapi-schema/string-code-point-31.exit   |  1 +
 tests/qapi-schema/string-code-point-31.json   |  2 ++
 tests/qapi-schema/string-code-point-31.out    |  0
 tests/qapi-schema/unicode-str.err             |  1 -
 tests/qapi-schema/unicode-str.json            |  2 --
 12 files changed, 17 insertions(+), 21 deletions(-)
 create mode 100644 tests/qapi-schema/string-code-point-127.err
 rename tests/qapi-schema/{unicode-str.exit =3D> string-code-point-127.ex=
it} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-127.json
 rename tests/qapi-schema/{unicode-str.out =3D> string-code-point-127.out=
} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-31.err
 create mode 100644 tests/qapi-schema/string-code-point-31.exit
 create mode 100644 tests/qapi-schema/string-code-point-31.json
 create mode 100644 tests/qapi-schema/string-code-point-31.out
 delete mode 100644 tests/qapi-schema/unicode-str.err
 delete mode 100644 tests/qapi-schema/unicode-str.json

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 54d02458b5..c3dfad024f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -523,17 +523,7 @@ class QAPISchemaParser(object):
                     if ch =3D=3D '\n':
                         raise QAPIParseError(self, 'Missing terminating =
"\'"')
                     if esc:
-                        if ch =3D=3D 'b':
-                            string +=3D '\b'
-                        elif ch =3D=3D 'f':
-                            string +=3D '\f'
-                        elif ch =3D=3D 'n':
-                            string +=3D '\n'
-                        elif ch =3D=3D 'r':
-                            string +=3D '\r'
-                        elif ch =3D=3D 't':
-                            string +=3D '\t'
-                        elif ch =3D=3D 'u':
+                        if ch =3D=3D 'u':
                             value =3D 0
                             for _ in range(0, 4):
                                 ch =3D self.src[self.cursor]
@@ -552,20 +542,21 @@ class QAPISchemaParser(object):
                                                      'For now, \\u escap=
e '
                                                      'only supports non-=
zero '
                                                      'values up to \\u00=
7f')
-                            string +=3D chr(value)
-                        elif ch in '\\/\'"':
-                            string +=3D ch
-                        else:
+                            ch =3D chr(value)
+                        elif ch not in '\\/\'"':
                             raise QAPIParseError(self,
                                                  "Unknown escape \\%s" %=
 ch)
                         esc =3D False
                     elif ch =3D=3D '\\':
                         esc =3D True
+                        continue
                     elif ch =3D=3D "'":
                         self.val =3D string
                         return
-                    else:
-                        string +=3D ch
+                    if ord(ch) < 32 or ord(ch) >=3D 127:
+                        raise QAPIParseError(
+                            self, "Funny character in string")
+                    string +=3D ch
             elif self.src.startswith('true', self.pos):
                 self.val =3D True
                 self.cursor +=3D 3
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f5ac09549c..403748579f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -452,6 +452,8 @@ qapi-schema +=3D returns-array-bad.json
 qapi-schema +=3D returns-dict.json
 qapi-schema +=3D returns-unknown.json
 qapi-schema +=3D returns-whitelist.json
+qapi-schema +=3D string-code-point-31.json
+qapi-schema +=3D string-code-point-127.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
@@ -463,7 +465,6 @@ qapi-schema +=3D type-bypass-bad-gen.json
 qapi-schema +=3D unclosed-list.json
 qapi-schema +=3D unclosed-object.json
 qapi-schema +=3D unclosed-string.json
-qapi-schema +=3D unicode-str.json
 qapi-schema +=3D union-base-empty.json
 qapi-schema +=3D union-base-no-discriminator.json
 qapi-schema +=3D union-branch-case.json
diff --git a/tests/qapi-schema/string-code-point-127.err b/tests/qapi-sch=
ema/string-code-point-127.err
new file mode 100644
index 0000000000..c310910c23
--- /dev/null
+++ b/tests/qapi-schema/string-code-point-127.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-code-point-127.json:2:14: Funny character in st=
ring
diff --git a/tests/qapi-schema/unicode-str.exit b/tests/qapi-schema/strin=
g-code-point-127.exit
similarity index 100%
rename from tests/qapi-schema/unicode-str.exit
rename to tests/qapi-schema/string-code-point-127.exit
diff --git a/tests/qapi-schema/string-code-point-127.json b/tests/qapi-sc=
hema/string-code-point-127.json
new file mode 100644
index 0000000000..480318a69f
--- /dev/null
+++ b/tests/qapi-schema/string-code-point-127.json
@@ -0,0 +1,2 @@
+# We accept printable ASCII: code points 32..126.  Test code point 127:
+{ 'command': '=7F' }
diff --git a/tests/qapi-schema/unicode-str.out b/tests/qapi-schema/string=
-code-point-127.out
similarity index 100%
rename from tests/qapi-schema/unicode-str.out
rename to tests/qapi-schema/string-code-point-127.out
diff --git a/tests/qapi-schema/string-code-point-31.err b/tests/qapi-sche=
ma/string-code-point-31.err
new file mode 100644
index 0000000000..45797928d9
--- /dev/null
+++ b/tests/qapi-schema/string-code-point-31.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-code-point-31.json:2:14: Funny character in str=
ing
diff --git a/tests/qapi-schema/string-code-point-31.exit b/tests/qapi-sch=
ema/string-code-point-31.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/string-code-point-31.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/string-code-point-31.json b/tests/qapi-sch=
ema/string-code-point-31.json
new file mode 100644
index 0000000000..f186cbd720
--- /dev/null
+++ b/tests/qapi-schema/string-code-point-31.json
@@ -0,0 +1,2 @@
+# We accept printable ASCII: code points 32..126.  Test code point 127:
+{ 'command': '=1F' }
diff --git a/tests/qapi-schema/string-code-point-31.out b/tests/qapi-sche=
ma/string-code-point-31.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/unicode-str.err b/tests/qapi-schema/unicod=
e-str.err
deleted file mode 100644
index f621cd6448..0000000000
--- a/tests/qapi-schema/unicode-str.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9=
'
diff --git a/tests/qapi-schema/unicode-str.json b/tests/qapi-schema/unico=
de-str.json
deleted file mode 100644
index 5253a1b9f3..0000000000
--- a/tests/qapi-schema/unicode-str.json
+++ /dev/null
@@ -1,2 +0,0 @@
-# we don't support full Unicode strings, yet
-{ 'command': '=C3=A9' }
--=20
2.21.0


