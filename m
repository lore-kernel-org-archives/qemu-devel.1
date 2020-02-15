Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B3C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983BB2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGJjFVsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983BB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2w0Z-0004eB-S6
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpT-0004bc-M2
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpS-0006ur-BP
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpS-0006ub-6A
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCc+5qLPVPb3mft6U9NkHFVFzv2oQYRT4mLOTm9h+10=;
 b=FGJjFVsqqHf/9EYdd2FLECDUhSYKCaJ+oK9ciR0mj904XDTTwxBkKjn5wyhu8UpHzbWd5E
 8wlMqqSfTiACJHY6V3V6vkiyQSXt/0T0WWCWHnQhUMn4R7hqFTzPvE56JzsBgJTRQAzjBF
 zfMiz9XfAAHCL/ulXn4jfJwzsGuZnRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-vEpWlTpbPQiGWTZ6Pc670A-1; Sat, 15 Feb 2020 06:41:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D971005510;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A97D15C1C3;
 Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27A7411366C8; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] configure: Check that sphinx-build is using Python 3
Date: Sat, 15 Feb 2020 12:41:19 +0100
Message-Id: <20200215114133.15097-5-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vEpWlTpbPQiGWTZ6Pc670A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently configure's has_sphinx_build() check simply runs a dummy
sphinx-build and either passes or fails.  This means that "no
sphinx-build at all" and "sphinx-build exists but is too old" are
both reported the same way.

Further, we want to assume that all the Python we write is running
with at least Python 3.5; configure checks that for our scripts, but
Sphinx extensions run with whatever Python version sphinx-build
itself is using.

Add a check to our conf.py which makes sphinx-build fail if it would
be running our extensions with an old Python, and handle this
in configure so we can report failure helpfully to the user.
This will mean that configure --enable-docs will fail like this
if the sphinx-build provided is not suitable:

Warning: sphinx-build exists but it is either too old or uses too old a Pyt=
hon version

ERROR: User requested feature docs
       configure was not able to find it.
       Install texinfo, Perl/perl-podlators and a Python 3 version of pytho=
n-sphinx

(As usual, the default is to simply not build the docs, as we would
if sphinx-build wasn't present at all.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200213175647.17628-3-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/conf.py | 10 ++++++++++
 configure    | 12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index ee7faa6b4e..7588bf192e 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -28,6 +28,16 @@
=20
 import os
 import sys
+import sphinx
+from sphinx.errors import VersionRequirementError
+
+# Make Sphinx fail cleanly if using an old Python, rather than obscurely
+# failing because some code in one of our extensions doesn't work there.
+# Unfortunately this doesn't display very neatly (there's an unavoidable
+# Python backtrace) but at least the information gets printed...
+if sys.version_info < (3,5):
+    raise VersionRequirementError(
+        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
=20
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
 # otherwise set it here if this is an entire-manual-set build.
diff --git a/configure b/configure
index 9f7bded369..7a826cbd26 100755
--- a/configure
+++ b/configure
@@ -4818,11 +4818,19 @@ has_sphinx_build() {
=20
 # Check if tools are available to build documentation.
 if test "$docs" !=3D "no" ; then
-  if has makeinfo && has pod2man && has_sphinx_build; then
+  if has_sphinx_build; then
+    sphinx_ok=3Dyes
+  else
+    sphinx_ok=3Dno
+  fi
+  if has makeinfo && has pod2man && test "$sphinx_ok" =3D "yes"; then
     docs=3Dyes
   else
     if test "$docs" =3D "yes" ; then
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and p=
ython-sphinx"
+      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then
+        echo "Warning: $sphinx_build exists but it is either too old or us=
es too old a Python version" >&2
+      fi
+      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a=
 Python 3 version of python-sphinx"
     fi
     docs=3Dno
   fi
--=20
2.21.1


