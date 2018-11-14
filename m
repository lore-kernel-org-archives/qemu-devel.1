Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMuwH-0001gs-Gm
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMuwD-0004dD-4q
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMuw3-0004Mt-Fu
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so15379842wmc.1
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:10:19 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b17fd075-7142-d7db-0df7-16938b5bd245@redhat.com>
Date: Wed, 14 Nov 2018 14:10:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 05/41] slirp: use a callback
 structure to interface with qemu
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
> This will bring slirp a bit forward to the state of an independent
> project.
> 
> This could be squashed with earlier submitted "slirp: associate
> slirp_output".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   slirp/libslirp.h |  7 +++++--
>   slirp/slirp.h    |  2 +-
>   net/slirp.c      |  6 +++++-
>   slirp/ncsi.c     |  2 +-
>   slirp/slirp.c    | 10 +++++-----
>   5 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 04b6db9f49..36d5fb9163 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -5,7 +5,10 @@
>   
>   typedef struct Slirp Slirp;
>   
> -typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int pkt_len);
> +typedef struct SlirpCb {
> +    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
> +} SlirpCb;
> +
>   
>   Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
>                     struct in_addr vnetmask, struct in_addr vhost,
> @@ -17,7 +20,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
>                     struct in_addr vdhcp_start, struct in_addr vnameserver,
>                     struct in6_addr vnameserver6, const char **vdnssearch,
>                     const char *vdomainname,
> -                  slirp_output output,
> +                  const SlirpCb *callbacks,
>                     void *opaque);
>   void slirp_cleanup(Slirp *slirp);
>   
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index de299aa36c..f7c087456a 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -220,7 +220,7 @@ struct Slirp {
>       GRand *grand;
>       QEMUTimer *ra_timer;
>   
> -    slirp_output output;
> +    const SlirpCb *cb;
>       void *opaque;
>   };
>   
> diff --git a/net/slirp.c b/net/slirp.c
> index dfc72cfc2e..233f66b1ef 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -140,6 +140,10 @@ static NetClientInfo net_slirp_info = {
>       .cleanup = net_slirp_cleanup,
>   };
>   
> +static SlirpCb slirp_cb = {

const     ^

With the const qualifier:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    .output = net_slirp_output,
> +};
> +
>   static int net_slirp_init(NetClientState *peer, const char *model,
>                             const char *name, int restricted,
>                             bool ipv4, const char *vnetwork, const char *vhost,
> @@ -379,7 +383,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>                             vhostname, tftp_server_name,
>                             tftp_export, bootfile, dhcp,
>                             dns, ip6_dns, dnssearch, vdomainname,
> -                          net_slirp_output, s);
> +                          &slirp_cb, s);
>       QTAILQ_INSERT_TAIL(&slirp_stacks, s, entry);
>   
>       for (config = slirp_configs; config; config = config->next) {
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index d7701f7785..10decfb5ef 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -163,5 +163,5 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>       *pchecksum = htonl(checksum);
>       ncsi_rsp_len += 4;
>   
> -    slirp->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
> +    slirp->cb->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
>   }
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 0e4ade3e4a..7213915bf3 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -288,14 +288,14 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
>                     struct in_addr vdhcp_start, struct in_addr vnameserver,
>                     struct in6_addr vnameserver6, const char **vdnssearch,
>                     const char *vdomainname,
> -                  slirp_output output,
> +                  const SlirpCb *callbacks,
>                     void *opaque)
>   {
>       Slirp *slirp = g_malloc0(sizeof(Slirp));
>   
>       slirp_init_once();
>   
> -    slirp->output = output;
> +    slirp->cb = callbacks;
>       slirp->grand = g_rand_new();
>       slirp->restricted = restricted;
>   
> @@ -843,7 +843,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>               rah->ar_sip = ah->ar_tip;
>               memcpy(rah->ar_tha, ah->ar_sha, ETH_ALEN);
>               rah->ar_tip = ah->ar_sip;
> -            slirp->output(slirp->opaque, arp_reply, sizeof(arp_reply));
> +            slirp->cb->output(slirp->opaque, arp_reply, sizeof(arp_reply));
>           }
>           break;
>       case ARPOP_REPLY:
> @@ -943,7 +943,7 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, struct ethhdr *eh,
>               /* target IP */
>               rah->ar_tip = iph->ip_dst.s_addr;
>               slirp->client_ipaddr = iph->ip_dst;
> -            slirp->output(slirp->opaque, arp_req, sizeof(arp_req));
> +            slirp->cb->output(slirp->opaque, arp_req, sizeof(arp_req));
>               ifm->resolution_requested = true;
>   
>               /* Expire request and drop outgoing packet after 1 second */
> @@ -1029,7 +1029,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
>                   eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
>                   eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]));
>       memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
> -    slirp->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
> +    slirp->cb->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
>       return 1;
>   }
>   
> 
