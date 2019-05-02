Received: from eggs.gnu.org ([209.51.188.92]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7r9-0007Kq-US
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7qz-0001Yh-AX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:18:12 -0400
References: <20190427162922.4207-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fc2aab1e-b709-2f1b-f357-3a027e499309@vivier.eu>
Date: Thu, 2 May 2019 11:17:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190427162922.4207-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] hw/sparc/leon3: Allow
 load of uImage firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, KONRAD Frederic <frederic.konrad@adacore.com>, Stefan Hajnoczi <stefanha@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 27/04/2019 18:29, Philippe Mathieu-Daudé wrote:
> Currently the Leon3 machine doesn't allow to load legacy u-boot images:
> 
>   $ qemu-system-sparc -M leon3_generic -d in_asm \
>       -kernel HelenOS-0.6.0-sparc32-leon3.bin
>   qemu-system-sparc: could not load kernel 'HelenOS-0.6.0-sparc32-leon3.bin'
> 
>   $ file HelenOS-0.6.0-sparc32-leon3.bin
>   HelenOS-0.6.0-sparc32-leon3.bin: u-boot legacy uImage, HelenOS-0.6.0,\
>     Linux/ARM, OS Kernel Image (Not compressed), 2424229 bytes,\
>     Sun Dec 21 19:18:09 2014,\
>     Load Address: 0x40000000, Entry Point: 0x40000000,\
>     Header CRC: 0x8BCFA236, Data CRC: 0x37AD87DF
> 
> Since QEMU can load uImages, add the necessary code,
> so the Leon3 machine can load these images:
> 
>   $ qemu-system-sparc -M leon3_generic -d in_asm \
>       -kernel HelenOS-0.6.0-sparc32-leon3.bin
>   ----------------
>   IN:
>   0x40000000:  b  0x400007a8
>   0x40000004:  nop
>   ----------------
>   IN:
>   0x400007a8:  save  %sp, -136, %sp
>   0x400007ac:  call  0x40000020
>   0x400007b0:  sethi  %hi(0x4000b800), %i1
>   ...
> 
> Tested with the following firmware:
> http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Fixed GIT_AUTHOR_EMAIL
> ---
>  hw/sparc/leon3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639af33..0383b17c29 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -193,6 +193,10 @@ static void leon3_generic_hw_init(MachineState *machine)
>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>                                 &entry, NULL, NULL,
>                                 1 /* big endian */, EM_SPARC, 0, 0);
> +        if (kernel_size < 0) {
> +            kernel_size = load_uimage(kernel_filename, NULL, &entry,
> +                                      NULL, NULL, NULL);
> +        }
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
