Received: from eggs.gnu.org ([209.51.188.92]:45515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwpFy-00005G-1R
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwpFx-0006sm-0h
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:23:21 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:43969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwpFw-0006ru-PI
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:23:20 -0500
Received: by mail-ot1-x335.google.com with SMTP id n71so44981449ota.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
In-Reply-To: <72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 14:23:06 +0000
Message-ID: <CAFEAcA8FAja8DzrmmARZ3eZHgj1BrkNyak9HWffL7QLP27o45g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
> On 2/14/19 8:05 PM, Peter Maydell wrote:
> > Support this by making kvm_arch_put_registers() synchronize
> > CPU state back into the list. We sync only those registers
> > where the initial write succeeds, which should be sufficient.

> This commit introduces a regression when running with EDK2 FW:
>
> I get the following traces:
>
> error: kvm run failed Function not implemented
>  PC=000000013f5a6208 X00=00000000404003c4 X01=000000000000003a
> X02=0000000000000000 X03=00000000404003c4 X04=0000000000000000
> X05=0000000096000046 X06=000000013d2ef270 X07=000000013e3d1710
> X08=09010755ffaf8ba8 X09=ffaf8b9cfeeb5468 X10=feeb546409010756
> X11=09010757ffaf8b90 X12=feeb50680903068b X13=090306a1ffaf8bc0
> X14=0000000000000000 X15=0000000000000000 X16=000000013f872da0
> X17=00000000ffffa6ab X18=0000000000000000 X19=000000013f5a92d0
> X20=000000013f5a7a78 X21=000000000000003a X22=000000013f5a7ab2
> X23=000000013f5a92e8 X24=000000013f631090 X25=0000000000000010
> X26=0000000000000100 X27=000000013f89501b X28=000000013e3d14e0
> X29=000000013e3d12a0 X30=000000013f5a2518  SP=000000013b7be0b0
> PSTATE=404003c4 -Z-- EL1t
>
>
> and in host dmesg:
> [ 3507.926571] kvm [35042]: load/store instruction decoding not implemented

Ugh. Presumably this means that at some point we're writing
back a wrong value to a guest system register and making
it fall over :-( I guess debug would be by identifying
when execution diverges...

thanks
-- PMM
