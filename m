Received: from eggs.gnu.org ([2001:4830:134:3::10]:47298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBk91-00019t-NS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBk8x-0001Ry-Lv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:21:03 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:54224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eBk8x-0001QN-EL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:20:59 -0500
Received: by mail-wr0-x242.google.com with SMTP id u40so9109463wrf.10
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 08:20:59 -0800 (PST)
References: <1509732813-22957-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1509732813-22957-1-git-send-email-peter.maydell@linaro.org>
Date: Mon, 06 Nov 2017 16:20:56 +0000
Message-ID: <871slbs7iv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] nvic: Fix ARMv7M MPU_RBAR reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Fix an incorrect mask expression in the handling of v7M MPU_RBAR
> reads that meant that we would always report the ADDR field as zero.

nit: you could extend that to: "..as zero because we mask it when
written".

As I see you do:
  cpu->env.pmsav7.drbar[region] =3D value & ~0x1f;

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Doesn't affect v8M, which is a different codepath.
>
>  hw/intc/armv7m_nvic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index be46639..5d9c883 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -977,7 +977,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t off=
set, MemTxAttrs attrs)
>          if (region >=3D cpu->pmsav7_dregion) {
>              return 0;
>          }
> -        return (cpu->env.pmsav7.drbar[region] & 0x1f) | (region & 0xf);
> +        return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);
>      }
>      case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
>      case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */


--
Alex Benn=C3=A9e
