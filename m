Received: from eggs.gnu.org ([2001:4830:134:3::10]:57541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duGvO-0000FP-1a
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duGvK-0000CL-VJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:42:46 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1duGvK-0000BO-LP
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:42:42 -0400
References: <20170919081549.82541-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
Date: Tue, 19 Sep 2017 13:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170919081549.82541-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: syscall: Add SO_LINGER for
 setsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, riku.voipio@iki.fi, rth@twiddle.net

Le 19/09/2017 à 10:15, Carlo Marcelo Arenas Belón a écrit :
> Original implementation from Chen Gang; code moved around as per v2
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/syscall.c      | 16 ++++++++++++++++
>  linux-user/syscall_defs.h |  5 +++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a266..d3c500ca78 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2829,6 +2829,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>      int val;
>      struct ip_mreqn *ip_mreq;
>      struct ip_mreq_source *ip_mreq_source;
> +    struct linger lg;
> +    struct target_linger *tlg;
>  
>      switch(level) {
>      case SOL_TCP:
> @@ -3071,6 +3073,20 @@ set_timeout:
>  		unlock_user (dev_ifname, optval_addr, 0);
>  		return ret;
>  	}
> +        case TARGET_SO_LINGER:
> +                optname = SO_LINGER;
> +                if (optlen != sizeof(struct target_linger)) {
> +                    return -TARGET_EINVAL;
> +                }
> +                if (!lock_user_struct(VERIFY_READ, tlg, optval_addr, 1)) {
> +                    return -TARGET_EFAULT;
> +                }
> +                __get_user(lg.l_onoff, &tlg->l_onoff);
> +                __get_user(lg.l_linger, &tlg->l_linger);
> +                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname,
> +                                &lg, sizeof(lg)));
> +                unlock_user_struct(tlg, optval_addr, 0);
> +                return ret;
>              /* Options with 'int' argument.  */

It looks good.

Could you also add it for getsockopt()?

>          case TARGET_SO_DEBUG:
>  		optname = SO_DEBUG;
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 40c5027e93..a60d6bb163 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -202,6 +202,11 @@ struct target_ip_mreq_source {
>      uint32_t imr_sourceaddr;
>  };
>  
> +struct target_linger {
> +    abi_int l_onoff;        /* Linger active                */
> +    abi_int l_linger;       /* How long to linger for       */
> +};
> +
>  struct target_timeval {
>      abi_long tv_sec;
>      abi_long tv_usec;
> 

Could you update the definition of TARGET_SO_LINGER for sparc (kernel
says 0x0080, and we use 13)

Thanks,
Laurent
