Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51265C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273CB2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273CB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmw7-00056O-BI
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmB-000364-0l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmm9-0007Ru-Mo
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmm7-0007Ma-DQ; Fri, 27 Sep 2019 05:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FBF530ADBAF;
 Fri, 27 Sep 2019 09:42:54 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3614A100EBD7;
 Fri, 27 Sep 2019 09:42:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/18] iotests: Let _make_test_img parse its parameters
Date: Fri, 27 Sep 2019 11:42:28 +0200
Message-Id: <20190927094242.11152-5-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 27 Sep 2019 09:42:54 +0000 (UTC)
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

This will allow us to add more options than just -b.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 12b4751848..3e7adc4834 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -282,12 +282,12 @@ _make_test_img()
     # extra qemu-img options can be added by tests
     # at least one argument (the image size) needs to be added
     local extra_img_options=3D""
-    local image_size=3D$*
     local optstr=3D""
     local img_name=3D""
     local use_backing=3D0
     local backing_file=3D""
     local object_options=3D""
+    local misc_params=3D()
=20
     if [ -n "$TEST_IMG_FILE" ]; then
         img_name=3D$TEST_IMG_FILE
@@ -303,11 +303,23 @@ _make_test_img()
         optstr=3D$(_optstr_add "$optstr" "key-secret=3Dkeysec0")
     fi
=20
-    if [ "$1" =3D "-b" ]; then
-        use_backing=3D1
-        backing_file=3D$2
-        image_size=3D$3
-    fi
+    for param; do
+        if [ "$use_backing" =3D "1" -a -z "$backing_file" ]; then
+            backing_file=3D$param
+            continue
+        fi
+
+        case "$param" in
+            -b)
+                use_backing=3D1
+                ;;
+
+            *)
+                misc_params=3D("${misc_params[@]}" "$param")
+                ;;
+        esac
+    done
+
     if [ \( "$IMGFMT" =3D "qcow2" -o "$IMGFMT" =3D "qed" \) -a -n "$CLUS=
TER_SIZE" ]; then
         optstr=3D$(_optstr_add "$optstr" "cluster_size=3D$CLUSTER_SIZE")
     fi
@@ -323,9 +335,9 @@ _make_test_img()
     # XXX(hch): have global image options?
     (
      if [ $use_backing =3D 1 ]; then
-        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options -=
b "$backing_file" "$img_name" $image_size 2>&1
+        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options -=
b "$backing_file" "$img_name" "${misc_params[@]}" 2>&1
      else
-        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options "=
$img_name" $image_size 2>&1
+        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options "=
$img_name" "${misc_params[@]}" 2>&1
      fi
     ) | _filter_img_create
=20
--=20
2.21.0


