Received: from eggs.gnu.org ([2001:4830:134:3::10]:50600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcVo-0000Mc-JK
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcUd-00084V-DP
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ddcUc-00083P-Q1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:18:19 -0400
References: <20170804112946.5247-1-cohuck@redhat.com>
	<20170804112946.5247-9-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e935b4ab-28e6-bf15-0e69-7d57b09e83ac@redhat.com>
Date: Fri, 4 Aug 2017 15:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170804112946.5247-9-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 8/9] s390x/kvm: msi route fixup for
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
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 04.08.2017 13:29, Cornelia Huck wrote:
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
> +        return -ENODEV;
> +    }
> +

/* How can we get here without pci enabled? */
g_assert(s390_has_feat(S390_FEAT_ZPCI));

?

>      pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>      if (!pbdev) {
>          DPRINTF("add_msi_route no dev\n");
> 


-- 

Thanks,

David
