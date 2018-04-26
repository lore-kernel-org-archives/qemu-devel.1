Received: from eggs.gnu.org ([2001:4830:134:3::10]:51960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBozU-0000Pt-Le
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 18:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBozT-0006TN-J7
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 18:03:48 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBozT-0006T2-Bz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 18:03:47 -0400
Received: by mail-oi0-x241.google.com with SMTP id p62-v6so25547302oie.10
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 15:03:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180426104715.21702-16-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
	<20180426104715.21702-16-peter.maydell@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 27 Apr 2018 10:03:46 +1200
Message-ID: <CAHNT7NtuV06sw9UeQQxn40+KJo3xEgEQ64MFS6vWy4VtZvK7nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 15/19] hw/arm/highbank: don't make sysram
 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Thu, Apr 26, 2018 at 10:47 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> Currently we use memory_region_init_ram_nomigrate() to create
> the "highbank.sysram" memory region, and we don't manually
> register it with vmstate_register_ram(). This currently
> means that its contents are migrated but as a ram block
> whose name is the empty string; in future it may mean they
> are not migrated at all. Use memory_region_init_ram() instead.
>

It is self evident that memory_region_init_ram() implies normal migration.


> Note that this is a cross-version migration compatibility
> break for the "highbank" and "midway" machines.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> Message-id: 20180420124835.7268-2-peter.maydell@linaro.org
> ---
>  hw/arm/highbank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 1742cf6f6c..88326d1bfd 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -291,7 +291,7 @@ static void calxeda_init(MachineState *machine, enum
> cxmachines machine_id)
>      memory_region_add_subregion(sysmem, 0, dram);
>
>      sysram = g_new(MemoryRegion, 1);
> -    memory_region_init_ram_nomigrate(sysram, NULL, "highbank.sysram",
> 0x8000,
> +    memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
>                             &error_fatal);
>      memory_region_add_subregion(sysmem, 0xfff88000, sysram);
>

magic constants are better as #define or enum but there is a lot of code
that already does this, and that would be a separate change. It's peeking
through in the diff context :-D


>      if (bios_name != NULL) {
> --
> 2.17.0
>
>
>
