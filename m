Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC6FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 23:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606F520700
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 23:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606F520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jobl4-0002SQ-Jo
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 19:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jobkE-00022Q-PS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 19:57:26 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:55036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jobkB-0001CQ-NN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 19:57:25 -0400
IronPort-SDR: WCpJpJKN2oHZCCpguNy659OnUVu8NEPqH/ihPXk9AkjxWrGsleq/aMRoMA5z2q0Cf7YMSD3U3e
 HooxNFHwAL4mIS/8F0FpoKkiYKGzcUC6hDWdHwr3UrElg2eQ8W8bx0L7LvqpmZBnouK3fbdqUf
 rtixA52tZU78/luCDKXa0RrslHCeh9G3vGRcmNq2uPD1KSs5FxTSbc/0p727Z6IC1SrOvrrb0J
 NHZghyQnm9YNW6jr34DqAiyR4KUuzecXxwMaG59dQhEOK3XI1Nunv5ujc1iNBNtOr32xEG0gs/
 28c=
X-IronPort-AV: E=Sophos;i="5.75,281,1589270400"; d="scan'208";a="50205195"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 25 Jun 2020 15:57:18 -0800
IronPort-SDR: TqZQZXTuFL4yHbmpXKoE06q1/WHeEXDl73xrrKQl7Y4xhY46f5jBpNOQDwJWfZGkmFRQS4S5tS
 e03LT1KcaVCf+3K3rMgcRFUbKlfVvxYdhXAiYSvJqLJn0oO/It4YrHcpnspJ/VlVh0w5pPSsbB
 MmaGLcGjL+tLH78EwPynRK3vnmSwX5AVlDBUhpR9RcuU5P7k12pH+Z3iHtCJI50x5QHESBW9My
 yM91KNxJe8eK5hlVdS1XyM2OCuJi7xdHpYyjyghDI+McJL8M28qrbWUWIrfFtEckVkTolVhp6S
 I2Q=
Date: Thu, 25 Jun 2020 23:57:13 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 0/2] target/i386: SSE floating-point fixes
Message-ID: <alpine.DEB.2.21.2006252355430.3832@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 19:57:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Fix some issues relating to SSE floating-point emulation.  The first
patch fixes a problem with the handling of the FTZ bit that was found
through the testcase written for the second patch.  Rather than
writing a separate standalone test for that bug, it seemed sufficient
for the testcase in the second patch to cover both patches.

The style checker will produce its usual inapplicable warnings about
use of "volatile" in the testcase and about C99 hex float constants.

Joseph Myers (2):
  target/i386: set SSE FTZ in correct floating-point state
  target/i386: fix IEEE SSE floating-point exception raising

 target/i386/cpu.h                         |   1 +
 target/i386/fpu_helper.c                  |  35 +-
 target/i386/gdbstub.c                     |   1 +
 target/i386/helper.c                      |   1 +
 target/i386/helper.h                      |   1 +
 target/i386/ops_sse.h                     |  28 +-
 target/i386/translate.c                   |   1 +
 tests/tcg/i386/Makefile.target            |   4 +
 tests/tcg/i386/test-i386-sse-exceptions.c | 813 ++++++++++++++++++++++
 9 files changed, 872 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-sse-exceptions.c

-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

