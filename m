Received: from eggs.gnu.org ([2001:4830:134:3::10]:54765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFmvX-00021G-0W
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFmvV-0000SE-1l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:07:50 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFmvU-0000RC-Qp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:07:48 -0500
Received: by mail-wr0-x244.google.com with SMTP id z14so3060715wrb.8
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 12:07:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116115926.16627-8-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Nov 2017 20:07:27 +0000
Message-ID: <CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 16 November 2017 at 11:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch adds a condition before overwriting exception_index fiels.
> It is needed when exception_index is already set to some meaningful value.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> Message-Id: <20171114081812.27640.26372.stgit@pasha-VirtualBox>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/cpu-exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 61297f8f4a..0473055a08 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -594,7 +594,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      if (unlikely(atomic_read(&cpu->exit_request)
>          || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
>          atomic_set(&cpu->exit_request, 0);
> -        cpu->exception_index = EXCP_INTERRUPT;
> +        if (cpu->exception_index == -1) {
> +            cpu->exception_index = EXCP_INTERRUPT;
> +        }
>          return true;
>      }

Hi. This commit breaks booting of Debian on aarch64 virt board.
(repro instructions for creating the image available at:
https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/)
The guest kernel never prints anything to the serial port.

Reverting this commit fixes master for me, so I plan to do
that on Monday.

thanks
-- PMM
