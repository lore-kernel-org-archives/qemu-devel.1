Received: from eggs.gnu.org ([209.51.188.92]:34989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1ggNo3-0002FM-EQ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 00:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tom.deseyn@gmail.com>) id 1ggNo2-0001B6-90
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 00:50:35 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tom.deseyn@gmail.com>)
	id 1ggNo2-000146-0g
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 00:50:34 -0500
Received: by mail-qk1-x743.google.com with SMTP id o8so8373028qkk.11
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 21:50:28 -0800 (PST)
MIME-Version: 1.0
References: <b95d4a9c-4bee-5e0d-5ec6-02edf3aefcc1@vivier.eu>
	<20181214154130.4069-1-tom.deseyn@gmail.com>
In-Reply-To: <20181214154130.4069-1-tom.deseyn@gmail.com>
From: Tom Deseyn <tom.deseyn@gmail.com>
Date: Mon, 7 Jan 2019 06:50:15 +0100
Message-ID: <CAErTmiPDhaLR8YZbABtZ=BAquXC0ZW=Y+tBRZr4YtRas0UpiLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] Add getsockopt for settable SOL_IPV6
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, Laurent Vivier <laurent@vivier.eu>

Hi Laurent,

Can you please take a look at the updated patch? Should I add braces for
code-style?

Thanks,

Tom


On Fri, Dec 14, 2018 at 4:43 PM <tom.deseyn@gmail.com> wrote:

> From: Tom Deseyn <tom.deseyn@gmail.com>
>
> Thank you for reviewing Laurant.
> Sorry for missing history, I'm not used to sending patches via mail.
> I got an email about code style. For now, I'm sticking to the style
> that is used in the function.
>
> v2: default to unimplemented
> v3: match kernel behavior
>
> Signed-off-by: Tom Deseyn <tom.deseyn@gmail.com>
> ---
>  linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 280137da8c..f103437f26 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2352,6 +2352,42 @@ static abi_long do_getsockopt(int sockfd, int
> level, int optname,
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
> +        case IPV6_CHECKSUM: {
> +            void* target_addr;
> +            if (get_user_u32(len, optlen))
> +                return -TARGET_EFAULT;
> +            if (len < 0)
> +                return -TARGET_EINVAL;
> +            lv = sizeof(val);
> +            ret = get_errno(getsockopt(sockfd, level, optname, &val,
> &lv));
> +            if (ret < 0)
> +                return ret;
> +            if (lv < len)
> +                len = lv;
> +            if (put_user_u32(len, optlen))
> +                return -TARGET_EFAULT;
> +            target_addr = lock_user(VERIFY_WRITE, optval_addr, len, 0);
> +            tswap32s((uint32_t*)&val);
> +            memcpy(target_addr, &val, len);
> +            unlock_user(target_addr, optval_addr, len);
> +            break;
> +        }
> +        default:
> +            goto unimplemented;
> +        }
> +        break;
>      default:
>      unimplemented:
>          gemu_log("getsockopt level=%d optname=%d not yet supported\n",
> --
> 2.19.2
>
>
