Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E02D20575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk6Am+GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E02D20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYzJF-0008VF-Fj
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYzIY-0007lN-TD
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:52:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYzIX-0007s0-O7
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EOmpODj413rB3tVsvDFY13oAFzqLvRlVX5BkjrddPBY=;
 b=Fk6Am+GPHUz3JnQyrII0gnE56OfMtXmsIs5+aYJSbYGFs/iCJxLMnkoyccX8zTkZkL8qSC
 Emio265cIoCcagRaQrfC1l/gi/uzJ4j1n1DKPhJitt3I/d83o022/d781v3xca6FRWu/E3
 /8KVGRLyESKXWfzKs6A+mpCFO2LCIzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-BP6ro5sGO4eGKSZNrkL37w-1; Wed, 13 May 2020 17:52:14 -0400
X-MC-Unique: BP6ro5sGO4eGKSZNrkL37w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F587184194D;
 Wed, 13 May 2020 21:52:13 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74EDF50DA;
 Wed, 13 May 2020 21:52:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] configure: prefer sphinx-build to sphinx-build-3
Date: Wed, 13 May 2020 17:52:11 -0400
Message-Id: <20200513215211.17341-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
package itself. sphinx-build-3 is a pacakging convention in the Fedora
distribution of Sphinx. Prefer, where possible, the canonical package
name.

In the event that this resolves to a python2 version, test the
suitability of the binary early in the configuration process, and
continue looking for sphinx-build-3 if necessary.

This prioritizes a virtual environment version of sphinx above any
distribution versions, if attempting to build out of a virtual python
environment, which can ease dependency difficulties on older
distributions, as well as allowing easy testing of specific sphinx
versions.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure | 66 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/configure b/configure
index 0d69c360c0..cda4b022e7 100755
--- a/configure
+++ b/configure
@@ -929,13 +929,42 @@ do
     fi
 done
 
+# If we're making warnings fatal, apply this to Sphinx runs as well
+sphinx_werror=""
+if test "$werror" = "yes"; then
+    sphinx_werror="-W"
+fi
+
+# Check we have a new enough version of sphinx-build
+test_sphinx_build() {
+    sphinx=$1
+    # This is a bit awkward but works: create a trivial document and
+    # try to run it with our configuration file (which enforces a
+    # version requirement). This will fail if either
+    # sphinx-build doesn't exist at all or if it is too old.
+    mkdir -p "$TMPDIR1/sphinx"
+    touch "$TMPDIR1/sphinx/index.rst"
+    "$sphinx" $sphinx_werror -c "$source_path/docs" \
+              -b html "$TMPDIR1/sphinx" \
+              "$TMPDIR1/sphinx/out" >> config.log 2>&1
+}
+
+# We require the python3 version of sphinx, but sphinx-build-3 is a
+# distro package. prefer 'sphinx-build' to find the venv version, if
+# any, but ensure it is a suitable version.
 sphinx_build=
-for binary in sphinx-build-3 sphinx-build
+sphinx_ok=
+for binary in sphinx-build sphinx-build-3
 do
     if has "$binary"
     then
-        sphinx_build=$(command -v "$binary")
-        break
+        sphinx_candidate=$(command -v "$binary")
+        if test_sphinx_build "$sphinx_candidate"
+        then
+            sphinx_build=$sphinx_candidate
+            sphinx_ok=yes
+            break
+        fi
     fi
 done
 
@@ -4929,32 +4958,17 @@ if check_include sys/kcov.h ; then
     kcov=yes
 fi
 
-# If we're making warnings fatal, apply this to Sphinx runs as well
-sphinx_werror=""
-if test "$werror" = "yes"; then
-    sphinx_werror="-W"
-fi
-
-# Check we have a new enough version of sphinx-build
-has_sphinx_build() {
-    # This is a bit awkward but works: create a trivial document and
-    # try to run it with our configuration file (which enforces a
-    # version requirement). This will fail if either
-    # sphinx-build doesn't exist at all or if it is too old.
-    mkdir -p "$TMPDIR1/sphinx"
-    touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
-                    -b html "$TMPDIR1/sphinx" \
-                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
-}
-
 # Check if tools are available to build documentation.
 if test "$docs" != "no" ; then
-  if has_sphinx_build; then
-    sphinx_ok=yes
-  else
-    sphinx_ok=no
+
+  if [ "$sphinx_ok" != "yes" ]; then
+    if test_sphinx_build "$sphinx_build"; then
+      sphinx_ok=yes
+    else
+      sphinx_ok=no
+    fi
   fi
+
   if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
     docs=yes
   else
-- 
2.21.1


