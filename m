Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B53C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CB1206EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbxl38Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CB1206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUztn-0005JU-DL
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crobinso@redhat.com>) id 1iUzsh-0004K3-AK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crobinso@redhat.com>) id 1iUzsg-0006Hk-6F
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:08:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1iUzsg-0006GP-2L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573679329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eJCqJWR8acQwzfcefPriX5xuSEUaakfykNzq7QUKrVQ=;
 b=Kbxl38Yiv1YovIKOla82mpHyneAJuEwnn7dRA8ZwuSizdfRi6ATmWEZF5yQCpXLWr85Fwn
 URVKyUx1Mud44mEHyf+s/pmF56yXjp2W29o8NEyg4XHn4Nw14F8KmF2betJuG9ToDLV8Vk
 hK0U/+fOVM8U0K82cGV8czZY5P7ya14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-iOGmqgjHMYuNgDAp_dSHhw-1; Wed, 13 Nov 2019 16:08:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71134835B63;
 Wed, 13 Nov 2019 21:08:45 +0000 (UTC)
Received: from worklaptop.redhat.com (ovpn-125-32.rdu2.redhat.com
 [10.10.125.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B73431084192;
 Wed, 13 Nov 2019 21:08:41 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: fix modules-test 'duplicate test case' error
Date: Wed, 13 Nov 2019 16:09:35 -0500
Message-Id: <d64c9aa098cc6e5c0b638438c4959eddfa7e24e2.1573679311.git.crobinso@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: iOGmqgjHMYuNgDAp_dSHhw-1
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

./configure --enable-sdl --audio-drv-list=3Dsdl --enable-modules

Will generate two identical test names: /$arch/module/load/sdl
Which generates an error like:

(tests/modules-test:23814): GLib-ERROR **: 18:23:06.359: duplicate test cas=
e path: /aarch64//module/load/sdl

Add the subsystem prefix in the name as well, so instead we get:

/$arch/module/load/audio-sdl
/$arch/module/load/ui-sdl

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 tests/modules-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/modules-test.c b/tests/modules-test.c
index d1a6ace218..88217686e1 100644
--- a/tests/modules-test.c
+++ b/tests/modules-test.c
@@ -64,7 +64,8 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
=20
     for (i =3D 0; i < G_N_ELEMENTS(modules); i +=3D 2) {
-        char *testname =3D g_strdup_printf("/module/load/%s", modules[i + =
1]);
+        char *testname =3D g_strdup_printf("/module/load/%s%s",
+                                         modules[i], modules[i + 1]);
         qtest_add_data_func(testname, modules + i, test_modules_load);
         g_free(testname);
     }
--=20
2.23.0


