Received: from eggs.gnu.org ([2001:4830:134:3::10]:42725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3tUe-0006Tj-O9
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 20:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3tUd-0002OW-Tq
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 20:10:40 -0400
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
Date: Thu, 27 Apr 2017 19:10:30 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix compilation dependency issues of
 CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



On 04/27/2017 04:13 PM, Peter Maydell wrote:
> On 27 April 2017 at 18:38, Wei Huang <wei@redhat.com> wrote:
>> CONFIG_ARM_V7M is used to control the compilation of NVIC and SysTick
>> Timer in QEMU. These two devices are not available when CONFIG_ARM_V7M
>> is un-defined. This can cause problems with ARMv7M code as it is tightly
>> integrated with NVIC for processing IRQ and exception.
>>
>> This patchset addresses the problem by introducing stub functions when
>> CONFIG_ARM_V7M is not defined. It also makes the compilation of several
>> existing v7M-profile SoCs depedent on CONFIG_ARM_V7M.
> 
> Can you explain in what situation this causes a problem?
> It's not clear to me what you're trying to fix...

In our downstream code, we try to minimize the number of supported
devices to reduce the maintenance effort. ARM v7M is not in the
supported list.

For most unsupported devices, we can remove them by configuring
default-configs file, except for CONFIG_ARM_V7M=y. This is because the
ARMv7m code in target/arm/helper.c intertwines with NVIC code. As a
result we have to keep NVIC and SysTick in order to compile helper.c,
which is not desirable.

This patchset tries to address the problem by making NVIC and SysTick
removable.

PS: There is a compilation issue under user mode. I will send out
another version to address it (by adding #ifndef CONFIG_USER_ONLY in
stub code).

> 
> thanks
> -- PMM
> 
