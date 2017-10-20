Received: from eggs.gnu.org ([2001:4830:134:3::10]:37921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fhZ-0000NM-Ez
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fhW-0002vw-Az
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:23:37 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:55672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fhW-0002ve-5P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:23:34 -0400
Received: by mail-qt0-x241.google.com with SMTP id v41so20199325qtv.12
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:23:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c2460888-acab-120d-43ef-8abfffda3f0a@amsat.org>
Date: Fri, 20 Oct 2017 19:23:30 -0300
MIME-Version: 1.0
In-Reply-To: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] arm: Adding new arm machine,
 Kinetis K64 MK64FN1M0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gabriel291075@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 10/19/2017 09:50 AM, gabriel291075@gmail.com wrote:
> From: Gabriel Augusto Costa <gabriel291075@gmail.com>
> 
> I add a new arm machine with some peripherals. The machine is mk64fn1m0, a 
> cortex-m4 microcontroller from NXP Kinetis family. The machine can run a 
> simple arm binary file using UART0 in polling mode.
> I prepared two patchs to include this machine:
> PATCH v1: Include the machine and peripherals devices;
> PATCH v2: Change the make file to compile this machine.
> Also, I made a folder tree to accomodate this machine more or less like u-boot.
> In my opinion put all files in the same folder "/hw/arm" is not a good idea, 
> or put all code in an unique file, because machines from the same family 
> sharing the same peripherals.
> The folder tree struct is machine/family/peripheral, as an example:
> kinetis/k64/peripheral.
> So, in this way the code will be more maintainable. 
> 
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
[...]
> +static void kinetis_k64_sim_init(Object *obj)
> +{
> +    kinetis_k64_sim_state *s = KINETIS_K64_SIM(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    
> +    memory_region_init_io(&s->iomem, obj, &kinetis_k64_sim_ops, s,
> +            TYPE_KINETIS_K64_SIM, 0x2000);

Why not... personally I'd rather use 2 regions for the sysctl, a 8B for
SOPT1 and and 128B for the rest mapped at the next 4KB block.

> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
