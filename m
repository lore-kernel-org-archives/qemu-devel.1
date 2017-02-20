Received: from eggs.gnu.org ([2001:4830:134:3::10]:42423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cftB3-0005xM-0h
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cftAz-0004PQ-NY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:59:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40226
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cftAz-0004PB-Ha
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:59:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KIrajc168597
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:59:08 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r2pn943s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:59:08 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 18:59:06 -0000
Date: Mon, 20 Feb 2017 19:59:01 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170217082939.33208-16-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170217082939.33208-16-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170220195901.252083fe.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 15/15] vfio: ccw: introduce support
 for ccw0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

On Fri, 17 Feb 2017 09:29:39 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Although Linux does not use format-0 channel command words (CCW0)
> these are a non-optional part of the platform spec, and for the sake
> of platform compliance, and possibly some non-Linux guests, we have
> to support CCW0.
> 
> Making the kernel execute a format 0 channel program is too much hassle
> because we would need to allocate and use memory which can be addressed
> by 24 bit physical addresses (because of CCW0.cda). So we implement CCW0
> support by translating the channel program into an equivalent CCW1
> program instead.
> 
> Signed-off-by: Kai Yue Wang <wkywang@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  arch/s390/Kconfig              |  7 +++++
>  drivers/s390/cio/vfio_ccw_cp.c | 58 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 32008b8..f25d077 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -680,6 +680,13 @@ config VFIO_CCW
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vfio_ccw.
> 
> +config VFIO_CCW_CCW0
> +	def_bool n
> +	prompt "Support for CCW0 translation"
> +	depends on VFIO_CCW
> +	help
> +	  Enable translation for CCW0 programs for VFIO-CCW subchannels.

Hm... if ccw0 is non-optional for the architecture, why are you making
it optional then?

> +
>  endmenu
> 
>  menu "Dump support"
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 16bbb54..b0a8bc05 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -15,6 +15,26 @@
> 
>  #include "vfio_ccw_cp.h"
> 
> +#ifdef CONFIG_VFIO_CCW_CCW0
> +/**
> + * struct ccw0 - channel command word
> + * @cmd_code: command code
> + * @cda: data address
> + * @flags: flags, like IDA addressing, etc.
> + * @reserved: will be ignored
> + * @count: byte count
> + *
> + * The format-0 ccw structure.
> + */
> +struct ccw0 {
> +	__u8 cmd_code;
> +	__u32 cda : 24;
> +	__u8  flags;
> +	__u8  reserved;
> +	__u16 count;
> +} __packed __aligned(8);
> +#endif

Would it be better to move this definition next to the struct ccw1
definition? Even if the kernel does not build format-0 ccws, it makes
sense from a logical POV.

> +
>  /*
>   * Max length for ccw chain.
>   * XXX: Limit to 256, need to check more?
> @@ -243,12 +263,42 @@ static long copy_from_iova(struct device *mdev,
>  	return l;
>  }
> 
> +#ifdef CONFIG_VFIO_CCW_CCW0
> +static long copy_ccw_from_iova(struct channel_program *cp,
> +			       struct ccw1 *to, u64 iova,
> +			       unsigned long len)
> +{
> +	struct ccw0 ccw0;
> +	struct ccw1 *pccw1;
> +	int ret;
> +	int i;
> +
> +	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
> +	if (ret)
> +		return ret;
> +
> +	if (!cp->orb.cmd.fmt) {
> +		pccw1 = to;
> +		for (i = 0; i < len; i++) {
> +			ccw0 = *(struct ccw0 *)pccw1;
> +			pccw1->cmd_code = ccw0.cmd_code;
> +			pccw1->flags = ccw0.flags;
> +			pccw1->count = ccw0.count;
> +			pccw1->cda = ccw0.cda;
> +			pccw1++;
> +		}

IIRC there are one or two very subtle differences between what format-0
and what format-1 ccws allow (see the ccw interpretation in qemu --
probably easier than combing through the PoP). We should either check
this or add a comment why we don't.

> +	}
> +
> +	return ret;
> +}
> +#else
>  static long copy_ccw_from_iova(struct channel_program *cp,
>  			       struct ccw1 *to, u64 iova,
>  			       unsigned long len)
>  {
>  	return copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
>  }
> +#endif

This would be nicer without #ifdefs :)

> 
>  /*
>   * Helpers to operate ccwchain.
> @@ -616,10 +666,14 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  	 * Only support prefetch enable mode now.
>  	 * Only support 64bit addressing idal.
>  	 * Only support 4k IDAW.
> -	 * Only support ccw1.
>  	 */
> -	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k || !orb->cmd.fmt)
> +	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
> +		return -EOPNOTSUPP;
> +
> +#ifndef CONFIG_VFIO_CCW_CCW0
> +	if (!orb->cmd.fmt)
>  		return -EOPNOTSUPP;
> +#endif

dito

> 
>  	INIT_LIST_HEAD(&cp->ccwchain_list);
>  	memcpy(&cp->orb, orb, sizeof(*orb));

The "translate format-0 into format-1 ccws" approach is fine, but I
think you need to double check the subtle differences I mentioned.
