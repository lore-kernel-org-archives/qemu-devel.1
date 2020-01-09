Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9662067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKvc+0Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9662067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZy6-0002ys-QS
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZv2-0007DJ-MZ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZv1-0003qw-9k
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZv0-0003mv-Vt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578584418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvMUId5CAgve5E5mWjadx78NUWbTZqBc9nfElX7Eg10=;
 b=UKvc+0Fo/RxCTOzVQvcKJ7h+cIyXc9kqvryWKyuKb4XCHJuQbJ3D4qlL84FY48aIVQ3w7V
 hhdm4u+pyaMU3mIqBIu37jjSWD/p+APd4FjTQ5AwgGpDGtFpcv3M9ScRmHkp/VSpMVIbyq
 e8l+DYZID0xskUi+k8buxLXRhBU5qGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-jwR0XzlnPp2phPzFg0i5-w-1; Thu, 09 Jan 2020 10:40:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EB4F8C0C40;
 Thu,  9 Jan 2020 15:40:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B710687EC5;
 Thu,  9 Jan 2020 15:40:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] Makefile: Restrict system emulation and tools objects
Date: Thu,  9 Jan 2020 16:39:38 +0100
Message-Id: <20200109153939.27173-4-philmd@redhat.com>
In-Reply-To: <20200109153939.27173-1-philmd@redhat.com>
References: <20200109153939.27173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jwR0XzlnPp2phPzFg0i5-w-1
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restrict all the system emulation and tools objects with a
Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.

Using the same description over and over is not very helpful.
Use it once, just before the if() block.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5aae561984..395dd1e670 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -4,16 +4,15 @@ stub-obj-y =3D stubs/
 util-obj-y =3D crypto/ util/ qobject/ qapi/
 qom-obj-y =3D qom/
=20
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
 chardev-obj-y =3D chardev/
=20
-#######################################################################
-# authz-obj-y is code used by both qemu system emulation and qemu-img
-
 authz-obj-y =3D authz/
=20
-#######################################################################
-# block-obj-y is code used by both qemu system emulation and qemu-img
-
 block-obj-y =3D nbd/
 block-obj-y +=3D block.o blockjob.o job.o
 block-obj-y +=3D block/ scsi/
@@ -22,16 +21,12 @@ block-obj-$(CONFIG_REPLICATION) +=3D replication.o
=20
 block-obj-m =3D block/
=20
-#######################################################################
-# crypto-obj-y is code used by both qemu system emulation and qemu-img
-
 crypto-obj-y =3D crypto/
=20
-#######################################################################
-# io-obj-y is code used by both qemu system emulation and qemu-img
-
 io-obj-y =3D io/
=20
+endif # CONFIG_SOFTMMU or CONFIG_TOOLS
+
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. a
--=20
2.21.1


