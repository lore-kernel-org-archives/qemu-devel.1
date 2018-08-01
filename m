Received: from eggs.gnu.org ([2001:4830:134:3::10]:36990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fktXY-00030O-72
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fktXX-0000q8-3l
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:59:56 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fktXW-0000pU-RV
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:59:55 -0400
Received: by mail-oi0-x241.google.com with SMTP id n84-v6so35493611oib.9
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 08:59:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180801151417.23655-1-pbonzini@redhat.com>
References: <20180801151417.23655-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Aug 2018 16:59:33 +0100
Message-ID: <CAFEAcA8WXLyAgesP6n2X7D-Uj46uZbY0209xaLLTJ1M2GojA2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fix "Missing break in switch" coverity
 reports
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

On 1 August 2018 at 16:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Many of these are marked as "intentional/fix required" because they
> just need adding a fall through comment.  This is exactly what this
> patch does, except for target/mips/translate.c where it is easier to
> duplicate the code, and hw/audio/sb16.c where I consulted the DOSBox
> sources and decide to just remove the LOG_UNIMP before the fallthrough.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 5a4d32364e..665a7e75c5 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -741,10 +741,8 @@ static void complete (SB16State *s)
>              ldebug ("set time const %d\n", s->time_const);
>              break;
>
> -        case 0x42:              /* FT2 sets output freq with this, go figure */
> -            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
> -                          " should\n");
>          case 0x41:
> +        case 0x42:              /* FT2 sets output freq with this, go figure */
>              s->freq = dsp_get_hilo (s);
>              ldebug ("set freq %d\n", s->freq);
>              break;

I agree with the outcome; see previous discussions
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02081.html
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02079.html

and this description of what the hardware does:
http://homepages.cae.wisc.edu/~brodskye/sb16doc/sb16doc.html#SamplingRate

We could improve the somewhat cryptic comment:
    /*
     * 0x41 is documented as setting the output sample rate,
     * and 0x42 the input sample rate, but in fact SB16 hardware
     * seems to have only a single sample rate under the hood,
     * and some (buggy) guest programs such as FT2 will set the
     * output rate using 0x42. Compare:
     * http://homepages.cae.wisc.edu/~brodskye/sb16doc/sb16doc.html#SamplingRate
     */

thanks
-- PMM
