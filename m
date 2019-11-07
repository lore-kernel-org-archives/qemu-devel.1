Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26FC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2C92085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4GSS3Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2C92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkrO-0000aP-La
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkmr-0002ym-2i
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkmp-0005dL-VG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkmp-0005d0-Rh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvtEJxtN+VhNoTv1kegXVQEwmrJNIg6cVYHXcN72VZ0=;
 b=Q4GSS3ZmCtUgxnfxHD67PCiiIBfIxFS5kfyoQeW81s55c+byYV7p9aD8roArYBDaqnGoWg
 LGHnto6gTRTRn1aIKM2RBipAOYNV7Sca55lAgMLWaWG6hOPUF/yBv3+YIuixCeDWlF37UP
 0qCrAO3cfQXqFY4z9pv19Rs4d1OVsFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-HAtlDfMyM9me6ASICRQnSw-1; Thu, 07 Nov 2019 11:37:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 316AB477;
 Thu,  7 Nov 2019 16:37:29 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8C95600D1;
 Thu,  7 Nov 2019 16:37:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/22] iotests: Add -o and --no-opts to _make_test_img
Date: Thu,  7 Nov 2019 17:36:55 +0100
Message-Id: <20191107163708.833192-10-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HAtlDfMyM9me6ASICRQnSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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

Blindly overriding IMGOPTS is suboptimal as this discards user-specified
options.  Whatever options the test needs should simply be appended.

Some tests do this (with IMGOPTS=3D$(_optstr_add "$IMGOPTS" "...")), but
that is cumbersome.  It=E2=80=99s simpler to just give _make_test_img an -o
parameter with which tests can add options.

Some tests actually must override the user-specified options, though,
for example when creating an image in a different format than the test
$IMGFMT.  For such cases, --no-opts allows clearing the current option
list.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/common.rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e12216b5f2..a623485f96 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -307,6 +307,7 @@ _make_test_img()
     local use_backing=3D0
     local backing_file=3D""
     local object_options=3D""
+    local opts_param=3Dfalse
     local misc_params=3D()
=20
     if [ -n "$TEST_IMG_FILE" ]; then
@@ -327,6 +328,10 @@ _make_test_img()
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
@@ -334,6 +339,14 @@ _make_test_img()
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
2.23.0


