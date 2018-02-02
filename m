Received: from eggs.gnu.org ([208.118.235.92]:41813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehPyo-0002Ak-BZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehPsn-00016s-7c
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:12:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehPhh-0001KX-Id
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:59:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w120xEmS046674
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 19:59:44 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvancq1hy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 19:59:43 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 17:59:43 -0700
References: <1517527416-31328-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1517527416-31328-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 19:59:39 -0500
MIME-Version: 1.0
In-Reply-To: <1517527416-31328-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <b3ca57bf-5e45-cb82-4de1-1e49ec888df7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm: Split off tpm_crb_reset function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

On 02/01/2018 06:23 PM, Stefan Berger wrote:
> Split off the tpm_crb_reset function part from tpm_crb_realize
> that we need to run every time the machine resets.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   hw/tpm/tpm_crb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 687d255..624e2e9 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -232,6 +232,11 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>           TPM_CRB_ADDR_BASE, &s->mmio);
>       memory_region_add_subregion(get_system_memory(),
>           TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> +}
> +
> +static void tpm_crb_reset(DeviceState *dev)
> +{
> +    CRBState *s = CRB(dev);
>
>       tpm_backend_reset(s->tpmbe);
>
> @@ -274,6 +279,7 @@ static void tpm_crb_class_init(ObjectClass *klass, void *data)
>
>       dc->realize = tpm_crb_realize;
>       dc->props = tpm_crb_properties;
> +    dc->reset = tpm_crb_reset;
>       dc->vmsd  = &vmstate_tpm_crb;
>       dc->user_creatable = true;
>       tc->model = TPM_MODEL_TPM_CRB;


So this splt-off unfortunately causes the tpm-crb-test to fail since the 
reset function is not called. I wonder how to trigger that? Do we need 
to call tpm_crb_reset now from tpm_crb_realize just to make the tests 
work ? Or is there a function we can call in the test case to trigger 
the device reset ?
