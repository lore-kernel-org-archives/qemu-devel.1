Received: from eggs.gnu.org ([2001:4830:134:3::10]:58092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyDXk-0004H7-IX
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyDXh-0003mk-Ba
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:22:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37080
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cyDXh-0003mW-5Z
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:22:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3C88sWO020167
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:22:19 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29s2mk89u7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:22:19 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 12 Apr 2017 18:22:15 +1000
Date: Wed, 12 Apr 2017 13:51:19 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <20170412082119.GA1429@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr-cpu-core: Release ICPState object
 during CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org

This should be considered for ppc-for-2.10 branch of dwg's tree.

On Wed, Apr 12, 2017 at 01:45:07PM +0530, Bharata B Rao wrote:
> Recent commits that re-organized ICPState object missed to destroy
> the object when CPU is unrealized. Fix this so that CPU unplug
> doesn't abort QEMU.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2e689b5..4389ef4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -127,6 +127,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
> 
>          spapr_cpu_destroy(cpu);
> +        object_unparent(cpu->intc);
>          cpu_remove_sync(cs);
>          object_unparent(obj);
>      }
> -- 
> 2.7.4
