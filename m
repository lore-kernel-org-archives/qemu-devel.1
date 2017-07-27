Received: from eggs.gnu.org ([2001:4830:134:3::10]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dafkN-0001Hu-Kl
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dafkM-0001Oe-OD
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dafkM-0001O9-H1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:10:22 -0400
Date: Thu, 27 Jul 2017 12:10:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727121017.3a655122@gondolin>
In-Reply-To: <20170727015418.85407-2-bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-2-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/css: use macro for
 event-information pending error recover code
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

On Thu, 27 Jul 2017 03:54:16 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Let's use a macro for the ERC (error recover code) when generating a
> Channel Subsystem Event-information pending CRW (channel report word).

Sounds reasonable.

> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c            | 2 +-
>  include/hw/s390x/ioinst.h | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 6a42b95cee..5321ca016b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -2103,7 +2103,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
>  void css_generate_css_crws(uint8_t cssid)
>  {
>      if (!channel_subsys.sei_pending) {
> -        css_queue_crw(CRW_RSC_CSS, 0, 0, cssid);
> +        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, cssid);
>      }
>      channel_subsys.sei_pending = true;
>  }
> diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
> index 92d15655e4..c1d1052279 100644
> --- a/include/hw/s390x/ioinst.h
> +++ b/include/hw/s390x/ioinst.h
> @@ -201,8 +201,9 @@ typedef struct CRW {
>  #define CRW_FLAGS_MASK_A 0x0080
>  #define CRW_FLAGS_MASK_ERC 0x003f
>  
> -#define CRW_ERC_INIT 0x02
> -#define CRW_ERC_IPI  0x04
> +#define CRW_ERC_EVENT  0x00

OK, that matches the name the Linux kernel uses.

Do we want to add all ERCs while we're at it?

> +#define CRW_ERC_INIT   0x02
> +#define CRW_ERC_IPI    0x04
>  
>  #define CRW_RSC_SUBCH 0x3
>  #define CRW_RSC_CHP   0x4
