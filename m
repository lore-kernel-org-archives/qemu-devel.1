Received: from eggs.gnu.org ([2001:4830:134:3::10]:33825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHA3-0004CG-5c
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNH9x-0007Ip-SY
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:54:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNH9w-0007Gl-77
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:54:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id k15-v6so21064837wre.12
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 04:54:07 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-8-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7bae7a16-4c98-999f-24c1-6db3b24e75d3@redhat.com>
Date: Thu, 15 Nov 2018 13:54:02 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 07/41] slirp: add clock_get_ns()
 callback
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

On 14/11/2018 13:36, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/libslirp.h |  6 ++++++
>  net/slirp.c      | 19 +++++++++++++++++++
>  slirp/if.c       |  2 +-
>  slirp/ip6_icmp.c |  6 ++++--
>  slirp/slirp.c    | 11 ++++++-----
>  5 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 16ced2aa0f..fcebcd1e58 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -5,9 +5,15 @@
>  
>  typedef struct Slirp Slirp;
>  
> +typedef enum SlirpClockType {
> +    SLIRP_CLOCK_VIRTUAL,
> +    SLIRP_CLOCK_REALTIME,

The more I look at this, the more I think that SLIRP_CLOCK_REALTIME is
wrong and it should also be using SLIRP_CLOCK_VIRTUAL.  It's used to put
a cap on the amount of time the guest has to reply to an ARP request,
and of course the guest cannot process it if it's paused.  So this can
be simpler, because SlirpClockType can disappear completely.

Paolo

> +} SlirpClockType;
> +
>  typedef struct SlirpCb {
>      void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
>      int (*chr_write_all)(void *chr, const void *buf, size_t len);
> +    int64_t (*clock_get_ns)(SlirpClockType type);
>  } SlirpCb;
>  
>  
> diff --git a/net/slirp.c b/net/slirp.c
> index 5c1f676487..af6c643b82 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -145,9 +145,28 @@ static int net_slirp_chr_write_all(void *chr, const void *buf, size_t len)
>      return qemu_chr_fe_write_all(chr, buf, len);
>  }
>  
> +static QEMUClockType slirp_clock_to_qemu(SlirpClockType type)
> +{
> +    switch (type) {
> +    case SLIRP_CLOCK_VIRTUAL:
> +        return QEMU_CLOCK_VIRTUAL;
> +    case SLIRP_CLOCK_REALTIME:
> +        return QEMU_CLOCK_REALTIME;
> +    }
> +
> +    g_warn_if_reached();
> +    return QEMU_CLOCK_REALTIME;
> +}
> +
> +static int64_t net_slirp_clock_get_ns(SlirpClockType type)
> +{
> +    return qemu_clock_get_ns(slirp_clock_to_qemu(type));
> +}
> +
>  static SlirpCb slirp_cb = {
>      .output = net_slirp_output,
>      .chr_write_all = net_slirp_chr_write_all,
> +    .clock_get_ns = net_slirp_clock_get_ns,
>  };
>  
>  static int net_slirp_init(NetClientState *peer, const char *model,
> diff --git a/slirp/if.c b/slirp/if.c
> index 590753c658..1c96869831 100644
> --- a/slirp/if.c
> +++ b/slirp/if.c
> @@ -150,7 +150,7 @@ diddit:
>   */
>  void if_start(Slirp *slirp)
>  {
> -    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    uint64_t now = slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME);
>      bool from_batchq = false;
>      struct mbuf *ifm, *ifm_next, *ifqt;
>  
> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index cd1e0b9fe1..0f80d49ef9 100644
> --- a/slirp/ip6_icmp.c
> +++ b/slirp/ip6_icmp.c
> @@ -17,7 +17,8 @@ static void ra_timer_handler(void *opaque)
>  {
>      Slirp *slirp = opaque;
>      timer_mod(slirp->ra_timer,
> -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
> +              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
> +              NDP_Interval);
>      ndp_send_ra(slirp);
>  }
>  
> @@ -31,7 +32,8 @@ void icmp6_init(Slirp *slirp)
>                                       SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
>                                       ra_timer_handler, slirp);
>      timer_mod(slirp->ra_timer,
> -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
> +              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
> +              NDP_Interval);
>  }
>  
>  void icmp6_cleanup(Slirp *slirp)
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 4e809e5d7f..979495e88b 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -571,15 +571,15 @@ void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
>  
>  void slirp_pollfds_poll(GArray *pollfds, int select_error)
>  {
> -    Slirp *slirp;
> +    Slirp *slirp = QTAILQ_FIRST(&slirp_instances);
>      struct socket *so, *so_next;
>      int ret;
>  
> -    if (QTAILQ_EMPTY(&slirp_instances)) {
> +    if (!slirp) {
>          return;
>      }
>  
> -    curtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    curtime = slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME) / SCALE_MS;
>  
>      QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
>          /*
> @@ -947,7 +947,8 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, struct ethhdr *eh,
>              ifm->resolution_requested = true;
>  
>              /* Expire request and drop outgoing packet after 1 second */
> -            ifm->expiration_date = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + 1000000000ULL;
> +            ifm->expiration_date = slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME)
> +                + 1000000000ULL;
>          }
>          return 0;
>      } else {
> @@ -974,7 +975,7 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, struct ethhdr *eh,
>              ndp_send_ns(slirp, ip6h->ip_dst);
>              ifm->resolution_requested = true;
>              ifm->expiration_date =
> -                qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + 1000000000ULL;
> +                slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME) + 1000000000ULL;
>          }
>          return 0;
>      } else {
> 
