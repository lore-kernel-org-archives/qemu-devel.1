Received: from eggs.gnu.org ([209.51.188.92]:43931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3N1W-0002qd-ND
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3N1R-0005aN-24
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:39:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3N1P-0005Zl-4H
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:39:23 -0400
Received: by mail-oi1-x244.google.com with SMTP id w66so3996399oia.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 08:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <0184EA26B2509940AA629AE1405DD7F202153AC7@dggema523-mbx.china.huawei.com>
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F202153AC7@dggema523-mbx.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 15:39:09 +0000
Message-ID: <CAFEAcA9yr3trFz7ZFsS-P-g=gxe=MX6Eet_dTdcOCSdhW7_J4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH] target/arm: change arch timer
 registers access permission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Mar 2019 at 15:24, gengdongjiu <gengdongjiu@huawei.com> wrote:
> So If QEMU defined the timer registers read only in PL0, even though it has been configured to have write permission in PL0 by high PLx, we still cannot have
> Write permission, because QEMU will firstly check the defined permission and then check the configured permission by high PLx.

I'm afraid I don't understand what you're trying to say here.

Yes, it was a bug that we marked these registers as read-only for PL0,
and we should fix it.

What I am trying to say is that
 .access = PL1_RW | PL0_RW

is exactly equivalent to
 .access = PL0_RW

and we should use the simpler version of the expression.

(If you look at the definitions of all the PL*_ constants,
you can see that PL0_W implies PL1_W:
#define PL0_W (0x01 | PL1_W)
and similarly for PL0_R. So all the bits in the bitfield that would be
set by PL1_RW are also set by PL0_RW.)

thanks
-- PMM
