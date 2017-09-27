Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dx9Wl-0003Ym-EZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dx9Wi-0004RB-7M
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dx9Wh-0004Q5-V1
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:25:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8RAO1ZQ115919
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 06:25:07 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d87p18e6e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 06:25:06 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 27 Sep 2017 04:25:06 -0600
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 27 Sep 2017 18:25:00 +0800
MIME-Version: 1.0
In-Reply-To: <20170927114717.72bd69f8.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, dgilbert@redhat.com



=D4=DA 2017/9/27 =CF=C2=CE=E75:47, Cornelia Huck =D0=B4=B5=C0:
> On Tue, 26 Sep 2017 20:40:25 +0200
> David Hildenbrand <david@redhat.com> wrote:
>
>> On 26.09.2017 18:20, Cornelia Huck wrote:
>>> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
>>> creating the s390 phb dependant on the zpci facility. This broke
>>> migration from pre-cpu model machines which was fixed with
>>> 8ad9087c4a ("s390x/ccw: create s390 phb for compat reasons as well").
>>> However, that is not enough: Migration from 2.10 with -cpu z13
>>> breaks as well.
>>>
>>> Let's create a phb for all pre-2.11 compat machines to fix this.
>>> We leave the zpci facility off to avoid a guest-visible change
>>> with cpu models on.
>>>
>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>   hw/s390x/s390-virtio-ccw.c         | 8 +++++++-
>>>   include/hw/s390x/s390-virtio-ccw.h | 1 +
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 1bcb7000ab..981f1c4336 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -247,6 +247,8 @@ static void s390_create_virtio_net(BusState *bus,=
 const char *name)
>>>       }
>>>   }
>>>  =20
>>> +static S390CcwMachineClass *get_machine_class(void);
>>> +
>>>   static void ccw_init(MachineState *machine)
>>>   {
>>>       int ret;
>>> @@ -266,7 +268,7 @@ static void ccw_init(MachineState *machine)
>>>                         machine->initrd_filename, "s390-ccw.img",
>>>                         "s390-netboot.img", true);
>>>  =20
>>> -    if (s390_has_feat(S390_FEAT_ZPCI)) {
>>> +    if (s390_has_feat(S390_FEAT_ZPCI) || get_machine_class()->phb_co=
mpat) {
>>>           DeviceState *dev =3D qdev_create(NULL, TYPE_S390_PCI_HOST_B=
RIDGE);
>>>           object_property_add_child(qdev_get_machine(),
>>>                                     TYPE_S390_PCI_HOST_BRIDGE,
>>> @@ -407,6 +409,7 @@ static void ccw_machine_class_init(ObjectClass *o=
c, void *data)
>>>       s390mc->cpu_model_allowed =3D true;
>>>       s390mc->css_migration_enabled =3D true;
>>>       s390mc->gs_allowed =3D true;
>>> +    s390mc->phb_compat =3D false;
>>>       mc->init =3D ccw_init;
>>>       mc->reset =3D s390_machine_reset;
>>>       mc->hot_add_cpu =3D s390_hot_add_cpu;
>>> @@ -716,6 +719,9 @@ static void ccw_machine_2_10_instance_options(Mac=
hineState *machine)
>>>  =20
>>>   static void ccw_machine_2_10_class_options(MachineClass *mc)
>>>   {
>>> +    S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
>>> +
>>> +    s390mc->phb_compat =3D pci_available;
>>>       ccw_machine_2_11_class_options(mc);
>>>       SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_10);
>>>   }
>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s3=
90-virtio-ccw.h
>>> index a9a90c2022..fb717afe92 100644
>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>>>       bool cpu_model_allowed;
>>>       bool css_migration_enabled;
>>>       bool gs_allowed;
>>> +    bool phb_compat;
>>>   } S390CcwMachineClass;
>>>  =20
>>>   /* runtime-instrumentation allowed by the machine */
>>>   =20
>> I'd really really really (did I mention really?) favor something like =
a
>> dummy device, because we could easily handle the !CONFIG_PCI case then.
>>
>> All these compat options and conditions will kill us someday... we're
>> already patching around that whole stuff way too much.
>>
>> If we ever unconditionally created a device, we should keep doing so.
> Yes, that whole thing is horrible, especially interaction with compat
> machines.
>
> Do you have an idea on how to create such a dummy device (without
> having to effectively copy a lot of configured-out code)?
>
>
How about in s390_pcihost_hot_plug() we check s390_has_feat(zpci)?
If no zpci feature, we avoid plugging any pci device.
Then we could always create phb.
I think pcibus's vmstate is only data to migrate.
