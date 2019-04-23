Received: from eggs.gnu.org ([209.51.188.92]:46316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ47z-00073h-7N
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ47w-0005Gk-RN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:43:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ47u-000595-2h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:42:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so22242571wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:42:51 -0700 (PDT)
References: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8303cc43-6bc4-6225-e632-e02629ef74ff@redhat.com>
Date: Wed, 24 Apr 2019 00:42:48 +0200
MIME-Version: 1.0
In-Reply-To: <1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, thuth@redhat.com, jcmvbkbc@gmail.com, arikalo@wavecomp.com, daniel.santos@pobox.com, amarkovic@wavecomp.com, aurelien@aurel32.net

Hi Aleksandar,

On 4/23/19 7:35 PM, Aleksandar Markovic wrote:
> From: Daniel Santos <daniel.santos@pobox.com>
> 
> Sanitize interp_info structure in load_elf_binary() and, for mips only,
> init its field fp_abi. This fixes appearances of "Unexpected FPU mode"
> message in some MIPS use cases.
> 

Please add:

Fixes: https://bugs.launchpad.net/qemu/+bug/1825002

> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/elfload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a2602..7f09d57 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>      char *elf_interpreter = NULL;
>      char *scratch;
>  
> +    memset(&interp_info, 0, sizeof(interp_info));
> +#ifdef TARGET_MIPS
> +    interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
> +#endif
> +
>      info->start_mmap = (abi_ulong)ELF_START_MMAP;
>  
>      load_elf_image(bprm->filename, bprm->fd, info,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
