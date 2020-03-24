Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1CC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820152074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820152074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGqlE-00007b-If
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jGqju-00073f-Dh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jGqjt-0005O5-9B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:05:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:48356
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jGqjt-0005ND-3g; Tue, 24 Mar 2020 17:05:33 -0400
Received: from host86-130-37-163.range86-130.btcentralplus.com
 ([86.130.37.163] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jGqkG-0001H4-1T; Tue, 24 Mar 2020 21:06:00 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, jsnow@redhat.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org
Date: Tue, 24 Mar 2020 21:05:16 +0000
Message-Id: <20200324210519.2974-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.163
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH for-5.0 0/3] ide: fix potential memory leaks (plus one via-ide
 bugfix)
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was supposed to be a simple patchset to switch via-ide and cmd646-ide
over to use qdev gpio in the same way as Peter's patch did for sil3112, but
at the same time I spotted a silly mistake in my last set of via-ide
patches which is included as patch 1.

I'm not sure exactly why Coverity CID 1421984 isn't triggered by the
via-ide and cmd646-ide devices, however given the simplicity of the fix it
seems worth doing just to keep everything the same and ensure it won't
suddenly appear in future.

The via-ide changes were tested using the instructions provided by Zoltan
for MIPS fulong2e and PPC pegasos2, whilst the cmd646 change was tested
using one of my SPARC64 Linux test images.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  via-ide: don't use PCI level for legacy IRQs
  via-ide: use qdev gpio rather than qemu_allocate_irqs()
  cmd646-ide: use qdev gpio rather than qemu_allocate_irqs()

 hw/ide/cmd646.c | 9 ++++-----
 hw/ide/via.c    | 7 ++++---
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.20.1


