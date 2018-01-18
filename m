Received: from eggs.gnu.org ([2001:4830:134:3::10]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec9xo-0003P2-Ut
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec9xj-00009l-8i
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:10:40 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:38414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec9xj-00009S-2s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:10:35 -0500
Received: by mail-ot0-x22a.google.com with SMTP id v5so9665040oth.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:10:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118140605.028b7e33@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
	<CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
	<20180118140605.028b7e33@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 13:10:13 +0000
Message-ID: <CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 18 January 2018 at 13:06, Igor Mammedov <imammedo@redhat.com> wrote:
> I've looked and such case is rather an exception,
> I can fix it up in 2 ways:
> 1st:
>   target/arm/cpu.h
>   +#if !defined(CONFIG_USER_ONLY)
>   +#define TARGET_DEFAULT_CPU_TYPE TYPE_ARM_CPU
>   +else
>   +#define TARGET_DEFAULT_CPU_TYPE ARM_CPU_TYPE_NAME("any")
>   +#endif

This is weird, because TYPE_ARM_CPU isn't really
a sensible thing to use for anything, so you've really set
it up as a "this is only of any use for null-machine.c",
in which case you should just do that in null-machine.c.

> or 2nd is to compile in "any" type in system mode
> (which most targets do), roughly it would amount to:
>   target/arm/cpu.c
>   @@ -1671,10 +1671,8 @@ static const ARMCPUInfo arm_cpus[] = {
>      { .name = "pxa270-b1",   .initfn = pxa270b1_initfn },
>      { .name = "pxa270-c0",   .initfn = pxa270c0_initfn },
>      { .name = "pxa270-c5",   .initfn = pxa270c5_initfn },
>   -#ifdef CONFIG_USER_ONLY
>      { .name = "any",         .initfn = arm_any_initfn },
>    #endif
>   -#endif
>      { .name = NULL }
>    };

This is definitely wrong. We deliberately don't provide "any"
in system mode, because it's not a sensible thing for users
to try to use with board emulation. We disabled it some while
back to avoid users trying it by accident and getting confused.

In general, for Arm you really need to know which CPU you want
to use and why. So:
 linux-user and bsd-user: should use "any"
 board models: should use whatever CPU that board is designed for
 null-machine: if it genuinely doesn't care, then pick one at random

But there is no single sensible "default CPU type" at an architecture
level, which is why you can't define a TARGET_DEFAULT_CPU_TYPE
in target/arm/cpu.h. Any code that thinks it wants that should
instead be defining it own default that makes sense for that
context.

thanks
-- PMM
