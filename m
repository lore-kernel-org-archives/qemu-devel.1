Received: from eggs.gnu.org ([2001:4830:134:3::10]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d3NKq-0004Ry-VT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d3NKm-0003ii-1l
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:50:25 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d3NKl-0003id-Qr
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:50:19 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so109062wrc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:50:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-13-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f2966cf-4e5a-a2cc-5eb3-7e7d4f62bb85@redhat.com>
Date: Wed, 26 Apr 2017 15:50:16 +0200
MIME-Version: 1.0
In-Reply-To: <1493201210-14357-13-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/20] Memory: Add func to fire
 pasidt_bind notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com



On 26/04/2017 12:06, Liu, Yi L wrote:
> +void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
> +                                         void *data)
> +{
> +    IOMMUNotifier *iommu_notifier;
> +    IOMMUNotifierFlag request_flags;
> +
> +    assert(memory_region_is_iommu(mr));
> +
> +    /*TODO: support other bind requests with smaller gran,
> +     * e.g. bind signle pasid entry
> +     */
> +    request_flags = IOMMU_NOTIFIER_SVM_PASIDT_BIND;
> +
> +    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> +        if (iommu_notifier->notifier_flags & request_flags) {
> +            iommu_notifier->notify(iommu_notifier, data);
> +            break;
> +        }
> +    }

Peter,

should this reuse ->notify, or should it be different function pointer
in IOMMUNotifier?

Paolo
