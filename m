Received: from eggs.gnu.org ([209.51.188.92]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtxwF-0006dm-M1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtxwE-0007Ea-QT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:03:11 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtxwE-0007C6-JO
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:03:10 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so5400582ota.12
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 09:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20181206151401.13455-1-peter.maydell@linaro.org>
	<87ftsrird3.fsf@zen.linaroharston>
In-Reply-To: <87ftsrird3.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Feb 2019 17:02:57 +0000
Message-ID: <CAFEAcA_GPW0B9bMOia_aB=H0PV8DwUNWBARz+uNbRk2565a+4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] arm: Allow system registers for KVM guests
 to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Dongjiu Geng <gengdongjiu@huawei.com>

On Wed, 13 Feb 2019 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > At the moment the Arm implementations of kvm_arch_{get,put}_registers()
> > don't support having QEMU change the values of system registers
> > (aka coprocessor registers for AArch32). This is because although
> > kvm_arch_get_registers() calls write_list_to_cpustate() to
> > update the CPU state struct fields (so QEMU code can read the
> > values in the usual way), kvm_arch_put_registers() does not
> > call write_cpustate_to_list(), meaning that any changes to
> > the CPU state struct fields will not be passed back to KVM.
> >
> > The rationale for this design is documented in a comment in the
> > AArch32 kvm_arch_put_registers() -- writing the values in the
> > cpregs list into the CPU state struct is "lossy" because the
> > write of a register might not succeed, and so if we blindly
> > copy the CPU state values back again we will incorrectly
> > change register values for the guest. The assumption was that
> > no QEMU code would need to write to the registers.
> >
> > However, when we implemented debug support for KVM guests, we
> > broke that assumption: the code to handle "set the guest up
> > to take a breakpoint exception" does so by updating various
> > guest registers including ESR_EL1.
> >
> > Support this by making kvm_arch_put_registers() synchronize
> > CPU state back into the list. We sync only those registers
> > where the initial write succeeds, which should be sufficient.

> [snip a long test setup that I didn't really understand]

I'm confused -- I'm not sure if the things you're saying
didn't work:
 (a) didn't work before this patch and still don't
 (b) used to work and are broken by this patch
 (c) used to not work and are fixed by this patch

More generally:
 * this patch claims to fix the code path where QEMU sets
   up the guest to take a breakpoint exception (specifically
   making our change of ESR_EL1 actually take effect) -- so does
   it do that? Or is it impossible for that code path in QEMU
   to be used (if so, can we just remove it) ?

thanks
-- PMM
