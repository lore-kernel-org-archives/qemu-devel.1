Received: from eggs.gnu.org ([2001:4830:134:3::10]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diKBc-0000Xw-0t
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diKBY-0003H7-Vj
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:46:08 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diKBY-0003H3-Qm
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:46:04 -0400
Received: by mail-qt0-x242.google.com with SMTP id c13so1850297qtk.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 05:46:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
	<f2b025c6-bfd9-2b01-497c-d08f262bd0d5@amsat.org>
	<1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df2baed0-0ec0-d16c-ed14-ebec64f98f3e@amsat.org>
Date: Thu, 17 Aug 2017 09:45:59 -0300
MIME-Version: 1.0
In-Reply-To: <1cb3a142-be2d-920e-7b9e-f3ea3df0ad52@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 09:35 AM, Thomas Huth wrote:
> On 17.08.2017 13:40, Philippe Mathieu-Daudé wrote:
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
> 
> There is maybe even a simpler solution than that, see below ...
> 
> [...]
>>>    feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>> index 74d5b35..aeb730c 100644
>>> --- a/target/s390x/cpu.h
>>> +++ b/target/s390x/cpu.h
>>> @@ -41,6 +41,7 @@
>>>    #include "exec/cpu-all.h"
>>>      #include "fpu/softfloat.h"
>>> +#include "kvm_s390x.h"
> 
> Do we still need that? cpu.h should theoretically be independent from
> kvm now, shouldn't it? And for the .c files, it's likely better to
> include kvm_s390x.h directly there if they require it.

Oh you totally right, I missed this include.

[...]
>>> +#ifndef KVM_S390X_H
>>> +#define KVM_S390X_H
>>> +
>>> +#include "sysemu/kvm.h"
>>> +
>>> +#ifndef CONFIG_KVM
>>> +struct kvm_s390_irq {};
>>> +#endif /* CONFIG_KVM */
>>
>> change by
>>
>> typedef struct kvm_s390_irq kvm_s390_irq_t;
> 
> May I suggest to simply use this instead:
> 
> struct kvm_s390_irq;
> 
> No need to switch for a typedef here, you can simply use this anonymous
> struct declaration, I think.
