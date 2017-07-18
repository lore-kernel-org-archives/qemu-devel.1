Received: from eggs.gnu.org ([2001:4830:134:3::10]:43864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXTwy-0005ap-UA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXTww-0001sb-Pd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:58:13 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXTww-0001sN-J3
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:58:10 -0400
Received: by mail-io0-x244.google.com with SMTP id f1so1011768ioj.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:58:10 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170718142455.32676-9-cohuck@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-9-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 11:58:08 -0300
Message-ID: <CAAdtpL4TGurYS3tO1RbbJ78HrMRg+AyUmFf_+WhfkTdXLp0cOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v2 8/9] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, zyimin@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi Cornelia,

On Tue, Jul 18, 2017 at 11:24 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> If we don't provide pci, we cannot have a pci device for which we
> have to translate to adapter routes: just return -ENODEV.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 60688888c3..df0e5af151 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2424,22 +2424,27 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>      uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
>      uint32_t vec = data & ZPCI_MSI_VEC_MASK;
>
> -    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> -    if (!pbdev) {
> -        DPRINTF("add_msi_route no dev\n");
> -        return -ENODEV;
> -    }
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> +        if (!pbdev) {
> +            DPRINTF("add_msi_route no dev\n");
> +            return -ENODEV;
> +        }
>
> -    pbdev->routes.adapter.ind_offset = vec;
> +        pbdev->routes.adapter.ind_offset = vec;
>
> -    route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
> -    route->flags = 0;
> -    route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
> -    route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
> -    route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
> -    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
> -    route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
> -    return 0;
> +        route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
> +        route->flags = 0;
> +        route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
> +        route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
> +        route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
> +        route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
> +        route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
> +        return 0;
> +    } else {
> +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
> +        return -ENODEV;
> +    }
>  }
>
>  int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
> --
> 2.13.3

What about inverting the check?

+    if (!s390_has_feat(S390_FEAT_ZPCI)) {
+        DPRINTF("fixup_msi_route on non-pci machine?!\n");
+        return -ENODEV;
+    }

Phil.
