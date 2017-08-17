Received: from eggs.gnu.org ([2001:4830:134:3::10]:38490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diKIY-0003GR-TZ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diKIS-0005xn-RA
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diKIS-0005wT-Ir
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:53:12 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
	<1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
	<20170817144845.7287d788.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <23202ec2-9cd6-727b-b2a1-1af3115f6830@redhat.com>
Date: Thu, 17 Aug 2017 14:53:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170817144845.7287d788.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 17.08.2017 14:48, Cornelia Huck wrote:
> On Thu, 17 Aug 2017 14:35:53 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 17.08.2017 13:40, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi David,
>>>
>>> On 08/17/2017 06:22 AM, David Hildenbrand wrote: =20
>>>> Let's do it just like the other architectures. Introduce kvm-stub.c
>>>> for stubs and kvm_s390x.h for the declarations.
>>>>
>>>> Add a fake declaration of struct kvm_s390_irq so we don't need other
>>>> ugly CONFIG_KVM checks. =20
>>>
>>> You can use an opaque pointer to avoid that ("bridge" design pattern)=
.
>>>
>>> It involves few more changes but looks safer. =20
>>
>> There is maybe even a simpler solution than that, see below ...
>>
>>>> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
>>>> new file mode 100644
>>>> index 0000000..35db28c
>>>> --- /dev/null
>>>> +++ b/target/s390x/kvm_s390x.h
>>>> @@ -0,0 +1,51 @@
>>>> +/*
>>>> + * QEMU KVM support -- s390x specific functions.
>>>> + *
>>>> + * Copyright (c) 2009 Ulrich Hecht
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or
>>>> later.
>>>> + * See the COPYING file in the top-level directory.
>>>> + */
>>>> +
>>>> +#ifndef KVM_S390X_H
>>>> +#define KVM_S390X_H
>>>> +
>>>> +#include "sysemu/kvm.h"
>>>> +
>>>> +#ifndef CONFIG_KVM
>>>> +struct kvm_s390_irq {};
>>>> +#endif /* CONFIG_KVM */ =20
>>>
>>> change by
>>>
>>> typedef struct kvm_s390_irq kvm_s390_irq_t; =20
>>
>> May I suggest to simply use this instead:
>>
>> struct kvm_s390_irq;
>>
>> No need to switch for a typedef here, you can simply use this anonymou=
s
>> struct declaration, I think.
>=20
> Yes, I think so.
>=20
> I'm wondering if there are more cleanup opportunities...
>=20
> We currently have the flic which is supposed to deal with floating
> interrupts (in hw/intc/). It comes in a kvm (backed by a kvm device)
> and a non-kvm flavour. Recent changes have introduced some adapter
> interrupt handling in both the kvm device backing and in the non-kvm
> flic.
>=20
> Creation/injection of floating interrupts (like I/O interrupts) is
> currently a bit scattered around the code, and the tcg code (which
> predates the flic) does not have much in common with the kvm code. Can
> we enhance the flic with one or more injection methods, move the tcg
> interrupt creation into the non-kvm flic, and get rid of
> kvm_s390_inject_flic()? Not sure how doable that is.
>=20

There are many more possible cleanups, let's limit the scope of this
series. (it all started by wanting to move one function to cpu.h ...)

Thanks!

--=20

Thanks,

David
