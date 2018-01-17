Received: from eggs.gnu.org ([2001:4830:134:3::10]:45981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1ebdQT-000803-Rg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1ebdQR-0001Tj-RZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:05 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:46354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1ebdQR-0001Sj-JX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:03 -0500
Received: by mail-pf0-x243.google.com with SMTP id y5so10729144pff.13
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:26:03 -0800 (PST)
MIME-Version: 1.0
Sender: wzssyqa@gmail.com
In-Reply-To: <20180113144847.8403-4-laurent@vivier.eu>
References: <20180113144847.8403-1-laurent@vivier.eu>
	<20180113144847.8403-4-laurent@vivier.eu>
From: YunQiang Su <syq@debian.org>
Date: Wed, 17 Jan 2018 10:26:01 +0800
Message-ID: <CAKcpw6WCjeo-G-kHeiHbUEPAOYCGkjojG69YFjzkzLC9vyXa6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] linux-user: MIPS set cpu to r6 CPU if
 binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Sat, Jan 13, 2018 at 10:48 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> From: YunQiang Su <syq@debian.org>
>
> So here we need to detect the version of binaries and set
> cpu_model for it.
>
> [lv: original patch modified to move code into get_cpu_model()]
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     YunQiang Su, please add your Signed-off-by that was
>     missing in your original patch.

How to add Signed-off-by? Send a v2 for my version of patch?

>
>  include/elf.h     |  4 ++++
>  linux-user/main.c | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/elf.h b/include/elf.h
> index e8a515ce3d..f2104809b1 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -40,6 +40,10 @@ typedef int64_t  Elf64_Sxword;
>  #define EF_MIPS_ARCH_5         0x40000000      /* -mips5 code.  */
>  #define EF_MIPS_ARCH_32                0x50000000      /* MIPS32 code.  */
>  #define EF_MIPS_ARCH_64                0x60000000      /* MIPS64 code.  */
> +#define EF_MIPS_ARCH_32R2       0x70000000      /* MIPS32r2 code.  */
> +#define EF_MIPS_ARCH_64R2       0x80000000      /* MIPS64r2 code.  */
> +#define EF_MIPS_ARCH_32R6       0x90000000      /* MIPS32r6 code.  */
> +#define EF_MIPS_ARCH_64R6       0xa0000000      /* MIPS64r6 code.  */
>
>  /* The ABI of a file. */
>  #define EF_MIPS_ABI_O32                0x00001000      /* O32 ABI.  */
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 2fc2267fd4..3229ef079e 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4285,9 +4285,19 @@ static const char *get_cpu_model(int fd)
>      return "Fujitsu MB86904";
>  #endif
>  #elif defined(TARGET_MIPS)
> +    int ret;
> +    uint32_t eflags;
> +
> +    ret = get_elf_eflags(fd, &eflags);
>  #if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
> +    if (ret == 0 && (eflags & EF_MIPS_ARCH_64R6) != 0) {
> +        return "I6400";
> +    }
>      return "5KEf";
>  #else
> +    if (ret == 0 && (eflags & EF_MIPS_ARCH_32R6) != 0) {
> +        return "mips32r6-generic";
> +    }
>      return "24Kf";
>  #endif
>  #elif defined TARGET_OPENRISC
> --
> 2.14.3
>
