Received: from eggs.gnu.org ([2001:4830:134:3::10]:32832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUavg-0006f7-1D
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUavc-00047S-TN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:48:56 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUavc-000475-Mb
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:48:52 -0400
Received: by mail-wr0-f172.google.com with SMTP id r103so144217908wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:48:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 16:47:43 +0100
Message-Id: <20170710154749.13624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/6] DISAS_UPDATE fixes for eret
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

This is a follow-up to the eret patch I posted on Friday:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01831.html

It fixes the same bug but does it in a slightly more holistic way. We
start by expanding the commentary on the common DISAS_n exit flags in
exec-all.h. I then update ARMs usage of DISAS_UPDATE to:

  - explicitly exit the run-loop (and not fall-through to DISAS_JUMP)
  - make setting the PC optional (as helpers may set it)

I then get rid of the architecture specific hack DISAS_EXIT and use
DISAS_UPDATE for all the eret paths.

Please review.

Alex Bennée (6):
  include/exec/exec-all: document common exit conditions
  target/arm/translate.c: make DISAS_UPDATE match declared semantics
  target/arm/translate-a64: make DISAS_UPDATE match declared semantics
  target/arm/translate-a64: get rid of DISAS_EXIT
  target/arm: use DISAS_JUMP for ISB handling
  target/arm: ensure eret exits the run-loop via DISAS_UPDATE

 include/exec/exec-all.h    | 29 ++++++++++++++++++++++++++---
 target/arm/translate-a64.c | 21 +++++++++++----------
 target/arm/translate.c     | 36 ++++++++++++++++++++++++++----------
 target/arm/translate.h     |  4 ----
 4 files changed, 63 insertions(+), 27 deletions(-)

-- 
2.13.0
