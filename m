Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4544EC2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105A72073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrCS8/bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105A72073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTeB-0004GS-IQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTbp-0002Nv-OG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTbo-0008L6-KQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTbo-0008K4-GJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CeObgrpqME/H5gUhHJMZVtmA8RRafdQNdxrTROk0Ig=;
 b=CrCS8/bGsNLVOs0YXXnrJaMsXzbhnK/dUIzOwO9gdsLUojnS8zGD/3W+Eva4E/phff1Irm
 CYsogkbCZe5PbHBe0zYXNQOnI5d3AlsPSYpz7L2R8HsWQ3fFrjQo/iRxRPDo7QaVKmM/PT
 7EFkpbQ4koF7OLQg2knI6H2qbbppCF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-E03gZje-Msa4dC7IF7P8FA-1; Thu, 12 Dec 2019 13:54:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F41EE1800D45;
 Thu, 12 Dec 2019 18:54:40 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80A7419C4F;
 Thu, 12 Dec 2019 18:54:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/10] tests: fix modules-test 'duplicate test case' error
Date: Thu, 12 Dec 2019 19:54:19 +0100
Message-Id: <20191212185424.4675-6-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
References: <20191212185424.4675-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: E03gZje-Msa4dC7IF7P8FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cole Robinson <crobinso@redhat.com>

./configure --enable-sdl --audio-drv-list=3Dsdl --enable-modules

Will generate two identical test names: /$arch/module/load/sdl
Which generates an error like:

(tests/modules-test:23814): GLib-ERROR **: 18:23:06.359: duplicate test cas=
e path: /aarch64//module/load/sdl

Add the subsystem prefix in the name as well, so instead we get:

/$arch/module/load/audio-sdl
/$arch/module/load/ui-sdl

Signed-off-by: Cole Robinson <crobinso@redhat.com>
Message-Id: <d64c9aa098cc6e5c0b638438c4959eddfa7e24e2.1573679311.git.crobin=
so@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.18.1


