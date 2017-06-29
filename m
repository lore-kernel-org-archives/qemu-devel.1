Received: from eggs.gnu.org ([2001:4830:134:3::10]:55791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFs-0006H6-Iv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFp-0005vw-IC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:48 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:35513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQUFp-0005vl-CR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:45 -0400
Received: by mail-yw0-x241.google.com with SMTP id z21so4618166ywz.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 00:52:45 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 03:52:40 -0400
Message-Id: <20170629075243.26984-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Relax code buffer size limitation on
 aarch64 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

Hello,

The following patches enable us to relax the 128MB code buffer size
limitation on ARM64 hosts.

Patch 2 increases this limitation to 3GB, even though ADRP+ADD can
address 4GB of pc-relative addresses to give us some slack.

Patch 3 uses LDR (literal) to load the address, allowing us to remove
the code buffer size limitation altogether. However, I feel that 3GB
should be sufficient for now and hence did not change it ;). It
however enables the !USE_DIRECT_JUMP path on aarch64 hosts.

Thanks,

Pranith Kumar (3):
  tcg/aarch64: Introduce and use long branch to register
  tcg/aarch64: Use ADRP+ADD to compute target address
  tcg/aarch64: Enable indirect jump path using LDR (literal)

 accel/tcg/translate-all.c    |  2 +-
 tcg/aarch64/tcg-target.inc.c | 69 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 15 deletions(-)

-- 
2.13.0
