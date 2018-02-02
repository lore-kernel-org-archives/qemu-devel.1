Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ehcZ6-0000RE-7F
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ehcZ0-0002Fa-52
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ehcYz-0001Qp-Vb
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w129APF4110909
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 04:11:18 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fvmqn92n8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 04:11:17 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 04:11:14 -0500
References: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 2 Feb 2018 07:11:08 -0200
MIME-Version: 1.0
In-Reply-To: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
Content-Language: en-US
Message-Id: <5f7250a8-6169-0afc-6ee9-fe1576aef9c7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: add missing break in
 h_get_cpu_characteristics()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>



On 02/01/2018 05:47 PM, Greg Kurz wrote:
> Detected by Coverity (CID 1385702). This fixes the recently added hypercall
> to let guests properly apply Spectre and Meltdown workarounds.

Paolo Bonzini reported this error in a reply to the pull request that
added the patch:

"Re: [Qemu-ppc] [Qemu-devel] [PULL 12/12] target/ppc/spapr: Add H-Call 
H_GET_CPU_CHARACTERISTICS

On 28/01/2018 22:28, David Gibson wrote:

> +    switch (safe_indirect_branch) {
> +    case SPAPR_CAP_FIXED:
> +        characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;

Missing "break;" here.

Paolo

"

I think it is nice to mention in the commit msg that Paolo also detected 
this same error,
specially given that his email was sent before this patch.


Thanks,


Daniel


>
> Fixes: c59704b25473 "target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS"
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr_hcall.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4d0e6eb0cf1d..596f58378a40 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1697,6 +1697,7 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>       switch (safe_indirect_branch) {
>       case SPAPR_CAP_FIXED:
>           characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
> +        break;
>       default: /* broken */
>           assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
>           break;
>
>
