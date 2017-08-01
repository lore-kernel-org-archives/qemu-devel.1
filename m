Received: from eggs.gnu.org ([2001:4830:134:3::10]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dcZ1x-00054T-2P
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dcZ1u-00021Z-88
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:24:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48087
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dcZ1u-00021E-2h
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:24:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v71FNgYK051922
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 11:24:17 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c2tj2dqnw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 11:24:16 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 1 Aug 2017 16:24:15 +0100
References: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
	<20170801075727.31335-2-bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 1 Aug 2017 17:24:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170801075727.31335-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5c4c144e-7526-71cf-cd7a-c4ca4d2eff60@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/css: use macro for
 event-information pending error recover code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com



On 08/01/2017 09:57 AM, Dong Jia Shi wrote:
> Let's use a macro for the ERC (error recover code) when generating a
> Channel Subsystem Event-information pending CRW (channel report word).
> 
> While we are at it, let's also add all other ERCs.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c            |  2 +-
>  include/hw/s390x/ioinst.h | 11 +++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
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
> index 92d15655e4..f89019f78f 100644
> --- a/include/hw/s390x/ioinst.h
> +++ b/include/hw/s390x/ioinst.h
> @@ -201,8 +201,15 @@ typedef struct CRW {
>  #define CRW_FLAGS_MASK_A 0x0080
>  #define CRW_FLAGS_MASK_ERC 0x003f
> 
> -#define CRW_ERC_INIT 0x02
> -#define CRW_ERC_IPI  0x04
> +#define CRW_ERC_EVENT    0x00 /* event information pending */
> +#define CRW_ERC_AVAIL    0x01 /* available */
> +#define CRW_ERC_INIT     0x02 /* initialized */
> +#define CRW_ERC_TERROR   0x03 /* temporary error */
> +#define CRW_ERC_IPI      0x04 /* installed parm initialized */
> +#define CRW_ERC_TERM     0x05 /* terminal */
> +#define CRW_ERC_PERRN    0x06 /* perm. error, facility not init */
> +#define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
> +#define CRW_ERC_PMOD     0x08 /* installed parameters modified */

You have missed installed parameters restored from the PoP (above
you say add all other).

Other than that.

LGTM

> 
>  #define CRW_RSC_SUBCH 0x3
>  #define CRW_RSC_CHP   0x4
> 
