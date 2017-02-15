Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ce3tS-0000Fj-0G
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ce3tN-0008Fr-3y
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:01:30 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:54143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ce3tM-0008BU-Ol
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:01:25 -0500
References: <20170211221148.GA2924@ls3530.fritz.box>
	<ed7dc116-ef8a-bdba-c817-b36ebbfbf637@amsat.org>
	<20170213220131.GA10356@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f90bcad4-6bb3-3b5d-a15a-b53d6544e9a7@vivier.eu>
Date: Wed, 15 Feb 2017 19:00:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170213220131.GA10356@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add sockopts for IPv6 ping
 and IPv6 traceroute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 13/02/2017 à 23:01, Helge Deller a écrit :
> Add the neccessary sockopts for ping and traceroute on IPv6.
> 
> This fixes the following qemu warnings with IPv6:
> Unsupported ancillary data: 0/2
> Unsupported ancillary data: 0/11
> Unsupported ancillary data: 41/25
> Unsupported setsockopt level=0 optname=12 
> Unsupported setsockopt level=41 optname=16
> Unsupported setsockopt level=41 optname=25
> Unsupported setsockopt level=41 optname=50
> Unsupported setsockopt level=41 optname=51
> Unsupported setsockopt level=41 optname=8
> Unsupported setsockopt level=58 optname=1
> 
> Tested on hppa-linux-user and x86_64-linux-user.
> 
> Changes to v1:
> - Added IPV6_PKTINFO sockopt as reported by Philippe Mathieu-Daudé

Please, add the version comment after the "---" marker
(BTW, where is it?)

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

("---" should be here, you should use "git send-email"...)

> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9be8e95..97c2519 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -57,6 +57,8 @@ int __clone2(int (*fn)(void *), void *child_stack_base,
>  #include <netinet/tcp.h>
>  #include <linux/wireless.h>
>  #include <linux/icmp.h>
> +#include <linux/icmpv6.h>
> +#include <linux/errqueue.h>
>  #include "qemu-common.h"
>  #ifdef CONFIG_TIMERFD
>  #include <sys/timerfd.h>
> @@ -1839,6 +1841,78 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>              }
>              break;
>  
> +        case SOL_IP:
> +            switch (cmsg->cmsg_type) {
> +            case IP_TTL:
> +            {
> +                goto copy_word;

Not sure a "goto" between "SOL_*" cases is a good idea.

> +            }
> +            case IP_RECVERR:
> +            {
> +                struct errhdr_t {
> +                   struct sock_extended_err ee;
> +                   struct sockaddr_in offender;
> +                };
> +                struct errhdr_t *errh = (struct errhdr_t *)data;
> +                struct errhdr_t *target_errh =
> +                    (struct errhdr_t *)target_data;
> +
> +                __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
> +                __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
> +                __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
> +                __put_user(errh->ee.ee_code, &target_errh->ee.ee_code);
> +                __put_user(errh->ee.ee_pad, &target_errh->ee.ee_pad);
> +                __put_user(errh->ee.ee_info, &target_errh->ee.ee_info);
> +                __put_user(errh->ee.ee_data, &target_errh->ee.ee_data);
> +                host_to_target_sockaddr((unsigned long) &target_errh->offender,
> +                    (void *) &errh->offender, sizeof(errh->offender));
> +		break;
> +            }
> +            default:
> +                goto unimplemented;
> +            }
> +            break;
> +
> +        case SOL_IPV6:
> +            switch (cmsg->cmsg_type) {
> +            case IPV6_HOPLIMIT:
> +            copy_word:
> +            {
> +                uint32_t *v = (uint32_t *)data;
> +                uint32_t *t_int = (uint32_t *)target_data;
> +                if (tgt_len != CMSG_LEN(0))
> +                    goto unimplemented;
> +
> +                __put_user(*v, t_int);
> +		break;
> +            }
> +            case IPV6_RECVERR:
> +            {
> +                struct errhdr6_t {
> +                   struct sock_extended_err ee;
> +                   struct sockaddr_in6 offender;
> +                };
> +                struct errhdr6_t *errh = (struct errhdr6_t *)data;
> +                struct errhdr6_t *target_errh =
> +                    (struct errhdr6_t *)target_data;
> +
> +                __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
> +                __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
> +                __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
> +                __put_user(errh->ee.ee_code, &target_errh->ee.ee_code);
> +                __put_user(errh->ee.ee_pad, &target_errh->ee.ee_pad);
> +                __put_user(errh->ee.ee_info, &target_errh->ee.ee_info);
> +                __put_user(errh->ee.ee_data, &target_errh->ee.ee_data);
> +                target_errh->offender = errh->offender;
> +                __put_user(errh->offender.sin6_family, &target_errh->offender.sin6_family);
> +                __put_user(errh->offender.sin6_scope_id, &target_errh->offender.sin6_scope_id);

Perhaps you can put this in host_to_target_sockaddr()?
[I don't know IPv6]

> +		break;
> +            }
> +            default:
> +                goto unimplemented;
> +            }
> +            break;
> +
>          default:
>          unimplemented:
>              gemu_log("Unsupported ancillary data: %d/%d\n",
> @@ -2766,6 +2840,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>          case IP_PKTINFO:
>          case IP_MTU_DISCOVER:
>          case IP_RECVERR:
> +        case IP_RECVTTL:
>          case IP_RECVTOS:
>  #ifdef IP_FREEBIND
>          case IP_FREEBIND:
> @@ -2815,6 +2890,11 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>          case IPV6_MTU:
>          case IPV6_V6ONLY:
>          case IPV6_RECVPKTINFO:
> +        case IPV6_UNICAST_HOPS:
> +        case IPV6_RECVERR:
> +        case IPV6_PKTINFO:

It doesn't use an uint32_t but an in6_pktinfo.

> +        case IPV6_RECVHOPLIMIT:
> +        case IPV6_2292HOPLIMIT:
>              val = 0;
>              if (optlen < sizeof(uint32_t)) {
>                  return -TARGET_EINVAL;
> @@ -2829,9 +2909,21 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>              goto unimplemented;
>          }
>          break;
> +    case SOL_ICMPV6:
> +        switch(optname) {
> +        case ICMPV6_FILTER:
> +        case IPV6_CHECKSUM:

IPV6_CHECKSUM, should be in "case SOL_IPV6"

> +            goto icmp_filter;

I think the "goto" is not a good idea, IMHO you should copy the code
(it's what it is done for every "case SOL_*").

Moreover icmp_filter is:

    struct icmp_filter {
            __u32           data;
    };

while icmpv6_filter is:

    struct icmp6_filter {
            __u32           data[8];
    };

So you can't use the same code.

> +            break;
> +        default:
> +            goto unimplemented;
> +        }
> +        break;
>      case SOL_RAW:
>          switch (optname) {
>          case ICMP_FILTER:
> +        case IPV6_CHECKSUM:
> +            icmp_filter:
>              /* struct icmp_filter takes an u32 value */
>              if (optlen < sizeof(uint32_t)) {
>                  return -TARGET_EINVAL;
> 


Thanks,
Laurent
