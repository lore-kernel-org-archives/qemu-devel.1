Received: from eggs.gnu.org ([2001:4830:134:3::10]:39693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1daJGw-0002P4-1E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1daJGs-0003rK-17
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:10:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44719
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1daJGr-0003qu-Rw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:10:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6Q9lR3k112538
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 06:10:25 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxpk27chr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 06:10:25 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Jul 2017 11:10:22 +0100
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-6-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Jul 2017 12:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-6-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <60e7d52a-5a69-2809-62a4-3846dddf8daa@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/9] s390x/ccw: create s390 phb
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com



On 07/25/2017 05:33 PM, Cornelia Huck wrote:
> Don't create the s390 pci host bridge if we do not provide the zpci
> facility.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/s390x/s390-virtio-ccw.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1c7af39ce6..8be4a541c1 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -118,7 +118,6 @@ static void ccw_init(MachineState *machine)
>  {
>      int ret;
>      VirtualCssBus *css_bus;
> -    DeviceState *dev;
> 
>      s390_sclp_init();
>      s390_memory_init(machine->ram_size);
> @@ -134,10 +133,13 @@ static void ccw_init(MachineState *machine)
>                        machine->initrd_filename, "s390-ccw.img",
>                        "s390-netboot.img", true);
> 
> -    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
> -    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
> -                              OBJECT(dev), NULL);
> -    qdev_init_nofail(dev);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
> +        object_property_add_child(qdev_get_machine(),
> +                                  TYPE_S390_PCI_HOST_BRIDGE,
> +                                  OBJECT(dev), NULL);
> +        qdev_init_nofail(dev);
> +    }
> 
>      /* register hypercalls */
>      virtio_ccw_register_hcalls();
> 
