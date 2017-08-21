Received: from eggs.gnu.org ([2001:4830:134:3::10]:49918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djlNe-0000us-Qr
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djlNZ-00007a-3x
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:00:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1djlNY-0008Vj-RB
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:00:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LBxemK049967
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:23 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cfttvw6dw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 08:00:23 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 13:00:20 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-10-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 14:00:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170821091614.28251-10-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com



On 08/21/2017 11:16 AM, Cornelia Huck wrote:
> If we don't provide pci, we cannot have a pci device for which we
> have to translate to adapter routes: just return -ENODEV.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 9de165d8b1..d8db1cbf6e 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2424,6 +2424,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>      uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
>      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
> 
> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> +        /* How can we get here without pci enabled? */
> +        g_assert(false);

You don't tell us about the g_assert in the commit message.
Do you expect G_DISABLE_ASSERT being defined for production 
builds. I've grepped for G_DISABLE_ASSERT and found nothing.

And why g_assert over assert (again no guidance in HACKING
mostly asking for my own learning)?

Other that that LGTM.


> +        return -ENODEV;
> +    }
> +
>      pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>      if (!pbdev) {
>          DPRINTF("add_msi_route no dev\n");
> 
