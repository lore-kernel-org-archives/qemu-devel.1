Received: from eggs.gnu.org ([2001:4830:134:3::10]:54396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQbZQ-0006Cd-Ih
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQbZP-0006S6-Mg
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:09:12 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:33855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQbZP-0006RS-8B
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:09:11 -0500
Received: by mail-vk0-x229.google.com with SMTP id r136so5642447vke.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 07:09:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161213211606.x4cssgt4knld4m4z@hawk.localdomain>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<20161213211606.x4cssgt4knld4m4z@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 15:08:50 +0000
Message-ID: <CAFEAcA_OcGnvGGMe+9eh1tK9HXysECLeG6+x91LD8mi0kuqEkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 13 December 2016 at 21:16, Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Dec 13, 2016 at 10:36:01AM +0000, Peter Maydell wrote:
>> This patchset adds support for the Virtualization extensions to QEMU's
>> GICv3 emulation.

> I've started some testing with this. When I boot an outer (L1) kernel
> with more than one cpu allocated I get
>
> [    3.441908] CPU: CPUs started in inconsistent modes
> [    3.442787] ------------[ cut here ]------------
> [    3.445434] WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/smp.c:418 smp_cpus_done+0x80/0xa0
> ...
>
> and KVM does not init. Booting with only one cpu I see we do start in EL2
> and KVM does init.

This turns out to be a bug in QEMU's builtin PSCI implementation:
the CPU_ON call is supposed to start the new CPU in the highest
implemented-and-enabled NS exception level, but we were always
starting it in the exception level of the calling CPU. Since
Linux does its CPU_ON calls from EL1, this meant the new CPU got
started at EL1 rather than EL2.

I have a fix which I will put into v2 of the patchset (which I
will send mostly as an encouragement to further code review
since I don't think I've seen any other comments for things
I need to fix...)

thanks
-- PMM
