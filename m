Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E16C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438192075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438192075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbRT-0003kP-HH
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb2d-000412-KQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb2b-0002SS-T2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47543)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb27-0001gS-8r; Thu, 27 Jun 2019 16:30:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 000B5882FF;
 Thu, 27 Jun 2019 20:30:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4920B600CC;
 Thu, 27 Jun 2019 20:29:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:10 +0200
Message-Id: <20190627202719.17739-20-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 27 Jun 2019 20:30:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 19/28] hw/block/pflash_cfi02: Extract
 pflash_regions_count()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the pflash_regions_count() function, the code will be
easier to review.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 1f096ec185..a0d3bd60dc 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -157,6 +157,11 @@ static void pflash_register_memory(PFlashCFI02 *pfl,=
 int rom_mode)
     pfl->rom_mode =3D rom_mode;
 }
=20
+static size_t pflash_regions_count(PFlashCFI02 *pfl)
+{
+    return pfl->cfi_table[0x2c];
+}
+
 static void pflash_timer (void *opaque)
 {
     PFlashCFI02 *pfl =3D opaque;
@@ -192,9 +197,8 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, hw=
addr offset,
 static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)
 {
     assert(offset < pfl->chip_len);
-    int nb_regions =3D pfl->cfi_table[0x2C];
     hwaddr addr =3D 0;
-    for (int i =3D 0; i < nb_regions; ++i) {
+    for (int i =3D 0; i < pflash_regions_count(pfl); ++i) {
         uint64_t region_size =3D (uint64_t)pfl->nb_blocs[i] * pfl->secto=
r_len[i];
         if (addr <=3D offset && offset < addr + region_size) {
             return pfl->sector_len[i];
--=20
2.20.1


