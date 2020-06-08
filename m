Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E168AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F612053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F612053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL4y-0003aK-0P
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL2Z-0000CH-7L
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:54:27 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:45544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL2X-0000eG-A5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:54:26 -0400
IronPort-SDR: mDw2/XJfyBkVZD0vtKIUp5t5jQ/fIHFQZJ6zfeeFzoYSlH3viF6LgfgUVBrw+WQjmFsRqkxtbB
 CQtIZaTceg2phouESSHkZRfpdQnlYwdQP/sWYFzD5szY3vFHeQ49AXzUQojCZEsinB90/Jo3+H
 KGXE05WUTJNHTRQrp12PjL38XVVPs3dcZAVvmjIWbjw8vwnqBQzk3esqhj9IGyFO5c56PyvMW8
 YswwCdQ0ipOeUOHznNQ0vbys3d5FtFTppClD/6WrWDFeEmM3a7Q3tNFNv3m4NdhaEygenwLha4
 yC4=
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="49617101"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 08 Jun 2020 08:54:23 -0800
IronPort-SDR: 61D7sudd/kZ2oSTFCuqCDxPs3LJh3wX++gF5p94jskrl+Gxsa1R0jI54uWwX5tZgeuCqZS8kst
 68Y60RGB8dFjfGy7C+0tPT2y8oPo1SPYcf0+zeVYkFQQOSGNFKMJG1BwKbQNv4JzvcPelC5M5/
 AxUCvAoy1YaFyp5NBTkcJnnZsVqy8ujCv3cPyCkLjcl2TpfZgkCo5LQEktEc/EpDCJppuvvNAJ
 BxydE/JAT2jOq4iT37hxWlrRaEZZAuLUfeLQKlIbQWwGr0H0ahQdNLYG3h99mrJUU7qg4eaBSc
 WHQ=
Date: Mon, 8 Jun 2020 16:54:16 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 0/6] softfloat, target/i386: fprem, fprem1 fixes
Message-ID: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:54:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The x87 floating-point emulation of the fprem and fprem1 instructions
works via conversion to and from double.  This is inherently
unsuitable for a good emulation of any floatx80 operation.  This patch
series adapts the softfloat floatx80_rem implementation to be suitable
for these instructions and uses it to reimplement them.

There is an existing test for these instructions, test-i386-fprem.c,
based on comparison of output.  It produces 1679695 lines of output,
and before this patch series 415422 of those lines are different on
hardware from the output produced by QEMU.  Some of those differences
are because QEMU's x87 emulation does not yet produce the "denormal
operand" exception; ignoring such differences (modifying the output
from a native run not to report that exception), there are still
398833 different lines.  This patch series reduces that latter number
to 1 (that one difference being because of missing checks for
floating-point stack underflow, another global issue with the x87
emulation), or 35517 different lines without the correction for lack
of denormal operand exception support.

Several fixes to and new features in the softfloat support for this
operation are needed; floatx80_mod, previously present in the m68k
code only, is made generic and unified with floatx80_rem in a new
floatx80_modrem of which floatx80_mod and floatx80_rem are thin
wrappers.  The only architectures using float*_rem for other formats
are arm (FPA emulation) and openrisc (instructions that have been
removed in the latest architecture version); they do not appear to
need any of the new features, and all the bugs fixed are specific to
floatx80, so no changes are made to the remainder implementation for
those formats.

A new feature added is returning the low bits of the quotient from
floatx80_modrem, as needed for both x87 and m68k.  The logic used to
determine the low 7 bits of the quotient for m68k
(target/m68k/fpu_helper.c:make_quotient) appears completely bogus (it
looks at the result of converting the remainder to integer, the
quotient having been discarded by that point); this patch series does
not change that to use the new interface, but the m68k maintainers may
wish to do so.

The Intel instruction set documentation leaves unspecified the exact
number of bits by which the remainder instructions reduce the operand
each time.  The AMD documentation gives a specific formula, which
empirically Intel processors follow as well, and that formula is
implemented in the code.  The AMD documentation also specifies that
flags other than C2 are cleared in the partial remainder case, whereas
the Intel manual is silent on that (but the processors do appear to
clear those flags); this patch implements that flag clearing, and
keeps the existing flag clearing in cases where the instructions raise
"invalid" (although it seems hardware in fact only clears some but not
all flags in that case, leaving other flags unchanged).

The Intel manuals include an inaccurate table asserting that (finite
REM 0) should raise "divide by zero"; actually, in accordance with
IEEE semantics, it raises "invalid".  The AMD manuals inaccurately say
for both fprem and fprem1 that if the exponent difference is negative,
the numerator is returned unchanged, which is correct (apart from
normalizing pseudo-denormals) for fprem but not for fprem1 (and the
old QEMU code had an incorrect optimization following the AMD manuals
for fprem1).

Changes in version 2 of the patch series: fix comment formatting and
combine patches 6 and 7.

Joseph Myers (6):
  softfloat: merge floatx80_mod and floatx80_rem
  softfloat: fix floatx80 remainder pseudo-denormal check for zero
  softfloat: do not return pseudo-denormal from floatx80 remainder
  softfloat: do not set denominator high bit for floatx80 remainder
  softfloat: return low bits of quotient from floatx80_modrem
  target/i386: reimplement fprem, fprem1 using floatx80 operations

 fpu/softfloat.c          |  87 ++++++++++++++++++----
 include/fpu/softfloat.h  |   3 +
 target/i386/fpu_helper.c | 156 ++++++++++++---------------------------
 target/m68k/softfloat.c  |  83 ---------------------
 target/m68k/softfloat.h  |   1 -
 5 files changed, 122 insertions(+), 208 deletions(-)

-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

