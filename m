Received: from eggs.gnu.org ([2001:4830:134:3::10]:50129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f4IW7-0001xW-1W
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 23:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f4IW3-0008D6-64
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 23:58:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1f4IW2-0008CX-VT
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 23:58:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w363t91s106829
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 23:58:17 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h5u6svb51-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 23:58:17 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 6 Apr 2018 04:58:14 +0100
Date: Fri, 6 Apr 2018 09:28:08 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
	<1522938923-96058-2-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522938923-96058-2-git-send-email-spopovyc@redhat.com>
Message-Id: <20180406035249.GA10482@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 1/2] Revert "spapr: Don't allow
 memory hotplug to memory less nodes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Thu, Apr 05, 2018 at 10:35:22AM -0400, Serhii Popovych wrote:
> This reverts commit b556854bd8524c26b8be98ab1bfdf0826831e793.
> 
> Leave change @node type from uint32_t to to int from reverted commit
> because node < 0 is always false.
> 
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> ---
>  hw/ppc/spapr.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2c0be8c..3ad4545 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3477,28 +3477,6 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>              return;
>          }
> 
> -        /*
> -         * Currently PowerPC kernel doesn't allow hot-adding memory to
> -         * memory-less node, but instead will silently add the memory
> -         * to the first node that has some memory. This causes two
> -         * unexpected behaviours for the user.
> -         *
> -         * - Memory gets hotplugged to a different node than what the user
> -         *   specified.
> -         * - Since pc-dimm subsystem in QEMU still thinks that memory belongs
> -         *   to memory-less node, a reboot will set things accordingly
> -         *   and the previously hotplugged memory now ends in the right node.
> -         *   This appears as if some memory moved from one node to another.
> -         *
> -         * So until kernel starts supporting memory hotplug to memory-less
> -         * nodes, just prevent such attempts upfront in QEMU.
> -         */
> -        if (nb_numa_nodes && !numa_info[node].node_mem) {
> -            error_setg(errp, "Can't hotplug memory to memory-less node %d",
> -                       node);
> -            return;
> -        }
> -

If you remove this unconditionally, wouldn't it be a problem in case
of newer QEMU with older guest kernels ?

Regards,
Bharata.
