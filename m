Received: from eggs.gnu.org ([2001:4830:134:3::10]:60346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkdn-0000qA-R6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkdm-0007Zg-SP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:11:47 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkdm-0007Z2-MN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:11:46 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t201so29696461wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:11:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-23-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-23-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:11:25 +0100
Message-ID: <CAFEAcA9dciLWNYce7+4HjW1Cu4pEJ1V9gHQ2pokBECCj0mp1QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 22/35] arm/vexpress: fix potential
 memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Reorder to only allocate if required.
>
> hw/arm/vexpress.c:667:13: warning: Potential leak of memory pointed to by=
 'flashalias'
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/vexpress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 528c65ddb6..76c4d84482 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -553,8 +553,6 @@ static void vexpress_common_init(MachineState *machin=
e)
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *vram =3D g_new(MemoryRegion, 1);
>      MemoryRegion *sram =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *flashalias =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *flash0mem;
>      const hwaddr *map =3D daughterboard->motherboard_map;
>      int i;
>
> @@ -657,6 +655,9 @@ static void vexpress_common_init(MachineState *machin=
e)
>      }
>
>      if (map[VE_NORFLASHALIAS] !=3D -1) {
> +        MemoryRegion *flashalias =3D g_new(MemoryRegion, 1);
> +        MemoryRegion *flash0mem;
> +
>          /* Map flash 0 as an alias into low memory */
>          flash0mem =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(pflash0), 0)=
;
>          memory_region_init_alias(flashalias, NULL, "vexpress.flashalias"=
,
> --
> 2.13.3

flashalias is no different from any of the other MemoryRegion*
variables we allocate here with g_new() -- they all
leak, and it doesn't matter because the function
runs once and we want the MemoryRegions to survive
until the end of the simulation.

These days we could in theory clean this up by
switching from doing g_new() to having a set of
MemoryRegion fields in the VexpressMachineState
struct (compare hw/arm/mps2.c).

thanks
-- PMM
