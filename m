Received: from eggs.gnu.org ([2001:4830:134:3::10]:38862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZjEt-00020k-8Q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZjEs-0007Gk-I5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:41:59 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-30-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eff38438-8224-680b-86a8-b3ed0053a855@vivier.eu>
Date: Mon, 24 Jul 2017 21:41:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-30-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 29/35] syscall: fix out-of-bound
 memory access
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
> linux-user/syscall.c:555:25: warning: Out of bound memory access (accessed memory precedes memory block)
>     target_fd_trans[fd] = trans;
>     ~~~~~~~~~~~~~~~~~~~~^~~~~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 637270a02d..26450d235f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -544,6 +544,7 @@ static void fd_trans_register(int fd, TargetFdTrans *trans)
>  {
>      unsigned int oldmax;
>  
> +    assert(fd >= 0);
>      if (fd >= target_fd_max) {
>          oldmax = target_fd_max;
>          target_fd_max = ((fd >> 6) + 1) << 6; /* by slice of 64 entries */
> 

I think we should fix inotify_init(), inotify_init1(), eventfd() and
eventfd2() that call fd_trans_register() without checking the value of
fd before adding this assert...

Thanks,
Laurent
