Received: from eggs.gnu.org ([2001:4830:134:3::10]:39486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1ef3iB-0006cP-Vl
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1ef3iA-0000lm-BV
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:06:31 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:46249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <izik@veertu.com>) id 1ef3iA-0000ks-02
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:06:30 -0500
Received: by mail-lf0-x241.google.com with SMTP id q194so585901lfe.13
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 05:06:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <74335d27-da55-fe29-1275-e20bb2409e32@redhat.com>
References: <20180123123639.35255-1-izik@veertu.com>
	<20180123123639.35255-3-izik@veertu.com>
	<74335d27-da55-fe29-1275-e20bb2409e32@redhat.com>
From: Izik Eidus <izik@veertu.com>
Date: Fri, 26 Jan 2018 12:41:46 +0200
Message-ID: <CAJTBuygjbhqDQE1Syh86xYxWZotsS3C-2--3mo2-AhUcoE_d-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] ept_emulation_fault() need NetApp BSD
 attribution:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 26, 2018 at 11:39 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/01/2018 13:36, Izik Eidus wrote:
>> Moving it to a new file and add the BSD license there.
>>
>> Signed-off-by: Izik Eidus <izik@veertu.com>
>
> Since it's compatible, I'm just adding the NetApp BSD license to the file.

Sure.

>
> What is the original source?  xhyve or something like that?

This function is from freebsd:
sys/amd64/vmm/intel/vmx.c
http://web.mit.edu/freebsd/head/sys/amd64/vmm/intel/vmx.c


Thanks.

>
> Paolo
>
>> ---
>>  target/i386/hvf/ept_fault.h | 70 +++++++++++++++++++++++++++++++++++++++++++++
>>  target/i386/hvf/hvf.c       | 38 +-----------------------
>>  2 files changed, 71 insertions(+), 37 deletions(-)
>>  create mode 100644 target/i386/hvf/ept_fault.h
>>
>> diff --git a/target/i386/hvf/ept_fault.h b/target/i386/hvf/ept_fault.h
>> new file mode 100644
>> index 0000000000..c2938d2bd4
>> --- /dev/null
>> +++ b/target/i386/hvf/ept_fault.h
>> @@ -0,0 +1,70 @@
>> +/*-
>> + * Copyright (c) 2011 NetApp, Inc.
>> + * All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + * 1. Redistributions of source code must retain the above copyright
>> + *    notice, this list of conditions and the following disclaimer.
>> + * 2. Redistributions in binary form must reproduce the above copyright
>> + *    notice, this list of conditions and the following disclaimer in the
>> + *    documentation and/or other materials provided with the distribution.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY NETAPP, INC ``AS IS'' AND
>> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
>> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
>> + * ARE DISCLAIMED.  IN NO EVENT SHALL NETAPP, INC OR CONTRIBUTORS BE LIABLE
>> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
>> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
>> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
>> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
>> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>> + * SUCH DAMAGE.
>> + */
>> +
>> +#ifndef EPT_FAULT_H
>> +#define EPT_FAULT_H
>> +
>> +#include "hvf-i386.h"
>> +
>> +static inline bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
>> +{
>> +    int read, write;
>> +
>> +    /* EPT fault on an instruction fetch doesn't make sense here */
>> +    if (ept_qual & EPT_VIOLATION_INST_FETCH) {
>> +        return false;
>> +    }
>> +
>> +    /* EPT fault must be a read fault or a write fault */
>> +    read = ept_qual & EPT_VIOLATION_DATA_READ ? 1 : 0;
>> +    write = ept_qual & EPT_VIOLATION_DATA_WRITE ? 1 : 0;
>> +    if ((read | write) == 0) {
>> +        return false;
>> +    }
>> +
>> +    if (write && slot) {
>> +        if (slot->flags & HVF_SLOT_LOG) {
>> +            memory_region_set_dirty(slot->region, gpa - slot->start, 1);
>> +            hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
>> +                          HV_MEMORY_READ | HV_MEMORY_WRITE);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * The EPT violation must have been caused by accessing a
>> +     * guest-physical address that is a translation of a guest-linear
>> +     * address.
>> +     */
>> +    if ((ept_qual & EPT_VIOLATION_GLA_VALID) == 0 ||
>> +        (ept_qual & EPT_VIOLATION_XLAT_VALID) == 0) {
>> +        return false;
>> +    }
>> +
>> +    return !slot;
>> +}
>> +
>> +
>> +#endif
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index ab4820c3f5..94d8d119d5 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -36,6 +36,7 @@
>>  #include "x86_emu.h"
>>  #include "x86_task.h"
>>  #include "x86hvf.h"
>> +#include "ept_fault.h"
>>
>>  #include <Hypervisor/hv.h>
>>  #include <Hypervisor/hv_vmx.h>
>> @@ -292,43 +293,6 @@ void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
>>      run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>>  }
>>
>> -static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
>> -{
>> -    int read, write;
>> -
>> -    /* EPT fault on an instruction fetch doesn't make sense here */
>> -    if (ept_qual & EPT_VIOLATION_INST_FETCH) {
>> -        return false;
>> -    }
>> -
>> -    /* EPT fault must be a read fault or a write fault */
>> -    read = ept_qual & EPT_VIOLATION_DATA_READ ? 1 : 0;
>> -    write = ept_qual & EPT_VIOLATION_DATA_WRITE ? 1 : 0;
>> -    if ((read | write) == 0) {
>> -        return false;
>> -    }
>> -
>> -    if (write && slot) {
>> -        if (slot->flags & HVF_SLOT_LOG) {
>> -            memory_region_set_dirty(slot->region, gpa - slot->start, 1);
>> -            hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
>> -                          HV_MEMORY_READ | HV_MEMORY_WRITE);
>> -        }
>> -    }
>> -
>> -    /*
>> -     * The EPT violation must have been caused by accessing a
>> -     * guest-physical address that is a translation of a guest-linear
>> -     * address.
>> -     */
>> -    if ((ept_qual & EPT_VIOLATION_GLA_VALID) == 0 ||
>> -        (ept_qual & EPT_VIOLATION_XLAT_VALID) == 0) {
>> -        return false;
>> -    }
>> -
>> -    return !slot;
>> -}
>> -
>>  static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
>>  {
>>      hvf_slot *slot;
>>
>
