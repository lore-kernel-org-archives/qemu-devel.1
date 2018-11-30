Received: from eggs.gnu.org ([2001:4830:134:3::10]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmR2-0007iW-RC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmR1-0006SH-OH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:18:36 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSmR1-0006Rr-IX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:18:35 -0500
Received: by mail-oi1-x243.google.com with SMTP id u18so5337119oie.10
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:18:35 -0800 (PST)
MIME-Version: 1.0
References: <fe1367d1-33f7-21fa-be84-20b9795a2157@gmail.com>
In-Reply-To: <fe1367d1-33f7-21fa-be84-20b9795a2157@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 17:18:23 +0000
Message-ID: <CAFEAcA_K6S2pB6cP+RHDZjeACU_ROJ6jkkG-2h7TCyiCkejRug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Hudson <nicholas.a.hudson@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Thu, 29 Nov 2018 at 20:22, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
>
> noload kernels are loaded with the u-boot image header and as a result
> the header size needs adding to the entry point.  Fake up a hdr so the
> kernel image is loaded at the right address and the entry point is
> adjusted appropriately.
>
> The bootloader fits in the space that the uboot header would have occupied.
>
> Update the load_uimage API to allow passing of load address when an image
> doesn't specify one.
>
> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> ---

> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 67a0af84ac..10ff0ff76d 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -163,7 +163,8 @@ int load_aout(const char *filename, hwaddr addr, int max_sz,
>  /** load_uimage_as:
>   * @filename: Path of uimage file
>   * @ep: Populated with program entry point. Ignored if NULL.
> - * @loadaddr: Populated with the load address. Ignored if NULL.
> + * @loadaddr: load address if none specified in the image. Populated with the
> + *            load address. Ignored if NULL.

This API change will break some existing users. For instance
hw/microblaze/boot.c does this:
            hwaddr uentry, loadaddr;

            kernel_size = load_uimage(kernel_filename, &uentry, &loadaddr, 0,
                                      NULL, NULL);

which is a legitimate use of the current API, but your changes will
mean that load_uboot_image() will be using an uninitialized
variable. Getting every call site that cares about the returned
result from loadaddr to also provide a valid default load
address as input is going to be really painful, so I think we
need to figure out an API for this function that doesn't
make the input (default load address) argument the same
parameter as the output (where we actually loaded the image)
argument.

Off the top of my head, the first thing that comes to mind is
adding another argument to the function:
 @defaultloadaddr: Load address to use if none specified in
          the image. If NULL, no default address is available
          (and images which do not specify a load address will
          not be loadable).
but there might be a neater approach than that that I haven't
thought of.

We should also make the load_uboot_image() function print an
error message if we don't load the file because it needs a
default load address and the caller didn't pass one
("this image format cannot be loaded on this machine type",
or similar).

PS: our coding style wants {} on all if()s -- scripts/checkpatch.pl
can help catch this kind of nit.

thanks
-- PMM
