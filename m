Received: from eggs.gnu.org ([2001:4830:134:3::10]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dezj3-0008Py-9R
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dezj2-0003G5-4r
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:18:53 -0400
MIME-Version: 1.0
In-Reply-To: <1502116754-18867-3-git-send-email-peter.maydell@linaro.org>
References: <1502116754-18867-1-git-send-email-peter.maydell@linaro.org>
	<1502116754-18867-3-git-send-email-peter.maydell@linaro.org>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Tue, 8 Aug 2017 10:18:47 +0200
Message-ID: <CAPTzt1DVmyLtvq6819Jmqm3p2AyXLV9F6rCRKCycBEYjQ1NYFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] loader: Ignore zero-sized ELF segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, patches@linaro.org, Richard Henderson <rth@twiddle.net>

Tested-by: Hua Yanghao <huayanghao@gmail.com>

On Mon, Aug 7, 2017 at 4:39 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Some ELF files have program headers that specify segments that
> are of zero size. Ignore them, rather than trying to create
> zero-length ROM blobs for them, because the zero-length blob
> can falsely trigger the overlapping-ROM-blobs check.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/elf_ops.h | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 2e526d3..d192e7e 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -451,14 +451,24 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                  *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
>              }
>
> -            if (load_rom) {
> -                snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
> -
> -                /* rom_add_elf_program() seize the ownership of 'data' */
> -                rom_add_elf_program(label, data, file_size, mem_size, addr, as);
> -            } else {
> -                cpu_physical_memory_write(addr, data, file_size);
> +            if (mem_size == 0) {
> +                /* Some ELF files really do have segments of zero size;
> +                 * just ignore them rather than trying to create empty
> +                 * ROM blobs, because the zero-length blob can falsely
> +                 * trigger the overlapping-ROM-blobs check.
> +                 */
>                  g_free(data);
> +            } else {
> +                if (load_rom) {
> +                    snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
> +
> +                    /* rom_add_elf_program() seize the ownership of 'data' */
> +                    rom_add_elf_program(label, data, file_size, mem_size,
> +                                        addr, as);
> +                } else {
> +                    cpu_physical_memory_write(addr, data, file_size);
> +                    g_free(data);
> +                }
>              }
>
>              total_size += mem_size;
> --
> 2.7.4
>
