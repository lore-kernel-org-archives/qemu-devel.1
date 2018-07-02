Received: from eggs.gnu.org ([2001:4830:134:3::10]:46235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa491-0005s1-U9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa48w-0008Na-W1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:05:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa48w-0008MN-Ls
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:05:46 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-7-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0efbb3ec-a168-aabd-4808-a5c69280c8d7@vivier.eu>
Date: Mon, 2 Jul 2018 21:05:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/13] linux-user/strace: Dump
 AF_NETLINK sockaddr content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/syscall_defs.h |  7 +++++++
>  linux-user/strace.c       | 34 ++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c      |  6 ++++--
>  3 files changed, 45 insertions(+), 2 deletions(-)

Could you split this patch in two parts:
- one to introduce target_sockaddr_nl and modify syscall.c
- one to add the strace part

> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 40bb60ef4c..5a0b76721f 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -152,6 +152,13 @@ struct target_sockaddr_un {
>      uint8_t sun_path[108];
>  };
>  
> +struct target_sockaddr_nl {
> +    uint16_t nl_family;     /* AF_NETLINK */
> +    uint16_t __pad;
> +    uint32_t nl_pid;
> +    uint32_t nl_groups;
> +};
> +
>  struct target_in_addr {
>      uint32_t s_addr; /* big endian */
>  };
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 8a21d3bcfc..77e36467cd 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -8,6 +8,7 @@
>  #include <arpa/inet.h>
>  #include <netinet/tcp.h>
>  #include <linux/if_packet.h>
> +#include <linux/netlink.h>
>  #include <sched.h>
>  #include "qemu.h"
>  
> @@ -398,6 +399,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>              gemu_log("}");
>              break;
>          }
> +        case AF_NETLINK: {
> +            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
> +            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
> +                     nl->nl_pid, nl->nl_groups);
> +            break;
> +        }
>          default:
>              gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
>              for (i = 0; i < 13; i++) {
> @@ -424,6 +431,9 @@ print_socket_domain(int domain)
>      case PF_INET:
>          gemu_log("PF_INET");
>          break;
> +    case PF_NETLINK:
> +        gemu_log("PF_NETLINK");
> +        break;
>      case PF_PACKET:
>          gemu_log("PF_PACKET");
>          break;
> @@ -473,6 +483,30 @@ print_socket_protocol(int domain, int type, int protocol)
>          return;
>      }
>  
> +    if (domain == AF_NETLINK) {

domain uses PF_NETLINK

> +        switch (protocol) {
> +        case NETLINK_ROUTE:
> +            gemu_log("NETLINK_ROUTE");
> +            break;
> +        case NETLINK_AUDIT:
> +            gemu_log("NETLINK_AUDIT");
> +            break;
> +        case NETLINK_NETFILTER:
> +            gemu_log("NETLINK_NETFILTER");
> +            break;
> +        case NETLINK_RDMA:
> +            gemu_log("NETLINK_RDMA");
> +            break;
> +        case NETLINK_CRYPTO:
> +            gemu_log("NETLINK_CRYPTO");
> +            break;
> +        default:
> +            gemu_log("%d", protocol);
> +            break;
> +        }

add NETLINK_KOBJECT_UEVENT, it is managed in syscall.c

Thanks,
Laurent
