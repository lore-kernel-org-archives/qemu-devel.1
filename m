Received: from eggs.gnu.org ([2001:4830:134:3::10]:52697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1gKJPI-0000OF-EH
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 03:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1gKJPF-0006U4-5K
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 03:41:48 -0500
MIME-Version: 1.0
References: <20181106184212.29377-1-eric.auger@redhat.com>
In-Reply-To: <20181106184212.29377-1-eric.auger@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Nov 2018 09:41:29 +0100
Message-ID: <CAMuHMdWdOFJHoMh2UfLmELwWhRV7g24rVpzLM-kA+p2cY6qujw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-3.1] hw/arm/sysbus-fdt: Only call
 match_fn callback if the type matches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Eric,

On Tue, Nov 6, 2018 at 7:42 PM Eric Auger <eric.auger@redhat.com> wrote:
> Commit af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with DT
> compatible value) introduced a match_fn callback which gets called
> for each registered combo to check whether a sysbus device can be
> dynamically instantiated. However the callback gets called even if
> the device type does not match the binding combo typename field.
> This causes an assert when passing "-device ramfb" to the qemu
> command line as vfio_platform_match() gets called on a non
> vfio-platform device.
>
> To fix this regression, let's change the add_fdt_node() logic so
> that we first check the type and if the match_fn callback is defined,
> then we also call it.
>
> Binding combos only requesting a type check do not define the
> match_fn callback.
>
> Fixes: af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with
> DT compatible value)
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Thomas Huth <thuth@redhat.com>
>
> ---
>
> v1 -> v2:
> - use "if (!iter->match_fn || iter->match_fn(sbdev, iter)) {"
>   as suggested by Peter to avoid code duplication
> - mention the ramfb regression fixed by this patch in the
>   commit message.

Thanks for looking into this!

After applying "hw/arm/sysbus-fdt: Add support for instantiating generic
devices", "-device vfio-platform,host=ee300000.sata" still works fine.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
