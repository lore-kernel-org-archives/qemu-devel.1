Received: from eggs.gnu.org ([2001:4830:134:3::10]:46738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyF4v-00018T-Gt
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyF4p-00082t-CH
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:05:17 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyF4p-00082Q-8E
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:05:11 -0400
Received: by mail-ot0-x241.google.com with SMTP id r30-v6so1225021otr.2
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:05:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521526368-1996-1-git-send-email-kamensky@cisco.com>
References: <1521526368-1996-1-git-send-email-kamensky@cisco.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 11:04:49 +0000
Message-ID: <CAFEAcA9haOX3wHXv4Lyp26nebzu7R=MgGN2m_0iV6HZ_wepWfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] arm/translate-a64: treat DISAS_UPDATE as
 variant of DISAS_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Victor Kamensky <kamensky@cisco.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 20 March 2018 at 06:12, Victor Kamensky <kamensky@cisco.com> wrote:
> In OE project 4.15 linux kernel boot hang was observed under
> single cpu aarch64 qemu. Kernel code was in a loop waiting for
> vtimer arrival, spinning in TC generated blocks, while interrupt
> was pending unprocessed. This happened because when qemu tried to
> handle vtimer interrupt target had interrupts disabled, as
> result flag indicating TCG exit, cpu->icount_decr.u16.high,
> was cleared but arm_cpu_exec_interrupt function did not call
> arm_cpu_do_interrupt to process interrupt. Latter when target
> reenabled interrupts, it happened without exit into main loop, so
> following code that waited for result of interrupt execution
> run in infinite loop.
>
> To solve the problem instructions that operate on CPU sys state
> (i.e enable/disable interrupt), and marked as DISAS_UPDATE,
> should be considered as DISAS_EXIT variant, and should be
> forced to exit back to main loop so qemu will have a chance
> processing pending CPU state updates, including pending
> interrupts.
>
> This change brings consistency with how DISAS_UPDATE is treated
> in aarch32 case.
>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> CC: qemu-stable@nongnu.org
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM
