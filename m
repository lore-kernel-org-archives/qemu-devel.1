Received: from eggs.gnu.org ([2001:4830:134:3::10]:41919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv02-00052N-5q
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMuzq-0000Nn-O9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:14:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMuzq-0000Mf-IX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:14:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so15507433wmw.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:14:18 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-25-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <363dbe0f-e342-708f-16ed-ee78bc9d6c5d@redhat.com>
Date: Wed, 14 Nov 2018 14:14:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 24/41] slirp: replace
 HOST_WORDS_BIGENDIAN with glib equivalent
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
> One more step towards making the project independent from QEMU.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   slirp/ip.h           | 8 +++++---
>   slirp/ip6.h          | 3 ++-
>   slirp/ip6_icmp.h     | 6 +++---
>   slirp/slirp_config.h | 3 ---
>   slirp/tcp.h          | 4 +++-
>   5 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/slirp/ip.h b/slirp/ip.h
> index 59cf4aa918..83fc9cdfbf 100644
> --- a/slirp/ip.h
> +++ b/slirp/ip.h
> @@ -33,7 +33,9 @@
>   #ifndef IP_H
>   #define IP_H
>   
> -#ifdef HOST_WORDS_BIGENDIAN
> +#include <glib.h>
> +
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>   # undef NTOHL
>   # undef NTOHS
>   # undef HTONL
> @@ -69,7 +71,7 @@ typedef uint32_t n_long;                 /* long as received from the net */
>    * Structure of an internet header, naked of options.
>    */
>   struct ip {
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>   	uint8_t ip_v:4,			/* version */
>   		ip_hl:4;		/* header length */
>   #else
> @@ -135,7 +137,7 @@ struct	ip_timestamp {
>   	uint8_t	ipt_code;		/* IPOPT_TS */
>   	uint8_t	ipt_len;		/* size of structure (variable) */
>   	uint8_t	ipt_ptr;		/* index of current entry */
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>   	uint8_t	ipt_oflw:4,		/* overflow counter */
>   		ipt_flg:4;		/* flags, see below */
>   #else
> diff --git a/slirp/ip6.h b/slirp/ip6.h
> index b1bea43b3c..14e9c78735 100644
> --- a/slirp/ip6.h
> +++ b/slirp/ip6.h
> @@ -6,6 +6,7 @@
>   #ifndef SLIRP_IP6_H
>   #define SLIRP_IP6_H
>   
> +#include <glib.h>
>   #include "net/eth.h"
>   
>   #define ALLNODES_MULTICAST  { .s6_addr = \
> @@ -113,7 +114,7 @@ static inline void in6_compute_ethaddr(struct in6_addr ip,
>    * Structure of an internet header, naked of options.
>    */
>   struct ip6 {
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>       uint32_t
>           ip_v:4,         /* version */
>           ip_tc_hi:4,     /* traffic class */
> diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
> index b3378b17b5..32b0914055 100644
> --- a/slirp/ip6_icmp.h
> +++ b/slirp/ip6_icmp.h
> @@ -34,7 +34,7 @@ struct ndp_rs {     /* Router Solicitation Message */
>   
>   struct ndp_ra {     /* Router Advertisement Message */
>       uint8_t chl;    /* Cur Hop Limit */
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>       uint8_t
>           M:1,
>           O:1,
> @@ -56,7 +56,7 @@ struct ndp_ns {     /* Neighbor Solicitation Message */
>   } QEMU_PACKED;
>   
>   struct ndp_na {     /* Neighbor Advertisement Message */
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>       uint32_t
>           R:1,                /* Router Flag */
>           S:1,                /* Solicited Flag */
> @@ -125,7 +125,7 @@ struct ndpopt {
>   #define ndpopt_linklayer ndpopt_body.linklayer_addr
>           struct prefixinfo {                     /* Prefix Information */
>               uint8_t     prefix_length;
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>               uint8_t     L:1, A:1, reserved1:6;
>   #else
>               uint8_t     reserved1:6, A:1, L:1;
> diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
> index 5126711849..b2def6d20c 100644
> --- a/slirp/slirp_config.h
> +++ b/slirp/slirp_config.h
> @@ -11,8 +11,5 @@
>    * You shouldn't need to touch any of these
>    */
>   
> -/* Define if the machine is big endian */
> -//#undef HOST_WORDS_BIGENDIAN
> -
>   /* Define to sizeof(char *) */
>   #define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
> diff --git a/slirp/tcp.h b/slirp/tcp.h
> index 174d3d960c..47aaea6c5b 100644
> --- a/slirp/tcp.h
> +++ b/slirp/tcp.h
> @@ -33,6 +33,8 @@
>   #ifndef TCP_H
>   #define TCP_H
>   
> +#include <glib.h>
> +
>   typedef	uint32_t tcp_seq;
>   
>   #define      PR_SLOWHZ       2               /* 2 slow timeouts per second (approx) */
> @@ -51,7 +53,7 @@ struct tcphdr {
>   	uint16_t th_dport;              /* destination port */
>   	tcp_seq	th_seq;			/* sequence number */
>   	tcp_seq	th_ack;			/* acknowledgement number */
> -#ifdef HOST_WORDS_BIGENDIAN
> +#if G_BYTE_ORDER == G_BIG_ENDIAN
>   	uint8_t	th_off:4,		/* data offset */
>   		th_x2:4;		/* (unused) */
>   #else
> 
