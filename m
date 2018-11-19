Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOkRY-0005rJ-GM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOkRX-00023L-Mk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:22:28 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOkRX-00022X-Ar
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:22:27 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so27758082oth.7
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 06:22:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181117160213.18995-1-luc.michel@greensocs.com>
References: <20181117160213.18995-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 14:22:06 +0000
Message-ID: <CAFEAcA9Y4fykSD+FyE_K_G6U1OB0oSjEgxma6wp-qYm9pws_Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix smc incorrectly trapping
 to EL3 when secure is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 November 2018 at 16:02, Luc Michel <luc.michel@greensocs.com> wrote:
> This commit fixes a case where the CPU would try to go to EL3 when
> executing an smc instruction, even though ARM_FEATURE_EL3 is false. This
> case is raised when the PSCI conduit is set to smc, but the smc
> instruction does not lead to a valid PSCI call.
>
> QEMU crashes with an assertion failure latter on because of incoherent
> mmu_idx.
>
> This commit refactors the pre_smc helper by enumerating all the possible
> way of handling an scm instruction, and covering the previously missing
> case leading to the crash.
>
> The following minimal test would crash before this commit:
>
> .global _start
>     .text
> _start:
>     ldr x0, =0xdeadbeef  ; invalid PSCI call
>     smc #0
>
> run with the following command line:
>
> aarch64-linux-gnu-gcc -nostdinc -nostdlib -Wl,-Ttext=40000000 \
>                       -o test test.s
>
> qemu-system-aarch64 -M virt,virtualization=on,secure=off \
>                     -cpu cortex-a57 -kernel test
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Thanks in particular for that helpful table summarising all
the cases -- that made this patch much easier to review.

Applied to target-arm.next, thanks.

-- PMM
