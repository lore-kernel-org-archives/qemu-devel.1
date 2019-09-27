Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE508C352AB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5095207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5095207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmzF-0000on-Fl
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmD-00039h-2Z
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmB-0007U4-Vo
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmm9-0007RT-LA; Fri, 27 Sep 2019 05:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E423B2CE955;
 Fri, 27 Sep 2019 09:42:56 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F84C5C21A;
 Fri, 27 Sep 2019 09:42:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 05/18] iotests: Add -o and --no-opts to _make_test_img
Date: Fri, 27 Sep 2019 11:42:29 +0200
Message-Id: <20190927094242.11152-6-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 27 Sep 2019 09:42:56 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Blindly overriding IMGOPTS is suboptimal as this discards user-specified
options.  Whatever options the test needs should simply be appended.

Some tests do this (with IMGOPTS=3D$(_optstr_add "$IMGOPTS" "...")), but
that is cumbersome.  It=E2=80=99s simpler to just give _make_test_img an =
-o
parameter with which tests can add options.

Some tests actually must override the user-specified options, though,
for example when creating an image in a different format than the test
$IMGFMT.  For such cases, --no-opts allows clearing the current option
list.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 3e7adc4834..f3784077de 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -287,6 +287,7 @@ _make_test_img()
     local use_backing=3D0
     local backing_file=3D""
     local object_options=3D""
+    local opts_param=3Dfalse
     local misc_params=3D()
=20
     if [ -n "$TEST_IMG_FILE" ]; then
@@ -307,6 +308,10 @@ _make_test_img()
         if [ "$use_backing" =3D "1" -a -z "$backing_file" ]; then
             backing_file=3D$param
             continue
+        elif $opts_param; then
+            optstr=3D$(_optstr_add "$optstr" "$param")
+            opts_param=3Dfalse
+            continue
         fi
=20
         case "$param" in
@@ -314,6 +319,14 @@ _make_test_img()
                 use_backing=3D1
                 ;;
=20
+            -o)
+                opts_param=3Dtrue
+                ;;
+
+            --no-opts)
+                optstr=3D""
+                ;;
+
             *)
                 misc_params=3D("${misc_params[@]}" "$param")
                 ;;
--=20
2.21.0


