Received: from eggs.gnu.org ([2001:4830:134:3::10]:47373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dXtK8-0003Yu-UL
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dXtK5-0002NP-Rh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:03:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49246
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dXtK5-0002Mw-Lv
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:03:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6JHwnT1000768
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 14:03:44 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2btashbv8m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 14:03:43 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 15:03:41 -0300
References: <1500454449-29557-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 15:03:34 -0300
MIME-Version: 1.0
In-Reply-To: <1500454449-29557-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ba37c868-33c5-2412-fae9-9ddb42c04bb0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [FIX PATCH] spapr: Fix QEMU abort
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



On 07/19/2017 05:54 AM, Bharata B Rao wrote:
> Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
> sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
> device that is marked for removal. Since this commit we can hit the
> assert in spapr_pending_dimm_unplugs_add() in the following situation:
>
> - DIMM device removal fails as the guest doesn't allow the removal.
> - Subsequent attempt to remove the same DIMM would hit the assert
>    as the corresponding sPAPRDIMMState is still part of the
>    pending_dimm_unplugs list.

I've asked Mike if there was any way of knowing if the unplug were 
successful
in the guest, and aside from the DRC state changes we don't have
any other way. I wanted to propose a simple cleanup of the remaining
sPAPRDIMMState from the failed unplug to avoid this situation altogether.

It appears that we'll have to deal with it with extra logic to cover this.

> Fix this by removing the assert and conditionally adding the
> sPAPRDIMMState to pending_dimm_unplugs list only when it is not
> already present.

I think there is a better place to put this verification. The function
spapr_pending_dimm_unplugs_add is called in two places:

1- in spapr_memory_unplug_request, when it first creates the structure
before starting the DRC unplug requests;

2- in spapr_recover_pending_dimm_state, to restore the DIMM state when
it is lost after a migration for example.

spapr_recover_pending_dimm_state is called as follows from 
spapr_lmb_release:


     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, 
PC_DIMM(dev));

     /* This information will get lost if a migration occurs
      * during the unplug process. In this case recover it. */
     if (ds == NULL) {
         ds = spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
         /* The DRC being examined by the caller at least must be counted */
         g_assert(ds->nr_lmbs);
     }


As we can see there is a find() call before calling recover(). This 
means that if you
do the verification inside unplugs_add() you're end up doing find() 
twice when
this recover() condition happens. This also means that you're most 
likely hitting
this situation from the regular LMB unplug flow from 
spapr_memory_unplug_request.

My suggestion would be to move this verification to 
spapr_memory_unplug_request
like this:

     (...)
     if (local_err) {
         goto out;
     }

     /* If there were prior unplugs attempts from this same DIMM that 
failed,
        there will be a dimm state object inside 
spapr->pending_dimm_unplugs list.
        In this case, do not add a new sPAPRDIMMState. */
     ds = spapr_recover_pending_dimm_state(spapr, dimm);
     if (ds == NULL) {
         ds = g_malloc0(sizeof(sPAPRDIMMState));
         ds->nr_lmbs = nr_lmbs;
         ds->dimm = dimm;
         spapr_pending_dimm_unplugs_add(spapr, ds);
     }


I prefer this way because you avoid a g_malloc0 that would be thrown away in
the unplugs_add().

Now, if we decide to stick with the verification inside unplugs_add() like
you proposed ....

>
> Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>   hw/ppc/spapr.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1cb09e7..990bb2d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2853,8 +2853,9 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
>   static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>                                              sPAPRDIMMState *dimm_state)
>   {
> -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
> -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
> +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    }
... you'll need to free() the incoming dimm_state object that was allocated
outside of unplugs_add() if you're not going to add it:


+    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
+        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+    }

     else {
         g_free(dimm_state);
     }



Now that I think about it, in this approach you'll waste not just a 
g_malloc()
but also a g_free(). Making the verification inside 
spapr_memory_unplug_request
like I said above would be my way to go in this case.



Daniel

>   }
>
>   static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
