Received: from eggs.gnu.org ([2001:4830:134:3::10]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d7zzQ-0004QS-C4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d7zzN-0002vE-A7
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:55:24 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d7zzN-0002v6-2A
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:55:21 -0400
Received: by mail-pg0-x242.google.com with SMTP id u187so14055157pgb.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 00:55:20 -0700 (PDT)
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-7-git-send-email-yi.l.liu@intel.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <9441ea23-1867-f59a-1ae3-be5afa4d51da@gmail.com>
Date: Tue, 9 May 2017 15:55:20 +0800
MIME-Version: 1.0
In-Reply-To: <1493201525-14418-7-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] VFIO: do pasid table binding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>



On 04/26/2017 06:12 PM, Liu, Yi L wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> This patch adds IOCTL processing in vfio_iommu_type1 for
> VFIO_IOMMU_SVM_BIND_TASK. Binds the PASID table bind by
> calling iommu_ops->bind_pasid_table to link the whole
> PASID table to pIOMMU.
> 
> For VT-d, it is linking the guest PASID table to host pIOMMU.
> This is key point to support SVM virtualization on VT-d.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>   drivers/vfio/vfio_iommu_type1.c | 72 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index b3cc33f..30b6d48 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1512,6 +1512,50 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>   	return ret;
>   }
>   
> +struct vfio_svm_task {
> +	struct iommu_domain *domain;
> +	void *payload;
> +};
> +
> +static int bind_pasid_tbl_fn(struct device *dev, void *data)
> +{
> +	int ret = 0;
> +	struct vfio_svm_task *task = data;
> +	struct pasid_table_info *pasidt_binfo;
> +
> +	pasidt_binfo = task->payload;
> +	ret = iommu_bind_pasid_table(task->domain, dev, pasidt_binfo);
> +	return ret;
> +}
> +
> +static int vfio_do_svm_task(struct vfio_iommu *iommu, void *data,
> +				int (*fn)(struct device *, void *))
> +{
> +	int ret = 0;
> +	struct vfio_domain *d;
> +	struct vfio_group *g;
> +	struct vfio_svm_task task;
> +
> +	task.payload = data;
> +
> +	mutex_lock(&iommu->lock);
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		list_for_each_entry(g, &d->group_list, next) {
> +			if (g->iommu_group != NULL) {
> +				task.domain = d->domain;
> +				ret = iommu_group_for_each_dev(
> +					g->iommu_group, &task, fn);
> +				if (ret != 0)
> +					break;
> +			}
> +		}
> +	}
> +
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>   static long vfio_iommu_type1_ioctl(void *iommu_data,
>   				   unsigned int cmd, unsigned long arg)
>   {
> @@ -1582,6 +1626,34 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>   
>   		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>   			-EFAULT : 0;
> +	} else if (cmd == VFIO_IOMMU_SVM_BIND_TASK) {
> +		struct vfio_device_svm hdr;
> +		u8 *data = NULL;
> +		int ret = 0;
> +
> +		minsz = offsetofend(struct vfio_device_svm, length);
> +		if (copy_from_user(&hdr, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (hdr.length == 0)
> +			return -EINVAL;
> +
> +		data = memdup_user((void __user *)(arg + minsz),
> +					hdr.length);

You should check the @length is at least sizeof(struct pasid_table_info) as
kernel uses it as pasid_table_info, a evil application can crash kernel.
