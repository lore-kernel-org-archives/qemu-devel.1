Received: from eggs.gnu.org ([2001:4830:134:3::10]:41533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUeGQ-00086e-GJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUeGN-000760-DA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:22:34 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUeGN-00075o-5r
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:22:31 -0400
Received: by mail-wr0-f170.google.com with SMTP id k67so151271253wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 12:22:31 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 20:21:23 +0100
Message-Id: <20170710192128.9048-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/5] arm: fixes for eret,
 isb and DISAS_UPDATE handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is a quick iteration from the previous series:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02371.html

Which was born out of the fix:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01831.html

Following feedback I reverted the attempt to use DISAS_UPDATE for
everything and just made it match the semantics of not-chaining. So
patches 1 & 3 are purely documentation.

Patch 2 should prevent any system change prompted by writing to a
system register not exiting the loop.

Patch 4 is a minor optimisation to ISB handling
Patch 5 fixes the eret regression from the DISAS_JUMP optimisation

I think now all users of DISAS_JUMP should be safe with respect to TB
chaining.

Please review.

Alex Bennée (5):
  include/exec/exec-all: document common exit conditions
  target/arm/translate: make DISAS_UPDATE match declared semantics
  target/arm/translate.h: expand comment on DISAS_EXIT
  target/arm: use DISAS_JUMP for ISB handling
  target/arm: use DISAS_EXIT for eret handling

 include/exec/exec-all.h    | 29 ++++++++++++++++++++++++++---
 target/arm/translate-a64.c | 20 +++++++++++---------
 target/arm/translate.c     | 24 +++++++++++++++++-------
 target/arm/translate.h     |  5 ++++-
 4 files changed, 58 insertions(+), 20 deletions(-)

-- 
2.13.0
