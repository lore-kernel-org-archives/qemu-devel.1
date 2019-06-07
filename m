Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E4C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9C3206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C3206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIWf-0006Hr-13
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZGzo-0003Yj-7q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGy5-0003QZ-MK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGy3-0003C3-KW
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2B6222387F;
 Fri,  7 Jun 2019 15:39:37 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE947FE99;
 Fri,  7 Jun 2019 15:39:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:22 +0200
Message-Id: <20190607153725.18055-27-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 15:39:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 26/29] target/rx: Restrict access to
 extable[]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/rx/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 3eef1329a1..7b8e0144c8 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -229,11 +229,10 @@ static void rx_cpu_register_types(void)
=20
 type_init(rx_cpu_register_types)
=20
-static uint32_t extable[32];
-
 void rx_load_image(RXCPU *cpu, const char *filename,
                    uint32_t start, uint32_t size)
 {
+    static uint32_t extable[32];
     long kernel_size;
     int i;
=20
@@ -246,7 +245,7 @@ void rx_load_image(RXCPU *cpu, const char *filename,
=20
     /* setup exception trap trampoline */
     /* linux kernel only works little-endian mode */
-    for (i =3D 0; i < 32; i++) {
+    for (i =3D 0; i < ARRAY_SIZE(extable); i++) {
         extable[i] =3D cpu_to_le32(0x10 + i * 4);
     }
     rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
--=20
2.20.1


