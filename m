Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCOUy-00032i-7E
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCOUt-0007rP-SQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:30:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCOUs-0007mb-UB
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:30:51 -0400
Received: by mail-oi1-x242.google.com with SMTP id u197-v6so17846128oif.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 05:30:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180825074742.15963-1-pbonzini@redhat.com>
References: <20180825074742.15963-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 13:30:27 +0100
Message-ID: <CAFEAcA_nM97VPBJqTRhPiAd-5Vss0iDxgKBW1ryETeAvMvVT5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] es1370: fix ADC_FRAMEADR and ADC_FRAMECNT
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

On 25 August 2018 at 08:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
> They are not consecutive with DAC1_FRAME* and DAC2_FRAME*.
>
> Fixes: 154c1d1f960c5147a3f8ef00907504112f271cd8
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/audio/es1370.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index dd75c9e8f5..4f980a598b 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -506,10 +506,13 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>                  d - &s->chan[0], val >> 16, (val & 0xffff));
>          break;
>
> +    case ES1370_REG_ADC_FRAMEADR:
> +        d += 2;
> +        goto frameadr;
>      case ES1370_REG_DAC1_FRAMEADR:
>      case ES1370_REG_DAC2_FRAMEADR:
> -    case ES1370_REG_ADC_FRAMEADR:
>          d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
> +    frameadr:
>          d->frame_addr = val;
>          ldebug ("chan %td frame address %#x\n", d - &s->chan[0], val);
>          break;
> @@ -521,10 +524,13 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>          lwarn ("writing to phantom frame address %#x\n", val);
>          break;
>
> +    case ES1370_REG_ADC_FRAMECNT:
> +        d += 2;
> +        goto framecnt;
>      case ES1370_REG_DAC1_FRAMECNT:
>      case ES1370_REG_DAC2_FRAMECNT:
> -    case ES1370_REG_ADC_FRAMECNT:
>          d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
> +    framecnt:
>          d->frame_cnt = val;
>          d->leftover = 0;
>          ldebug ("chan %td frame count %d, buffer size %d\n",

Hi Paolo; I've just noticed that this patch (now commit cf9270e522067)
fixed the es1370_write() but left the code in es1370_read() unfixed.
Coverity complains in CID 1395185 (though oddly only about the
ADC_FRAMECNT case, not the ADC_FRAMEADR one).

thanks
-- PMM
