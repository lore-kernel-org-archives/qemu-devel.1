Received: from eggs.gnu.org ([2001:4830:134:3::10]:35791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZj2P-0007Xn-TA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZj2M-0001jT-Kl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:29:05 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-32-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <950e1d4b-3a65-6cf5-88a7-13a986f69e0f@vivier.eu>
Date: Mon, 24 Jul 2017 21:28:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-32-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 31/35] syscall: replace strcpy()
 by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
> linux-user/syscall.c:9860:17: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
>                 strcpy (buf->machine, cpu_to_uname_machine(cpu_env));
>                 ^~~~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 963b9c8f4b..847f729834 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9853,7 +9853,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              if (!is_error(ret)) {
>                  /* Overwrite the native machine name with whatever is being
>                     emulated. */
> -                strcpy (buf->machine, cpu_to_uname_machine(cpu_env));
> +                g_strlcpy(buf->machine, cpu_to_uname_machine(cpu_env),
> +                          sizeof(buf->machine));
>                  /* Allow the user to override the reported release.  */
>                  if (qemu_uname_release && *qemu_uname_release) {
>                      g_strlcpy(buf->release, qemu_uname_release,
> 

We should not have a problem here as cpu_to_uname_machine() is "const
char *" and the string is defined inside QEMU (so it should fit into
machine[]).

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
