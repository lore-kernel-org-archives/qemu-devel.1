Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FBE20739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF7jvaBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FBE20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlGym-00077A-S3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jlGy0-0006IM-RQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:09:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jlGxy-0003QW-Jr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592334589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRqczKv1ry8MnbqQzqLLb1v1aqvQHvIx0njYzId9Vh0=;
 b=KF7jvaBC0RzHrlfyJJSOkuSV2mDey+82uOHqaR5TYRJjiiCDINeoYxs2Li9Vwh8dSu4s98
 uTOrRojAYQF0bxh+bubWhn65QF/JE+oByf0kLlDCZMDywD35ouIDclVTbGdg3uoQUHAQAK
 OwnSWyQaZ4FX/7b88fi3FeZbB+2bdBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-N5UiDXaJMNWF9awtYu8PFA-1; Tue, 16 Jun 2020 15:09:48 -0400
X-MC-Unique: N5UiDXaJMNWF9awtYu8PFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D42B80F5CE;
 Tue, 16 Jun 2020 19:09:47 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FCAF60BE2;
 Tue, 16 Jun 2020 19:09:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] configure: prefer python's sphinx module
Date: Tue, 16 Jun 2020 15:09:42 -0400
Message-Id: <20200616190942.24624-2-jsnow@redhat.com>
In-Reply-To: <20200616190942.24624-1-jsnow@redhat.com>
References: <20200616190942.24624-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, peter.maydell@linaro.org,
 John Snow <jsnow@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using an explicit entry path script for sphinx can lead to confusing
results: If the python binary belongs to a virtual environment, our
configure script may still select a sphinx script that belongs to the
system distribution packages.

It is likely best to use python itself (whichever one the user provides)
to resolve the sphinx script. This has a few benefits:

1. It will always be Python 3. Script entry points like 'sphinx-build'
might attempt to invoke python2 -- or indeed, any version of python that
the user did not specify with --python.

2. When using a user installation of sphinx, it will naturally prefer
that version.

3. When using a virtual environment, it will naturally prefer that
version.

4. Removing explicit python script entry points gives us greater control
within the QEMU build ecosystem; we can be confident we are respecting
the user's --python configuration, if any.

It's my hope that this will make it simpler to integrate some optional
pipenv functionality into the build for adding regression testing to our
python module -- by offloading more of the python environment
configuration and testing directly to the python tooling ecosystem.

This would, ideally, free us up to use more modern python packages not
always offered in older system distributions. (For instance, we already
violate this requirement with sphinx, which does not have the necessary
versions in our oldest build platforms.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/system/deprecated.rst | 19 +++++++++++++++++++
 configure                  | 20 +++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 544ece0a45e..a762a8c8043 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -17,6 +17,25 @@ they were first deprecated in the 2.10.0 release.
 What follows is a list of all features currently marked as
 deprecated.
 
+Configure script options
+------------------------
+
+``--sphinx-build=`` (since 5.1)
+'''''''''''''''''''''''''''''''
+
+The ``--sphinx-build`` option to select a specific sphinx-build entry
+point is replaced by configuring Python accordingly. QEMU will now
+default to using ``$python -m sphinx`` to use Python's preferred version
+of sphinx.
+
+Python will generally default to preferring user packages installed with
+``pip install --user`` first, and system distribution packages
+second. By specifying a custom Python binary or activating a virtual
+environment, Python will alter its module search behavior. As a last
+resort, the PYTHONPATH environment variable can be modified to specify
+an explicit directory.
+
+
 System emulator command line arguments
 --------------------------------------
 
diff --git a/configure b/configure
index b01b5e3bed0..e04b9d836ee 100755
--- a/configure
+++ b/configure
@@ -932,16 +932,6 @@ do
     fi
 done
 
-sphinx_build=
-for binary in sphinx-build-3 sphinx-build
-do
-    if has "$binary"
-    then
-        sphinx_build=$(command -v "$binary")
-        break
-    fi
-done
-
 # Check for ancillary tools used in testing
 genisoimage=
 for binary in genisoimage mkisofs
@@ -1014,7 +1004,9 @@ for opt do
   ;;
   --python=*) python="$optarg"
   ;;
-  --sphinx-build=*) sphinx_build="$optarg"
+  --sphinx-build=*)
+      sphinx_build="$optarg"
+      echo "--sphinx-build is deprecated. QEMU uses the specified python's sphinx module."
   ;;
   --gcov=*) gcov_tool="$optarg"
   ;;
@@ -4996,6 +4988,12 @@ has_sphinx_build() {
                     "$TMPDIR1/sphinx/out"  >> config.log 2>&1
 }
 
+# While we support --sphinx-build, defer to that.
+# Otherwise, use the module execution feature of Python.
+if ! has $sphinx_build; then
+    sphinx_build="$python -m sphinx"
+fi
+
 # Check if tools are available to build documentation.
 if test "$docs" != "no" ; then
   if has_sphinx_build; then
-- 
2.21.3


