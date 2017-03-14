Received: from eggs.gnu.org ([2001:4830:134:3::10]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnp3O-0006mX-Iy
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnp3L-0003k5-EF
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:12:06 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnp3L-0003jb-7Z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:12:03 -0400
Received: by mail-wm0-x230.google.com with SMTP id v186so67909827wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:12:03 -0700 (PDT)
References: <1488542374-1256-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1488542374-1256-1-git-send-email-peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 16:12:18 +0000
Message-ID: <87pohjq1lp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] hw/misc/imx6_src: Don't crash
 trying to reset missing CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Peter Chubb <peter.chubb@nicta.com.au>, Jean-Christophe DUBOIS <jcd@tribudubois.net>


Peter Maydell <peter.maydell@linaro.org> writes:

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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


--
Alex Bennée
