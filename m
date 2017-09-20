Received: from eggs.gnu.org ([2001:4830:134:3::10]:57938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duey6-00089B-WB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duex4-0007kE-9c
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:23:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1duex3-0007iP-RL
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:22:06 -0400
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
	<20170919230643.87425-3-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a308b7b3-633b-cb31-0a8e-a1f0a9bb1f9a@vivier.eu>
Date: Wed, 20 Sep 2017 11:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170919230643.87425-3-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] linux-user: add SO_LINGER to getsockopt
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

Le 20/09/2017 à 01:06, Carlo Marcelo Arenas Belón a écrit :
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/syscall.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ad689dad50..91bd27c63a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3178,7 +3178,6 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>          level = SOL_SOCKET;
>          switch (optname) {
>          /* These don't just return a single integer */
> -        case TARGET_SO_LINGER:
>          case TARGET_SO_RCVTIMEO:
>          case TARGET_SO_SNDTIMEO:
>          case TARGET_SO_PEERNAME:
> @@ -3216,6 +3215,39 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>              }
>              break;
>          }
> +        case TARGET_SO_LINGER:
> +        {
> +            struct linger lg;
> +            socklen_t lglen;
> +            struct target_linger *tlg;
> +
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            lglen = sizeof(lg);
> +            ret = get_errno(getsockopt(sockfd, level, SO_LINGER,
> +                                       &lg, &lglen));
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            if (len > lglen) {
> +                len = lglen;
> +            }
> +            if (!lock_user_struct(VERIFY_WRITE, tlg, optval_addr, 0)) {
> +                return -TARGET_EFAULT;
> +            }
> +            __put_user(lg.l_onoff, &tlg->l_onoff);
> +            __put_user(lg.l_linger, &tlg->l_linger);
> +            unlock_user_struct(tlg, optval_addr, 1);
> +            if (put_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            break;
> +        }
>          /* Options with 'int' argument.  */
>          case TARGET_SO_DEBUG:
>              optname = SO_DEBUG;
> 

You should merge PATCH 2/3 and PATCH 3/3.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
