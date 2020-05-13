Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9DAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575D020575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575D020575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ182-0007o6-72
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ177-00073H-97
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:48:37 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:33443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ174-0001XY-R7
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:48:36 -0400
IronPort-SDR: tAHN9PLLLLDqA296LNHzl1IX8fYEFXh0KqZVsvX6q1S6y8Fj/97IWii8oGJkidiDG9SO4XPjZ1
 bM9VvtRA+uigW4eT/sioqx3XmX4wPWM6i/0jtEkvXwY79E+Gyzz0lRR+5QwrcbwOkgL0wOh5ee
 XrbihtuHTZS1QM93N2NZI2a26bU65yPEnF9itoDP2ugaZJhxkJz5KS1z3+6jHchw+I5M+cP+d5
 VaOGsfiAf95ppWIi6B1YMgqhxGdKbr8+2HBStr+cf2qEKWXHrPqEgnlE+yT9uruuYRujmR9lNg
 8Vc=
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="48881433"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 13 May 2020 15:48:30 -0800
IronPort-SDR: 5K25mymgb8RBecWCKebYrqhGB5C4vGfguDh5mOetzjigPcAGcq24sPWnJCJ/u5gbH/dPbL4INv
 HLEyJYTWMD3F2WHk0ULZZpERj0AVIBhdsNfgD3LXycJs7exG7EJmSyjXhAyopZMfUyhVMLYjeY
 vtOzUqOulXW30JvZfCyTl6AySY6L/ZDfWWNP91pTIWaWP2UIjxUg1zamUF8ezMKxqPu+QRVo2S
 WOGb4La/Tx2RJlzXnr11AP98ZdvUwGls3GwT9NGG/f+G/y5JpGSz08MLzVAYsCf1Mbm+F+Z+vM
 C5w=
Date: Wed, 13 May 2020 23:48:24 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 0/4] target/i386: miscellaneous x87 fixes
Message-ID: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:48:30
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

Following my previous patch series
<https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg00781.html>
and
<https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01465.html>
for problems found in the x87 floating-point emulation, this patch
series fixes further miscellaneous bugs in that emulation.

There are further problems with x87 emulation that I am aware of and
intend to address in future patch series.  Those other problems, not
addressed by the first three patch series, generally relate to
exceptions, flag setting and those instructions for which the
emulation currently converts to host double (so losing range and
precision) and then works on host double for the rest of the emulation
process before converting back to floatx80 at the end.  Thus, the same
comments as for the previous patch series apply about this patch
series not fixing missing propagation of exceptions even when it adds
code to set exceptions in the softfloat state.

Joseph Myers (4):
  target/i386: fix floating-point load-constant rounding
  target/i386: fix fxam handling of invalid encodings
  target/i386: fix fbstp handling of negative zero
  target/i386: fix fbstp handling of out-of-range values

 target/i386/fpu_helper.c          |  73 +++++++++--
 tests/tcg/i386/test-i386-fbstp.c  | 140 +++++++++++++++++++++
 tests/tcg/i386/test-i386-fldcst.c | 199 ++++++++++++++++++++++++++++++
 tests/tcg/i386/test-i386-fxam.c   | 143 +++++++++++++++++++++
 4 files changed, 547 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fbstp.c
 create mode 100644 tests/tcg/i386/test-i386-fldcst.c
 create mode 100644 tests/tcg/i386/test-i386-fxam.c

-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

