Received: from eggs.gnu.org ([2001:4830:134:3::10]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dep78-0001r9-Lw
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dep73-0006Gg-Nr
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:59:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1502116754-18867-1-git-send-email-peter.maydell@linaro.org>
	<1502116754-18867-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3913adf1-78be-e668-57d6-5f9ba2910962@amsat.org>
Date: Mon, 7 Aug 2017 17:58:52 -0300
MIME-Version: 1.0
In-Reply-To: <1502116754-18867-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] loader: Ignore zero-sized
 ELF segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Hua Yanghao <huayanghao@gmail.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 08/07/2017 11:39 AM, Peter Maydell wrote:
> Some ELF files have program headers that specify segments that
> are of zero size. Ignore them, rather than trying to create
> zero-length ROM blobs for them, because the zero-length blob
> can falsely trigger the overlapping-ROM-blobs check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   include/hw/elf_ops.h | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 2e526d3..d192e7e 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -451,14 +451,24 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                   *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
>               }
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
>                   g_free(data);
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
>               }
>   
>               total_size += mem_size;
> 
