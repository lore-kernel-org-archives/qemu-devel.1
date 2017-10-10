Received: from eggs.gnu.org ([2001:4830:134:3::10]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1xjY-0000iu-73
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1xjU-0004Kt-8i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:50:20 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:47727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1xjU-0004IV-1O
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:50:16 -0400
Received: by mail-wm0-x232.google.com with SMTP id t69so6993042wmt.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:50:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010151811.19935-1-pbonzini@redhat.com>
References: <20171010151811.19935-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 17:49:54 +0100
Message-ID: <CAFEAcA_=qfeuk-J-oGruTXcKiWriKo9A8a+FOn1pcbnb6kCdrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nios2: define tcg_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, Thomas Huth <thuth@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 10 October 2017 at 16:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This should be done by all target and, since commit 53f6672bcf
> ("gen-icount: use tcg_ctx.tcg_env instead of cpu_env", 2017-06-30),
> is causing the NIOS2 target to hang.
>
> This is because the test for "should I exit to the main loop"
> was being done with the correct offset to the icount decrementer,
> but using TCG temporary 0 (the frame pointer) rather than the
> env pointer.
>
> Cc: qemu-stable@nongnu.org
> Cc: Marek Vasut <marex@denx.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/nios2/translate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index 6b0961837d..54fbe898df 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -948,6 +948,7 @@ void nios2_tcg_init(void)
>      int i;
>
>      cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
> +    tcg_ctx.tcg_env = cpu_env;
>
>      for (i = 0; i < NUM_CORE_REGS; i++) {
>          cpu_R[i] = tcg_global_mem_new(cpu_env,
> --

Is there somewhere we could put an assert() so we can catch this
error for future targets rather than them just silently generating
bad code?

thanks
-- PMM
