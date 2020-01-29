Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBBC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74412070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74412070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjqp-0007Ej-5g
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjlO-0004LY-Kn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjlN-0001Df-Fe
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:35:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50030)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iwjlN-0000jK-AQ; Wed, 29 Jan 2020 04:35:57 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 1A37A299AD; Wed, 29 Jan 2020 04:35:35 -0500 (EST)
Message-Id: <cover.1580290069.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jan 2020 20:27:49 +1100
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

There are bugs in the emulated dp8393x device that can stop packet
reception in a Linux/m68k guest (q800 machine).

With a Linux/m68k v5.5 guest (q800), it's possible to remotely trigger
an Oops by sending ping floods.

With a Linux/mips guest (magnum machine), the driver fails to probe
the dp8393x device.

With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
fatal to the guest kernel.

Whilst debugging the device, I found that the receiver algorithm
differs from the one described in the National Semiconductor
datasheet.

This patch series resolves these bugs.

AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
---
Changed since v1:
 - Minor revisions as described beneath commit logs.
 - Dropped patches 4/10 and 7/10.
 - Added 5 new patches.

Changed since v2:
 - Minor revisions as described beneath commit logs.
 - Dropped patch 13/13.
 - Added 2 new patches.

Changed since v3:
 - Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=C3=A9=
.


Finn Thain (14):
  dp8393x: Mask EOL bit from descriptor addresses
  dp8393x: Always use 32-bit accesses
  dp8393x: Clean up endianness hacks
  dp8393x: Have dp8393x_receive() return the packet size
  dp8393x: Update LLFA and CRDA registers from rx descriptor
  dp8393x: Clear RRRA command register bit only when appropriate
  dp8393x: Implement packet size limit and RBAE interrupt
  dp8393x: Don't clobber packet checksum
  dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
  dp8393x: Pad frames to word or long word boundary
  dp8393x: Clear descriptor in_use field to release packet
  dp8393x: Always update RRA pointers and sequence numbers
  dp8393x: Don't reset Silicon Revision register
  dp8393x: Don't stop reception upon RBE interrupt assertion

 hw/net/dp8393x.c | 202 +++++++++++++++++++++++++++++++----------------
 1 file changed, 134 insertions(+), 68 deletions(-)

--=20
2.24.1


