Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA73C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC16217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC16217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTB4E-0005XV-HM
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:08:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTB30-0004uH-BZ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTB2x-0006g5-N7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:07:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hTB2q-0006GP-SR; Tue, 21 May 2019 16:07:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD4FF307D971;
	Tue, 21 May 2019 20:07:04 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 205C417B23;
	Tue, 21 May 2019 20:07:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 16:06:56 -0400
Message-Id: <20190521200657.5377-2-jsnow@redhat.com>
In-Reply-To: <20190521200657.5377-1-jsnow@redhat.com>
References: <20190521200657.5377-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 21 May 2019 20:07:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] sphinx: add qmp_lexer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
	John Snow <jsnow@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sphinx, through Pygments, does not like annotated json examples very
much. In some versions of Sphinx (1.7), it will render the non-json
portions of code blocks in red, but in newer versions (2.0) it will
throw an exception and not highlight the block at all. Though we can
suppress this warning, it doesn't bring back highlighting on non-strict
json blocks.

We can alleviate this by creating a custom lexer for QMP examples that
allows us to properly highlight these examples in a robust way, keeping
our directionality notations.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py             |  4 ++--
 docs/sphinx/qmp_lexer.py | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 docs/sphinx/qmp_lexer.py

diff --git a/docs/conf.py b/docs/conf.py
index befbcc6c3e..e46b299b71 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -41,7 +41,7 @@ except NameError:
 # add these directories to sys.path here. If the directory is relative t=
o the
 # documentation root, use an absolute path starting from qemu_docdir.
 #
-# sys.path.insert(0, os.path.join(qemu_docdir, "my_subdir"))
+sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
=20
=20
 # -- General configuration ---------------------------------------------=
---
@@ -54,7 +54,7 @@ needs_sphinx =3D '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions =3D []
+extensions =3D ['qmp_lexer']
=20
 # Add any paths that contain templates here, relative to this directory.
 templates_path =3D ['_templates']
diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
new file mode 100644
index 0000000000..f619f11139
--- /dev/null
+++ b/docs/sphinx/qmp_lexer.py
@@ -0,0 +1,34 @@
+# QEMU Monitor Protocol Lexer Extension
+#
+# Copyright (C) 2019, Red Hat Inc.
+#
+# Authors:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#  John Snow <jsnow@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+"""qmp_lexer is a Sphinx extension that provides a QMP lexer for code bl=
ocks."""
+
+from pygments.lexer import RegexLexer, DelegatingLexer
+from pygments.lexers.data import JsonLexer
+import pygments.token
+
+class QMPExampleMarkersLexer(RegexLexer):
+    """QMPExampleMarkersLexer highlights directionality flow indicators.=
"""
+    tokens =3D {
+        'root': [
+            (r'-> ', pygments.token.Generic.Prompt),
+            (r'<- ', pygments.token.Generic.Prompt),
+        ]
+    }
+
+class QMPExampleLexer(DelegatingLexer):
+    """QMPExampleLexer highlights annotated QMP examples."""
+    def __init__(self, **options):
+        super(QMPExampleLexer, self).__init__(JsonLexer, QMPExampleMarke=
rsLexer,
+                                              pygments.token.Error, **op=
tions)
+
+def setup(sphinx):
+    """For use by Sphinx() extensions API."""
+    sphinx.add_lexer("QMP", QMPExampleLexer())
--=20
2.20.1


