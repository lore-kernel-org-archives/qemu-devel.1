Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EFEC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500BA2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2l2hgpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500BA2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53141 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOlw4-0001pi-B7
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jOlus-0000gd-LX
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jOlur-0004HI-0V
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:33:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jOluq-0004G8-PQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586972015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Az/gQbOKfUzruycPEWSy5QuYUfbuKgZBYvnLcR55WV8=;
 b=Y2l2hgpxsAUKiOJiOUd2Zu/nTa1ymbmc8ZkRpvZqikEVkmXIScBbIGQcvkgNdzupZz65Ws
 JYlP30kDZNNFb53x6/ts4z+XLSRMuPIHttvE/1+4mpi8sH6/2gdfidcpsoNpiOMYPVELMS
 ggXurqiCmAr7Yi/qHHJ9/I0Yl38xJWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-KHugAyvnMuuViLQUwUIZRg-1; Wed, 15 Apr 2020 13:33:31 -0400
X-MC-Unique: KHugAyvnMuuViLQUwUIZRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA1E0107ACC4;
 Wed, 15 Apr 2020 17:33:30 +0000 (UTC)
Received: from probe.redhat.com (ovpn-119-33.rdu2.redhat.com [10.10.119.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B3EB19488;
 Wed, 15 Apr 2020 17:33:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] configure: prefer sphinx-build to sphinx-build-3
Date: Wed, 15 Apr 2020 13:33:29 -0400
Message-Id: <20200415173329.4920-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: John Snow <jsnow@redhat.com>, peter.maydell@linaro.org, philmd@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sphinx-build is the name of the script entry point from the sphinx
package itself. sphinx-build-3 is a pacakging convention by Linux
distributions. Prefer, where possible, the canonical package name.

In the event that this resolves to a python2 version, test the
suitability of the binary early in the configuration process, and
continue looking for sphinx-build-3 if necessary.

This prioritizes a virtual environment version of sphinx above any
distribution versions, if attempting to build of a virtual python
environment.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/configure b/configure
index 233c671aaa..82143e8a41 100755
--- a/configure
+++ b/configure
@@ -928,13 +928,34 @@ do
     fi
 done
=20
+# Check we have a new enough version of sphinx-build
+test_sphinx_build() {
+    sphinx=3D$1
+    # This is a bit awkward but works: create a trivial document and
+    # try to run it with our configuration file (which enforces a
+    # version requirement). This will fail if either
+    # sphinx-build doesn't exist at all or if it is too old.
+    mkdir -p "$TMPDIR1/sphinx"
+    touch "$TMPDIR1/sphinx/index.rst"
+    "$sphinx" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/s=
phinx/out" >/dev/null 2>&1
+}
+
+# We require the python3 version of sphinx, but sphinx-build-3 is a
+# distro package. prefer 'sphinx-build' to find the venv version, if
+# any, but ensure it is a suitable version.
 sphinx_build=3D
-for binary in sphinx-build-3 sphinx-build
+sphinx_ok=3D
+for binary in sphinx-build sphinx-build-3
 do
     if has "$binary"
     then
-        sphinx_build=3D$(command -v "$binary")
-        break
+        sphinx_candidate=3D$(command -v "$binary")
+        if test_sphinx_build "$sphinx_candidate"
+        then
+            sphinx_build=3D$sphinx_candidate
+            sphinx_ok=3Dyes
+            break
+        fi
     fi
 done
=20
@@ -4928,24 +4949,17 @@ if check_include sys/kcov.h ; then
     kcov=3Dyes
 fi
=20
-# Check we have a new enough version of sphinx-build
-has_sphinx_build() {
-    # This is a bit awkward but works: create a trivial document and
-    # try to run it with our configuration file (which enforces a
-    # version requirement). This will fail if either
-    # sphinx-build doesn't exist at all or if it is too old.
-    mkdir -p "$TMPDIR1/sphinx"
-    touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMP=
DIR1/sphinx/out" >/dev/null 2>&1
-}
-
 # Check if tools are available to build documentation.
 if test "$docs" !=3D "no" ; then
-  if has_sphinx_build; then
-    sphinx_ok=3Dyes
-  else
-    sphinx_ok=3Dno
+
+  if [ "$sphinx_ok" !=3D "yes" ]; then
+    if test_sphinx_build "$sphinx_build"; then
+      sphinx_ok=3Dyes
+    else
+      sphinx_ok=3Dno
+    fi
   fi
+
   if has makeinfo && has pod2man && test "$sphinx_ok" =3D "yes"; then
     docs=3Dyes
   else
--=20
2.21.1


