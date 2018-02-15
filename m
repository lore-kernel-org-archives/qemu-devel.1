Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emK9P-0006vI-Oh
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emK9K-0001cc-Rv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:04:39 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emK9K-0001c1-IQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:04:34 -0500
References: <mvmtvuvk6kf.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ea4f017e-1217-d191-3bcf-d3bb059fb2e5@vivier.eu>
Date: Thu, 15 Feb 2018 15:04:09 +0100
MIME-Version: 1.0
In-Reply-To: <mvmtvuvk6kf.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Implement setsockopt
 SOL_SOCKET/SO_LINGER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, Chen Gang <gang.chen.5i5j@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>

Le 05/02/2018 à 12:40, Andreas Schwab a écrit :
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ff89016adc..82848fd97d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3130,6 +3130,29 @@ set_timeout:
>  		unlock_user (dev_ifname, optval_addr, 0);
>  		return ret;
>  	}
> +        case TARGET_SO_LINGER:
> +        {
> +                struct linger {
> +                    int l_onoff;
> +                    int l_linger;
> +                } linger;
> +
> +                optname = SO_LINGER;
> +
> +                if (optlen != sizeof(linger)) {
> +                    return -TARGET_EINVAL;
> +                }
> +                if (copy_from_user(&linger, optval_addr, optlen)) {
> +                    return -TARGET_EFAULT;
> +                }
> +
> +                linger.l_onoff = tswap32(linger.l_onoff);
> +                linger.l_linger = tswap32(linger.l_linger);
> +
> +                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname,
> +                                           &linger, sizeof(linger)));
> +                return ret;
> +        }
>              /* Options with 'int' argument.  */
>          case TARGET_SO_DEBUG:
>  		optname = SO_DEBUG;
> 

I think this series gives a more complete solution to the problem:

https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3985
  [1/3] linux-user: fix TARGET_SO_LINGER for sparc
  [2/3] linux-user: add SO_LINGER to setsockopt
  [3/3] linux-user: add SO_LINGER to getsockopt

but it needs some updates.

Thanks,
Laurent
