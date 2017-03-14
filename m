Received: from eggs.gnu.org ([2001:4830:134:3::10]:59526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnl1M-0004d5-CP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnl1L-0001b5-Ed
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:53:44 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnl1L-0001ac-7O
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:53:43 -0400
Received: by mail-wm0-x232.google.com with SMTP id v186so61932140wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:53:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1488542374-1256-1-git-send-email-peter.maydell@linaro.org>
References: <1488542374-1256-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 12:53:21 +0100
Message-ID: <CAFEAcA-S5REnMvKZsDKf8cNgfsHrCCtQm9A=mMevkkwwCYb1BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.9] hw/misc/imx6_src: Don't
 crash trying to reset missing CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Chubb <peter.chubb@nicta.com.au>, Jean-Christophe DUBOIS <jcd@tribudubois.net>, "patches@linaro.org" <patches@linaro.org>

Ping for review...

thanks
-- PMM

On 3 March 2017 at 12:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> Commit 4881658a4b introduced a call to arm_get_cpu_by_id(),
> and Coverity noticed that we weren't checking that it didn't
> return NULL (CID 1371652).
>
> Normally this won't happen (because all 4 CPUs are expected
> to exist), but it's possible the user requested fewer CPUs
> on the command line. Handle this possibility by silently
> doing nothing, which is the same behaviour as before commit
> 4881658a4b and also how we handle the other CPU operations
> (since we ignore the INVALID_PARAM returns from arm_set_cpu_on()
> and friends).
>
> There is a slight behavioural difference to the pre-4881658a4b
> situation: the "reset this core" bit will remain set rather
> than not being permitted to be set. The imx6 datasheet is
> unclear about the behaviour in this odd corner case, so we
> opt for the simpler code rather than complicated logic to
> maintain identical behaviour.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I couldn't actually get this to crash even with -smp 1 with
> my test image, but we should fix it anyhow.
>
>  hw/misc/imx6_src.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
> index edbb756..cfb0871 100644
> --- a/hw/misc/imx6_src.c
> +++ b/hw/misc/imx6_src.c
> @@ -143,13 +143,17 @@ static void imx6_defer_clear_reset_bit(int cpuid,
>                                         unsigned long reset_shift)
>  {
>      struct SRCSCRResetInfo *ri;
> +    CPUState *cpu = arm_get_cpu_by_id(cpuid);
> +
> +    if (!cpu) {
> +        return;
> +    }
>
>      ri = g_malloc(sizeof(struct SRCSCRResetInfo));
>      ri->s = s;
>      ri->reset_bit = reset_shift;
>
> -    async_run_on_cpu(arm_get_cpu_by_id(cpuid), imx6_clear_reset_bit,
> -                     RUN_ON_CPU_HOST_PTR(ri));
> +    async_run_on_cpu(cpu, imx6_clear_reset_bit, RUN_ON_CPU_HOST_PTR(ri));
>  }
>
>
> --
> 2.7.4
