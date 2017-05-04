Received: from eggs.gnu.org ([2001:4830:134:3::10]:37084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1d6J0n-0002ki-RM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1d6J0n-0003e2-0l
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:49:49 -0400
Message-ID: <590B4D73.60000@arm.com>
Date: Thu, 04 May 2017 16:49:07 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<5908A5BC.1060202@arm.com>
In-Reply-To: <5908A5BC.1060202@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] arm64: kvm: support kvmtool to
 detect RAS extension feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com

Hi Dongjiu Geng,

On 02/05/17 16:29, James Morse wrote:
> I think we need a new API for injecting SError for SEI from Qemu/kvmtool, but it
> shouldn't be related to the RAS extensions. All v8.0 CPUs have HCR_EL2.VSE, so
> we need to know KVM supports this API.

Thinking about this some more, it is slightly more nuanced, KVM can always
provide an API to inject SError, but it can only set the VSESR if the CPU has
the RAS Extensions.

Only offering the inject-SError API call if we can also set the VSESR looks a
bit funny, but no-one has needed the no-ESR version so far.

I still don't think we should let user-space make the 'RAS Extensions means
VSESR' logical step.

So my comments on this patch become:
Don't read id registers directly, use cpus_have_cap() which handles features
that differ across CPUs or were turned off at compile time.

Please don't call this 'KVM_CAP_ARM_RAS_EXTENSION', if we are building an API to
inject SError, call it that instead.


Thanks,

James
