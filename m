Received: from eggs.gnu.org ([2001:4830:134:3::10]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLVxL-00005x-Hv
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLVxG-0005e2-1s
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:41:07 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLVxF-0005ds-Ro
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:41:01 -0400
Received: by mail-wm0-x234.google.com with SMTP id n195so1411872wmg.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 07:41:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 15:40:40 +0100
Message-ID: <CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KONRAD Frederic <fred.konrad@greensocs.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 14 June 2017 at 12:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> I think the various bindings and rates could be refreshed as devices are
> migrated.  This assumes that the device migration order is okay
> according to the clock tree, that is if you have three devices X/Y/Z and
> five clocks a/b/c/d/e/f:
>
>   fixed-clock
>     |     |
>    X:a   X:b
>     |     |    \
>    Y:c   Y:d      Z:e
>           |
>          Z:f
>
> you could do this:
>
> - migrate X
>   - retrieve the PLL ratios for a and b's bound clocks (if the ratio
>     is variable, otherwise no need for this)
>   - in the post_load callback, bind a and b to the fixed-clock
>     (if the binding is variable, otherwise no need for this)
> - migrate Y
>   - retrieve the PLL ratio for d's bound clocks (if the ratio
>     is variable, otherwise no need for this)
>   - in the post_load callback, bind c and d to a and b respectively
>     (if the binding is variable, otherwise no need for this)
> - migrate Z
>   - in the post_load callback, bind e and f to b and d respectively
>     (if the binding is variable, otherwise no need for this)

Unfortunately we make no guarantees at all about migration order
for devices as far as I'm aware, so devices have to cope regardless.

(There's also the possibility of an oddball bit of hardware which
has a clocktree with loops in it.)

thanks
-- PMM
