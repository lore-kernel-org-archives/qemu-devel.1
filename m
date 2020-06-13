Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A7C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 01:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849F3206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 01:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849F3206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjuhU-0007qr-PW
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 21:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jjugX-0006eO-1W
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 21:10:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:45859)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jjugT-0001cD-Vi
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 21:10:12 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3D685748DD1;
 Sat, 13 Jun 2020 03:10:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 139D574633F; Sat, 13 Jun 2020 03:10:03 +0200 (CEST)
Message-Id: <cover.1592009699.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/2] Mac Old World ROM experiment
Date: Sat, 13 Jun 2020 02:54:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 21:10:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on https://github.com/dingusdev/dingusppc this series allows
experimenting with binary ROM image from a G3 beige machine. It does
not get very far though. Running with

-bios 78F57389.rom -d unimp,guest_errors -trace enable="pci*" | uniq -c

I get the logs below and hangs reading the last reg. It seems to
expect macio to be mapped at 0xf3000000 (also confirmed by comments in
https://github.com/dingusdev/dingusppc/blob/master/devices/macio.h and
some logs I've found on-line) but I don't see where it would set this
up so maybe this needs to be mapped by default there?

Regards,
BALATON Zoltan

      1 pci_cfg_read grackle 00:0 @0x0 -> 0x21057
      1 pci_cfg_read grackle 00:0 @0xa8 -> 0x0
      1 pci_cfg_write grackle 00:0 @0xa8 <- 0x40e0c
      1 pci_cfg_read grackle 00:0 @0xac -> 0x0
      1 pci_cfg_write grackle 00:0 @0xac <- 0x12000000
      1 pci_cfg_read grackle 00:0 @0xac -> 0x12000000
      1 pci_cfg_write grackle 00:0 @0xac <- 0x2000000
      1 pci_cfg_read grackle 00:0 @0x70 -> 0x0
      1 pci_cfg_write grackle 00:0 @0x70 <- 0x11000000
      1 machine_id_read(0, 2)
      1 pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x0
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12900000
      1 Unassigned mem write 00000000f3000024 = 0x80000000
      1 Unassigned mem write 00000000f3000028 = 0xffffffff
      1 Unassigned mem write 00000000f3000038 = 0x33eff3a
      1 Unassigned mem write 00000000f3000038 = 0x1befffa
      1 machine_id_read(0, 2)
      1 Unassigned mem read 00000000f3000038
      1 Unassigned mem write 00000000f3000038 = 0xc000010
      1 Unassigned mem write 00000000f3017e00 = 0x10
      1 Unassigned mem write 00000000f3016600 = 0x58
      1 Unassigned mem write 00000000f3016000 = 0x38
      1 Unassigned mem write 00000000f3016400 = 0x30
      1 Unassigned mem write 00000000f3017800 = 0x0
      1 Unassigned mem write 00000000f3017600 = 0x1c
      1 Unassigned mem write 00000000f3017c00 = 0x7f
      1 Unassigned mem read 00000000f3017600
      1 Unassigned mem write 00000000f3017600 = 0x0
      1 Unassigned mem write 00000000f3017c00 = 0x84
      1 Unassigned mem read 00000000f3016000
      1 Unassigned mem write 00000000f3016000 = 0x30
   3138 Unassigned mem read 00000000f3016000
   6627 Unassigned mem read 00000000f3017a00
      1 Unassigned mem read 00000000f3016000
      1 Unassigned mem write 00000000f3016000 = 0x10
   6681 Unassigned mem read 00000000f3016000
   6710 Unassigned mem read 00000000f3017a00
   6710 Unassigned mem read 00000000f3016000
   6600 Unassigned mem read 00000000f3017a00
   5543 Unassigned mem read 00000000f3016000
      1 Unassigned mem read 00000000f3000034
      1 Unassigned mem read 00000000f3016000
      1 Unassigned mem write 00000000f3016000 = 0x30
   1234 Unassigned mem read 00000000f3016000
   1195 Unassigned mem read 00000000f3017a00
      1 Unassigned mem read 00000000f3017400
      1 Unassigned mem read 00000000f3016000
      1 Unassigned mem write 00000000f3016000 = 0x0
      1 Unassigned mem read 00000000f3016000
   5441 Unassigned mem read 00000000f3017a00
   6820 Unassigned mem read 00000000f3016000
   6710 Unassigned mem read 00000000f3017a00
   5439 Unassigned mem read 00000000f3016000
      1 pci_cfg_write grackle 00:0 @0x80 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x88 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x90 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x98 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x84 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x8c <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x94 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x9c <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0xa0 <- 0x0
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12900000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12900000
      1 machine_id_read(0, 2)
      1 pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12900000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12940000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12940000
      1 pci_cfg_write grackle 00:0 @0xf4 <- 0x40010fe4
      1 pci_cfg_write grackle 00:0 @0xf8 <- 0x7302293
      1 pci_cfg_write grackle 00:0 @0xfc <- 0x25302220
      1 pci_cfg_read grackle 00:0 @0xa0 -> 0x0
      1 pci_cfg_write grackle 00:0 @0xa0 <- 0x67000000
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12940000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x129c0000
 545701 Unassigned mem read 00000000f3014020
      1 Unassigned mem write 00000000f30723f0 = 0x1c
      1 Unassigned mem write 00000000f30723e0 = 0x42
      1 Unassigned mem write 00000000f30723d0 = 0xf0
      1 Unassigned mem write 00000000f30723c0 = 0xff
      1 Unassigned mem write 00000000f3013020 = 0x9
      1 Unassigned mem write 00000000f3013020 = 0xc0
      1 Unassigned mem write 00000000f3013020 = 0xd
      1 Unassigned mem write 00000000f3013020 = 0x0
      1 Unassigned mem write 00000000f3013020 = 0xc
      1 Unassigned mem write 00000000f3013020 = 0xa
      1 Unassigned mem write 00000000f3013020 = 0xe
      1 Unassigned mem write 00000000f3013020 = 0x1
      1 Unassigned mem write 00000000f3013020 = 0xb
      1 Unassigned mem write 00000000f3013020 = 0x50
      1 Unassigned mem write 00000000f3013020 = 0x5
      1 Unassigned mem write 00000000f3013020 = 0xea
      1 Unassigned mem write 00000000f3013020 = 0x4
      1 Unassigned mem write 00000000f3013020 = 0x44
      1 Unassigned mem write 00000000f3013020 = 0x3
      1 Unassigned mem write 00000000f3013020 = 0xc1
 806156 Unassigned mem read 00000000f3013020


BALATON Zoltan (2):
  mac_oldworld: Allow loading binary ROM image
  mac_oldworld: Add machine ID register

 hw/ppc/mac_oldworld.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

-- 
2.21.3


