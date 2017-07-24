Received: from eggs.gnu.org ([2001:4830:134:3::10]:36670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZj6q-0000eN-Mq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZj6n-0003Tt-Iw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:33:40 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-28-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9ed15cf4-3b4b-2d67-7278-feb5503bd9f6@vivier.eu>
Date: Mon, 24 Jul 2017 21:33:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-28-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 27/35] syscall: fix dereference of
 undefined pointer
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
> Clang's scan-build-5.0 reports:
> 
> linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer value
>     if (*host_rt_dev_ptr != 0) {
>         ^~~~~~~~~~~~~~~~
> 
> Reported-by: Clang Static Analyzer
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fcd20fa276..e79b5baec4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5524,7 +5524,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>      int target_size;
>      void *argptr;
>      abi_ulong *target_rt_dev_ptr;
> -    unsigned long *host_rt_dev_ptr;
> +    unsigned long *host_rt_dev_ptr = NULL;
>      abi_long ret;
>      int i;
>  
> @@ -5570,6 +5570,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>      unlock_user(argptr, arg, 0);
>  
>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
> +    assert(host_rt_dev_ptr);
>      if (*host_rt_dev_ptr != 0) {
>          unlock_user((void *)*host_rt_dev_ptr,
>                      *target_rt_dev_ptr, 0);
> 

I think if you add the assert you should not have to add the "= NULL".
Could you check?

Thanks,
Laurent
