Received: from eggs.gnu.org ([2001:4830:134:3::10]:35404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diK1q-0004KJ-UU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diK1o-0006Sn-AV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:36:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diK1o-0006S8-4I
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:36:00 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
Date: Thu, 17 Aug 2017 14:35:53 +0200
MIME-Version: 1.0
In-Reply-To: <f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 17.08.2017 13:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi David,
>=20
> On 08/17/2017 06:22 AM, David Hildenbrand wrote:
>> Let's do it just like the other architectures. Introduce kvm-stub.c
>> for stubs and kvm_s390x.h for the declarations.
>>
>> Add a fake declaration of struct kvm_s390_irq so we don't need other
>> ugly CONFIG_KVM checks.
>=20
> You can use an opaque pointer to avoid that ("bridge" design pattern).
>=20
> It involves few more changes but looks safer.

There is maybe even a simpler solution than that, see below ...

[...]
>>   feat-src =3D $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 74d5b35..aeb730c 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -41,6 +41,7 @@
>>   #include "exec/cpu-all.h"
>>     #include "fpu/softfloat.h"
>> +#include "kvm_s390x.h"

Do we still need that? cpu.h should theoretically be independent from
kvm now, shouldn't it? And for the .c files, it's likely better to
include kvm_s390x.h directly there if they require it.

[...]
>> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
>> new file mode 100644
>> index 0000000..35db28c
>> --- /dev/null
>> +++ b/target/s390x/kvm_s390x.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * QEMU KVM support -- s390x specific functions.
>> + *
>> + * Copyright (c) 2009 Ulrich Hecht
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef KVM_S390X_H
>> +#define KVM_S390X_H
>> +
>> +#include "sysemu/kvm.h"
>> +
>> +#ifndef CONFIG_KVM
>> +struct kvm_s390_irq {};
>> +#endif /* CONFIG_KVM */
>=20
> change by
>=20
> typedef struct kvm_s390_irq kvm_s390_irq_t;

May I suggest to simply use this instead:

struct kvm_s390_irq;

No need to switch for a typedef here, you can simply use this anonymous
struct declaration, I think.

 Thomas
