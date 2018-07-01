Received: from eggs.gnu.org ([2001:4830:134:3::10]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZiP4-0002mE-57
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fZiP1-0004PU-3Z
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:52:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fZiP0-0004NR-On
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:52:55 -0400
References: <20180628034652.24152-1-f4bug@amsat.org>
	<20180628034652.24152-5-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a7baf500-bfe7-6720-700c-8a39e5ea7ebc@vivier.eu>
Date: Sun, 1 Jul 2018 21:52:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180628034652.24152-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/12] linux-user/strace: Improve
 gettimeofday() and settimeofday() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 28/06/2018 à 05:46, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  4 ++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b43a21f48b..955fe80ef2 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1499,6 +1499,19 @@ print_futimesat(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_gettimeofday) || defined(TARGET_NR_settimeofday)
> +static void
> +print_timeofday(const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_timeval(arg0, 0);
> +    print_timezone(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_link
>  static void
>  print_link(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index afe4db07f3..9b477b7730 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -384,7 +384,7 @@
>  { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_gettimeofday
> -{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
> +{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_timeofday, NULL },

print_timeofday() will be called before the call of gettimeofday() so I
don't think the values you will print here have any meaning.

Thanks,
Laurent
