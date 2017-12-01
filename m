Received: from eggs.gnu.org ([2001:4830:134:3::10]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqqC-0004JG-Ua
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqqC-00030Q-82
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:19:16 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Dec 2017 18:51:34 +0000
Message-Id: <1512154296-5652-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] v8m: make systick banked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This patchset makes the systick device be banked between
security states for ARM v8M.

It is perhaps not the absolute cleanest way to implement
this banking, but the alternative (which I had an irc
discussion with Paolo about some weeks back) would involve
adding a feature to our IOMMU abstraction to allow them
to change transaction attributes, refactoring the NVIC
so that it exposes memory regions for its S and NS views
separately (to be mapped into the CPU's S and NS address
spaces by the board code), and then using an IOMMU region
to implement the "S alias that behaves like NS" memory
region. This version is less than 100 lines by diffstat :-)

thanks
-- PMM

Peter Maydell (2):
  nvic: Make nvic_sysreg_ns_ops work with any MemoryRegion
  nvic: Make systick banked

 include/hw/intc/armv7m_nvic.h |  4 +-
 hw/intc/armv7m_nvic.c         | 91 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 16 deletions(-)

-- 
2.7.4
