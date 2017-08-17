Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diKKZ-0004cy-MS
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diKKV-0006Vq-Pw
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diKKV-0006UH-JV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:55:19 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
	<1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c38eee58-0e16-1a3f-47f5-550f7cbc943f@redhat.com>
Date: Thu, 17 Aug 2017 14:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 09/10] s390x/kvm: move KVM
 declarations and stubs to separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 17.08.2017 14:35, Thomas Huth wrote:
> On 17.08.2017 13:40, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi David,
>>
>> On 08/17/2017 06:22 AM, David Hildenbrand wrote:
>>> Let's do it just like the other architectures. Introduce kvm-stub.c
>>> for stubs and kvm_s390x.h for the declarations.
>>>
>>> Add a fake declaration of struct kvm_s390_irq so we don't need other
>>> ugly CONFIG_KVM checks.
>>
>> You can use an opaque pointer to avoid that ("bridge" design pattern).
>>
>> It involves few more changes but looks safer.
>=20
> There is maybe even a simpler solution than that, see below ...
>=20
> [...]
>>>   feat-src =3D $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>> index 74d5b35..aeb730c 100644
>>> --- a/target/s390x/cpu.h
>>> +++ b/target/s390x/cpu.h
>>> @@ -41,6 +41,7 @@
>>>   #include "exec/cpu-all.h"
>>>     #include "fpu/softfloat.h"
>>> +#include "kvm_s390x.h"
>=20
> Do we still need that? cpu.h should theoretically be independent from
> kvm now, shouldn't it? And for the .c files, it's likely better to
> include kvm_s390x.h directly there if they require it.

It should work if:

a) we include "sysemu/kvm.h" in hw/s390x/s390-virtio-ccw.c
b) we include "target/s390x/kvm_s390x.h" in hw/intc/s390_flic_kvm.c
c) we include "kvm_s390x.h" in "internal.h"
d) we drop the "KVMState" parameter from kvm_s390_get_memslot_count()
(separate patch)

>=20
> May I suggest to simply use this instead:
>=20
> struct kvm_s390_irq;

That also seems to compile just fine.

>=20
> No need to switch for a typedef here, you can simply use this anonymous
> struct declaration, I think.
>=20
>  Thomas
>=20


--=20

Thanks,

David
