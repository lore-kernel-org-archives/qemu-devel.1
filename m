Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F4421D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F4421D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii9pB-00028j-0u
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 23:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9nh-0008Ub-8F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9nf-00023e-Fs
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:04 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34398)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ii9nf-0001x1-4e; Thu, 19 Dec 2019 23:22:03 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id DA3EA27FF9; Thu, 19 Dec 2019 23:22:01 -0500 (EST)
Message-Id: <cover.1576815466.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 00/13] Fixes for DP8393X SONIC device emulation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Dec 2019 15:17:46 +1100
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

There are bugs in the DP8393X emulation that can stop packet reception.

Whilst debugging the device I found that the receiver algorithm differs
from the one described in the National Semiconductor datasheet.

These issues and others are addressed by this patch series.

This series has only been tested with Linux/m68k guests. It needs further
testing with MIPS Magnum guests such as NetBSD or Windows NT.

Note that the mainline Linux sonic driver also has bugs.
Those bugs have been fixed in a series of patches at,
https://github.com/fthain/linux/commits/mac68k

---
Changed since v1:
 - Minor revisions described in patch descriptions.
 - Dropped patches 4/10 and 7/10.
 - Added 5 new patches.


Finn Thain (13):
  dp8393x: Mask EOL bit from descriptor addresses
  dp8393x: Clean up endianness hacks
  dp8393x: Have dp8393x_receive() return the packet size
  dp8393x: Update LLFA and CRDA registers from rx descriptor
  dp8393x: Clear RRRA command register bit only when appropriate
  dp8393x: Implement packet size limit and RBAE interrupt
  dp8393x: Don't stop reception upon RBE interrupt assertion
  dp8393x: Don't clobber packet checksum
  dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
  dp8393x: Pad frames to word or long word boundary
  dp8393x: Clear descriptor in_use field when necessary
  dp8393x: Always update RRA pointers and sequence numbers
  dp8393x: Correctly advance RRP

 hw/net/dp8393x.c | 147 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 47 deletions(-)

--=20
2.23.0


