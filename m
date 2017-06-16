Received: from eggs.gnu.org ([2001:4830:134:3::10]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLuzM-0008Ng-Mx
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLuzH-0001SS-Pf
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:24:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLuzH-0001Rt-GX
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:24:47 -0400
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
	<1497625153-19812-6-git-send-email-thuth@redhat.com>
	<87h8zfc13z.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7388ac00-b7bd-c081-fdb2-4493e1273b34@redhat.com>
Date: Fri, 16 Jun 2017 19:24:43 +0200
MIME-Version: 1.0
In-Reply-To: <87h8zfc13z.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] cpu: Introduce a wrapper for
 tlb_flush() that can be used in common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 16/06/2017 19:07, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> Commit 1f5c00cfdb8114c ("qom/cpu: move tlb_flush to cpu_common_reset")
>> moved the call to tlb_flush() from the target-specific reset handlers
>> into the common code qom/cpu.c file, and protected the call with
>> "#ifdef CONFIG_SOFTMMU" to avoid that it is called for linux-user
>> only targets. But since qom/cpu.c is common code, CONFIG_SOFTMMU is
>> *never* defined here, so the tlb_flush() was simply never executed
>> anymore. Fix it by introducing a wrapper for tlb_flush() in a file
>> that is re-compiled for each target, i.e. in translate-all.c.
>>
>> Fixes: 1f5c00cfdb8114c1e3a13426588ceb64f82c9ddb
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  include/exec/cpu-common.h | 2 ++
>>  qom/cpu.c                 | 5 ++---
>>  translate-all.c           | 8 ++++++++
>>  3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 4d45a72..74341b1 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -28,6 +28,8 @@ void qemu_init_cpu_list(void);
>>  void cpu_list_lock(void);
>>  void cpu_list_unlock(void);
>>
>> +void tcg_flush_softmmu_tlb(CPUState *cs);
>> +
>>  #if !defined(CONFIG_USER_ONLY)
>>
>>  enum device_endian {
>> diff --git a/qom/cpu.c b/qom/cpu.c
>> index 5069876..303eb42 100644
>> --- a/qom/cpu.c
>> +++ b/qom/cpu.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/notify.h"
>>  #include "qemu/log.h"
>>  #include "exec/log.h"
>> +#include "exec/cpu-common.h"
>>  #include "qemu/error-report.h"
>>  #include "sysemu/sysemu.h"
>>  #include "hw/qdev-properties.h"
>> @@ -296,9 +297,7 @@ static void cpu_common_reset(CPUState *cpu)
>>              atomic_set(&cpu->tb_jmp_cache[i], NULL);
>>          }
>>
>> -#ifdef CONFIG_SOFTMMU
>> -        tlb_flush(cpu, 0);
>> -#endif
>> +        tcg_flush_softmmu_tlb(cpu);
>>      }
>>  }
>>
>> diff --git a/translate-all.c b/translate-all.c
>> index b3ee876..a45480f 100644
>> --- a/translate-all.c
>> +++ b/translate-all.c
>> @@ -2219,3 +2219,11 @@ int page_unprotect(target_ulong address, uintpt=
r_t pc)
>>      return 0;
>>  }
>>  #endif /* CONFIG_USER_ONLY */
>> +
>> +/* This is a wrapper for common code that can not use CONFIG_SOFTMMU =
*/
>> +void tcg_flush_softmmu_tlb(CPUState *cs)
>> +{
>> +#ifdef CONFIG_SOFTMMU
>> +    tlb_flush(cs);
>> +#endif
>> +}
>=20
> Don't you usually have a empty inline for the stub in the headers so th=
e
> non-SoftMMU build can optimize away rather than link to an empty functi=
on?

Optimizing reset doesn't seem worthwhile. :)

Paolo
