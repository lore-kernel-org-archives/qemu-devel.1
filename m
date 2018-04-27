Received: from eggs.gnu.org ([2001:4830:134:3::10]:34151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC7Wm-0002KC-Be
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC7Wl-0005nz-JU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:51:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC7Wl-0005nm-De
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:51:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id 11-v6so2301919ois.8
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 10:51:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427134728.2w5f3tx2hjcdgucd@kamzik.brq.redhat.com>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-6-git-send-email-imammedo@redhat.com>
	<20180427134728.2w5f3tx2hjcdgucd@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 18:51:02 +0100
Message-ID: <CAFEAcA_NMWuA8WSs3cNeY6xX1kerO_uAcN_3=fK02BEhHJW86g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13 v2 5/5] arm/boot: split load_dtb()
 from arm_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 27 April 2018 at 14:47, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Apr 18, 2018 at 04:28:05PM +0200, Igor Mammedov wrote:
>> @@ -1173,15 +1141,6 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>>      for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
>>          ARM_CPU(cs)->env.boot_info = info;
>>      }
>
> I wonder why we need to start at cpu here, but first_cpu below. If
> they could both be first_cpu, then we could merge the loop statements
> into one loop. Reading enough code to build confidence that it could
> be first_cpu is too much to ask for a Friday afternoon though...

It should be starting at first_cpu -- starting with 'cpu' is
a bug. However as with the bug fixed in 75ed2c02484101d5, it
isn't currently causing any incorrect behaviour, because every
board we have is passing first_cpu as the boot cpu, either directly
or indirectly.

There is a theoretical use case for only feeding the boot_info
to a subset of CPUs, which is where you have a setup like
the xilinx zynqmp which has 4x A-class cores which run Linux
and 4x R-class cores which run something else; in that setup
you might want to say "the boot_info stuff we have here is
just for the A-class cluster, and the R-class cores should
look after themselves". However, (a) we don't really properly
support heterogenous setups like that -- zynqmp works by
accident rather than design -- and (b) if we do want to
support them we need a sensible API for indicating which
CPUs should or should not be involved in -kernel boot as
primary or secondaries.

So we should fix this loop to start at first_cpu, and worry
about the heterogenous setup usecase if and when it becomes
reality rather than theory.

thanks
-- PMM
