Received: from eggs.gnu.org ([2001:4830:134:3::10]:49589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvRBE-0002dd-Rf
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvRBA-00056I-Tt
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:51:56 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dvRBA-00055r-J7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:51:52 -0400
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-5-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3a07484c-13bc-1dab-67ba-6bbcdf2e58c2@vivier.eu>
Date: Fri, 22 Sep 2017 18:51:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170922140237.10869-5-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 4/6] linux-user: refactor socket.h for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, riku.voipio@iki.fi

Le 22/09/2017 à 16:02, Carlo Marcelo Arenas Belón a écrit :
> fixes SOL_SOCKET and SO_LINGER at least

And fix TARGET_SOCK_NONBLOCK and TARGET_SOCK_CLOEXEC values.

> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/socket.h         |  46 ++------------------
>  linux-user/sparc/sockbits.h | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+), 43 deletions(-)
>  create mode 100644 linux-user/sparc/sockbits.h
> 
> diff --git a/linux-user/socket.h b/linux-user/socket.h
> index 036270a6e4..dfa692286b 100644
> --- a/linux-user/socket.h
> +++ b/linux-user/socket.h
> @@ -4,50 +4,10 @@
>  #include "alpha/sockbits.h"
>  #elif defined(TARGET_HPPA)
>  #include "hppa/sockbits.h"
> +#elif defined(TARGET_SPARC)
> +#include "sparc/sockbits.h"
>  #else
>  
> -#if defined(TARGET_SPARC)
> -    /** sock_type - Socket types
> -     *
> -     * Please notice that for binary compat reasons SPARC has to
> -     * override the enum sock_type in include/linux/net.h, so
> -     * we define ARCH_HAS_SOCKET_TYPES here.
> -     *
> -     * @SOCK_DGRAM - datagram (conn.less) socket
> -     * @SOCK_STREAM - stream (connection) socket
> -     * @SOCK_RAW - raw socket
> -     * @SOCK_RDM - reliably-delivered message
> -     * @SOCK_SEQPACKET - sequential packet socket
> -     * @SOCK_DCCP - Datagram Congestion Control Protocol socket
> -     * @SOCK_PACKET - linux specific way of getting packets at the dev level.
> -     *                For writing rarp and other similar things on the user
> -     *                level.
> -     * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
> -     * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
> -     */
> -
> -    #define ARCH_HAS_SOCKET_TYPES          1
> -
> -    enum sock_type {
> -           TARGET_SOCK_STREAM      = 1,
> -           TARGET_SOCK_DGRAM       = 2,
> -           TARGET_SOCK_RAW         = 3,
> -           TARGET_SOCK_RDM         = 4,
> -           TARGET_SOCK_SEQPACKET   = 5,
> -           TARGET_SOCK_DCCP        = 6,
> -           TARGET_SOCK_PACKET      = 10,
> -           TARGET_SOCK_CLOEXEC     = 020000000,
> -           TARGET_SOCK_NONBLOCK    = 040000,
> -    };
...
> +enum sock_type {
> +    TARGET_SOCK_STREAM      = 1,
> +    TARGET_SOCK_DGRAM       = 2,
> +    TARGET_SOCK_RAW         = 3,
> +    TARGET_SOCK_RDM         = 4,
> +    TARGET_SOCK_SEQPACKET   = 5,
> +    TARGET_SOCK_DCCP        = 6,
> +    TARGET_SOCK_PACKET      = 10,
> +    TARGET_SOCK_CLOEXEC     = 0x400000,
> +    TARGET_SOCK_NONBLOCK    = 0x4000,
> +};
> +
> +#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
> +#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
> +
> +#define ARCH_HAS_SOCKET_TYPES 1
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
