Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emLIL-00065O-Lt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emLII-0002qm-Gg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:17:57 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:39781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emLII-0002qN-62
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:17:54 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue105 [212.227.15.183]) with ESMTPSA (Nemesis) id
	0LgGuK-1eP5IC2wzM-00nh70 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018
	16:17:52 +0100
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-2-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c11eca2b-abba-63cd-c0da-f4bdb04304d2@vivier.eu>
Date: Thu, 15 Feb 2018 16:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/11] linux-user/strace: dump
 AF_NETLINK sockaddr content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> please double check __pad and ntohl()
> 
>  linux-user/syscall_defs.h |  7 +++++++
>  linux-user/strace.c       | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index bec3680b94..550e7d2939 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -151,6 +151,13 @@ struct target_sockaddr_un {
>      uint8_t sun_path[108];
>  };
>  
> +struct target_sockaddr_nl {
> +    uint16_t nl_family;     /* AF_NETLINK */
> +    int16_t __pad;

netlink.h uses an unsigned type here.

> +    uint32_t nl_pid;
> +    uint32_t nl_groups;
> +};
> +
>  struct target_in_addr {
>      uint32_t s_addr; /* big endian */
>  };
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index bd897a3f20..7eb5e2ab48 100644
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
> @@ -397,6 +398,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>              gemu_log("}");
>              break;
>          }
> +        case AF_NETLINK: {
> +            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
> +            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
> +                     ntohl(nl->nl_pid), ntohl(nl->nl_groups));

Both sides of the netlink pipe are local and have the same endianness,
so I don't think we need the ntohl() here. Moreover, I didn't find any
endianness change in the kernel for them.

Thanks,
Laurent
