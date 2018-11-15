Received: from eggs.gnu.org ([2001:4830:134:3::10]:34239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHCA-0004vv-5b
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHBy-0001Dc-U9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:56:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNHBy-0001CD-OT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:56:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so18706764wmc.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 04:56:16 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-9-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32f53263-4a02-0c60-c012-6895d9e936ba@redhat.com>
Date: Thu, 15 Nov 2018 13:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 08/41] slirp: add callbacks for
 timer
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
>  slirp/slirp.h    |  2 +-
>  net/slirp.c      | 23 +++++++++++++++++++++++
>  slirp/ip6_icmp.c | 21 ++++++++++-----------
>  4 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index fcebcd1e58..88185e6c33 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -10,10 +10,16 @@ typedef enum SlirpClockType {
>      SLIRP_CLOCK_REALTIME,
>  } SlirpClockType;
>  
> +typedef void (*SlirpTimerCb)(void *opaque);
> +
>  typedef struct SlirpCb {
>      void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
>      int (*chr_write_all)(void *chr, const void *buf, size_t len);
>      int64_t (*clock_get_ns)(SlirpClockType type);
> +    void *(*timer_new)(SlirpClockType type, int scale,
> +                      SlirpTimerCb cb, void *opaque);

Same here wrt SlirpClockType; and nicely, scale is always nanoseconds so
it can be removed.

Paolo

> +    void (*timer_free)(void *timer);
> +    void (*timer_mod)(void *timer, int64_t expire_timer);
>  } SlirpCb;
>  
>  
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index f7c087456a..e5abf1c594 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -218,7 +218,7 @@ struct Slirp {
>      NdpTable ndp_table;
>  
>      GRand *grand;
> -    QEMUTimer *ra_timer;
> +    void *ra_timer;
>  
>      const SlirpCb *cb;
>      void *opaque;
> diff --git a/net/slirp.c b/net/slirp.c
> index af6c643b82..7b28886802 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -163,10 +163,33 @@ static int64_t net_slirp_clock_get_ns(SlirpClockType type)
>      return qemu_clock_get_ns(slirp_clock_to_qemu(type));
>  }
>  
> +static void *net_slirp_timer_new(SlirpClockType type,
> +                                 int scale,
> +                                 SlirpTimerCb cb, void *opaque)
> +{
> +    return timer_new_full(NULL, slirp_clock_to_qemu(type),
> +                          scale, QEMU_TIMER_ATTR_EXTERNAL,
> +                          cb, opaque);
> +}
> +
> +static void net_slirp_timer_free(void *timer)
> +{
> +    timer_del(timer);
> +    timer_free(timer);
> +}
> +
> +static void net_slirp_timer_mod(void *timer, int64_t expire_timer)
> +{
> +    timer_mod(timer, expire_timer);
> +}
> +
>  static SlirpCb slirp_cb = {
>      .output = net_slirp_output,
>      .chr_write_all = net_slirp_chr_write_all,
>      .clock_get_ns = net_slirp_clock_get_ns,
> +    .timer_new = net_slirp_timer_new,
> +    .timer_free = net_slirp_timer_free,
> +    .timer_mod = net_slirp_timer_mod,
>  };
>  
>  static int net_slirp_init(NetClientState *peer, const char *model,
> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index 0f80d49ef9..71d95daef0 100644
> --- a/slirp/ip6_icmp.c
> +++ b/slirp/ip6_icmp.c
> @@ -16,9 +16,10 @@
>  static void ra_timer_handler(void *opaque)
>  {
>      Slirp *slirp = opaque;
> -    timer_mod(slirp->ra_timer,
> -              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
> -              NDP_Interval);
> +
> +    slirp->cb->timer_mod(slirp->ra_timer,
> +        slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
> +        NDP_Interval);
>      ndp_send_ra(slirp);
>  }
>  
> @@ -28,12 +29,11 @@ void icmp6_init(Slirp *slirp)
>          return;
>      }
>  
> -    slirp->ra_timer = timer_new_full(NULL, QEMU_CLOCK_VIRTUAL,
> -                                     SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
> -                                     ra_timer_handler, slirp);
> -    timer_mod(slirp->ra_timer,
> -              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
> -              NDP_Interval);
> +    slirp->ra_timer = slirp->cb->timer_new(SLIRP_CLOCK_VIRTUAL, SCALE_MS,
> +                                           ra_timer_handler, slirp);
> +    slirp->cb->timer_mod(slirp->ra_timer,
> +        slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
> +        NDP_Interval);
>  }
>  
>  void icmp6_cleanup(Slirp *slirp)
> @@ -42,8 +42,7 @@ void icmp6_cleanup(Slirp *slirp)
>          return;
>      }
>  
> -    timer_del(slirp->ra_timer);
> -    timer_free(slirp->ra_timer);
> +    slirp->cb->timer_free(slirp->ra_timer);
>  }
>  
>  static void icmp6_send_echoreply(struct mbuf *m, Slirp *slirp, struct ip6 *ip,
> 
