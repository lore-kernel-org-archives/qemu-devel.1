Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQv8y-0007Wm-88
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQv8x-0006BZ-G3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:40:00 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQv8x-0006BA-AF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:39:59 -0400
Received: by mail-ot0-x244.google.com with SMTP id h6-v6so11572927otj.0
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 06:39:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528378684-14487-1-git-send-email-hejianet@gmail.com>
References: <1528378684-14487-1-git-send-email-hejianet@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 14:39:38 +0100
Message-ID: <CAFEAcA__8bZEku0vUAVQzheb8kjgZeRbKw_TXy6bY9RnKi+U9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/smmuv3: fix smmu emulation when
 guest smmu is in passthrough mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <hejianet@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, jia.he@hxt-semitech.com, Eric Auger <eric.auger@redhat.com>

On 7 June 2018 at 14:38, Jia He <hejianet@gmail.com> wrote:
> There is an exception when I passes iommu.passthrough=1 to guest's
> kernel boot parameter(host QDF2400 kernel 4.17, guest kernel 4.14).
> The guest will be hang when booting up.
>
> When guest smmu is in passthrough mode, entry.perm will not be assigned
> to flag in smmuv3_translate. It seems not be correct.
>
> After this patch, I have tested in 4 cases and all passed.
> host smmu on/passthrough + guest smmu on/passthrough
>
> Signed-off-by: jia.he@hxt-semitech.com
> ---
>  hw/arm/smmuv3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 42dc521..5c46102 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -560,6 +560,12 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      }
>
>      ret = smmuv3_decode_config(mr, &cfg, &event);
> +
> +    if (cfg.bypassed) {
> +        ret = 0;
> +        goto out;
> +    }
> +
>      if (ret) {
>          goto out;
>      }
> --
> 1.8.3.1
>

Ccing Eric as the author of the smmuv3 code.

thanks
-- PMM
