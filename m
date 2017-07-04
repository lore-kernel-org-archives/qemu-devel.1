Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOR8-0006pv-GL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOR4-0000nI-Ge
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:04:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSOR4-0000mJ-6J
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:04:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64Dx8fL131231
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 10:04:12 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6j6jj3y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 10:04:12 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 08:04:11 -0600
References: <20170704132350.11874-1-haoqf@linux.vnet.ibm.com>
	<20170704132350.11874-2-haoqf@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 16:04:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170704132350.11874-2-haoqf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <1c49923a-e493-9faf-d642-a48aeb8bf3ad@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, zyimin@linux.vnet.ibm.com, famz@redhat.com, cohuck@redhat.com, peterx@redhat.com, stefanha@redhat.com

On 07/04/2017 03:23 PM, QingFeng Hao wrote:
> This patch is based on a similar patch from Stefan Hajnoczi -
> commit c324fd0a39c ("virtio-pci: use ioeventfd even when KVM is disabled")
> 
> Do not check kvm_eventfds_enabled() when KVM is disabled since it
> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> qtest or TCG mode.
> 
> This patch makes -device virtio-scsi-ccw,iothread=iothread0 work even
> when KVM is disabled.
> Currently we don't have an equivalent to "memory: emulate ioeventfd"
> for ccw yet, but that this doesn't hurt and qemu-iotests 068 can pass with
> skipping iothread arguments.
> 
> I have tested that virtio-scsi-ccw works under tcg both with and without
> iothread.
> 
> This patch fixes qemu-iotests 068, which was accidentally merged early
> despite the dependency on ioeventfd.
> 
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

I will take it via the s390-next tree.

thanks applied.

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
> 
