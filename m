Received: from eggs.gnu.org ([2001:4830:134:3::10]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXRVc-0005Jp-Sf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXRVZ-0000lQ-Dc
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:58:36 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gXRVZ-0000kl-3j
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:58:33 -0500
References: <20181213130611.7496-1-tom.deseyn@gmail.com>
	<20181213133733.8110-1-tom.deseyn@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b95d4a9c-4bee-5e0d-5ec6-02edf3aefcc1@vivier.eu>
Date: Thu, 13 Dec 2018 14:57:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181213133733.8110-1-tom.deseyn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] Add getsockopt for settable SOL_IPV6
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tom.deseyn@gmail.com, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi

On 13/12/2018 14:37, tom.deseyn@gmail.com wrote:
> From: Tom Deseyn <tom.deseyn@gmail.com>
> 
> Signed-off-by: Tom Deseyn <tom.deseyn@gmail.com>
> ---

Please add here an history of the changes between the version 1 and 2:

v2: ?????

>  linux-user/syscall.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 280137da8c..ad52cfbd54 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2352,6 +2352,44 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>              break;
>          }
>          break;
> +    case SOL_IPV6:
> +        switch (optname) {
> +        case IPV6_MTU_DISCOVER:
> +        case IPV6_MTU:
> +        case IPV6_V6ONLY:
> +        case IPV6_RECVPKTINFO:
> +        case IPV6_UNICAST_HOPS:
> +        case IPV6_MULTICAST_HOPS:
> +        case IPV6_MULTICAST_LOOP:
> +        case IPV6_RECVERR:
> +        case IPV6_RECVHOPLIMIT:
> +        case IPV6_2292HOPLIMIT:
> +        case IPV6_CHECKSUM:
> +            if (get_user_u32(len, optlen))
> +                return -TARGET_EFAULT;
> +            if (len < 0)
> +                return -TARGET_EINVAL;
> +            lv = sizeof(lv);
> +            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
> +            if (ret < 0)
> +                return ret;
> +            if (len < sizeof(int) && len > 0 && val >= 0 && val < 255) {
> +                len = 1;
> +                if (put_user_u32(len, optlen)
> +                    || put_user_u8(val, optval_addr))
> +                    return -TARGET_EFAULT;
> +            } else {
> +                if (len > sizeof(int))
> +                    len = sizeof(int);
> +                if (put_user_u32(len, optlen)
> +                    || put_user_u32(val, optval_addr))
> +                    return -TARGET_EFAULT;
> +            }

This way to compute the size of the result is good for SOL_IP, but not
for SOL_IPV6, in kernel do_ip_getsockopt() we have:

       if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
                unsigned char ucval = (unsigned char)val;
                len = 1;
                if (put_user(len, optlen))
                        return -EFAULT;
                if (copy_to_user(optval, &ucval, 1))
                        return -EFAULT;
        } else {
                len = min_t(unsigned int, sizeof(int), len);
                if (put_user(len, optlen))
                        return -EFAULT;
                if (copy_to_user(optval, &val, len))
                        return -EFAULT;
        }

Whereas in kernel do_ipv6_getsockopt():

        default:
                return -ENOPROTOOPT;
        }
        len = min_t(unsigned int, sizeof(int), len);
        if (put_user(len, optlen))
                return -EFAULT;
        if (copy_to_user(optval, &val, len))
                return -EFAULT;
        return 0;


So in QEMU for SOL_IPV6 to mimic this I think you should use something like:

    len = min(lv, sizeof(val));
    if (put_user_u32(len, optlen) {
         return -TARGET_EFAULT;
    }
    target_addr =  lock_user(VERIFY_WRITE, optval_addr, len, 0);
    tswap32s(&val);
    memcpy(target_addr, &val, len);
    unlock_user(target_addr, optval_addr, len);

Thanks,
Laurent
