Received: from eggs.gnu.org ([209.51.188.92]:58242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gk7mn-0008Vn-9X
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gk7dM-00060M-Cz
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:23:01 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:24954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gk7dM-0005yY-47
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:23:00 -0500
Date: Thu, 17 Jan 2019 14:22:57 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190117132257.uoksqpl6cuu6zilt@function>
References: <20181226034254.17842-1-richard.henderson@linaro.org>
	<20190116235009.tl4gcv53e62npecl@function>
	<d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, jan.kiszka@siemens.com, qemu-devel@nongnu.org

Philippe Mathieu-Daudé, le jeu. 17 janv. 2019 14:16:16 +0100, a ecrit:
> On 1/17/19 12:50 AM, Samuel Thibault wrote:
> > Hello,
> > 
> > Richard Henderson, le mer. 26 déc. 2018 14:42:54 +1100, a ecrit:
> >> The pointer may be unaligned, so we must use our routines for that.
> >> At the same time, we might as well use the big-endian version
> >> instead of ntohs.
> >>
> >> This fixes sparc64 host SIGBUS during pxe boot.
> > 
> > I'm not at ease with applying this, when Marc-André is trying to make
> > slirp an external library...  I'd rather apply the change below, could
> > somebody review it?
> > 
> > Samuel
> > 
> > 
> > slirp: Avoid unaligned 16bit memory access
> > 
> > pkt parameter may be unaligned, so we must access it byte-wise.
> > 
> > This fixes sparc64 host SIGBUS during pxe boot.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > diff --git a/slirp/slirp.c b/slirp/slirp.c
> > index ab2fc4eb8b..0e41d5aedf 100644
> > --- a/slirp/slirp.c
> > +++ b/slirp/slirp.c
> > @@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
> >      if (pkt_len < ETH_HLEN)
> >          return;
> >  
> > -    proto = ntohs(*(uint16_t *)(pkt + 12));
> > +    proto = (((uint16_t) pkt[12]) << 8) + pkt[13];
> >      switch(proto) {
> >      case ETH_P_ARP:
> >          arp_input(slirp, pkt, pkt_len);
> 
> What about using memcpy?

Well, it looks to me even more confusing than doing the shifts :)

> -- >8 --
> @@ -846,12 +846,13 @@ static void arp_input(Slirp *slirp, const uint8_t
> *pkt, int pkt_len)
>  void slirp_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>  {
>      struct mbuf *m;
> -    int proto;
> +    uint16_t proto;
> 
>      if (pkt_len < ETH_HLEN)
>          return;
> 
> -    proto = ntohs(*(uint16_t *)(pkt + 12));
> +    memcpy(&proto, pkt + 12, sizeof(proto)); /* Avoid unaligned 16bit
> access */
> +    proto = ntohs(proto);
>      switch(proto) {
>      case ETH_P_ARP:
>          arp_input(slirp, pkt, pkt_len);
> ---
> 
