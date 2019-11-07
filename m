Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D926C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D3921D79
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8HyKmJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D3921D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSktq-0003aR-RE
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkmr-0002zU-Fj
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkmq-0005dV-BH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkmq-0005dI-83
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvUe363zoxzVQxVzE0TqWwCfauKMF3hSpsO7eGilil8=;
 b=V8HyKmJSuZLg9bAdEAU2Q8k3hjfvfwIfsGAh/JHD2CbiY65dphZZdy2IPxedGGCglpMah1
 WXGbH8Kk8YSiiEszt4tCCnrpGoL6wd/h6pmKgr3AcGitperWmExUIcBeKjKSQ4ORuS5Jdu
 B/NlWJvyMMOxpGWH6pMdgpALJS3pUP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-XUjMCnsTN42OL3O8cw9mmQ-1; Thu, 07 Nov 2019 11:37:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 294FB1005500;
 Thu,  7 Nov 2019 16:37:27 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD18E1001B34;
 Thu,  7 Nov 2019 16:37:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/22] iotests: Let _make_test_img parse its parameters
Date: Thu,  7 Nov 2019 17:36:54 +0100
Message-Id: <20191107163708.833192-9-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XUjMCnsTN42OL3O8cw9mmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow us to add more options than just -b.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/common.rc | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index fa7bae2422..e12216b5f2 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -302,12 +302,12 @@ _make_test_img()
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
@@ -323,11 +323,23 @@ _make_test_img()
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
     if [ \( "$IMGFMT" =3D "qcow2" -o "$IMGFMT" =3D "qed" \) -a -n "$CLUSTE=
R_SIZE" ]; then
         optstr=3D$(_optstr_add "$optstr" "cluster_size=3D$CLUSTER_SIZE")
     fi
@@ -343,9 +355,9 @@ _make_test_img()
     # XXX(hch): have global image options?
     (
      if [ $use_backing =3D 1 ]; then
-        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options -b =
"$backing_file" "$img_name" $image_size 2>&1
+        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options -b =
"$backing_file" "$img_name" "${misc_params[@]}" 2>&1
      else
-        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options "$i=
mg_name" $image_size 2>&1
+        $QEMU_IMG create $object_options -f $IMGFMT $extra_img_options "$i=
mg_name" "${misc_params[@]}" 2>&1
      fi
     ) | _filter_img_create
=20
--=20
2.23.0


