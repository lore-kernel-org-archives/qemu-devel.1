Received: from eggs.gnu.org ([2001:4830:134:3::10]:52607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHU8V-0003ny-CK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHU8T-0004ta-Tc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:32:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHU8T-0003vf-N0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:32:45 -0400
Received: by mail-oi1-x244.google.com with SMTP id u130-v6so5628289oie.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:32:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181022173559.17111-5-edgar.iglesias@gmail.com>
References: <20181022173559.17111-1-edgar.iglesias@gmail.com>
	<20181022173559.17111-5-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:31:44 +0000
Message-ID: <CAFEAcA_BGhqMiQGgF3TSXBXHacQf31emVTZv2tcr0Qo77bKcvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] hw/arm: versal: Add a virtual
 Xilinx Versal board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 22 October 2018 at 18:35, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add a virtual Xilinx Versal board.
>
> This board is based on the Xilinx Versal SoC. The exact
> details of what peripherals are attached to this board
> will remain in control of QEMU. QEMU will generate an
> FDT on the fly for Linux and other software to auto-discover
> peripherals.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

> +static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
> +                                     uint32_t phandle)
> +{
> +    char *name = g_strdup_printf("%s/fixed-link", gemname);
> +
> +    qemu_fdt_add_subnode(s->fdt, name);
> +    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
> +    qemu_fdt_setprop_cells(s->fdt, name, "full-duplex");

Hi. This fails to compile in a non-debug build:

In file included from /home/peter.maydell/qemu/hw/arm/xlnx-versal-virt.c:16:0:
/home/peter.maydell/qemu/hw/arm/xlnx-versal-virt.c: In function
'fdt_add_fixed_link_nodes':
/home/peter.maydell/qemu/include/sysemu/device_tree.h:110:23: error:
comparison of unsigned expression < 0 is always false
[-Werror=type-limits]
         for (i = 0; i < ARRAY_SIZE(qdt_tmp); i++) {                           \
                       ^
/home/peter.maydell/qemu/hw/arm/xlnx-versal-virt.c:191:5: note: in
expansion of macro 'qemu_fdt_setprop_cells'
     qemu_fdt_setprop_cells(s->fdt, name, "full-duplex");
     ^

because qemu_fdt_setprop_cells() requires you to provide
at least one cell value for the property being set.
What was the intention here ?


> +    qemu_fdt_setprop_cell(s->fdt, name, "speed", 1000);
> +    g_free(name);
> +}

In the meantime, I'm dropping the versal patches from
target-arm.next.

thanks
-- PMM
