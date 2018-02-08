Received: from eggs.gnu.org ([2001:4830:134:3::10]:43960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejjwP-0006Nj-5c
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejjwJ-0007jX-7d
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:00:33 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:34233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejjwJ-0007jH-0l
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:00:27 -0500
Received: by mail-oi0-x230.google.com with SMTP id k15so3169343oib.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 03:00:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202075009.11653-3-kraxel@redhat.com>
References: <20180202075009.11653-1-kraxel@redhat.com>
	<20180202075009.11653-3-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 11:00:05 +0000
Message-ID: <CAFEAcA-ALKDhxTmwTYewzqKL8A098W3ZgUvTnrYE3=26MuY=Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 2/2] hw/audio/sb16.c: change dolog() to
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, John Arbuckle <programmingkidx@gmail.com>

On 2 February 2018 at 07:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: John Arbuckle <programmingkidx@gmail.com>
>
> Changes all the occurrances of dolog() to qemu_log_mask().
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> Message-id: 20180201172744.7504-1-programmingkidx@gmail.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

> @@ -735,9 +742,8 @@ static void complete (SB16State *s)
>              break;
>
>          case 0x42:              /* FT2 sets output freq with this, go figure */
> -#if 0
> -            dolog ("cmd 0x42 might not do what it think it should\n");
> -#endif
> +            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
> +                          " should\n");
>          case 0x41:
>              s->freq = dsp_get_hilo (s);
>              ldebug ("set freq %d\n", s->freq);

Hi. The removal of the #if 0 here means that Coverity reports a
new warning (CID 1385841) about a potential missing break.

The case 0x42 should end either with a "break;" or with a comment
"/* fall through */".

http://homepages.cae.wisc.edu/~brodskye/sb16doc/sb16doc.html#SamplingRate
suggests that "/* fall through */" is correct, since 0x42 is 'set
input sample rate', 0x41 is 'set output sample rate', and supposedly
the two are equivalent on the hardware.

I suspect that may also mean that this log should be a LOG_GUEST_ERROR
rather than LOG_UNIMP (or perhaps not a warning at all, since we
can't tell if the guest really was trying to program the input
frequency).

thanks
-- PMM
