Received: from eggs.gnu.org ([2001:4830:134:3::10]:49696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOj47-0004N7-0o
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOj43-0007va-3S
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:49:39 -0500
Date: Tue, 12 Dec 2017 12:49:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171212124929.6cf989b3.cohuck@redhat.com>
In-Reply-To: <0df9176c-80d3-69b7-fcdc-2279ea8dbcea@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-5-david@redhat.com>
	<20171211181754.4a3b847d.cohuck@redhat.com>
	<08154f0d-d526-d735-a952-853fcabe946b@redhat.com>
	<20171212101545.3bbd19dc.cohuck@redhat.com>
	<0df9176c-80d3-69b7-fcdc-2279ea8dbcea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 04/15] s390x/flic: simplify
 flic initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Tue, 12 Dec 2017 11:45:22 +0100
David Hildenbrand <david@redhat.com> wrote:

> This is what it looks like now:
> 
> commit dec1ff5cfc72fa0998e28a25dd23f0695ddfe21b
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon Nov 13 23:09:56 2017 +0100
> 
>     s390x/flic: simplify flic initialization
>     
>     This makes it clearer, which device is used for which accelerator.
>     
>     We can directly attach both to /machine/s390-flic/ instead of two
>     different locations (/machine/s390x-flic[qemu|kvm]). Should not
>     harm migration.

Not sure about libvirt usage, though. Let's keep it as-is?

>     
>     Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>     Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6eaf178d79..dd5b157392 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -40,12 +40,13 @@ void s390_flic_init(void)
>  {
>      DeviceState *dev;
>  
> -    dev = s390_flic_kvm_create();
> -    if (!dev) {
> +    if (kvm_enabled()) {
> +        dev = qdev_create(NULL, TYPE_KVM_S390_FLIC);
> +    } else {
>          dev = qdev_create(NULL, TYPE_QEMU_S390_FLIC);
> -        object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
> -                                  OBJECT(dev), NULL);
>      }
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_FLIC_COMMON,
> +                              OBJECT(dev), NULL);

Dropping the check for tcg_enabled() is fine with me, though.

>      qdev_init_nofail(dev);
>  }
>  
> ...
> 
