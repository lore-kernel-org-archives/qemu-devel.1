Received: from eggs.gnu.org ([2001:4830:134:3::10]:60856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej1Ko-0007Vw-A1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej1Ke-0004RU-UJ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:22:46 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:43303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ej1Ke-0004Qf-Jy
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:22:36 -0500
References: <20180206111936.12592.68781.stgit@pasha-VirtualBox>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3aca546c-3af4-acfe-fc9b-905e55272e2d@vivier.eu>
Date: Tue, 6 Feb 2018 12:22:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180206111936.12592.68781.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: huth@tuxfamily.org, dovgaluk@ispras.ru

Le 06/02/2018 à 12:19, Pavel Dovgalyuk a écrit :
> This patch implements movep instruction. It moves data between a data register
> and alternate bytes within the address space starting at the location
> specified and incrementing by two.
> 
> It was designed for the original 68000 and used in firmwares for
> interfacing the 8-bit peripherals through the 16-bit data bus.
> Without this patch opcode for this instruction is recognized as some bitop.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> 
> --
> 
> v2: - disabled movep for Coldfire
>     - fixed gen_store/load usage
> ---
>  target/m68k/cpu.c       |    3 +++
>  target/m68k/cpu.h       |    1 +
>  target/m68k/translate.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 98919b3..2b38b9b 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -113,6 +113,7 @@ static void m68000_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_M68000);
>      m68k_set_feature(env, M68K_FEATURE_USP);
>      m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> +    m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
>  static void m68020_cpu_initfn(Object *obj)
> @@ -135,6 +136,7 @@ static void m68020_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_BKPT);
>      m68k_set_feature(env, M68K_FEATURE_RTD);
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
> +    m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  #define m68030_cpu_initfn m68020_cpu_initfn
>  
> @@ -145,6 +147,7 @@ static void m68040_cpu_initfn(Object *obj)
>  
>      m68020_cpu_initfn(obj);
>      m68k_set_feature(env, M68K_FEATURE_M68040);
> +    m68k_set_feature(env, M68K_FEATURE_MOVEP);

You don't need to add it here as it comes with m68020_cpu_initfn().

Thanks,
Laurent
