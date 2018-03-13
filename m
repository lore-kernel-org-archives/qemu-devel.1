Received: from eggs.gnu.org ([2001:4830:134:3::10]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evtE7-0008S7-DA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evtE4-0002wX-8h
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:21:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e77539c8-5c9e-4ee5-edc4-a4d044e5c476@amsat.org>
Date: Wed, 14 Mar 2018 00:20:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180313153458.26822-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/9] hw/arm/raspi: Don't do
 board-setup or secure-boot for raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>, patches@linaro.org

On 03/13/2018 04:34 PM, Peter Maydell wrote:
> For the rpi1 and 2 we want to boot the Linux kernel via some
> custom setup code that makes sure that the SMC instruction
> acts as a no-op, because it's used for cache maintenance.
> The rpi3 boots AArch64 kernels, which don't need SMC for
> cache maintenance and always expect to be booted non-secure.
> Don't fill in the aarch32-specific parts of the binfo struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/raspi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index a37881433c..1ac0737149 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -82,10 +82,19 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>      binfo.board_id = raspi_boardid[version];
>      binfo.ram_size = ram_size;
>      binfo.nb_cpus = smp_cpus;
> -    binfo.board_setup_addr = BOARDSETUP_ADDR;
> -    binfo.write_board_setup = write_board_setup;
> -    binfo.secure_board_setup = true;
> -    binfo.secure_boot = true;
> +
> +    if (version <= 2) {
> +        /* The rpi1 and 2 require some custom setup code to run in Secure
> +         * mode before booting a kernel (to set up the SMC vectors so
> +         * that we get a no-op SMC; this is used by Linux to call the
> +         * firmware for some cache maintenance operations.
> +         * The rpi3 doesn't need this.
> +         */

I was expecting a much complicated fix... neat.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        binfo.board_setup_addr = BOARDSETUP_ADDR;
> +        binfo.write_board_setup = write_board_setup;
> +        binfo.secure_board_setup = true;
> +        binfo.secure_boot = true;
> +    }
>  
>      /* Pi2 and Pi3 requires SMP setup */
>      if (version >= 2) {
> 
