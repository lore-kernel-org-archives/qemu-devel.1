Received: from eggs.gnu.org ([2001:4830:134:3::10]:49489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dYB2a-0000Y1-0t
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dYB2W-0004Ja-Mf
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:58:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dYB2W-0004IG-Bn
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:58:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6KCwesN091369
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:58:46 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bts1muggt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:58:45 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 20 Jul 2017 09:58:43 -0300
References: <1500523879-23860-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 20 Jul 2017 09:58:35 -0300
MIME-Version: 1.0
In-Reply-To: <1500523879-23860-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <1af11c1a-7917-6616-9d03-39efcfd2001c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [FIX PATCH v1] spapr: Fix QEMU abort
 during memory unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au



On 07/20/2017 01:11 AM, Bharata B Rao wrote:
> Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
> sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
> device that is marked for removal. Since this commit we can hit the
> assert in spapr_pending_dimm_unplugs_add() in the following situation:
>
> - DIMM device removal fails as the guest doesn't allow the removal.
> - Subsequent attempt to remove the same DIMM would hit the assert
>    as the corresponding sPAPRDIMMState is still part of the
>    pending_dimm_unplugs list.
>
> Fix this by removing the assert and conditionally adding the
> sPAPRDIMMState to pending_dimm_unplugs list only when it is not
> already present.
>
> Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> Changes in v1:
> - Added comment (David Gibson)
> - Ensured we free sPAPRDIMMState when corresonding entry already
>    exists (Daniel Henrique Barboza)
>
> Daniel had shown another alternative, we can switch over to that
> if preferred.

Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>

>
>   hw/ppc/spapr.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1cb09e7..c6091e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2853,8 +2853,17 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
>   static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>                                              sPAPRDIMMState *dimm_state)
>   {
> -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
> -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    /*
> +     * If this request is for a DIMM whose removal had failed earlier
> +     * (due to guest's refusal to remove the LMBs), we would have this
> +     * dimm_state already in the pending_dimm_unplugs list. In that
> +     * case don't add again.
> +     */
> +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
> +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    } else {
> +        g_free(dimm_state);
> +    }
>   }
>
>   static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
