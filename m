Received: from eggs.gnu.org ([2001:4830:134:3::10]:45825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2an-0004N3-Gd
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2am-0007lC-Hn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:35:13 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:34267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2am-0007kf-By
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:35:12 -0400
Received: by mail-ot0-x232.google.com with SMTP id i5-v6so1840045oth.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:35:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180306040154.3669-4-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<20180306040154.3669-4-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:34:51 +0100
Message-ID: <CAFEAcA_ErkL21OvsXtHWX6k9wTM0DYv0eHOTio7aX=0YP1RTqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 03/30] ppc440: Add emulation of plb-pcix
 controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, surajjs@au1.ibm.com, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, BALATON Zoltan <balaton@eik.bme.hu>

On 6 March 2018 at 04:01, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> This is the PCIX controller found in newer 440 core SoCs e.g. the
> AMMC 460EX. The device tree refers to this as plb-pcix compared to
> the plb-pci controller in older 440 SoCs.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> [dwg: Remove hwaddr from trace-events, that doesn't work with some
>  trace backends]
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

> +    case PCIX0_PIM2SAL:
> +        s->pim[2].sa &= 0xffffffff00000000ULL;
> +        s->pim[2].sa = val;
> +        ppc440_pcix_update_pim(s, 2);
> +        break;

Coverity (CID1390577) points out that the "s->pim[2].sa = val;"
overwrites the value set by the &= line, making it pointless.
Should this be "|= val" like the other cases in this switch?

thanks
-- PMM
