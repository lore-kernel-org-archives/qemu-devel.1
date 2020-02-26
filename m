Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E268C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9AE2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWa3LMh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9AE2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wDg-00088L-9D
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6wCz-0007IR-MN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6wCy-0004iY-JO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:54:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6wCx-0004d1-FW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582721675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v4FVryLbnMoUxxCWBob9heqhH4N2c8R4yK+8Eyi/Dxw=;
 b=iWa3LMh17IGQPsXgl5fG0JaXoynDCfGL3cL7CpYUQhwwaz90Sn/ontdQIwIImyUvLixTTd
 ztmk7jFXeUsAO72wpyqlPZok4xvy+7eb/l/35bafmE/GhqaaYZVpXxmfsR5yiOzEWiHCgN
 2KF+8oFWqq85CL+hZILUXP/rzPMLgFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-DmyYd94rP5K_Sn1ldkj2Mg-1; Wed, 26 Feb 2020 07:54:31 -0500
X-MC-Unique: DmyYd94rP5K_Sn1ldkj2Mg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C4D8017CC;
 Wed, 26 Feb 2020 12:54:30 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D56B91001DDE;
 Wed, 26 Feb 2020 12:54:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] iotests: Fix nonportable use of od --endian
Date: Wed, 26 Feb 2020 06:54:24 -0600
Message-Id: <20200226125424.481840-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, andrey.shinkevich@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tests 261 and 272 fail on RHEL 7 with coreutils 8.22, since od
--endian was not added until coreutils 8.23.  Fix this by manually
constructing the final value one byte at a time.

Fixes: fc8ba423
Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---

In v2: s/i/byte/, add Max's R-b

 tests/qemu-iotests/common.rc | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 8a6366c09daf..4c246c0450e4 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -56,18 +56,30 @@ poke_file()
 # peek_file_le 'test.img' 512 2 =3D> 65534
 peek_file_le()
 {
-    # Wrap in echo $() to strip spaces
-    echo $(od -j"$2" -N"$3" --endian=3Dlittle -An -vtu"$3" "$1")
+    local val=3D0 shift=3D0 byte
+
+    # coreutils' od --endian is not portable, so manually assemble bytes.
+    for byte in $(od -j"$2" -N"$3" -An -v -tu1 "$1"); do
+        val=3D$(( val | (byte << shift) ))
+        shift=3D$((shift + 8))
+    done
+    printf %llu $val
 }

 # peek_file_be 'test.img' 512 2 =3D> 65279
 peek_file_be()
 {
-    # Wrap in echo $() to strip spaces
-    echo $(od -j"$2" -N"$3" --endian=3Dbig -An -vtu"$3" "$1")
+    local val=3D0 byte
+
+    # coreutils' od --endian is not portable, so manually assemble bytes.
+    for byte in $(od -j"$2" -N"$3" -An -v -tu1 "$1"); do
+        val=3D$(( (val << 8) | byte ))
+    done
+    printf %llu $val
 }

-# peek_file_raw 'test.img' 512 2 =3D> '\xff\xfe'
+# peek_file_raw 'test.img' 512 2 =3D> '\xff\xfe'. Do not use if the raw da=
ta
+# is likely to contain \0 or trailing \n.
 peek_file_raw()
 {
     dd if=3D"$1" bs=3D1 skip=3D"$2" count=3D"$3" status=3Dnone
--=20
2.24.1


