Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E560C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AD1207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AD1207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWUdI-0007mZ-4y
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 20:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUce-0007De-Q1
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:42:44 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:64294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUcc-0003VF-Kr
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:42:44 -0400
IronPort-SDR: kf/FT9FU5+Q0kxBgYDelklWlHPoTwQXaiK0OwinXnf4148Iz3jJqa09uBG4hjkwehBhkG4I/yB
 DjtZXqWK6srvDht11om1QkQztWg0it9rtpBH9L9+pX1AzWCYv7xGjG+pUj2d/QigZR3WqfpA4N
 55VDFQAqNF2ZDxtzMVwxhtIOl4xVMnC5rbSOLgnkBWGlaSG0KikSiIBldnrbI7cPCYH1Lsij25
 inYpRSeTRaB67Io4ohdIqZzKpo+zNg88uiBIYrcJV+OEAjd4NAStYZLv9eVq40sXEQn7uS+2ef
 3hc=
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="48541240"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 06 May 2020 16:42:37 -0800
IronPort-SDR: fE3f8ALgf3DrYV2N31iY4kmrb3d0XD88cVLvE3VahhH3lXiyvgu0KUbThkCp55Tf7rBzEH5olv
 a7IlpZBFLmsEuw85enj3lfV2YHHm9htV75RqYNT2icqHhIiGfjgtDVxX6qvuXPMOoztmjVUU4y
 Qm7aP6yFkc6tcP6pVpuQiqqilGOLNLAr6k7Jd3Pg3DLYEZTdMUs1/RzBIIYSTbLiMlljrk5N4x
 LWhOvpQ+mkoeOkY3L2uX1qxGhT9XCgNIimAPSj7DCOTyCU1zR6zjMzky7hBG9HpAUDdL7GrwaN
 FnA=
Date: Thu, 7 May 2020 00:42:31 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 0/5] target/i386: fxtract, fscale fixes
Message-ID: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 20:42:37
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

Among the various bugs in the x87 floating-point emulation that show
up through a combination of glibc testing and code inspection, there
are several in the implementations of the fxtract and fscale
instructions.  This series fixes those bugs.

Bugs in other instructions, and bugs relating to floating-point
exceptions and flag setting, will be addressed separately.  In
particular, while some of these patches add code that sets exception
flags in the softfloat state, it's generally the case that the x87
emulation ignores exceptions in that state rather than propagating
them to the status word (and to generating traps where appropriate).
I intend to address that missing propagation of exceptions in a
subsequent patch series; until it's addressed, the code setting
exceptions won't actually do anything useful.  (There is also code in
the x87 emulation, including that of fscale, that would result in
spurious exceptions being set from a naive propagation of exceptions
from the softfloat state, and thus will need updating to avoid
propagating inappropriate exceptions when such propagation is
implemented.)

Joseph Myers (5):
  target/i386: implement special cases for fxtract
  target/i386: fix fscale handling of signaling NaN
  target/i386: fix fscale handling of invalid exponent encodings
  target/i386: fix fscale handling of infinite exponents
  target/i386: fix fscale handling of rounding precision

 target/i386/fpu_helper.c           |  59 +++++++++++++-
 tests/tcg/i386/test-i386-fscale.c  | 108 ++++++++++++++++++++++++++
 tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fscale.c
 create mode 100644 tests/tcg/i386/test-i386-fxtract.c

-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

