Received: from eggs.gnu.org ([209.51.188.92]:39061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1groSr-00049Z-2J
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1groSp-0002JI-0L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:31:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1groSo-0002FV-Lc
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:31:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so922276wrp.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:31:52 -0800 (PST)
References: <20190207140316.16103-1-samuel.thibault@ens-lyon.org>
	<20190207140316.16103-28-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <df0735c3-cab0-085f-f8ea-db820055b221@redhat.com>
Date: Thu, 7 Feb 2019 19:31:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190207140316.16103-28-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULLv4 27/32] slirp: improve send_packet()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@redhat.com, jan.kiszka@siemens.com

Hi Samuel,

On 2/7/19 3:03 PM, Samuel Thibault wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Use a more descriptive name for the callback.
> 
> Reuse the SlirpWriteCb type. Wrap it to check that all data has been written.
> 
> Return a ssize_t for potential error handling and data-loss reporting.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  include/net/net.h |  2 +-
>  net/net.c         |  4 ++--
>  net/slirp.c       |  9 +++++----
>  slirp/libslirp.h  | 11 +++++++----
>  slirp/ncsi.c      |  2 +-
>  slirp/slirp.c     | 18 +++++++++++++++---
>  slirp/slirp.h     |  2 ++
>  7 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 643295d163..075cc01267 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -146,7 +146,7 @@ ssize_t qemu_sendv_packet(NetClientState *nc, const struct iovec *iov,
>                            int iovcnt);
>  ssize_t qemu_sendv_packet_async(NetClientState *nc, const struct iovec *iov,
>                                  int iovcnt, NetPacketSent *sent_cb);
> -void qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size);
> +ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size);
>  ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size);
>  ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
>                                 int size, NetPacketSent *sent_cb);
> diff --git a/net/net.c b/net/net.c
> index 3acbdccd61..5dcff7fe2a 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -668,9 +668,9 @@ ssize_t qemu_send_packet_async(NetClientState *sender,
>                                               buf, size, sent_cb);
>  }
>  
> -void qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
> +ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
>  {
> -    qemu_send_packet_async(nc, buf, size, NULL);
> +    return qemu_send_packet_async(nc, buf, size, NULL);
>  }
>  
>  ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size)
> diff --git a/net/slirp.c b/net/slirp.c
> index 7b4f9f5c5e..664ff1c002 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -108,11 +108,12 @@ static void slirp_smb_cleanup(SlirpState *s);
>  static inline void slirp_smb_cleanup(SlirpState *s) { }
>  #endif
>  
> -static void net_slirp_output(void *opaque, const uint8_t *pkt, int pkt_len)
> +static ssize_t net_slirp_send_packet(const void *pkt, size_t pkt_len,
> +                                     void *opaque)
>  {
>      SlirpState *s = opaque;
>  
> -    qemu_send_packet(&s->nc, pkt, pkt_len);
> +    return qemu_send_packet(&s->nc, pkt, pkt_len);
>  }
>  
>  static ssize_t net_slirp_receive(NetClientState *nc, const uint8_t *buf, size_t size)
> @@ -197,7 +198,7 @@ static void net_slirp_unregister_poll_fd(int fd)
>  }
>  
>  static const SlirpCb slirp_cb = {
> -    .output = net_slirp_output,
> +    .send_packet = net_slirp_send_packet,
>      .guest_error = net_slirp_guest_error,
>      .clock_get_ns = net_slirp_clock_get_ns,
>      .timer_new = net_slirp_timer_new,
> @@ -780,7 +781,7 @@ static void guestfwd_read(void *opaque, const uint8_t *buf, int size)
>      slirp_socket_recv(fwd->slirp, fwd->server, fwd->port, buf, size);
>  }
>  
> -static int guestfwd_write(const void *buf, size_t len, void *chr)
> +static ssize_t guestfwd_write(const void *buf, size_t len, void *chr)
>  {
>      return qemu_chr_fe_write_all(chr, buf, len);
>  }
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 02cbec9f8b..8e5d4ed11b 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -15,7 +15,7 @@
>  
>  typedef struct Slirp Slirp;
>  
> -typedef int (*SlirpWriteCb)(const void *buf, size_t len, void *opaque);
> +typedef ssize_t (*SlirpWriteCb)(const void *buf, size_t len, void *opaque);
>  typedef void (*SlirpTimerCb)(void *opaque);
>  
>  /*
> @@ -23,10 +23,13 @@ typedef void (*SlirpTimerCb)(void *opaque);
>   */
>  typedef struct SlirpCb {
>      /*
> -     * Send an ethernet frame to the guest network. The opaque parameter
> -     * is the one given to slirp_init().
> +     * Send an ethernet frame to the guest network. The opaque
> +     * parameter is the one given to slirp_init(). The function
> +     * doesn't need to send all the data and may return <len (no
> +     * buffering is done on libslirp side, so the data will be dropped
> +     * in this case). <0 reports an IO error.
>       */
> -    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
> +    SlirpWriteCb send_packet;
>      /* Print a message for an error due to guest misbehavior.  */
>      void (*guest_error)(const char *msg);
>      /* Return the virtual clock value in nanoseconds */
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index 327f17543c..359f52c284 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -162,5 +162,5 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>      *pchecksum = htonl(checksum);
>      ncsi_rsp_len += 4;
>  
> -    slirp->cb->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
> +    slirp_send_packet_all(slirp, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
>  }
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 3304c83001..2bc53e3e12 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -800,7 +800,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>              rah->ar_sip = ah->ar_tip;
>              memcpy(rah->ar_tha, ah->ar_sha, ETH_ALEN);
>              rah->ar_tip = ah->ar_sip;
> -            slirp->cb->output(slirp->opaque, arp_reply, sizeof(arp_reply));
> +            slirp_send_packet_all(slirp, arp_reply, sizeof(arp_reply));
>          }
>          break;
>      case ARPOP_REPLY:
> @@ -900,7 +900,7 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, struct ethhdr *eh,
>              /* target IP */
>              rah->ar_tip = iph->ip_dst.s_addr;
>              slirp->client_ipaddr = iph->ip_dst;
> -            slirp->cb->output(slirp->opaque, arp_req, sizeof(arp_req));
> +            slirp_send_packet_all(slirp, arp_req, sizeof(arp_req));
>              ifm->resolution_requested = true;
>  
>              /* Expire request and drop outgoing packet after 1 second */
> @@ -985,7 +985,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
>                eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
>                eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]);
>      memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
> -    slirp->cb->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
> +    slirp_send_packet_all(slirp, buf, ifm->m_len + ETH_HLEN);
>      return 1;
>  }
>  
> @@ -1152,3 +1152,15 @@ void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int guest_port,
>      if (ret > 0)
>          tcp_output(sototcpcb(so));
>  }
> +
> +void slirp_send_packet_all(Slirp *slirp, const void *buf, size_t len)
> +{
> +    ssize_t ret = slirp->cb->send_packet(buf, len, slirp->opaque);
> +
> +    if (ret < 0) {
> +        g_critical("Failed to send packet, ret: %ld", (long) ret);

>From the v3 discussion [*] I thought send_packet() would return a
gssize, then we'd use G_GSSIZE_FORMAT here (and similarly use gssize
instead ssize_t in this series).
Anyway your fix is simpler. And we can still do this on top of this PR.

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01841.html

> +    } else if (ret < len) {
> +        DEBUG_ERROR("send_packet() didn't send all data: %ld < %lu",
> +                (long) ret, (unsigned long) len);
> +    }
> +}
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 05b8364c07..752a4cd8c8 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -269,4 +269,6 @@ struct tcpcb *tcp_drop(struct tcpcb *tp, int err);
>  struct socket *
>  slirp_find_ctl_socket(Slirp *slirp, struct in_addr guest_addr, int guest_port);
>  
> +void slirp_send_packet_all(Slirp *slirp, const void *buf, size_t len);
> +
>  #endif
> 
