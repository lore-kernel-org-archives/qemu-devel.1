Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C350BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6E3206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6E3206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzSP-0001R1-SR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpzRH-00081i-3j; Mon, 29 Jun 2020 15:27:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpzRC-0002GX-Dk; Mon, 29 Jun 2020 15:27:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 24E9E748DCF;
 Mon, 29 Jun 2020 21:27:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 01C43745712; Mon, 29 Jun 2020 21:27:18 +0200 (CEST)
Message-Id: <cover.1593456926.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 0/8] Mac Old World ROM experiment
Date: Mon, 29 Jun 2020 20:55:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

This is now a minimal set of patches needed to make it possible to
experiment with a firmware ROM from real hardware. After finding out
that the board firmware does not probe PCI devices but expects them at
known fixed addresses we only need to change the address of the macio
device to get the firmware correctly map it. This allows dropping
workarounds in previous versions for this and now only the minimal set
of patches are included to get the firmware loaded and do something.
(Also excluded the grackle revision and machine ID pathes for now that
may be needed as the firmware accesses these but seems to go further
without them so until we hit a problem we can live without it,
although I wonder if this causes us unnecessary debugging later so
unless they cause regressions they could be merged).

I still don't get video output but at least it talks to the GPU chip
now so it can be debugged and improved (this will either need
emulating the correct chip the firmware has a driver for or an OF
compliant ROM for the emulated card).

As before the I2C part (patches 6-8) is RFC and unfinished but the
first 5 patches should be good enough now. I hope someone can take
care of I2C, I can look at the ati-vga side later.

Regards,
BALATON Zoltan

BALATON Zoltan (8):
  mac_oldworld: Allow loading binary ROM image
  mac_newworld: Allow loading binary ROM image
  mac_oldworld: Drop a variable, use get_system_memory() directly
  mac_oldworld: Drop some variables
  mac_oldworld: Change PCI address of macio to match real hardware
  i2c: Match parameters of i2c_start_transfer and i2c_send_recv
  WIP macio/cuda: Attempt to add i2c support
  mac_oldworld: Add SPD data to cover RAM

 hw/display/sm501.c           |  2 +-
 hw/i2c/core.c                | 34 +++++++-------
 hw/i2c/ppc4xx_i2c.c          |  2 +-
 hw/misc/macio/cuda.c         | 76 ++++++++++++++++++++++++++++++-
 hw/ppc/mac.h                 |  2 -
 hw/ppc/mac_newworld.c        | 22 +++++----
 hw/ppc/mac_oldworld.c        | 86 +++++++++++++++++++++++-------------
 include/hw/i2c/i2c.h         |  4 +-
 include/hw/misc/macio/cuda.h |  1 +
 9 files changed, 167 insertions(+), 62 deletions(-)

-- 
2.21.3


