Received: from eggs.gnu.org ([2001:4830:134:3::10]:44461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv77-0002Ub-7D
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv6z-0008Nv-5X
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:21:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMv6x-0008LZ-BI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:21:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so15531740wmw.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:21:38 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-39-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4362ae94-b1b1-e472-3876-7d4e9a57e46e@redhat.com>
Date: Wed, 14 Nov 2018 14:21:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-39-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 38/41] net: do not depend on slirp
 internals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/18 13:36, Marc-André Lureau wrote:
> Only slirp/libslirp.h should be included.
> 
> Instead of using some slirp declarations and utility functions directly,
> let's copy them in net/util.h.

Nice cleanup! Can this single patch be applied out of this RFC series?

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   net/colo.h            |  3 +--
>   net/util.h            | 55 +++++++++++++++++++++++++++++++++++++++++++
>   net/colo-compare.c    |  1 +
>   net/colo.c            |  1 +
>   net/filter-rewriter.c |  1 +
>   net/slirp.c           |  2 +-
>   stubs/slirp.c         |  2 +-
>   7 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/net/colo.h b/net/colo.h
> index 11c5226488..420d916af2 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -15,10 +15,9 @@
>   #ifndef QEMU_COLO_PROXY_H
>   #define QEMU_COLO_PROXY_H
>   
> -#include "slirp/slirp.h"
>   #include "qemu/jhash.h"
>   #include "qemu/timer.h"
> -#include "slirp/tcp.h"
> +#include "net/eth.h"
>   
>   #define HASHTABLE_MAX_SIZE 16384
>   
> diff --git a/net/util.h b/net/util.h
> index 60b73d372d..358185fd50 100644
> --- a/net/util.h
> +++ b/net/util.h
> @@ -26,6 +26,61 @@
>   #define QEMU_NET_UTIL_H
>   
>   
> +/*
> + * Structure of an internet header, naked of options.
> + */
> +struct ip {
> +#ifdef HOST_WORDS_BIGENDIAN
> +    uint8_t ip_v:4,         /* version */
> +            ip_hl:4;        /* header length */
> +#else
> +    uint8_t ip_hl:4,        /* header length */
> +            ip_v:4;         /* version */
> +#endif
> +    uint8_t ip_tos;         /* type of service */
> +    uint16_t ip_len;        /* total length */
> +    uint16_t ip_id;         /* identification */
> +    uint16_t ip_off;        /* fragment offset field */
> +#define IP_DF 0x4000        /* don't fragment flag */
> +#define IP_MF 0x2000        /* more fragments flag */
> +#define IP_OFFMASK 0x1fff   /* mask for fragmenting bits */
> +    uint8_t ip_ttl;         /* time to live */
> +    uint8_t ip_p;           /* protocol */
> +    uint16_t ip_sum;        /* checksum */
> +    struct in_addr ip_src, ip_dst;  /* source and dest address */
> +} QEMU_PACKED;
> +
> +static inline bool in6_equal_net(const struct in6_addr *a,
> +                                 const struct in6_addr *b,
> +                                 int prefix_len)
> +{
> +    if (memcmp(a, b, prefix_len / 8) != 0) {
> +        return 0;
> +    }
> +
> +    if (prefix_len % 8 == 0) {
> +        return 1;
> +    }
> +
> +    return a->s6_addr[prefix_len / 8] >> (8 - (prefix_len % 8))
> +        == b->s6_addr[prefix_len / 8] >> (8 - (prefix_len % 8));
> +}
> +
> +#define TCPS_CLOSED             0       /* closed */
> +#define TCPS_LISTEN             1       /* listening for connection */
> +#define TCPS_SYN_SENT           2       /* active, have sent syn */
> +#define TCPS_SYN_RECEIVED       3       /* have send and received syn */
> +/* states < TCPS_ESTABLISHED are those where connections not established */
> +#define TCPS_ESTABLISHED        4       /* established */
> +#define TCPS_CLOSE_WAIT         5       /* rcvd fin, waiting for close */
> +/* states > TCPS_CLOSE_WAIT are those where user has closed */
> +#define TCPS_FIN_WAIT_1         6       /* have closed, sent fin */
> +#define TCPS_CLOSING            7       /* closed xchd FIN; await FIN ACK */
> +#define TCPS_LAST_ACK           8       /* had fin and close; await FIN ACK */
> +/* states > TCPS_CLOSE_WAIT && < TCPS_FIN_WAIT_2 await ACK of FIN */
> +#define TCPS_FIN_WAIT_2         9       /* have closed, fin is acked */
> +#define TCPS_TIME_WAIT          10      /* in 2*msl quiet wait after close */
> +
>   int net_parse_macaddr(uint8_t *macaddr, const char *p);
>   
>   #endif /* QEMU_NET_UTIL_H */
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a39191d522..3b6f596432 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -30,6 +30,7 @@
>   #include "net/colo-compare.h"
>   #include "migration/colo.h"
>   #include "migration/migration.h"
> +#include "util.h"
>   
>   #define TYPE_COLO_COMPARE "colo-compare"
>   #define COLO_COMPARE(obj) \
> diff --git a/net/colo.c b/net/colo.c
> index 49176bf07b..8196b35837 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -15,6 +15,7 @@
>   #include "qemu/osdep.h"
>   #include "trace.h"
>   #include "colo.h"
> +#include "util.h"
>   
>   uint32_t connection_key_hash(const void *opaque)
>   {
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index bb8f4d93b1..9ccd8947db 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -22,6 +22,7 @@
>   #include "net/checksum.h"
>   #include "net/colo.h"
>   #include "migration/colo.h"
> +#include "util.h"
>   
>   #define FILTER_COLO_REWRITER(obj) \
>       OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
> diff --git a/net/slirp.c b/net/slirp.c
> index 4c39878933..7524049e49 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -38,12 +38,12 @@
>   #include "qemu/error-report.h"
>   #include "qemu/sockets.h"
>   #include "slirp/libslirp.h"
> -#include "slirp/ip6.h"
>   #include "chardev/char-fe.h"
>   #include "sysemu/sysemu.h"
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
>   #include "qapi/qmp/qdict.h"
> +#include "util.h"
>   
>   static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
>   {
> diff --git a/stubs/slirp.c b/stubs/slirp.c
> index 42f7e1afd0..70704346fd 100644
> --- a/stubs/slirp.c
> +++ b/stubs/slirp.c
> @@ -1,7 +1,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu-common.h"
>   #include "qemu/host-utils.h"
> -#include "slirp/slirp.h"
> +#include "slirp/libslirp.h"
>   
>   void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
>   {
> 
