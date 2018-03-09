Received: from eggs.gnu.org ([2001:4830:134:3::10]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1euCaX-0003nY-K8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1euCaT-0006Kd-Mj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:37:13 -0500
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:52342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1euCaT-0006JJ-Fq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:37:09 -0500
Received: from player728.ha.ovh.net (unknown [10.109.105.9])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id D286C909BC
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 08:37:00 +0100 (CET)
Date: Fri, 9 Mar 2018 08:36:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180309083654.27cff8fe@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1520578898-2610-1-git-send-email-thuth@redhat.com>
References: <1520578898-2610-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr: Allow
 "spapr-vlan" as NIC model name beside "ibmveth"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

On Fri,  9 Mar 2018 08:01:38 +0100
Thomas Huth <thuth@redhat.com> wrote:

> With the new "--nic" command line parameter option, the "old" way of
> specifying a NIC model via the nd_table[] is becoming more prominent
> again. But for the pseries "spapr-vlan" device, there is a confusing
> discrepancy between the model name that is used for "--device" (i.e.
> "spapr-vlan") and the model name that has to be used for "--net nic"
> or the new "--nic" parameter (i.e. "ibmveth"). Since "spapr-vlan" is
> the "real" name of the device, let's allow "spapr-vlan" to be used
> as model name for the nd_table[] entries, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7e1c858..dfa9e43 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2607,10 +2607,11 @@ static void spapr_machine_init(MachineState *machine)
>          NICInfo *nd = &nd_table[i];
>  
>          if (!nd->model) {
> -            nd->model = g_strdup("ibmveth");
> +            nd->model = g_strdup("spapr-vlan");
>          }
>  
> -        if (strcmp(nd->model, "ibmveth") == 0) {
> +        if (g_str_equal(nd->model, "spapr-vlan") ||
> +            g_str_equal(nd->model, "ibmveth")) {
>              spapr_vlan_create(spapr->vio_bus, nd);
>          } else {
>              pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, NULL);
