Received: from eggs.gnu.org ([2001:4830:134:3::10]:33745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFgp7-0005VB-2p
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFgp5-0000ke-VF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:04:33 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFgp5-0000iu-PT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:04:31 -0400
Received: by mail-wr0-x229.google.com with SMTP id q97so5485586wrb.2
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 06:04:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170408193322.16631-1-slyfox@gentoo.org>
References: <20170408193322.16631-1-slyfox@gentoo.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 14:04:10 +0100
Message-ID: <CAFEAcA9hGET8EyWYUwLvtnMEWzWJn0WCGEdz=nDhO4BCyxS8zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] alpha-user: wire epoll_create, epoll_ctl,
 epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergei Trofimovich <slyfox@gentoo.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

On 8 April 2017 at 20:33, Sergei Trofimovich <slyfox@gentoo.org> wrote:
> Noticed when ran GHC on alpha:
>     $ qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp/a
>     qemu: Unsupported syscall: 407
>
> linux-user/syscall.c does have 'epoll_create' wiring,
> but under nondeprecated name.
>
> Instead of defining both
>     TARGET_NR_sys_epoll_create
> and
>     TARGET_NR_epoll_create
> I've renamed former to later as old name is not used
> anywhere else in qemu.

It's also still used in the linux-user/strace.list
file:

#ifdef TARGET_NR_sys_epoll_create
{ TARGET_NR_sys_epoll_create, "sys_epoll_create" , NULL, NULL, NULL },
#endif
#ifdef TARGET_NR_sys_epoll_ctl
{ TARGET_NR_sys_epoll_ctl, "sys_epoll_ctl" , NULL, NULL, NULL },
#endif
#ifdef TARGET_NR_sys_epoll_wait
{ TARGET_NR_sys_epoll_wait, "sys_epoll_wait" , NULL, NULL, NULL },
#endif

so these sections are now unused and could be deleted.

> After this change GHC works fine under qemu-alpha:
>     $ ./alpha-linux-user/qemu-alpha -L /usr/alpha-unknown-linux-gnu/ /tmp/a
>     ...
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  linux-user/alpha/syscall_nr.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
> index 00e14bb6b3..e848154663 100644
> --- a/linux-user/alpha/syscall_nr.h
> +++ b/linux-user/alpha/syscall_nr.h
> @@ -343,9 +343,9 @@
>  #define TARGET_NR_io_cancel                    402
>  #define TARGET_NR_exit_group                   405
>  #define TARGET_NR_lookup_dcookie               406
> -#define TARGET_NR_sys_epoll_create             407
> -#define TARGET_NR_sys_epoll_ctl                408
> -#define TARGET_NR_sys_epoll_wait               409
> +#define TARGET_NR_epoll_create                 407
> +#define TARGET_NR_epoll_ctl                    408
> +#define TARGET_NR_epoll_wait                   409
>  #define TARGET_NR_remap_file_pages             410
>  #define TARGET_NR_set_tid_address              411
>  #define TARGET_NR_restart_syscall              412
> --
> 2.12.2

This change is fine though.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
