Received: from eggs.gnu.org ([2001:4830:134:3::10]:56350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g00lr-00036j-GW
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g00lm-0004LR-JU
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:45:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1g00lm-0004L4-0Z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:45:06 -0400
Date: Wed, 12 Sep 2018 10:45:01 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180912084501.aws4xjtkotb4ajwf@var.youpi.perso.aquilenet.fr>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912082007.3228.91491.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912082007.3228.91491.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v6 24/25] slirp: fix ipv6 timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk, le mer. 12 sept. 2018 11:20:07 +0300, a ecrit:
> ICMP implementation for IPv6 uses timers based on virtual clock.
> This is incorrect because this service is not related to the guest state,
> and its events should not be recorded and replayed.
> This patch changes using virtual clock to the new virtual_ext clock.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

As discussed previously

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  slirp/ip6_icmp.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
> index ee333d0..3f41187 100644
> --- a/slirp/ip6_icmp.c
> +++ b/slirp/ip6_icmp.c
> @@ -17,7 +17,7 @@ static void ra_timer_handler(void *opaque)
>  {
>      Slirp *slirp = opaque;
>      timer_mod(slirp->ra_timer,
> -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT) + NDP_Interval);
>      ndp_send_ra(slirp);
>  }
>  
> @@ -27,9 +27,10 @@ void icmp6_init(Slirp *slirp)
>          return;
>      }
>  
> -    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, ra_timer_handler, slirp);
> +    slirp->ra_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_EXT,
> +                                   ra_timer_handler, slirp);
>      timer_mod(slirp->ra_timer,
> -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_EXT) + NDP_Interval);
>  }
>  
>  void icmp6_cleanup(Slirp *slirp)
> 
> 

-- 
Samuel
<T> csp.tar.gz:     ascii text
 -+- #ens-mim - vive les browsers qui prennent des initiatives à la con -+-
