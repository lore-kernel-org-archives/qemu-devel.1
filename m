Received: from eggs.gnu.org ([2001:4830:134:3::10]:46393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2eG-0006d7-9v
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2eC-00026g-4W
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:38:48 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:41449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2eB-000253-Uc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:38:44 -0400
Received: by mail-oi0-x22f.google.com with SMTP id 11-v6so1427079ois.8
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:38:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180216100617.25265-15-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
	<20180216100617.25265-15-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:38:22 +0100
Message-ID: <CAFEAcA8TbXCR=pqpyueUN3ZLiup+NBxyZsh3ZwpuNRQdpq65Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 14/14] ppc4xx: Add device models found in
 PPC440 core SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, BALATON Zoltan <balaton@eik.bme.hu>

On 16 February 2018 at 10:06, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> These devices are found in newer SoCs based on 440 core e.g. the 460EX
> (http://www.embeddeddeveloper.com/assets/processors/amcc/datasheets/
> PP460EX_DS2063.pdf)
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

> +static target_ulong sdram_size(uint32_t bcr)
> +{
> +    target_ulong size;
> +    int sh;
> +
> +    sh = 1024 - ((bcr >> 6) & 0x3ff);
> +    if (sh == 0) {
> +        size = -1;
> +    } else {
> +        size = 8 * M_BYTE * sh;
> +    }
> +
> +    return size;
> +}

Hi. Coverity (CID 1390588) points out that the calculation
"1024 - ((bcr >> 6) & 0x3ff" must result in a value of sh
between 1 and 1024, and therefore the "sh == 0" branch of
the if() is dead code.

Is there an error in the size calculation here?

thanks
-- PMM
