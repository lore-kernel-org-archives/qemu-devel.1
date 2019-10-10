Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E729DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFDB214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFDB214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaOc-00037T-Mo
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJR-0005kw-4J
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJQ-0004Gu-0V
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJM-0004Fu-9d; Thu, 10 Oct 2019 11:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72035801661;
 Thu, 10 Oct 2019 15:25:03 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6286196B2;
 Thu, 10 Oct 2019 15:25:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 01/23] iotests: Introduce $SOCK_DIR
Date: Thu, 10 Oct 2019 17:24:35 +0200
Message-Id: <20191010152457.17713-2-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 10 Oct 2019 15:25:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unix sockets generally have a maximum path length.  Depending on your
$TEST_DIR, it may be exceeded and then all tests that create and use
Unix sockets there may fail.

Circumvent this by adding a new scratch directory specifically for
Unix socket files.  It defaults to a temporary directory (mktemp -d)
that is completely removed after the iotests are done.

(By default, mktemp -d creates a /tmp/tmp.XXXXXXXXXX directory, which
should be short enough for our use cases.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 588c453a94..a257215448 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -97,6 +97,7 @@ IMGFMT        -- $FULL_IMGFMT_DETAILS
 IMGPROTO      -- $IMGPROTO
 PLATFORM      -- $FULL_HOST_DETAILS
 TEST_DIR      -- $TEST_DIR
+SOCK_DIR      -- $SOCK_DIR
 SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
=20
 EOF
@@ -121,6 +122,16 @@ if [ ! -e "$TEST_DIR" ]; then
         mkdir "$TEST_DIR"
 fi
=20
+tmp_sock_dir=3Dfalse
+if [ -z "$SOCK_DIR" ]; then
+    SOCK_DIR=3D$(mktemp -d)
+    tmp_sock_dir=3Dtrue
+fi
+
+if [ ! -d "$SOCK_DIR" ]; then
+    mkdir "$SOCK_DIR"
+fi
+
 diff=3D"diff -u"
 verbose=3Dfalse
 debug=3Dfalse
@@ -534,6 +545,7 @@ if [ -z "$SAMPLE_IMG_DIR" ]; then
 fi
=20
 export TEST_DIR
+export SOCK_DIR
 export SAMPLE_IMG_DIR
=20
 if [ -s $tmp.list ]
@@ -716,6 +728,11 @@ END        { if (NR > 0) {
     rm -f "${TEST_DIR}"/*.out "${TEST_DIR}"/*.err "${TEST_DIR}"/*.time
     rm -f "${TEST_DIR}"/check.pid "${TEST_DIR}"/check.sts
     rm -f $tmp.*
+
+    if $tmp_sock_dir
+    then
+        rm -rf "$SOCK_DIR"
+    fi
 }
=20
 trap "_wrapup; exit \$status" 0 1 2 3 15
--=20
2.21.0


