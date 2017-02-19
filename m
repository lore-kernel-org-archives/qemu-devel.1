Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfNgG-0003oN-T4
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 04:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfNgB-0000IN-TP
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 04:21:20 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cfNgB-0000H8-Hz
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 04:21:15 -0500
References: <20170218223130.GA25278@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <347a4fcc-7ab3-ec00-1706-984c41fde9e0@vivier.eu>
Date: Sun, 19 Feb 2017 10:21:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170218223130.GA25278@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5] linux-user: Add sockopts for IPv6 ping
 and IPv6 traceroute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 18/02/2017 à 23:31, Helge Deller a écrit :
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
> Tested with hppa-linux-user (big-endian) on x86_64 (little-endian).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> 
> ---
> Changes to v4: (all suggested by Laurent Vivier)
> - Handle AF_INET6 in host_to_target_sockaddr()
> - Drop length check for IP_TTL and SOL_IPV6
> - Trunk optlen length in ICMPV6_FILTER if necessary
> 
> Changes to v3:
> - Fix up checkpatch fallouts
> 
> Changes to v2: (all suggested by Laurent Vivier)
> - Drop goto statements and replaced by real code
> - New function host_to_target_sockaddr_in6()
> - Fix IPV6_PKTINFO which uses in6_pktinfo instead of uint32_t
> - Move one IPV6_CHECKSUM from SOL_ICMPV6 to SOL_IPV6
> - Fix ICMPV6_FILTER to use icmpv6_filter
> 
> Changes to v1:
> - Added IPV6_PKTINFO sockopt as reported by Philippe Mathieu-Daudé
> 
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f569f82..b9d10e7 100644
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
> @@ -1634,6 +1636,11 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
>          struct sockaddr_ll *target_ll = (struct sockaddr_ll *)target_saddr;
>          target_ll->sll_ifindex = tswap32(target_ll->sll_ifindex);
>          target_ll->sll_hatype = tswap16(target_ll->sll_hatype);
> +    } else if (addr->sa_family == AF_INET6 &&
> +               len >= sizeof(struct target_sockaddr_in6)) {
> +        struct target_sockaddr_in6 *target_in6 =
> +               (struct target_sockaddr_in6 *)target_saddr;
> +        target_in6->sin6_scope_id = tswap16(target_in6->sin6_scope_id);
>      }
>      unlock_user(target_saddr, target_addr, len);
>  
> @@ -1839,6 +1846,78 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>              }
>              break;
>  
> +        case SOL_IP:
> +            switch (cmsg->cmsg_type) {
> +            case IP_TTL:
> +            {
> +                uint32_t *v = (uint32_t *)data;
> +                uint32_t *t_int = (uint32_t *)target_data;
> +
> +                __put_user(*v, t_int);
> +                break;
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
> +                break;
> +            }
> +            default:
> +                goto unimplemented;
> +            }
> +            break;
> +
> +        case SOL_IPV6:
> +            switch (cmsg->cmsg_type) {
> +            case IPV6_HOPLIMIT:
> +            {
> +                uint32_t *v = (uint32_t *)data;
> +                uint32_t *t_int = (uint32_t *)target_data;
> +
> +                __put_user(*v, t_int);
> +                break;
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
> +                host_to_target_sockaddr((unsigned long) &target_errh->offender,
> +                    (void *) &errh->offender, sizeof(errh->offender));
> +                break;
> +            }
> +            default:
> +                goto unimplemented;
> +            }
> +            break;
> +
>          default:
>          unimplemented:
>              gemu_log("Unsupported ancillary data: %d/%d\n",
> @@ -2768,6 +2847,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>          case IP_PKTINFO:
>          case IP_MTU_DISCOVER:
>          case IP_RECVERR:
> +        case IP_RECVTTL:
>          case IP_RECVTOS:
>  #ifdef IP_FREEBIND
>          case IP_FREEBIND:
> @@ -2817,6 +2897,11 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>          case IPV6_MTU:
>          case IPV6_V6ONLY:
>          case IPV6_RECVPKTINFO:
> +        case IPV6_UNICAST_HOPS:
> +        case IPV6_RECVERR:
> +        case IPV6_RECVHOPLIMIT:
> +        case IPV6_2292HOPLIMIT:
> +        case IPV6_CHECKSUM:
>              val = 0;
>              if (optlen < sizeof(uint32_t)) {
>                  return -TARGET_EINVAL;
> @@ -2827,6 +2912,50 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>              ret = get_errno(setsockopt(sockfd, level, optname,
>                                         &val, sizeof(val)));
>              break;
> +        case IPV6_PKTINFO:
> +        {
> +            struct in6_pktinfo pki;
> +
> +            if (optlen < sizeof(pki)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            if (copy_from_user(&pki, optval_addr, sizeof(pki))) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +            pki.ipi6_ifindex = tswap32(pki.ipi6_ifindex);
> +
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                       &pki, sizeof(pki)));
> +            break;
> +        }
> +        default:
> +            goto unimplemented;
> +        }
> +        break;
> +    case SOL_ICMPV6:
> +        switch (optname) {
> +        case ICMPV6_FILTER:
> +        {
> +            struct icmp6_filter icmp6f;
> +
> +            if (optlen > sizeof(icmp6f)) {
> +                optlen = sizeof(icmp6f);
> +            }
> +
> +            if (copy_from_user(&icmp6f, optval_addr, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +            for (val = 0; val < 8; val++) {
> +                icmp6f.data[val] = tswap32(icmp6f.data[val]);
> +            }
> +
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                       &icmp6f, optlen));
> +            break;
> +        }
>          default:
>              goto unimplemented;
>          }
> @@ -2834,7 +2963,8 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>      case SOL_RAW:
>          switch (optname) {
>          case ICMP_FILTER:
> -            /* struct icmp_filter takes an u32 value */
> +        case IPV6_CHECKSUM:
> +            /* those take an u32 value */
>              if (optlen < sizeof(uint32_t)) {
>                  return -TARGET_EINVAL;
>              }
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 72ca5b1..40c5027 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -164,6 +164,14 @@ struct target_sockaddr_in {
>                  sizeof(struct target_in_addr)];
>  };
>  
> +struct target_sockaddr_in6 {
> +    uint16_t sin6_family;
> +    uint16_t sin6_port; /* big endian */
> +    uint32_t sin6_flowinfo; /* big endian */
> +    struct in6_addr sin6_addr; /* IPv6 address, big endian */
> +    uint32_t sin6_scope_id;
> +};
> +
>  struct target_sock_filter {
>      abi_ushort code;
>      uint8_t jt;
> 
