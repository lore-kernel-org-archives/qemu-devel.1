Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYumX-0007p4-4P
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYumW-0006TV-4J
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:21:37 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:46828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYumV-0006SL-V9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:21:36 -0500
Received: by mail-oi0-x22c.google.com with SMTP id d124so6466365oib.13
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:21:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512742402-31669-1-git-send-email-peter.maydell@linaro.org>
References: <1512742402-31669-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:21:14 +0000
Message-ID: <CAFEAcA8-5Rgt82tfDFkh3niUYsvSUKmHeTsk7e+Mzq3HJMBbpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] get_phys_addr_pmsav7: Support AP=0b111 for
 v7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Andy Gross <andy.gross@linaro.org>, "patches@linaro.org" <patches@linaro.org>

Ping for code review?

thanks
-- PMM

On 8 December 2017 at 14:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> For PMSAv7, the v7A/R Arm ARM defines that setting AP to 0b111
> is an UNPREDICTABLE reserved combination. However, for v7M
> this value is documented as having the same behaviour as 0b110:
> read-only for both privileged and unprivileged. Accept this
> value on an M profile core rather than treating it as a guest
> error and a no-access page.
>
> Reported-by: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 91a9300..2f53dd8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9229,6 +9229,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>                  case 6:
>                      *prot |= PAGE_READ | PAGE_EXEC;
>                      break;
> +                case 7:
> +                    /* for v7M, same as 6; for R profile a reserved value */
> +                    if (arm_feature(env, ARM_FEATURE_M)) {
> +                        *prot |= PAGE_READ | PAGE_EXEC;
> +                        break;
> +                    }
> +                    /* fall through */
>                  default:
>                      qemu_log_mask(LOG_GUEST_ERROR,
>                                    "DRACR[%d]: Bad value for AP bits: 0x%"
> @@ -9247,6 +9254,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>                  case 6:
>                      *prot |= PAGE_READ | PAGE_EXEC;
>                      break;
> +                case 7:
> +                    /* for v7M, same as 6; for R profile a reserved value */
> +                    if (arm_feature(env, ARM_FEATURE_M)) {
> +                        *prot |= PAGE_READ | PAGE_EXEC;
> +                        break;
> +                    }
> +                    /* fall through */
>                  default:
>                      qemu_log_mask(LOG_GUEST_ERROR,
>                                    "DRACR[%d]: Bad value for AP bits: 0x%"
> --
> 2.7.4
