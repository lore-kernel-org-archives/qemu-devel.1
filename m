Received: from eggs.gnu.org ([2001:4830:134:3::10]:56001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dagsl-0008LK-Nz
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dagsi-0002Zo-D0
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:23:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dagsi-0002ZC-3t
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:23:04 -0400
Date: Thu, 27 Jul 2017 13:22:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727132259.7102a715@gondolin>
In-Reply-To: <20170727015418.85407-3-bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-3-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: generate solicited crw for
 rchp completion signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Thu, 27 Jul 2017 03:54:17 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> A successful completion of rchp should signal a solicited channel path
> initialized CRW (channel report word), while the current implementation
> always generates an un-solicited one. Let's fix this.

Sounds legit.

> 
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 15 +++++++++------
>  include/hw/s390x/css.h |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 5321ca016b..60e1592d5c 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1745,10 +1745,10 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid)
>      }
>  
>      /* We don't really use a channel path, so we're done here. */
> -    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT,
> +    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1,
>                    channel_subsys.max_cssid > 0 ? 1 : 0, chpid);
>      if (channel_subsys.max_cssid > 0) {
> -        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 0, real_cssid << 8);
> +        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1, 0, real_cssid << 8);
>      }
>      return 0;
>  }
> @@ -2028,7 +2028,7 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
>      }
>  }
>  
> -void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
> +void css_queue_crw(uint8_t rsc, uint8_t erc, int s, int chain, uint16_t rsid)

's' is not a very speaking name...

>  {
>      CrwContainer *crw_cont;
>  
> @@ -2040,6 +2040,9 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
>          return;
>      }
>      crw_cont->crw.flags = (rsc << 8) | erc;
> +    if (s) {
> +        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;

...as it obviously causes the S flag to be set ;) Let's call it 'solicited'?

> +    }
>      if (chain) {
>          crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
>      }
> @@ -2086,9 +2089,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
>      }
>      chain_crw = (channel_subsys.max_ssid > 0) ||
>              (channel_subsys.max_cssid > 0);
> -    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, chain_crw ? 1 : 0, schid);
> +    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0, chain_crw ? 1 : 0, schid);
>      if (chain_crw) {
> -        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0,
> +        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0, 0,
>                        (guest_cssid << 8) | (ssid << 4));
>      }
>      /* RW_ERC_IPI --> clear pending interrupts */
> @@ -2103,7 +2106,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
>  void css_generate_css_crws(uint8_t cssid)
>  {
>      if (!channel_subsys.sei_pending) {
> -        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, cssid);
> +        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, 0, cssid);

Should we want to support OS-triggered channel path vary (via SCLP or
otherwise) in the future, we'll probably need a version that generates a
solicited crw.

>      }
>      channel_subsys.sei_pending = true;
>  }
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 5c5fe6b202..d03b4ffeac 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -150,7 +150,7 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
>  void css_inject_io_interrupt(SubchDev *sch);
>  void css_reset(void);
>  void css_reset_sch(SubchDev *sch);
> -void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
> +void css_queue_crw(uint8_t rsc, uint8_t erc, int s, int chain, uint16_t rsid);
>  void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
>                             int hotplugged, int add);
>  void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);

Otherwise, patch looks good.
