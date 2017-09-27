Received: from eggs.gnu.org ([2001:4830:134:3::10]:42364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dx44v-0006g2-Fc
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dx44s-0001Wb-CY
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:36:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dx44s-0001W0-2H
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 00:36:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R4XbwI101441
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 00:36:01 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7vxe5p97-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 00:36:01 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 26 Sep 2017 22:36:00 -0600
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-2-borntraeger@de.ibm.com>
	<6f4a490e-96bc-58b5-c561-4491f175e2e4@redhat.com>
	<debb11b6-3eba-b2fe-961f-52df7b1c5926@de.ibm.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 27 Sep 2017 12:35:53 +0800
MIME-Version: 1.0
In-Reply-To: <debb11b6-3eba-b2fe-961f-52df7b1c5926@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <47df0694-49b2-7acf-fab1-af6119fa5aa2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>



=E5=9C=A8 2017/9/26 =E4=B8=8B=E5=8D=8810:06, Christian Borntraeger =E5=86=
=99=E9=81=93:
>
> On 09/26/2017 03:43 PM, David Hildenbrand wrote:
>>> +    /* try enable the AIS facility */
>>> +    test_attr.group =3D KVM_DEV_FLIC_AISM_ALL;
>>> +    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
>>> +            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
>>> +    }
>>> +
>>>       return;
>>>   fail:
>>>       error_propagate(errp, errp_local);
>>> @@ -578,7 +584,7 @@ static void kvm_s390_flic_reset(DeviceState *dev)
>>>  =20
>>>       flic_disable_wait_pfault(flic);
>>>  =20
>>> -    if (fs->ais_supported) {
>>> +    if (s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION)) {
>> I don't remember if a reset is trigger on realization. Most probably
>> not, but it could be.
>>
>> Would it hurt if the following code would not get called if the flic
>> hasn't been used yet? (possible reset before cpu model has been
>> initialized) - are kvm_s390_modify_ais_mode() calls required before ai=
s
>> can be used for the first time?
> Hmm, simm/nimm should default to zero in the kernel I guess. So I think=
 it would
> not hurt. Yi Min, correct?
Yes, the default mode is all interruption mode, IOW simm =3D 0 and nimm =3D=
 0.
>
>
> Anyway it seems that reset is NOT called during realize, the first
> call is
>
>                  #0  0x00000000010e5178 kvm_s390_flic_reset (qemu-syste=
m-s390x)
>                  #1  0x000000000124bbc4 device_reset (qemu-system-s390x=
)
>                  #2  0x0000000001248cd0 qdev_reset_one (qemu-system-s39=
0x)
>                  #3  0x0000000001249ea4 qdev_walk_children (qemu-system=
-s390x)
>                  #4  0x000000000124fd3a qbus_walk_children (qemu-system=
-s390x)
>                  #5  0x0000000001248e6c qbus_reset_all (qemu-system-s39=
0x)
>                  #6  0x0000000001248eae qbus_reset_all_fn (qemu-system-=
s390x)
>                  #7  0x0000000001250a60 qemu_devices_reset (qemu-system=
-s390x)
>                  #8  0x0000000001143c80 s390_machine_reset (qemu-system=
-s390x)
>                  #9  0x00000000011c5b72 qemu_system_reset (qemu-system-=
s390x)
>                  #10 0x00000000011ceb8e main (qemu-system-s390x)
>                  #11 0x000003ff947a289a __libc_start_main (libc.so.6)
>                  #12 0x0000000001017646 _start (qemu-system-s390x)
>
>
>
