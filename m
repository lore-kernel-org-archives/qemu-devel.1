Received: from eggs.gnu.org ([2001:4830:134:3::10]:59375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1flJZh-0005Ui-Kr
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1flJZe-0003HH-GU
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:47:53 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1flJZe-0003EP-57
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:47:50 -0400
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
	<1533219424-7627-78-git-send-email-stefan.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0a43387a-f475-874d-2846-46ce38d9d812@vivier.eu>
Date: Thu, 2 Aug 2018 21:47:02 +0200
MIME-Version: 1.0
In-Reply-To: <1533219424-7627-78-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 77/77] linux-user: Add nanoMIPS support
 in scripts/qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

Le 02/08/2018 à 16:17, Stefan Markovic a écrit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Add support for nanomips[eb] variant in scripts/qemu-binfmt-conf.sh.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  scripts/qemu-binfmt-conf.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b0dc8a7..ecde0c2 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -2,7 +2,7 @@
>  # Enable automatic program execution by the kernel.
>  
>  qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
> -mips mipsel mipsn32 mipsn32el mips64 mips64el \
> +mips mipsel mipsn32 mipsn32el mips64 mips64el nanomips nanomipseb \
>  sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
>  microblaze microblazeel or1k"
>  
> @@ -76,6 +76,14 @@ mips64el_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\
>  mips64el_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>  mips64el_family=mips
>  
> +nanomips_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf9\x00'
> +nanomips_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff'
> +nanomips_family=mips
> +
> +nanomipseb_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf9'
> +nanomipseb_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff'
> +nanomipseb_family=mips

The goal of the family value is not to register the interpreter if the
kernel can execute the executable directly (without qemu).
For instance a ppc64 kernel can execute a ppc executable, an x86_64
kernel can execute a i386 binary.

If you put nanomips in the mips family it means a mips kernel can
execute directly a nanomips executable: Is that the case?
If not, I think you can use "nanomips_family=nanomips", and if a
nanomips kernel cannot execute a nanomipseb executable, you need also a
nanomipseb family.

Thanks,
Laurent
