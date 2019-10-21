Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E17CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320AE20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2KwOzWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320AE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMd3c-0005Q8-BL
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMd1K-0003kb-GP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMd1I-0001pi-Vp
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMd1I-0001pE-MQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571684827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x6WSQf++IXMV4lLVOQZRebwL1vu/eSofy5b/RT7dHT4=;
 b=Z2KwOzWa3kRyK5C0AdW+504AxT3W+Kmob6NeJ3nelJRB7/C23si8+gLjNofWscmRyvFqa9
 7+qVOncH9h/NTWIlzclDeTyYRIwEX9EaGqdKSxbbLqS2+/bZF0b3mpWhCGDy0ea5EIGhTl
 MaXoF40HXFP4UrvKK6ch11h5RlOyF1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-Bm8gS4xrN0WTstTyGhgVFA-1; Mon, 21 Oct 2019 15:07:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C286800D41;
 Mon, 21 Oct 2019 19:07:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8110196AE;
 Mon, 21 Oct 2019 19:06:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/6] hw/arm: Create the RAM in the board
Date: Mon, 21 Oct 2019 21:06:47 +0200
Message-Id: <20191021190653.9511-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Bm8gS4xrN0WTstTyGhgVFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

This series contains the ARM patches extracted from the
"Let the machine be the owner of the system memory" series [1]
reviewed by Richard.

These are cleanups moving the creation of the system ram at
the board level. The other series will enforce
memory_region_allocate_system_memory() get called with a
MachineState argument, this preliminary cleanup is required.

Regard,

Phil.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg05085.html

Philippe Mathieu-Daud=C3=A9 (6):
  hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
  hw/arm/mps2: Use the IEC binary prefix definitions
  hw/arm/collie: Create the RAM in the board
  hw/arm/omap2: Create the RAM in the board
  hw/arm/omap1: Create the RAM in the board
  hw/arm/digic4: Inline digic4_board_setup_ram() function

 hw/arm/collie.c       |  8 ++++++--
 hw/arm/digic_boards.c |  9 ++-------
 hw/arm/mps2-tz.c      |  3 ++-
 hw/arm/mps2.c         |  3 ++-
 hw/arm/nseries.c      | 10 +++++++---
 hw/arm/omap1.c        | 12 +++++-------
 hw/arm/omap2.c        | 13 +++++--------
 hw/arm/omap_sx1.c     |  8 ++++++--
 hw/arm/palm.c         |  8 ++++++--
 hw/arm/strongarm.c    |  7 +------
 hw/arm/strongarm.h    |  4 +---
 hw/arm/xilinx_zynq.c  |  3 ++-
 include/hw/arm/omap.h | 10 +++-------
 13 files changed, 48 insertions(+), 50 deletions(-)

--=20
2.21.0


