Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eSmkT-0002Sf-2b
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 11:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eSmkQ-0008Co-Fo
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 11:34:09 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:63257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eSmkQ-00089h-6S
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 11:34:06 -0500
References: <20171219115041.6611-1-syq@debian.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f7b5659d-fed4-f7ab-71c4-1c3d849885b2@vivier.eu>
Date: Sat, 23 Dec 2017 17:34:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171219115041.6611-1-syq@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: MIPS set cpu to r6 CPU if
 binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: YunQiang Su <syq@debian.org>
Cc: qemu-devel@nongnu.org

Le 19/12/2017 à 12:50, YunQiang Su a écrit :
> MIPS r6 is not just simple super set for pre-R6,
> it also drops some instruction and even changes encoding for some.
> But r6 binary has the same header for binfmt_misc.
> So here we need to detect the version of binaries and set
> cpu_model for it.
> ---
>  include/elf.h        |  4 ++++
>  linux-user/elfload.c | 36 ++++++++++++++++++++++++++++++++++++
>  linux-user/main.c    | 15 +++++++++++++++
>  linux-user/qemu.h    |  1 +
>  4 files changed, 56 insertions(+)
> 
> diff --git a/include/elf.h b/include/elf.h
> index e8a515ce3d..f2104809b1 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -40,6 +40,10 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_ARCH_5		0x40000000	/* -mips5 code.  */
>  #define EF_MIPS_ARCH_32		0x50000000	/* MIPS32 code.  */
>  #define EF_MIPS_ARCH_64		0x60000000	/* MIPS64 code.  */
> +#define EF_MIPS_ARCH_32R2       0x70000000      /* MIPS32r2 code.  */
> +#define EF_MIPS_ARCH_64R2       0x80000000      /* MIPS64r2 code.  */
> +#define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
> +#define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */
>  
>  /* The ABI of a file. */
>  #define EF_MIPS_ABI_O32		0x00001000	/* O32 ABI.  */
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 20f3d8c2c3..f9b8e028ca 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2224,6 +2224,42 @@ static void load_elf_interp(const char *filename, struct image_info *info,
>      exit(-1);
>  }
>  
> +uint32_t get_elf_eflags(const char *filename)
> +{
> +    int fd, retval;
> +    char bprm_buf[BPRM_BUF_SIZE];
> +
> +    fd = open(path(filename), O_RDONLY);

You can't do that with binfmt and credential ('C' flag) enabled (it
implies 'O' flag, open-binary), because in this case the kernel opens
the file and provides the file descriptor to QEMU. We need the 'C' flags
to allow to execute binaries with the setuid flag (like "sudo") [1]

See linux-user/main.c:

   4446     execfd = qemu_getauxval(AT_EXECFD);
   4447     if (execfd == 0) {
   4448         execfd = open(filename, O_RDONLY);
   4449         if (execfd < 0) {
   4450             printf("Error while loading %s: %s\n", filename,
strerror(errno));
   4451             _exit(EXIT_FAILURE);
   4452         }
   4453     }

Thanks,
Laurent
[1]
https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/binfmt-misc.rst
