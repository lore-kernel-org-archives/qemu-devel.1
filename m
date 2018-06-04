Received: from eggs.gnu.org ([2001:4830:134:3::10]:44218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPq4T-0007y4-8U
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPq4N-00053O-FC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:02:53 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPq4N-00052t-AP
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:02:47 -0400
Received: by mail-qt0-x242.google.com with SMTP id s9-v6so11025797qtg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:02:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180604110358.2821-1-peter.maydell@linaro.org>
	<20180604110358.2821-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8446747d-2ddf-e7a0-c765-43b8570f78bc@amsat.org>
Date: Mon, 4 Jun 2018 11:02:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180604110358.2821-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/mips/boston: don't make flash
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, patches@linaro.org, dgilbert@redhat.com, Paul Burton <paul.burton@mips.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 06/04/2018 08:03 AM, Peter Maydell wrote:
> Currently we use memory_region_init_rom_nomigrate() to create
> the "boston.flash" memory region, and we don't manually register
> it with vmstate_register_ram(). This currently means that its
> contents are migrated but as a ram block whose name is the empty
> string; in future it may mean they are not migrated at all. Use
> memory_region_init_ram() instead.
> 
> Note that this is a a cross-version migration compatibility break
> for the "boston" machine.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/mips/boston.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 5302e5c885..1d136529ad 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -471,8 +471,7 @@ static void boston_mach_init(MachineState *machine)
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
>  
>      flash =  g_new(MemoryRegion, 1);
> -    memory_region_init_rom_nomigrate(flash, NULL,
> -                                     "boston.flash", 128 * M_BYTE, &err);
> +    memory_region_init_rom(flash, NULL, "boston.flash", 128 * M_BYTE, &err);
>      memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
>  
>      ddr = g_new(MemoryRegion, 1);
> 
