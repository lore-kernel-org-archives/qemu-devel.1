Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77248C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBBC2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBBC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEPb-00006l-G5
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:18:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKx-0004Ay-NN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKw-0002KT-Rn
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKw-0002KA-Mp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEA6C356F2;
	Thu,  2 May 2019 16:13:29 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B73817D58;
	Thu,  2 May 2019 16:13:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 18:13:05 +0200
Message-Id: <20190502161310.15624-4-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 02 May 2019 16:13:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/8] qtest: Don't compile qtest accel on
 non-POSIX systems
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161305.h7XrODlnYdbiSw4zh810lNQ2YxlGFUSOVsG0ogUYTiU@z>

From: Eduardo Habkost <ehabkost@redhat.com>

qtest_available() will always return 0 on non-POSIX systems.
It's simpler to just not compile the accelerator code on those
systems instead of relying on the AccelClass::available function.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190422210448.2488-3-ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> [on mingw64]
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/Makefile.objs    | 2 +-
 accel/qtest.c          | 1 -
 include/sysemu/qtest.h | 9 ---------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 2a5ed46940..8b498d39d8 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,5 +1,5 @@
 obj-$(CONFIG_SOFTMMU) +=3D accel.o
-obj-$(CONFIG_SOFTMMU) +=3D qtest.o
+obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-$(CONFIG_TCG) +=3D tcg/
 obj-y +=3D stubs/
diff --git a/accel/qtest.c b/accel/qtest.c
index a02b3c26c7..5b88f55921 100644
--- a/accel/qtest.c
+++ b/accel/qtest.c
@@ -34,7 +34,6 @@ static void qtest_accel_class_init(ObjectClass *oc, voi=
d *data)
 {
     AccelClass *ac =3D ACCEL_CLASS(oc);
     ac->name =3D "QTest";
-    ac->available =3D qtest_available;
     ac->init_machine =3D qtest_init_accel;
     ac->allowed =3D &qtest_allowed;
 }
diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 70aa40aa72..096ddfc20c 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -27,13 +27,4 @@ bool qtest_driver(void);
=20
 void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error *=
*errp);
=20
-static inline int qtest_available(void)
-{
-#ifdef CONFIG_POSIX
-    return 1;
-#else
-    return 0;
-#endif
-}
-
 #endif
--=20
2.21.0


