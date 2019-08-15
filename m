Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5042C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E4B206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E4B206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyOIt-0004Nk-IJ
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 18:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH9-00034a-IW
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH7-0006LY-Va
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hyOH7-0006KQ-Or
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 88C8974AB63;
 Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0402B7456CB; Fri, 16 Aug 2019 00:31:13 +0200 (CEST)
Message-Id: <cover.1565907489.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 16 Aug 2019 00:18:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 0/3] ati-vga fixes for MacOS driver
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These are some fixes to get MacOS driver closer to working. Patch 1
adds a simple VBlank interrupt (this could be refined later as MacOS
seems to poll it frequently enough to get 100% CPU usage when
enabled). Patch 2 fixes problems with mouse pointer color and movement
due to byte and word access to HW cursor regs and Patch 3 removes some
annoying trace messages that are frequent enough to flood the log when
traces are enabled.

With these fixes MacOS shows desktop and the mouse pointer can be
moved around but it does not seem to fully boot yet as nothing can be
clicked so it may still miss something somewhere. (Also to get to this
point one needs to run an FCode ROM which needs patches to OpenBIOS
currently.)

Regards,
BALATON Zoltan

BALATON Zoltan (3):
  ati-vga: Implement dummy VBlank IRQ
  ati-vga: Support unaligned access to hardware cursor registers
  ati-vga: Silence some noisy traces

 hw/display/ati.c      | 147 +++++++++++++++++++++++++++++++++++++++-----=
------
 hw/display/ati_dbg.c  |   1 +
 hw/display/ati_int.h  |   4 ++
 hw/display/ati_regs.h |   6 +++
 4 files changed, 128 insertions(+), 30 deletions(-)

--=20
2.13.7


