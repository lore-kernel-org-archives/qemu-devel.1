Received: from eggs.gnu.org ([2001:4830:134:3::10]:55306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwotn-0004BR-K6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwoti-0007r9-Lh
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:23:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwoti-0007qN-Ea
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:23:34 -0400
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f02e0480-238d-8407-c146-96fc75a44599@redhat.com>
Date: Tue, 26 Sep 2017 14:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170922083855.102341-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On 22.09.2017 10:38, Christian Borntraeger wrote:
> Instead of unconditionally enabling the KVM AIS capability
> in the kvm arch init function, do this in the flic realize function
> when we know if migration is available. This requires to initialize
> flic before the CPUs.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic.c          | 11 +++++++++--
>  hw/intc/s390_flic_kvm.c      |  8 +++++++-
>  hw/s390x/s390-virtio-ccw.c   |  8 ++++++--
>  include/hw/s390x/s390_flic.h |  1 +
>  target/s390x/cpu_models.c    |  6 ++++++
>  target/s390x/kvm.c           |  8 +-------
>  6 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6eaf178..08040fe 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU S390x floating interrupt controller (flic)
>   *
> - * Copyright 2014 IBM Corp.
> + * Copyright 2014,2017 IBM Corp.
>   * Author(s): Jens Freimann <jfrei@linux.vnet.ibm.com>
>   *            Cornelia Huck <cornelia.huck@de.ibm.com>
>   *
> @@ -49,6 +49,13 @@ void s390_flic_init(void)
>      qdev_init_nofail(dev);
>  }
>  
> +void s390_flic_enable_ais(void)
> +{
> +    S390FLICState *fs = s390_get_flic();
> +
> +    fs->ais_supported = true;

Can we simply replace all ais_supported checks by
s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION) and drop ais_supported?

Then, s390_flic_enable_ais() should not be needed.

As far as I understand, we will unlock kvm_vm_enable_cap(kvm_state,
KVM_CAP_S390_AIS, 0); only if we have migration support.

Therefore, CPU model init should see S390_FEAT_ADAPTER_INT_SUPPRESSION
only if migration support is available.


-- 

Thanks,

David
