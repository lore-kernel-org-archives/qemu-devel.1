Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A2C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C69C2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C69C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQGX-000562-Pj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hsQFD-0003Xe-Ft
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hsQFB-0006fp-1L
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hsQF5-0006dB-S1; Tue, 30 Jul 2019 07:24:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16AE081DF1;
 Tue, 30 Jul 2019 11:24:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-75.ams2.redhat.com
 [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AAEF60623;
 Tue, 30 Jul 2019 11:24:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 13:24:22 +0200
Message-Id: <20190730112425.21497-2-kwolf@redhat.com>
In-Reply-To: <20190730112425.21497-1-kwolf@redhat.com>
References: <20190730112425.21497-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 30 Jul 2019 11:24:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/4] tests/multiboot: Fix load address of test
 kernels
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While older toolchains produced binaries where the physical load address
of ELF segments was the same as the virtual address, newer versions seem
to choose a different physical address if it isn't specified explicitly.
The means that the test kernel doesn't use the right addresses to access
e.g. format strings any more and the whole output disappears, causing
all test cases to fail.

Fix this by specifying the physical load address of sections explicitly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/multiboot/link.ld | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/multiboot/link.ld b/tests/multiboot/link.ld
index 3d49b58c60..2eafcffc4f 100644
--- a/tests/multiboot/link.ld
+++ b/tests/multiboot/link.ld
@@ -3,14 +3,14 @@ ENTRY(_start)
 SECTIONS
 {
     . =3D 0x100000;
-    .text : {
+    .text : AT(ADDR(.text)) {
         *(multiboot)
         *(.text)
     }
-    .data ALIGN(4096) : {
+    .data ALIGN(4096) : AT(ADDR(.data)) {
         *(.data)
     }
-    .rodata ALIGN(4096) : {
+    .rodata ALIGN(4096) : AT(ADDR(.rodata)) {
         *(.rodata)
     }
     .bss ALIGN(4096) : {
--=20
2.20.1


