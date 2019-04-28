Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891DEC43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551BA20645
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551BA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKl2n-000789-AL
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 10:44:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0p-000603-C0
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0o-000554-Aq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:39 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:52896
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKl0o-0004ay-5L; Sun, 28 Apr 2019 10:42:38 -0400
Received: from host86-175-31-255.range86-175.btcentralplus.com
	([86.175.31.255] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hKkxC-0005tp-MC; Sun, 28 Apr 2019 15:38:55 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
	rth@twiddle.net, gkurz@kaod.org
Date: Sun, 28 Apr 2019 15:38:31 +0100
Message-Id: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 86.175.31.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH 00/14] target/ppc: remove getVSR()/putVSR() and
 further tidy-up
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428143831.ECOONagBThthr7s1wXIszD_yGXaArIO1NJkHkCeunFo@z>

With the conversion of PPC VSX registers to host endian during the 4.0 development
cycle, the VSX helpers getVSR() and putVSR() which were used to convert between big
endian and host endian (and are currently just a no-op) can now be removed. This
eliminates an extra copy for each VSX source and destination register at runtime.

Patches 1-3 do the elimination work on a per-file basis and switch VSX register
accesses to be via pointers rather than on copies managed using getVSR()/putVSR().

After this patches 4-12 change the VSX registers to be passed to helpers via pointers
rather than register number so that the decode of the vector register pointers occurs
at translation time instead of at runtime. This matches how VMX instructions are
currently decoded.

Finally patches 13 and 14 perform some additional tidy-up around decoding registers
at translation time instead of runtime for VSX_REST_DC and VSX_FMADD.

Greg: I've added you as CC since you managed to find a bug in my last series. This
one is much more mechanical, but if you are able to confirm this doesn't introduce
any regressions in your test images then that would be great.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (14):
  target/ppc: remove getVSR()/putVSR() from fpu_helper.c
  target/ppc: remove getVSR()/putVSR() from mem_helper.c
  target/ppc: remove getVSR()/putVSR() from int_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X2 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X1 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_R3 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_R2 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
  target/ppc: decode target register in VSX_VECTOR_LOAD_STORE_LENGTH at
    translation time
  target/ppc: decode target register in VSX_EXTRACT_INSERT at
    translation time
  target/ppc: improve VSX_TEST_DC with new generator macros
  target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro

 target/ppc/fpu_helper.c             | 745 +++++++++++++++---------------------
 target/ppc/helper.h                 | 344 +++++++++--------
 target/ppc/int_helper.c             |  24 +-
 target/ppc/internal.h               |  12 -
 target/ppc/mem_helper.c             |  22 +-
 target/ppc/translate/vsx-impl.inc.c | 523 ++++++++++++++++---------
 6 files changed, 842 insertions(+), 828 deletions(-)

-- 
2.11.0


