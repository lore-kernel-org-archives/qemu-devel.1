Received: from eggs.gnu.org ([2001:4830:134:3::10]:52608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dzfYj-0004lQ-SZ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dzfYe-0005CU-Uw
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:01:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37142
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dzfYe-0005BM-Ov
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:01:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v948s2MN011456
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 05:01:33 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcmvmd7q5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 05:01:32 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 4 Oct 2017 10:01:31 +0100
References: <20171004090032.27365-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Oct 2017 11:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <20171004090032.27365-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0a65b335-079a-c240-f843-4c71bffa0f18@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x: sort some devices into categories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On 10/04/2017 11:00 AM, Cornelia Huck wrote:
> Add missing categorizations for some s390x devices:
> - zpci device -> misc
> - 3270 -> display
> - vfio-ccw -> misc
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/s390x/3270-ccw.c     | 1 +
>  hw/s390x/s390-pci-bus.c | 1 +
>  hw/vfio/ccw.c           | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
> index eaca28e224..081e3ef6f4 100644
> --- a/hw/s390x/3270-ccw.c
> +++ b/hw/s390x/3270-ccw.c
> @@ -160,6 +160,7 @@ static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
>      dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
>      dc->realize = emulated_ccw_3270_realize;
>      dc->hotpluggable = false;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>  }
> 
>  static const TypeInfo emulated_ccw_3270_info = {
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 3b9965fde0..96116b7d1e 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1032,6 +1032,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
> 
>      dc->desc = "zpci device";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->reset = s390_pci_device_reset;
>      dc->bus_type = TYPE_S390_PCI_BUS;
>      dc->realize = s390_pci_device_realize;
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index a8baadf57a..76323c6bde 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -413,6 +413,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>      dc->props = vfio_ccw_properties;
>      dc->vmsd = &vfio_ccw_vmstate;
>      dc->desc = "VFIO-based subchannel assignment";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->realize = vfio_ccw_realize;
>      dc->unrealize = vfio_ccw_unrealize;
>      dc->reset = vfio_ccw_reset;
> 
