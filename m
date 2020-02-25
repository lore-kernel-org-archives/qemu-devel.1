Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD529C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6F02084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJbJZ3ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6F02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yz1-0001EH-Pv
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Ykh-0000rs-RK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Ykg-0007mY-Ic
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Ykg-0007fj-EK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582631509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NPFWnv/Ef9WwpSuw1jcfq/YK7QkVuPURI5RaLd84Zyc=;
 b=MJbJZ3kuQq0xd2ZQIn3gRkSJ12Tnh9Cz1Op+njpXfvzaW1F7KOCWyJ20maUCotSTZc7LhK
 EbAWL4vgQ6HQE/C2rC5Mb8V59jrUPAHDAvN8iwbr4ZGb1t0lYHxJ+rbORRD5BifkTZ4u9k
 76DorZocLmv88PWvZekyyYxvjo3T+30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-pC-yLtEAOY-oAKrYQ58sEQ-1; Tue, 25 Feb 2020 06:51:48 -0500
X-MC-Unique: pC-yLtEAOY-oAKrYQ58sEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A07800D5B;
 Tue, 25 Feb 2020 11:51:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B10A1001DC2;
 Tue, 25 Feb 2020 11:51:42 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/nios2/boot: Remove dead code (big endian check)
Date: Tue, 25 Feb 2020 12:51:40 +0100
Message-Id: <20200225115140.10023-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jenner <andrew@codesourcery.com>, qemu-trivial@nongnu.org,
 Chris Wulff <crwulff@gmail.com>, Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only build the little-endian softmmu configuration (all
Nios II processors are only little endian). Checking for
big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nios2/boot.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 88224aa84c..000f8205d6 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -140,16 +140,11 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base=
,
     if (kernel_filename) {
         int kernel_size, fdt_size;
         uint64_t entry, low, high;
-        int big_endian =3D 0;
-
-#ifdef TARGET_WORDS_BIGENDIAN
-        big_endian =3D 1;
-#endif
=20
         /* Boots a kernel elf binary. */
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, &low, &high, NULL,
-                               big_endian, EM_ALTERA_NIOS2, 0, 0);
+                               0, EM_ALTERA_NIOS2, 0, 0);
         if ((uint32_t)entry =3D=3D 0xc0000000) {
             /*
              * The Nios II processor reference guide documents that the
@@ -160,7 +155,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
             kernel_size =3D load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL, NULL,
-                                   big_endian, EM_ALTERA_NIOS2, 0, 0);
+                                   0, EM_ALTERA_NIOS2, 0, 0);
             boot_info.bootstrap_pc =3D ddr_base + 0xc0000000 +
                 (entry & 0x07ffffff);
         } else {
--=20
2.21.1


