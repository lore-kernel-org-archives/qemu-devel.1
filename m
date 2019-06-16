Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA4C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 12:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9DF2147A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 12:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9DF2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcUSd-0005sJ-Fe
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 08:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUQE-0003vU-HC
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hcUQD-00062i-91
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:38:10 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:46346
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUQD-00060t-2o; Sun, 16 Jun 2019 08:38:09 -0400
Received: from host86-173-229-95.range86-173.btcentralplus.com
 ([86.173.229.95] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hcUPs-0001jp-1u; Sun, 16 Jun 2019 13:37:48 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 rth@twiddle.net, gkurz@kaod.org
Date: Sun, 16 Jun 2019 13:37:36 +0100
Message-Id: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 86.173.229.95
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH v3 00/15] target/ppc: remove getVSR()/putVSR()
 and further tidy-up
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

With the conversion of PPC VSX registers to host endian during the 4.0 development
cycle, the VSX helpers getVSR() and putVSR() which were used to convert between big
endian and host endian (and are currently just a no-op) can now be removed. This
eliminates an extra copy for each VSX source register at runtime.

Patches 1-3 do the elimination work on a per-file basis and switch VSX register
accesses to be via pointers rather than on copies managed using getVSR()/putVSR().

After this patches 4-14 change the VSX registers to be passed to helpers via pointers
rather than register number so that the decode of the vector register pointers occurs
at translation time instead of at runtime. This matches how VMX instructions are
currently decoded.

Finally patch 15 performs some related tidy-up around VSX_FMADD which decodes the
a or m form at translation time, allowing a single helper function to be used for
both implementations.

Greg: I've added you as CC since you managed to find a bug in my last series. This
one is much more mechanical, but if you are able to confirm this doesn't introduce
any regressions in your test images then that would be great.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v3:
- Rebase onto master
- Add latest R-B tags from Richard
- Fix zero init in helper_xvxsigsp() in patch 1
- Preserve order of do_float_check_status() in helper_xsrqpi() in patch 1
- Remove accidental write after store in VSX_STXVL() macro, and also just use
  the xt pointer directly in patch 2

v2:
- Rebase onto master
- Use working copy of VSX destination registers in patches 1-3 to keep current
  semantics where src == dest and exception handling
- Add patches 4 and 6 to split out helper functions still requiring an opcode
  parameter
- Remove opcode parameter from GEN_VSX_HELPER_X3 and GEN_VSX_HELPER_X2 as it
  isn't required for the common case
- Drop VSX_TEST_DC improvement patch since it is no longer applicable with the
  removal of opcode from the above macros
- Rework VSX_MADD improvement patch to use a single helper for both a and m
  forms as suggested by Richard


Mark Cave-Ayland (15):
  target/ppc: remove getVSR()/putVSR() from fpu_helper.c
  target/ppc: remove getVSR()/putVSR() from mem_helper.c
  target/ppc: remove getVSR()/putVSR() from int_helper.c
  target/ppc: introduce separate VSX_CMP macro for xvcmp* instructions
  target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c
  target/ppc: introduce separate generator and helper for xscvqpdp
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
  target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro

 target/ppc/fpu_helper.c             | 841 ++++++++++++++++--------------------
 target/ppc/helper.h                 | 320 +++++++-------
 target/ppc/int_helper.c             |  26 +-
 target/ppc/internal.h               |  12 -
 target/ppc/mem_helper.c             |  25 +-
 target/ppc/translate/vsx-impl.inc.c | 567 ++++++++++++++++--------
 target/ppc/translate/vsx-ops.inc.c  |  70 +--
 7 files changed, 952 insertions(+), 909 deletions(-)

-- 
2.11.0


