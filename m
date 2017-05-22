Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dCfzV-0006rK-3K
	for qemu-devel@nongnu.org; Mon, 22 May 2017 01:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dCfzS-0000zR-0a
	for qemu-devel@nongnu.org; Mon, 22 May 2017 01:34:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39317
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dCfzR-0000xW-Rr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 01:34:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4M5KAZP123503
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 01:34:44 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aksr8gbxq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 01:34:43 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Mon, 22 May 2017 15:34:41 +1000
Date: Mon, 22 May 2017 15:33:39 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <20170509050458.23237-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509050458.23237-1-david@gibson.dropbear.id.au>
Message-Id: <20170522053339.GA8441@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't accidentally advertise HTM
 support on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, May 09, 2017 at 03:04:58PM +1000, David Gibson wrote:
> Logic in spapr_populate_pa_features() enables the bit advertising
> Hardware Transactional Memory (HTM) in the guest's device tree only when
> KVM advertises its availability with the KVM_CAP_PPC_HTM feature.
> 
> However, this assumes that the HTM bit is off in the base template used for
> the device tree value.  That is true for POWER8, but not for POWER9.
> 
> It looks like that was accidentally changed in 9fb4541 "spapr: Enable ISA
> 3.0 MMU mode selection via CAS".
> 
> Fixes: 9fb4541f5803f8d2ba116b12113386e26482ba30
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e2dc77c..1b7cada 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -219,7 +219,7 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
>          /* 16: Vector */
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
>          /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
> -        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
>          /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
>          0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
>          /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
> -- 
> 2.9.3
Looks good to me.

Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
