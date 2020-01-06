Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D52C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603D8207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU0rS+/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603D8207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTjq-00005G-0Q
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTb1-0006Rq-P8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTb0-0000KP-Kx
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTb0-0000Jt-Hf
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u01rTctSs8+0K9/VA+A+luPYWsbvIftoRd+neOuoVRE=;
 b=CU0rS+/KpBJhEqVqL9qKwMwHEVbuMklEaGXT1m+rwajd2VE4tsNwx082P1igERR/N2ZFaj
 jR2PxNOuTh0mphmOaEBkrKaPQRUkxaZYfFYwnDEWszhVf0SE1MYMmY/pGb+LQ3v3fSt/zr
 29WZZ0hzZTCt+Q/0lAC0aNpUh9WefWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-Rgat__iRMIuCUzkW32cFXg-1; Mon, 06 Jan 2020 09:43:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4A201576AD;
 Mon,  6 Jan 2020 14:43:01 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 356FC28984;
 Mon,  6 Jan 2020 14:43:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/34] iotests: Let _make_test_img parse its parameters
Date: Mon,  6 Jan 2020 15:41:47 +0100
Message-Id: <20200106144206.698920-16-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Rgat__iRMIuCUzkW32cFXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow us to add more options than just -b.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20191107163708.833192-9-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 555c453911..f01165a66e 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -303,12 +303,12 @@ _make_test_img()
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
@@ -324,11 +324,23 @@ _make_test_img()
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
@@ -344,9 +356,9 @@ _make_test_img()
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
2.24.1


