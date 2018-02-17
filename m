Received: from eggs.gnu.org ([2001:4830:134:3::10]:58727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6BQ-0008MP-6Y
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6BM-0002Zd-7n
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:21:56 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1en6BL-0002Z2-Tm
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:21:52 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-9-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6f75cd0a-1a5f-5915-a8a1-8279eeb1d6fd@vivier.eu>
Date: Sat, 17 Feb 2018 18:21:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/11] linux-user/strace: improve
 gettimeofday() output
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
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4b8ab6bcfb..b7c4cfae58 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1526,6 +1526,19 @@ print_futimesat(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_gettimeofday
> +static void
> +print_gettimeofday(const struct syscallname *name,
> +                   abi_long arg0, abi_long arg1, abi_long arg2,
> +                   abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_pointer(arg0, 0);
> +    print_pointer(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_link
>  static void
>  print_link(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 958d10d48f..f90c0e8ee4 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -384,7 +384,7 @@
>  { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_gettimeofday
> -{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
> +{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_gettimeofday, NULL },
>  #endif
>  #ifdef TARGET_NR_getuid
>  { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
> 

There is a print_timeval(), and you could add a print_timezone(), and
update the result() function pointer to call them.

And once it is done, you can also display them for settimeofday().

Thanks,
Laurent
