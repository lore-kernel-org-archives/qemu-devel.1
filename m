Received: from eggs.gnu.org ([2001:4830:134:3::10]:37130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6wP-0002W5-4I
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6wL-0002Rt-0M
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:10:29 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1en6wK-0002RR-JE
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:10:24 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-4-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <147860fa-3867-eb37-71a2-5cd03935b6f8@vivier.eu>
Date: Sat, 17 Feb 2018 19:10:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] linux-user/strace: add
 print_sockaddr_ptr() to handle plain/pointer addrlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
> since this argument differs between sendto()/recvfrom()
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index e7272f4ede..9726d9b378 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -335,12 +335,15 @@ static void print_siginfo(const target_siginfo_t *tinfo)
>  }
>  
>  static void
> -print_sockaddr(abi_ulong addr, abi_long addrlen)
> +print_sockaddr_ptr(abi_ulong addr, abi_long addrlen, bool addrlen_ptr)
>  {
>      struct target_sockaddr *sa;
>      int i;
>      int sa_family;
>  
> +    if (addrlen_ptr) {
> +        get_user_ual(addrlen, addrlen);
> +    }
>      sa = lock_user(VERIFY_READ, addr, addrlen, 1);
>      if (sa) {
>          sa_family = tswap16(sa->sa_family);
> @@ -417,7 +420,17 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>      } else {
>          print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
>      }
> -    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
> +    if (addrlen_ptr) {
> +        gemu_log(", ["TARGET_ABI_FMT_ld"]", addrlen);
> +    } else {
> +        gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
> +    }
> +}
> +
> +static void
> +print_sockaddr(abi_ulong addr, abi_long addrlen)
> +{
> +    print_sockaddr_ptr(addr, addrlen, false);
>  }
>  
>  static void
> 

Why not only something like:

static void
print_sockaddr_ptr(abi_ulong addr, abi_long addrlen_ptr)
{
    abi_ulong addrlen;

    get_user_ual(addrlen, addrlen_ptr);
    print_sockaddr(addr, addrlen);
}

?

You should also check addrlen_ptr != NULL (it's allowed with recvfrom()).

Thanks,
Laurent
