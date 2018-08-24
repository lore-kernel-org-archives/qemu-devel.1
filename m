Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDdU-0000dB-UT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDdR-0003CV-8x
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:04:27 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:35119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDdQ-0003Bu-Rf
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:04:25 -0400
Received: by mail-oi0-x22a.google.com with SMTP id m11-v6so15857503oic.2
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:04:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534870966-9287-4-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
	<1534870966-9287-4-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:04:03 +0100
Message-ID: <CAFEAcA-nN4AD1m1w8Uv=wfvAYbVVrdPAxFKN75maVJe9wi=yDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 03/74] es1370: simplify MemoryRegionOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 August 2018 at 18:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Use the automatic subregister extraction from the memory API, and avoid
> that Coverity complains about missing fallthrough comments.

Hi -- Coverity (CID 1395167) points out that these changes are wrong:

> @@ -572,21 +497,19 @@ static void es1370_writel(void *opaque, uint32_t addr, uint32_t val)
>          print_sctl (val);
>          break;
>
> -    case ES1370_REG_ADC_SCOUNT:
> -        d++;
> -    case ES1370_REG_DAC2_SCOUNT:
> -        d++;
>      case ES1370_REG_DAC1_SCOUNT:
> +    case ES1370_REG_DAC2_SCOUNT:
> +    case ES1370_REG_ADC_SCOUNT:
> +        d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
>          d->scount = (val & 0xffff) | (d->scount & ~0xffff);
>          ldebug ("chan %td CURR_SAMP_CT %d, SAMP_CT %d\n",
>                  d - &s->chan[0], val >> 16, (val & 0xffff));
>          break;
>
> -    case ES1370_REG_ADC_FRAMEADR:
> -        d++;
> -    case ES1370_REG_DAC2_FRAMEADR:
> -        d++;
>      case ES1370_REG_DAC1_FRAMEADR:
> +    case ES1370_REG_DAC2_FRAMEADR:
> +    case ES1370_REG_ADC_FRAMEADR:
> +        d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;

because these values aren't contiguous:

#define ES1370_REG_DAC1_FRAMEADR    0xc30
#define ES1370_REG_DAC2_FRAMEADR    0xc38
#define ES1370_REG_ADC_FRAMEADR     0xd30

so you can't calculate the value of 'd' from the addr
this way.

(Similarly for the SCOUNT registers.)

thanks
-- PMM
