Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQjzd-0001fH-P2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQjza-0006Gy-MS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:41:05 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:33769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQjza-0006GC-GH
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:41:02 -0400
Received: by mail-yw0-x243.google.com with SMTP id f200so5866189ywb.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 17:41:02 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 20:40:56 -0400
Message-Id: <20170630004059.25619-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] Relax code buffer size limitation on
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

v3:
* Update with comments and reviews by Richard

Pranith Kumar (3):
  tcg/aarch64: Introduce and use long branch to register
  tcg/aarch64: Use ADRP+ADD to compute target address
  tcg/aarch64: Enable indirect jump path using LDR (literal)

 accel/tcg/translate-all.c    |  2 +-
 tcg/aarch64/tcg-target.inc.c | 77 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 15 deletions(-)

-- 
2.13.0
