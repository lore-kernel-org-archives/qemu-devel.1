Received: from eggs.gnu.org ([2001:4830:134:3::10]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egq6B-00070f-BO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egq67-0001Fj-FG
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:58:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1egq67-0001FI-6X
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 05:58:35 -0500
Date: Wed, 31 Jan 2018 11:58:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180131115824.7329b8ee.cohuck@redhat.com>
In-Reply-To: <20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/pci: fixup the code walking
 IOMMU tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On Tue, 30 Jan 2018 10:47:13 +0100
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> Current s390x PCI IOMMU code is lack of flags' checking, including:
> 1) protection bit
> 2) table length
> 3) table offset
> 4) intermediate tables' invalid bit
> 5) format control bit
> 
> This patch introduces a new struct named S390IOTLBEntry, and makes up
> these missed checkings. At the same time, inform the guest with the
> corresponding error number when the check fails.

There are a lot of things in this patch I cannot review due to -ENODOC,
but some comments below.

> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 223 ++++++++++++++++++++++++++++++++++++++---------
>  hw/s390x/s390-pci-bus.h  |  10 +++
>  hw/s390x/s390-pci-inst.c |  10 ---
>  3 files changed, 190 insertions(+), 53 deletions(-)

(...)

> +/* ett is expected table type, -1 page table, 0 segment table, 1 region table */
> +static uint64_t get_table_index(uint64_t iova, int8_t ett)
> +{
> +    switch (ett) {
> +    case -1:
> +        return calc_px(iova);
> +    case 0:
> +        return calc_sx(iova);
> +    case 1:
> +        return calc_rtx(iova);
> +    }
> +
> +    return -1;

You use ett to differentiate between the three table types a lot. Is
this an architectured value, or an internal construct?

If you introduced it yourself, it might make sense to switch to an enum
instead. Otherwise, using some #defines would improve readability of
the code.

> +}

(...)

> +/**
> + * table_translate: do translation within one table and return the following
> + *                  table origin
> + *
> + * @entry: the entry being traslated, the result is stored in this.

s/traslated/translated/

> + * @to: the address of table origin.
> + * @ett: expected table type, 1 region table, 0 segment table and -1 page table.
> + * @error: error code
> + */
> +static uint64_t table_translate(S390IOTLBEntry *entry, uint64_t to, int8_t ett,
> +                                uint16_t *error)

(...)

> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index be449210d9..63fa06fb97 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -644,16 +644,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>  
>      while (start < end) {
>          entry = imrc->translate(iommu_mr, start, IOMMU_NONE);
> -
> -        if (!entry.translated_addr) {
> -            pbdev->state = ZPCI_FS_ERROR;
> -            setcc(cpu, ZPCI_PCI_LS_ERR);
> -            s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
> -            s390_pci_generate_error_event(ERR_EVENT_SERR, pbdev->fh, pbdev->fid,
> -                                          start, ERR_EVENT_Q_BIT);
> -            goto out;
> -        }
> -
>          memory_region_notify_iommu(iommu_mr, entry);
>          start += entry.addr_mask + 1;

You're now progressing even though you might have generated an error
event. Is that what's intended?

>      }
