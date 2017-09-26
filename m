Received: from eggs.gnu.org ([2001:4830:134:3::10]:51278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwq9N-0002m8-2n
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwq9J-0003sp-UO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwq9J-0003sU-NG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:43:45 -0400
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6f4a490e-96bc-58b5-c561-4491f175e2e4@redhat.com>
Date: Tue, 26 Sep 2017 15:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170926133624.155394-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/ais: enable ais when
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


> +    /* try enable the AIS facility */
> +    test_attr.group = KVM_DEV_FLIC_AISM_ALL;
> +    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
> +            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
> +    }
> +
>      return;
>  fail:
>      error_propagate(errp, errp_local);
> @@ -578,7 +584,7 @@ static void kvm_s390_flic_reset(DeviceState *dev)
>  
>      flic_disable_wait_pfault(flic);
>  
> -    if (fs->ais_supported) {
> +    if (s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {

I don't remember if a reset is trigger on realization. Most probably
not, but it could be.

Would it hurt if the following code would not get called if the flic
hasn't been used yet? (possible reset before cpu model has been
initialized) - are kvm_s390_modify_ais_mode() calls required before ais
can be used for the first time?

If so, we could add a manual reset after the cpu model has been initialized.

>          for (isc = 0; isc <= MAX_ISC; isc++) {
>              rc = kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL);
>              if (rc) {
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 75d4f30..1d4bb73 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1,7 +1,7 @@
>  /*
>   * Channel subsystem base support.
>   *
> - * Copyright 2012 IBM Corp.
> + * Copyright IBM Corp. 2012, 2017
>   * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or (at
> @@ -672,7 +672,7 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>      }
>  
>      trace_css_adapter_interrupt(isc);
> -    if (fs->ais_supported) {
> +    if (s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
>          if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
>              error_report("Failed to inject airq with AIS supported");
>              exit(1);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d..98c82c2 100644
> --- a/hw/s390x/s390-virtio-ccw.c

Looks much better to me now.

-- 

Thanks,

David
