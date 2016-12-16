Received: from eggs.gnu.org ([2001:4830:134:3::10]:45479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cI0HG-0001gX-Uq
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cI0HF-0005GA-QV
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:42:54 -0500
Date: Fri, 16 Dec 2016 22:42:43 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161216214243.gwoxt5yz7qyqbvhi@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/23] arm: Add virtualization to GICv3,
 and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Tue, Dec 13, 2016 at 10:36:01AM +0000, Peter Maydell wrote:
> This patchset adds support for the Virtualization extensions to QEMU's
> GICv3 emulation. This was the last missing piece that was stopping
> us from turning on the EL2 support in the CPU model, so the patchset
> also adds support for enabling it all on the virt board via the
> '-machine virtualization=on' option.
> 
> The result works well enough to allow booting a KVM outer guest kernel
> and then running QEMU + an inner guest under KVM inside it. The outer
> guest KVM also passes the kvm-unit-tests GIC tests.

After seeing that multiple cpus didn't work with Linux, I modified
my EL2 supporting kvm-unit-tests branch to also output what level
each cpu starts in. I see the same issue - only cpu0 starts in El2.
Here's the new kvm-unit-tests branch

 https://github.com/rhdrjones/kvm-unit-tests/commits/arm64/hyp-test

 $ ./configure --arch=arm64 --cross-prefix=aarch64-linux-gnu-
 $ make

 $ arm/run arm/hyp-mode.flat -smp 4 -machine virtualization=on
 INFO: cpu1 did not start in HYP
 INFO: cpu2 did not start in HYP
 INFO: cpu3 did not start in HYP
 INFO: cpu0 started in HYP
 FAIL: HYP start

Thanks,
drew
