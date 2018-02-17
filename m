Received: from eggs.gnu.org ([2001:4830:134:3::10]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emzqS-0002T5-D1
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 05:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emzqP-0008Rn-8b
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 05:35:52 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emzqO-0008Qs-Uj
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 05:35:49 -0500
References: <20180217020122.1469-1-vapier@gentoo.org>
	<20180217020230.1759-1-vapier@gentoo.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1d0dedd8-4f7e-4b8b-1c69-c581852c95b2@vivier.eu>
Date: Sat, 17 Feb 2018 11:35:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180217020230.1759-1-vapier@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: make getcpu optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Frysinger <vapier@gentoo.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: samuel.thibault@ens-lyon.org

Le 17/02/2018 à 03:02, Mike Frysinger a écrit :
> Not all arches implement this, and the kernel doesn't require them to.
> Add ifdef logic to disable it when not available.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  linux-user/syscall.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 799c8e2800ea..a9904fac791f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -290,8 +290,10 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
>  #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
>  _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
>            unsigned long *, user_mask_ptr);
> +#ifdef TARGET_NR_getcpu
>  #define __NR_sys_getcpu __NR_getcpu
>  _syscall3(int, sys_getcpu, unsigned *, cpu, unsigned *, node, void *, tcache);
> +#endif

I didn't find any arch that doesn't have it in linux-user/*/syscall_nr.h
Which arches are you speaking about?

As it can be also undefined for the host arch, you should use:

    #if defined(TARGET_NR_getcpu) && defined(__NR_getcpu)

Thanks,
Laurent
