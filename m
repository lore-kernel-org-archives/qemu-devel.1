Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2422C28CBC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3422076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBhR01/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3422076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9Q6-0003Oi-Nk
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU9KV-00081h-RS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU9Go-0004NO-L9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:34:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jU9Go-0004Kv-7U
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588253429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmgbOeWb0JQktfZP4eZYR5FLeHsoA4kgG2QxIgGT6tg=;
 b=FBhR01/SQWyXii3pmuGWMZYSdsB07TBBO2NxlWAZwh0Bw8ppybc5CoFJ8/q4qQD4eSU5Jn
 tl1hIzyZ2spLYj/Wvt6h1VQlI2iVbvAlZz277j/DdiZVCTBg1u+4CVa/GugpIwE0aUARJP
 OMOylwNyWImINRvudKitdJPl+jIM3q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-5L8nY77QPjGVgaALxjyGiA-1; Thu, 30 Apr 2020 09:30:27 -0400
X-MC-Unique: 5L8nY77QPjGVgaALxjyGiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4EAF8730ED;
 Thu, 30 Apr 2020 13:30:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A992967656;
 Thu, 30 Apr 2020 13:30:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 6/6] iotests: vmdk: Enable zeroed_grained=on by default
Date: Thu, 30 Apr 2020 15:30:07 +0200
Message-Id: <20200430133007.170335-7-kwolf@redhat.com>
In-Reply-To: <20200430133007.170335-1-kwolf@redhat.com>
References: <20200430133007.170335-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to avoid bitrot in the zero cluster code in VMDK, enable
zero_grained=3Don by default for the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/059   | 6 +++---
 tests/qemu-iotests/check | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 5438025285..4c90fc0363 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -41,9 +41,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt vmdk
 _supported_proto file
 _supported_os Linux
-_unsupported_imgopts "subformat=3DmonolithicFlat" \
-                     "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+
+# We test all kinds of VMDK options here, so ignore user-specified options
+IMGOPTS=3D""
=20
 capacity_offset=3D16
 granularity_offset=3D20
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f7a2d3d6c3..9c461cf76d 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -546,6 +546,9 @@ fi
 if [ "$IMGFMT" =3D=3D "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=3D"=
 > /dev/null); then
     IMGOPTS=3D$(_optstr_add "$IMGOPTS" "iter-time=3D10")
 fi
+if [ "$IMGFMT" =3D=3D "vmdk" ] && ! (echo "$IMGOPTS" | grep "zeroed_grain=
=3D" > /dev/null); then
+    IMGOPTS=3D$(_optstr_add "$IMGOPTS" "zeroed_grain=3Don")
+fi
=20
 if [ -z "$SAMPLE_IMG_DIR" ]; then
         SAMPLE_IMG_DIR=3D"$source_iotests/sample_images"
--=20
2.25.3


