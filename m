Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51122C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AADC20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJNmo3dD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AADC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxCD-0002Ze-2U
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxY-0005Zz-14
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxV-0006tr-NN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxR-0006q6-QC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfbWLLi0eC0FB0r0SaxA61U7hFeSImfNrdw/Lz5zxZc=;
 b=TJNmo3dDy5zteOLdRoL+9ma8iZZdwpGyWTn435lFl3n6X25yZnwIGMnXyRqMiPLlN4t6jJ
 9Dj3wZCA1JEsxEjsYpPMz+fgewTinbdRd5wSq9pRtkuzhMN3M60FJrishGyFbqJmRhVEYz
 N1l1M+1rgBGrufNULvcmrWyH3nywa5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-sxlIX28dPwWXQRpbkSHS7w-1; Thu, 19 Dec 2019 09:39:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11ED91061E4E;
 Thu, 19 Dec 2019 14:39:15 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EB1B5DA7D;
 Thu, 19 Dec 2019 14:39:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 15/18] iotests: Let _make_test_img guess $TEST_IMG_FILE
Date: Thu, 19 Dec 2019 15:38:15 +0100
Message-Id: <20191219143818.1646168-16-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sxlIX28dPwWXQRpbkSHS7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

When most iotests want to create a test image that is named differently
from the default $TEST_IMG, they do something like this:

    TEST_IMG=3D"$TEST_IMG.base" _make_test_img $options

This works fine with the "file" protocol, but not so much for anything
else: _make_test_img tries to create an image under $TEST_IMG_FILE
first, and only under $TEST_IMG if the former is not set; and on
everything but "file", $TEST_IMG_FILE is set.

There are two ways we can fix this: First, we could make all tests
adjust not only TEST_IMG, but also TEST_IMG_FILE if that is present
(e.g. with something like _set_test_img_suffix $suffix that would affect
not only TEST_IMG but also TEST_IMG_FILE, if necessary).  This is a
pretty clean solution, and this is maybe what we should have done from
the start.

But it would also require changes to most existing bash tests.  So the
alternative is this: Let _make_test_img see whether $TEST_IMG_FILE still
points to the original value.  If so, it is possible that the caller has
adjusted $TEST_IMG but not $TEST_IMG_FILE.  In such a case, we can (for
most protocols) derive the corresponding $TEST_IMG_FILE value from
$TEST_IMG value and thus work around what technically is the caller
misbehaving.

This second solution is less clean, but it is robust against people
keeping their old habit of adjusting TEST_IMG only, and requires much
less changes.  So this patch implements it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 42 +++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index d088392ab6..192c988401 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -250,6 +250,7 @@ else
         TEST_IMG=3D$IMGPROTO:$TEST_DIR/t.$IMGFMT
     fi
 fi
+ORIG_TEST_IMG_FILE=3D$TEST_IMG_FILE
 ORIG_TEST_IMG=3D"$TEST_IMG"
=20
 if [ -z "$TEST_DIR" ]; then
@@ -312,6 +313,33 @@ _get_data_file()
                     | sed -e "s#\\\$TEST_IMG#$1#"
 }
=20
+# Translate a $TEST_IMG to its corresponding $TEST_IMG_FILE for
+# different protocols
+_test_img_to_test_img_file()
+{
+    case "$IMGPROTO" in
+        file)
+            echo "$1"
+            ;;
+
+        nfs)
+            echo "$1" | sed -e "s#nfs://127.0.0.1##"
+            ;;
+
+        ssh)
+            echo "$1" | sed -e "s#ssh://127.0.0.1##"
+            ;;
+
+        vxhs)
+            echo "$1" | sed -e "s#vxhs://127.0.0.1:9999#$TEST_DIR#"
+            ;;
+
+        *)
+            return 1
+            ;;
+    esac
+}
+
 _make_test_img()
 {
     # extra qemu-img options can be added by tests
@@ -325,10 +353,18 @@ _make_test_img()
     local opts_param=3Dfalse
     local misc_params=3D()
=20
-    if [ -n "$TEST_IMG_FILE" ]; then
-        img_name=3D$TEST_IMG_FILE
-    else
+    if [ -z "$TEST_IMG_FILE" ]; then
         img_name=3D$TEST_IMG
+    elif [ "$TEST_IMG_FILE" =3D "$ORIG_TEST_IMG_FILE" ]; then
+        # Handle cases of tests only updating TEST_IMG, but not TEST_IMG_F=
ILE
+        img_name=3D$(_test_img_to_test_img_file "$TEST_IMG")
+        if [ "$?" !=3D 0 ]; then
+            img_name=3D$TEST_IMG_FILE
+        fi
+    else
+        # $TEST_IMG_FILE is not the default value, so it definitely has be=
en
+        # modified by the test
+        img_name=3D$TEST_IMG_FILE
     fi
=20
     if [ -n "$IMGOPTS" ]; then
--=20
2.23.0


