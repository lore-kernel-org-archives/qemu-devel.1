Received: from eggs.gnu.org ([2001:4830:134:3::10]:37353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e49kv-0001bD-EH
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e49kr-0006hc-Ct
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:04:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
References: <20171005143553.23784-1-malbarbo@gmail.com>
Message-ID: <8bc869d6-73cd-d085-99ca-aab8832ee1fc@msgid.tls.msk.ru>
Date: Mon, 16 Oct 2017 21:04:44 +0300
MIME-Version: 1.0
In-Reply-To: <20171005143553.23784-1-malbarbo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add AT_SECURE auxval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marco A L Barbosa <malbarbo@gmail.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

I'm Cc'ing this to qemu-devel@ for review, since this patch hasn't got any reviews.
Please the next time always inclure qemu-devel@ and other addresses according
to the output of scripts/get_maintainer.pl

Thanks,

/mjt

05.10.2017 17:35, Marco A L Barbosa wrote:
> This is necessary to run android ndk applications. Without this patch, the
> following error is generated:
> 
> FATAL: kernel did not supply AT_SECURE
> 
> Should AT_SECURE from host be considered or is the ids comparisons enough?
> 
> Signed-off-by: Marco A L Barbosa <malbarbo@gmail.com>
> ---
>  linux-user/elfload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 79062882ba..177ce30e89 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1354,7 +1354,7 @@ struct exec
>                                   ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
>  #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
>  
> -#define DLINFO_ITEMS 14
> +#define DLINFO_ITEMS 15
>  
>  static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
>  {
> @@ -1782,6 +1782,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>      NEW_AUX_ENT(AT_HWCAP, (abi_ulong) ELF_HWCAP);
>      NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
>      NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
> +    NEW_AUX_ENT(AT_SECURE, (abi_ulong) (getuid() != geteuid() || getgid() != getegid()));
>  
>  #ifdef ELF_HWCAP2
>      NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
> 
