Received: from eggs.gnu.org ([209.51.188.92]:41944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSKi-0004v4-K3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSKe-0000Wn-PZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:58:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSKb-0000VW-Ev
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:57:58 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so11137332oic.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:57:44 +0100
Message-ID: <CAFEAcA-30AuFEP6hYE-CEFTr7wosAi6Mugrp=FH-xWx4X-pNww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH+RFC 0/6] target/arm: Define cortex-a{73, 75,
 76}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There have been several announcements since the a72.
>
> The a75 and a76 entries are RFC because, while they boot with a 3.15
> kernel, they do not boot with a 5.0-rc7 kernel.  I'm really not sure
> where things have gone off the rails.  It'll take some more serious
> tracing to figure out what went wrong.
>
> I post this now mostly to get feedback on patch 5.  Should we do
> more to elide *all* of the aa32 system registers for that case?

We should make sure we don't expose non-existent sysregs to
EL0, but it's harmless to define aa32 PL1_RW sysregs in
an AArch64-only-for-EL1-and-up CPU -- the guest is just never
able to access them. (This is the inverse of the way we define
a lot of AArch64 sysregs for AArch32 CPUs).

The thing to watch out for here is that where we have AArch32 and
AArch64 aliases of each other, we tend to define one as the
"real thing" and the other as the alias, which matters for
migration. If we've used the AArch32 version as the "real thing"
then we can't just skip the definition or we'll drop the register
state from the migration stream entirely.

thanks
-- PMM
