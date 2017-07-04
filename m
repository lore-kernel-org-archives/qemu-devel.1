Received: from eggs.gnu.org ([2001:4830:134:3::10]:34115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSKEF-0001qc-Mq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSKE9-0007Zb-Ir
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:34:43 -0400
Date: Tue, 4 Jul 2017 11:34:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170704113419.1218ce97@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170704083231.98056-2-haoqf@linux.vnet.ibm.com>
References: <20170704083231.98056-1-haoqf@linux.vnet.ibm.com>
	<20170704083231.98056-2-haoqf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com

On Tue,  4 Jul 2017 10:32:31 +0200
QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:

> This patch is based on a similar patch from Stefan Hajnoczi -
> commit c324fd0a39c (" virtio-pci: use ioeventfd even when KVM is disabled)
> 
> Do not check kvm_eventfds_enabled() when KVM is disabled since it
> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> qtest or TCG mode.
> 
> This patch makes -device virtio-scsi-ccw,iothread=iothread0 work even
> when KVM is disabled.

It might be good to add a sentence that we don't have an equivalent to
"memory: emulate ioeventfd" for ccw yet, but that this doesn't hurt.

> 
> I have tested that virtio-scsi-ccw works under tcg both with and without
> iothread.
> 
> This patch fixes qemu-iotests 068, which was accidentally merged early
> despite the dependency on ioeventfd.
> 
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 2 +-
>  target/s390x/cpu.h    | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 90d37cb9ff..35896eb007 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -711,7 +711,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>          sch->cssid, sch->ssid, sch->schid, sch->devno,
>          ccw_dev->devno.valid ? "user-configured" : "auto-configured");
>  
> -    if (!kvm_eventfds_enabled()) {
> +    if (kvm_enabled() && !kvm_eventfds_enabled()) {
>          dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
>      }
>  
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 9faca04b52..bdb9bdbc9d 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -1264,7 +1264,11 @@ static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
>                                                uint32_t sch_id, int vq,
>                                                bool assign)
>  {
> -    return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
> +    if (kvm_enabled()) {
> +        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
> +    } else {
> +        return 0;
> +    }
>  }
>  
>  static inline void s390_crypto_reset(void)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
