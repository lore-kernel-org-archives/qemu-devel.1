Received: from eggs.gnu.org ([2001:4830:134:3::10]:49614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFdDQ-0000u1-Ft
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFdDP-0002d5-KP
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:17:56 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFdDP-0002cP-FO
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:17:55 -0400
Received: by mail-ot0-x244.google.com with SMTP id h8-v6so31358282otb.2
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 03:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507101013.32736-1-kraxel@redhat.com>
References: <20180507101013.32736-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 May 2018 11:17:34 +0100
Message-ID: <CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 May 2018 at 11:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
> ... to a virtual machine.  Without that we fail a ramblock register
> sanity check, leading to a abort(), which isn't exactly user friendly.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1206037
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 72181330b8..328b6413ad 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2184,6 +2184,14 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
>      }
>      s->vbe_size_mask = s->vbe_size - 1;
>
> +    if (global_vmstate) {
> +        static int have_vga;
> +        if (have_vga) {
> +            error_report("only one vga device is supported");
> +            exit(1);
> +        }
> +        have_vga = true;
> +    }
>      s->is_vbe_vmstate = 1;
>      memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
>                             &error_fatal);
> --
> 2.9.3
>

This seems like a bit of an irritating reason to refuse to
allow multiple VGA devices though, since we could make
them work by having the vmstate be not-global. Which is
exactly what it ought to be -- we're only defaulting to
"use global" here for migration compatibility, I think.
Since multiple VGA devices didn't work before, there's
no old configs we need to migrate from, and so I think
we could just say "the second and subsequent VGA devices
get non-global ram vmstate" ?

thanks
-- PMM
