Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3279C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8447C21D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J63rz2Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8447C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1tD-0001zk-I8
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1ml-0003nF-Rx
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1mk-0002SE-3y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1mj-0002QX-SL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnmHcvAzlYerfEhzxJ/5Dt9qcTxe4wP+0MOD1yMQ9wI=;
 b=J63rz2PzvqRgsf5Z83PJEJcQHb3JLjsSOaueuzslzKC5cVv8q1BaLb6RVCr75+ePsDlSEL
 GGTQ0qWN+fT06JEXpVDYml5Yw3vBnDRjSYAsBKLL1fynxAYsR9Gq5zx4Gs8wRq1PoCK2w/
 urR3P0qbwzUOUs8goU2N/fynjnmUAZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-C0phuaU1PiefNOZWoeqxEQ-1; Wed, 11 Mar 2020 09:52:29 -0400
X-MC-Unique: C0phuaU1PiefNOZWoeqxEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA20107ACC4;
 Wed, 11 Mar 2020 13:52:28 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89AB69296C;
 Wed, 11 Mar 2020 13:52:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v6 11/13] arm/run: Allow Migration tests
Date: Wed, 11 Mar 2020 14:51:15 +0100
Message-Id: <20200311135117.9366-12-eric.auger@redhat.com>
In-Reply-To: <20200311135117.9366-1-eric.auger@redhat.com>
References: <20200311135117.9366-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, andre.przywara@arm.com,
 thuth@redhat.com, yuzenghui@huawei.com, alexandru.elisei@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's link getchar.o to use puts and getchar from the
tests.

Then allow tests belonging to the migration group to
trigger the migration from the test code by putting
"migrate" into the uart. Then the code can wait for the
migration completion by using getchar().

The __getchar implement is minimalist as it just reads the
data register. It is just meant to read the single character
emitted at the end of the migration by the runner script.

It is not meant to read more data (FIFOs are not enabled).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- remove space around Elvis operator
- rename ___getchar into do_getchar

v2 -> v3:
- take the lock
- assert if more than 16 chars
- removed Thomas' R-b
---
 arm/Makefile.common |  2 +-
 arm/run             |  2 +-
 lib/arm/io.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arm/Makefile.common b/arm/Makefile.common
index b8988f2..a123e85 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -32,7 +32,7 @@ CFLAGS +=3D -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I=
 lib
 asm-offsets =3D lib/$(ARCH)/asm-offsets.h
 include $(SRCDIR)/scripts/asm-offsets.mak
=20
-cflatobjs +=3D lib/util.o
+cflatobjs +=3D lib/util.o lib/getchar.o
 cflatobjs +=3D lib/alloc_phys.o
 cflatobjs +=3D lib/alloc_page.o
 cflatobjs +=3D lib/vmalloc.o
diff --git a/arm/run b/arm/run
index 277db9b..a390ca5 100755
--- a/arm/run
+++ b/arm/run
@@ -61,6 +61,6 @@ fi
 M+=3D",accel=3D$ACCEL"
 command=3D"$qemu -nodefaults $M -cpu $processor $chr_testdev $pci_testde=
v"
 command+=3D" -display none -serial stdio -kernel"
-command=3D"$(timeout_cmd) $command"
+command=3D"$(migration_cmd) $(timeout_cmd) $command"
=20
 run_qemu $command "$@"
diff --git a/lib/arm/io.c b/lib/arm/io.c
index 99fd315..343e108 100644
--- a/lib/arm/io.c
+++ b/lib/arm/io.c
@@ -87,6 +87,34 @@ void puts(const char *s)
 	spin_unlock(&uart_lock);
 }
=20
+static int do_getchar(void)
+{
+	int c;
+
+	spin_lock(&uart_lock);
+	c =3D readb(uart0_base);
+	spin_unlock(&uart_lock);
+
+	return c ?: -1;
+}
+
+/*
+ * Minimalist implementation for migration completion detection.
+ * Without FIFOs enabled on the QEMU UART device we just read
+ * the data register: we cannot read more than 16 characters.
+ */
+int __getchar(void)
+{
+	int c =3D do_getchar();
+	static int count;
+
+	if (c !=3D -1)
+		++count;
+
+	assert(count < 16);
+
+	return c;
+}
=20
 /*
  * Defining halt to take 'code' as an argument guarantees that it will
--=20
2.20.1


