Received: from eggs.gnu.org ([2001:4830:134:3::10]:37105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gZU-0005SR-6d
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gZS-0004mR-OT
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:03:43 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6gZS-0004mD-Jb
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:03:42 -0400
Received: by mail-ot0-x243.google.com with SMTP id m22-v6so7001604otf.8
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-4-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-4-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 19:03:21 +0100
Message-ID: <CAFEAcA-Fm3Vq3VZwMa7zuKt+=N6s0L+D9C1Q_8LEi1Vv5JfCtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/14] timer: ds1338 persist 12-hour mode
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2018 at 19:24, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> Need to save HOUR[HOUR12] bit to keep
> track of guest selection of 12-hour mode.
> Write through current time registers to
> achieve this.  Will be overwritten
> by the next read/latch.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds1338.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index b5630e214a..72a4692d60 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -224,10 +224,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>             value unchanged. */
>          data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
>
> -        s->nvram[s->ptr] = data;
> -    } else {
> -        s->nvram[s->ptr] = data;
>      }
> +    s->nvram[s->ptr] = data;
>      inc_regptr(s);
>      return 0;

The code change here looks like a reasonable no-behaviour-change
simplification of the code, but it doesn't match up with
the description in the commit message ?

thanks
-- PMM
