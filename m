Received: from eggs.gnu.org ([209.51.188.92]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbku-0006aS-Qp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkt-00012d-Hz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMbkt-000111-A3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so8761979wre.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:13:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 May 2019 18:13:45 +0100
Message-Id: <20190503171347.13747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] hw/arm/boot: handle large Images more
 gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Mark Rutland <mark.rutland@arm.com>

This patchset attempts to fix https://bugs.launchpad.net/qemu/+bug/1823998
which reports that we don't handle kernels larger than 128MB
correctly, because we allow the initrd to be placed over the
tail end of the kernel. AArch64 kernel Image files (since v3.17)
report the total size they require (including any BSS area that
isn't in the Image itself), so we can use that to be sure we
place the initrd sufficiently far into the RAM.

Patch 1 in this series adjusts our "where do we put the initrd"
heuristic so that it always places it at least after whatever
our best guess at the kernel size is. (This might still not
be right for images like self-decompressing 32-bit kernels, where
there's no way to know how big the kernel will be after
decompression.) Patch 2 makes load_aarch64_image() return the
kernel size as indicated in the Image file header, so that for
the specific case of AArch64 Image files we will definitely not
put the initrd on top of them.

I've given this a quick smoke test but I don't have a very large
Image kernel to hand, so testing appreciated.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/boot: Avoid placing the initrd on top of the kernel
  hw/arm/boot: Honour image size field in AArch64 Image format kernels

 hw/arm/boot.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

-- 
2.20.1
