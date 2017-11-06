Received: from eggs.gnu.org ([2001:4830:134:3::10]:51312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBmj4-0004NN-2J
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBmj3-0002Nx-95
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:06:26 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-64-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d09209e7-5221-5b1e-dc17-1db05b84c614@amsat.org>
Date: Mon, 6 Nov 2017 16:06:14 -0300
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-64-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 63/88] bsd-user/syscall: fix a memory leak
 on EFAULT, use g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Hi Michael,

Since there is no bsd-user maintainers, can you take this single patch
for 2.11? It fixes a memory leak.

Regards,

Phil.

On 10/06/2017 08:49 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Kamil are you interested in maintaining bsd-user? :)
>  
>  bsd-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index 66492aaf5d..9120cea61e 100644
> --- a/bsd-user/syscall.c
> +++ b/bsd-user/syscall.c
> @@ -227,7 +227,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, int32_t namelen, abi_ulong ol
>      void *hnamep, *holdp, *hnewp = NULL;
>      size_t holdlen;
>      abi_ulong oldlen = 0;
> -    int32_t *snamep = g_malloc(sizeof(int32_t) * namelen), *p, *q, i;
> +    int32_t *snamep, *p, *q, i;
>      uint32_t kind = 0;
>  
>      if (oldlenp)
> @@ -239,6 +239,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, int32_t namelen, abi_ulong ol
>      if (!(holdp = lock_user(VERIFY_WRITE, oldp, oldlen, 0)))
>          return -TARGET_EFAULT;
>      holdlen = oldlen;
> +    snamep = g_new(int32_t, namelen);
>      for (p = hnamep, q = snamep, i = 0; i < namelen; p++, i++)
>         *q++ = tswap32(*p);
>      oidfmt(snamep, namelen, NULL, &kind);
> 
