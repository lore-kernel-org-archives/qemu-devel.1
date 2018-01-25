Received: from eggs.gnu.org ([2001:4830:134:3::10]:46850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eejB3-0003Ep-7s
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eejAz-0005N4-AQ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:10:57 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eejAz-0005Mf-4a
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:10:53 -0500
Received: by mail-oi0-x241.google.com with SMTP id k15so5439173oib.1
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 07:10:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
	<CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
	<20180122183301.GA31237@localhost.localdomain>
	<CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 15:10:31 +0000
Message-ID: <CAFEAcA96N1Nuh9rXVtWnmnmm_+xQRFiesdSLbTx4yJBGYEVJaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 25 January 2018 at 14:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 January 2018 at 18:33, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> About QOM type names:
>>
>> On x86, all CPU models are resolved to "<model>-<suffix>", and
>> i386 and x86_64 have different suffixes.  So the QOM type name is
>> "max-x86_64-cpu" on qemu-system-x86_64, and "max-i386-cpu" on
>> qemu-system-i386.
>
> OK. Looking at the target/arm code we do a similar suffix
> trick, but we seem to have cut-n-pasted the handling in
> aarch64_cpu_register(), so it uses the TYPE_ARM_CPU as the
> suffix, rather the TYPE_AARCH64_CPU.

...and that's not as simple a fix as I thought, because the
code in helper.c for implementing arch_query_cpu_definitions() and
arm_cpu_list() assumes it can create the QOM type name by appending
TYPE_ARM_CPU. The ARM_CPU_TYPE_NAME() macro which we use pretty
extensively also assumes the suffix is the same regardless of
what CPU type it's being applied to.

Looking at x86 it seems that TYPE_X86_CPU expands to a different
string for qemu-system-x86_64 and qemu-system-i386. I could do
that, but it seems very confusing: I would expect a QOM type
name like TYPE_FOO to always mean the same QOM type.

Given that the type names don't appear to the user, I think
we can go ahead with implementing "-cpu max" for Arm without
having to first disentangle this? "max" isn't in any worse
a position than the existing "host" and "any" types.

thanks
-- PMM
