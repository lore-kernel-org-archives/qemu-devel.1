Received: from eggs.gnu.org ([2001:4830:134:3::10]:35156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEC6u-0000hD-AH
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEC6q-0008Rm-9y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:32:28 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEC6p-0008RZ-SX
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:32:24 -0500
Received: by mail-ua0-f171.google.com with SMTP id b35so375220011uaa.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:32:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cb06a932a7c6b29bc6eb0d35f31766bfb0bba47f.1480962799.git.alistair.francis@xilinx.com>
References: <cb06a932a7c6b29bc6eb0d35f31766bfb0bba47f.1480962799.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 09:31:02 +0000
Message-ID: <CAFEAcA8k++Q9ByEj_yynGW+N6sry4wNCB-=ASXtWuLHEBUxSHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for 2.8 v3 1/1] cadence_uart: Check baud
 rate generator and divider values on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Huawei PSIRT <psirt@huawei.com>

On 5 December 2016 at 18:35, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> The Cadence UART device emulator calculates speed by dividing the
> baud rate by a 'baud rate generator' & 'baud rate divider' value.
> The device specification defines these register values to be
> non-zero and within certain limits. Checks were recently added when
> writing to these registers but not when restoring from migration.
>
> This patch adds checks when restoring from migration to avoid divide by
> zero errors.
>
> Reported-by: Huawei PSIRT <psirt@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> It would be nice to squeeze this into 2.8 if possible.
>
> V3:
>  - Fix broken migration logic
>  - Manually double checked and it passes migration.
> V2:
>  - Abort the migration if the data is invalid
>
>  hw/char/cadence_uart.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 0215d65..ce9063b 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -502,6 +502,13 @@ static int cadence_uart_post_load(void *opaque, int version_id)
>  {
>      CadenceUARTState *s = opaque;
>
> +    /* Ensure these two aren't invalid numbers */
> +    if (s->r[R_BRGR] <= 1 || s->r[R_BRGR] & ~0xFFFF ||
> +        s->r[R_BDIV] <= 3 || s->r[R_BDIV] & ~0xFF) {

The uart_write() code says BRGR == 1 is valid, but
this code says it isn't. Which is correct?

thanks
-- PMM
