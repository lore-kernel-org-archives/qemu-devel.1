Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AD7206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AD7206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkfJ-0002qo-EW
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkde-0000w4-UK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:36:42 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:10467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkdU-00086Z-Jy
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:36:42 -0400
IronPort-SDR: bXy8tnMkKqnTLZx4xa668fULSyLIXG06RbnTqNVFW5W4U+6TYkHyhYoM4dcjumWXz6Ps97XVWT
 Xa+RY94NnNvnetJW5cYPw9KG+j2iTQXsJlJGoQZ0EYE3+4Jof5NDE2BmvS2NzR/roleerLpXe8
 jn+9W/Lrq83HnBrv+BwHtLC9J8ToE3LZ8Xe+qGK5TJLk/mpOrKiaixH/Glwe0SKDW/ezg7u59R
 hRF4lHPz3lJnJJiqygZyVkyyWay1kQYw74BWWO1tvMwOK6RVlew8Qr9rD4qHHU2+7McrB4cDFC
 d0g=
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400"; d="scan'208";a="48579936"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 04 May 2020 15:36:19 -0800
IronPort-SDR: 7HfbzX/9t/hA0HwUu7sQQ+GN0CNsn0vxw7tPYrH2pYdBKibkOCfsMWmlYT2Y4YtNo+ezf04R6J
 coyAsZy7jGD092o4MJkP3ceqDrwMF0WNSROQP/vU9mOHjujkGo4wBgZz7GAmG4+52j/cJInXLj
 jYBiNuU2MUj2JYRwzAmo7pBmTmITIH0xw2DSy0CGVE8PjktT3scJRI0fxjDE6UhZYz8WRuKmJz
 0bf5TOPRUUKi3YUNAwpLgijjs3L/fbA5CuDNBkLruzURGf2ZecrbGuRIcs662ZDtNd+QU6KFj2
 JrE=
Date: Mon, 4 May 2020 23:36:12 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <pbonzini@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 0/4] softfloat: fix floatx80 emulation bugs
Message-ID: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:36:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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

Attempting to run the GCC and glibc testsuites for i686 under QEMU
shows up a range of bugs in the x87 floating-point emulation.  This
series fixes some bugs (found both through those testsuites and
through subsequent code inspection) that appear to be in the softfloat
code itself rather than in the target/i386 code; I intend to address
such bugs in target/i386 separately.

Note that the floatx80 code is used for both i386 and m68k emulation,
but the two variants of the floatx80 format are not entirely
compatible.  Where the code should do different things for i386 and
m68k, it consistently only does the thing that is right for i386, not
the thing that is right for m68k, and my patches (specifically, the
second and third patches) continue this, doing the things that are
right for i386 but not for m68k.

Specifically, the formats have the following differences (based on
documentation; I don't have m68k hardware to test):

* For m68k, the explicit integer bit of the significand may be either
  0 or 1 for infinities and NaNs, but for i386 it must be 1 and having
  0 there makes it an invalid encoding.

* For i386, when the biased exponent is 0, this is interpreted the
  same way as a biased exponent of 0 in an IEEE format; an explicit
  integer bit 0 means a subnormal value while an explicit integer bit
  1 means a pseudo-denormal; the integer bit has value 2^-16382, as
  for a biased exponent of 1.  For m68k, a biased exponent of 0
  results in the integer bit having value 2^-16383, so values with
  integer bit 1 are normal and those with integer bit 0 are
  subnormal.  So the least subnormal value is 2^-16445 for i386 and
  2^-16446 for m68k.  (This means that the i386 floatx80 format meets
  the IEEE definition of an extended format, which requires a certain
  relation between the largest and smallest exponents, but the m68k
  floatx80 format does not meet that definition.)

  Patches 2 and 3 in this series deal with pseudo-denormals in a way
  that is correct for i386 but not for m68k; to support the m68k
  format properly, the new code in patch 3 could simply be disabled
  for m68k, but addition / subtraction would need more complicated
  changes to be correct for m68k and just disabling the new code would
  not make it correct (likewise, various changes elsewhere in the
  softfloat code would be needed to handle the m68k semantics for
  biased exponent 0).

This second version of the patch series includes i386-specific tests
for the bugs being fixed (written to be reasonably self-contained
rather than depending on libm functionality).  Given the previous
discussion of how some existing tests for floating-point operations
that are present but not enabled fail for unrelated reasons if enabled
for floatx80, this does not do anything regarding enabling such tests.

Joseph Myers (4):
  softfloat: silence sNaN for conversions to/from floatx80
  softfloat: fix floatx80 pseudo-denormal addition / subtraction
  softfloat: fix floatx80 pseudo-denormal comparisons
  softfloat: fix floatx80 pseudo-denormal round to integer

 fpu/softfloat.c                            | 37 ++++++++++---
 tests/tcg/i386/test-i386-pseudo-denormal.c | 38 +++++++++++++
 tests/tcg/i386/test-i386-snan-convert.c    | 63 ++++++++++++++++++++++
 3 files changed, 131 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-pseudo-denormal.c
 create mode 100644 tests/tcg/i386/test-i386-snan-convert.c

-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

