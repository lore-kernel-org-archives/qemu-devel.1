Received: from eggs.gnu.org ([2001:4830:134:3::10]:37340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXj6o-0000un-RF
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXj6k-0000f2-Qn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXj6k-0000dy-Hf
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:09:18 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-9-cohuck@redhat.com>
	<CAAdtpL4TGurYS3tO1RbbJ78HrMRg+AyUmFf_+WhfkTdXLp0cOA@mail.gmail.com>
	<20170718172244.75fa5d73@gondolin>
	<95af5742-5f15-8858-4af0-1688f8af2c87@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b738069f-03d3-bf02-c98c-e07e8d42a8d2@redhat.com>
Date: Wed, 19 Jul 2017 09:09:11 +0200
MIME-Version: 1.0
In-Reply-To: <95af5742-5f15-8858-4af0-1688f8af2c87@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 8/9] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, pmorel@linux.vnet.ibm.com, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On 19.07.2017 05:16, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2017/7/18 =E4=B8=8B=E5=8D=8811:22, Cornelia Huck =E5=86=99=E9=
=81=93:
>> On Tue, 18 Jul 2017 11:58:08 -0300
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>>
>>> Hi Cornelia,
>>>
>>> On Tue, Jul 18, 2017 at 11:24 AM, Cornelia Huck <cohuck@redhat.com>
>>> wrote:
>>>> If we don't provide pci, we cannot have a pci device for which we
>>>> have to translate to adapter routes: just return -ENODEV.
>>>>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>   target/s390x/kvm.c | 33 +++++++++++++++++++--------------
>>>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index 60688888c3..df0e5af151 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -2424,22 +2424,27 @@ int kvm_arch_fixup_msi_route(struct
>>>> kvm_irq_routing_entry *route,
>>>>       uint32_t idx =3D data >> ZPCI_MSI_VEC_BITS;
>>>>       uint32_t vec =3D data & ZPCI_MSI_VEC_MASK;
>>>>
>>>> -    pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>>>> -    if (!pbdev) {
>>>> -        DPRINTF("add_msi_route no dev\n");
>>>> -        return -ENODEV;
>>>> -    }
>>>> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
>>>> +        pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>>>> +        if (!pbdev) {
>>>> +            DPRINTF("add_msi_route no dev\n");
>>>> +            return -ENODEV;
>>>> +        }
>>>>
>>>> -    pbdev->routes.adapter.ind_offset =3D vec;
>>>> +        pbdev->routes.adapter.ind_offset =3D vec;
>>>>
>>>> -    route->type =3D KVM_IRQ_ROUTING_S390_ADAPTER;
>>>> -    route->flags =3D 0;
>>>> -    route->u.adapter.summary_addr =3D
>>>> pbdev->routes.adapter.summary_addr;
>>>> -    route->u.adapter.ind_addr =3D pbdev->routes.adapter.ind_addr;
>>>> -    route->u.adapter.summary_offset =3D
>>>> pbdev->routes.adapter.summary_offset;
>>>> -    route->u.adapter.ind_offset =3D pbdev->routes.adapter.ind_offse=
t;
>>>> -    route->u.adapter.adapter_id =3D pbdev->routes.adapter.adapter_i=
d;
>>>> -    return 0;
>>>> +        route->type =3D KVM_IRQ_ROUTING_S390_ADAPTER;
>>>> +        route->flags =3D 0;
>>>> +        route->u.adapter.summary_addr =3D
>>>> pbdev->routes.adapter.summary_addr;
>>>> +        route->u.adapter.ind_addr =3D pbdev->routes.adapter.ind_add=
r;
>>>> +        route->u.adapter.summary_offset =3D
>>>> pbdev->routes.adapter.summary_offset;
>>>> +        route->u.adapter.ind_offset =3D
>>>> pbdev->routes.adapter.ind_offset;
>>>> +        route->u.adapter.adapter_id =3D
>>>> pbdev->routes.adapter.adapter_id;
>>>> +        return 0;
>>>> +    } else {
>>>> +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>>   }
>>>>
>>>>   int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *rout=
e,
>>>> --=20
>>>> 2.13.3
>>> What about inverting the check?
>>>
>>> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
>>> +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
>>> +        return -ENODEV;
>>> +    }
>> I usually prefer the more common branch on top, but (1) this causes
>> more changes in this case and (2) I'm not so sure if zpci on really is
>> the common case...
>>
> Sorry for my duplicated comment. I think we don't know which is more
> common. Currently 2.9
> machine doesn' t support zpci facility. But in the future, how will the
> thing change?

No matter whether zpci is the more common case or not, but one good
coding style is to keep the level of indentation small. So the early
exit as suggested by Philippe is certainly a good idea in this case here.

 Thomas
