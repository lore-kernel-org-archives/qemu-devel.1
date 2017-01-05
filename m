Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6vD-0007rO-CV
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6v9-0006w1-Ae
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:13:31 -0500
Received: from jessie.kos.to ([212.47.231.226]:41370 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1cP6v9-0006vg-3z
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:13:27 -0500
Date: Thu, 5 Jan 2017 12:13:21 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170105121321.GB19094@kos.to>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-3-git-send-email-Lena.Djokic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480003738-8754-3-git-send-email-Lena.Djokic@rt-rk.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] linux-user: Fix inotify_init1
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: qemu-devel@nongnu.org

On Thu, Nov 24, 2016 at 05:08:53PM +0100, Lena Djokic wrote:
> This commit adds necessary conversion of argument passed to inotify_init1.
> inotify_init1 flags can be IN_NONBLOCK and IN_CLOEXEC which rely on O_NONBLOCK
> and O_CLOEXEC and those can have different values on different platforms.

Thanks, applied to linux-user
 
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f5d9a26..41873ca 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11625,7 +11625,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #ifdef CONFIG_INOTIFY1
>  #if defined(TARGET_NR_inotify_init1) && defined(__NR_inotify_init1)
>      case TARGET_NR_inotify_init1:
> -        ret = get_errno(sys_inotify_init1(arg1));
> +        ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
> +                                          fcntl_flags_tbl)));
>          break;
>  #endif
>  #endif
> -- 
> 2.7.4
> 
