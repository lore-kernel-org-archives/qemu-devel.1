Received: from eggs.gnu.org ([2001:4830:134:3::10]:50513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwtKf-0000jY-OV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwtKa-0000B6-OB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwtKa-0000AT-Es
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:07:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QH6Wb7143848
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 13:07:32 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7qgrpy04-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 13:07:31 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Sep 2017 18:07:28 +0100
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Sep 2017 19:07:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170926162058.30772-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1ff22007-d4d9-791d-b204-f9490ac0cf00@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, david@redhat.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, dgilbert@redhat.com



On 09/26/2017 06:20 PM, Cornelia Huck wrote:
> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
> creating the s390 phb dependant on the zpci facility. This broke
> migration from pre-cpu model machines which was fixed with
> 8ad9087c4a ("s390x/ccw: create s390 phb for compat reasons as well").
> However, that is not enough: Migration from 2.10 with -cpu z13
> breaks as well.
> 
> Let's create a phb for all pre-2.11 compat machines to fix this.
> We leave the zpci facility off to avoid a guest-visible change
> with cpu models on.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

seems to work fine. 
> ---
>  hw/s390x/s390-virtio-ccw.c         | 8 +++++++-
>  include/hw/s390x/s390-virtio-ccw.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1bcb7000ab..981f1c4336 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -247,6 +247,8 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
>      }
>  }
> 
> +static S390CcwMachineClass *get_machine_class(void);
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -266,7 +268,7 @@ static void ccw_init(MachineState *machine)
>                        machine->initrd_filename, "s390-ccw.img",
>                        "s390-netboot.img", true);
> 
> -    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +    if (s390_has_feat(S390_FEAT_ZPCI) || get_machine_class()->phb_compat) {
>          DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
>          object_property_add_child(qdev_get_machine(),
>                                    TYPE_S390_PCI_HOST_BRIDGE,
> @@ -407,6 +409,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      s390mc->cpu_model_allowed = true;
>      s390mc->css_migration_enabled = true;
>      s390mc->gs_allowed = true;
> +    s390mc->phb_compat = false;
>      mc->init = ccw_init;
>      mc->reset = s390_machine_reset;
>      mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -716,6 +719,9 @@ static void ccw_machine_2_10_instance_options(MachineState *machine)
> 
>  static void ccw_machine_2_10_class_options(MachineClass *mc)
>  {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> +
> +    s390mc->phb_compat = pci_available;
>      ccw_machine_2_11_class_options(mc);
>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_10);
>  }
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index a9a90c2022..fb717afe92 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>      bool cpu_model_allowed;
>      bool css_migration_enabled;
>      bool gs_allowed;
> +    bool phb_compat;
>  } S390CcwMachineClass;
> 
>  /* runtime-instrumentation allowed by the machine */
> 
