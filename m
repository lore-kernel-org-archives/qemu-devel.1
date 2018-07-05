Received: from eggs.gnu.org ([2001:4830:134:3::10]:55942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb1K8-0001ep-Ei
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb1K7-0005fe-Fc
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:17:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb1K7-0005e1-0u
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:17:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so15785242oib.10
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 03:17:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704153919.12432-5-f4bug@amsat.org>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 11:16:53 +0100
Message-ID: <CAFEAcA-mhvAxF4bG3Zxx_w57Rkf4xnpTBuPrjekNzEK1vB0j9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] xen: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 July 2018 at 16:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Patch created mechanically by rerunning:
>
>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/xen/xen_pt_config_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
> index aee31c62bb..55a83333f2 100644
> --- a/hw/xen/xen_pt_config_init.c
> +++ b/hw/xen/xen_pt_config_init.c
> @@ -543,7 +543,7 @@ static int xen_pt_exp_rom_bar_reg_write(XenPCIPassthr=
oughState *s,
>  {
>      XenPTRegInfo *reg =3D cfg_entry->reg;
>      XenPTRegion *base =3D NULL;
> -    PCIDevice *d =3D (PCIDevice *)&s->dev;
> +    PCIDevice *d =3D &s->dev;

This line of code is odd even without the cast. XenPCIPassthroughState*
is a QOM object (TYPE_XEN_PT_DEVICE) which is a subclass of TYPE_PCI_DEVICE=
,
so the standard way to get the PCIDevice pointer for s would be
  PCIDevice *d =3D PCI_DEVICE(s);

thanks
-- PMM
