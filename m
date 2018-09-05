Received: from eggs.gnu.org ([2001:4830:134:3::10]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxPYw-0004ad-Gm
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fxPYs-00084Z-AS
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40426 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fxPYr-0007z2-Rn
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 00:37:02 -0400
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-4-fli@suse.com>
	<20180904112246.GF22349@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <638586ca-7cb2-4a60-e88c-eaf0bdee361d@suse.com>
Date: Wed, 5 Sep 2018 12:36:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180904112246.GF22349@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu_init_vcpu: add a new Error
 paramater to propagate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org



On 09/04/2018 07:22 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 04, 2018 at 07:08:20PM +0800, Fei Li wrote:
>> The caller of qemu_init_vcpu() already passed the **errp to handle
>> errors. In view of this, add a new Error parameter to the following
>> call trace to propagate the error and let the final caller check it.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   cpus.c                          | 32 +++++++++++++++++++------------=
-
>>   include/qom/cpu.h               |  2 +-
>>   target/alpha/cpu.c              |  6 +++++-
>>   target/arm/cpu.c                |  6 +++++-
>>   target/cris/cpu.c               |  6 +++++-
>>   target/hppa/cpu.c               |  6 +++++-
>>   target/i386/cpu.c               |  6 +++++-
>>   target/lm32/cpu.c               |  6 +++++-
>>   target/m68k/cpu.c               |  6 +++++-
>>   target/microblaze/cpu.c         |  6 +++++-
>>   target/mips/cpu.c               |  6 +++++-
>>   target/moxie/cpu.c              |  6 +++++-
>>   target/nios2/cpu.c              |  6 +++++-
>>   target/openrisc/cpu.c           |  6 +++++-
>>   target/ppc/translate_init.inc.c |  6 +++++-
>>   target/riscv/cpu.c              |  6 +++++-
>>   target/s390x/cpu.c              |  5 ++++-
>>   target/sh4/cpu.c                |  6 +++++-
>>   target/sparc/cpu.c              |  6 +++++-
>>   target/tilegx/cpu.c             |  6 +++++-
>>   target/tricore/cpu.c            |  6 +++++-
>>   target/unicore32/cpu.c          |  6 +++++-
>>   target/xtensa/cpu.c             |  6 +++++-
>>   23 files changed, 124 insertions(+), 35 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 8ee6e5db93..41efddc218 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1898,7 +1898,7 @@ void cpu_remove_sync(CPUState *cpu)
>>   /* For temporary buffers for forming a name */
>>   #define VCPU_THREAD_NAME_SIZE 16
>>  =20
>> -static void qemu_tcg_init_vcpu(CPUState *cpu)
>> +static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       char thread_name[VCPU_THREAD_NAME_SIZE];
>>       static QemuCond *single_tcg_halt_cond;
>> @@ -1954,7 +1954,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>>       }
>>   }
>>  =20
>> -static void qemu_hax_start_vcpu(CPUState *cpu)
>> +static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       char thread_name[VCPU_THREAD_NAME_SIZE];
>>  =20
>> @@ -1971,7 +1971,7 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
>>   #endif
>>   }
>>  =20
>> -static void qemu_kvm_start_vcpu(CPUState *cpu)
>> +static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       char thread_name[VCPU_THREAD_NAME_SIZE];
>>  =20
>> @@ -1984,7 +1984,7 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
>>                          cpu, QEMU_THREAD_JOINABLE);
>>   }
>>  =20
>> -static void qemu_hvf_start_vcpu(CPUState *cpu)
>> +static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       char thread_name[VCPU_THREAD_NAME_SIZE];
>>  =20
>> @@ -2002,7 +2002,7 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
>>                          cpu, QEMU_THREAD_JOINABLE);
>>   }
>>  =20
>> -static void qemu_whpx_start_vcpu(CPUState *cpu)
>> +static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       char thread_name[VCPU_THREAD_NAME_SIZE];
>>  =20
>> @@ -2018,7 +2018,7 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
>>   #endif
>>   }
>>  =20
>> -static void qemu_dummy_start_vcpu(CPUState *cpu)
>> +static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       char thread_name[VCPU_THREAD_NAME_SIZE];
>>  =20
>> @@ -2031,11 +2031,12 @@ static void qemu_dummy_start_vcpu(CPUState *cp=
u)
>>                          QEMU_THREAD_JOINABLE);
>>   }
>>  =20
>> -void qemu_init_vcpu(CPUState *cpu)
>> +void qemu_init_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       cpu->nr_cores =3D smp_cores;
>>       cpu->nr_threads =3D smp_threads;
>>       cpu->stopped =3D true;
>> +    Error *local_err =3D NULL;
>>  =20
>>       if (!cpu->as) {
>>           /* If the target cpu hasn't set up any address spaces itself=
,
>> @@ -2046,17 +2047,22 @@ void qemu_init_vcpu(CPUState *cpu)
>>       }
>>  =20
>>       if (kvm_enabled()) {
>> -        qemu_kvm_start_vcpu(cpu);
>> +        qemu_kvm_start_vcpu(cpu, &local_err);
>>       } else if (hax_enabled()) {
>> -        qemu_hax_start_vcpu(cpu);
>> +        qemu_hax_start_vcpu(cpu, &local_err);
>>       } else if (hvf_enabled()) {
>> -        qemu_hvf_start_vcpu(cpu);
>> +        qemu_hvf_start_vcpu(cpu, &local_err);
>>       } else if (tcg_enabled()) {
>> -        qemu_tcg_init_vcpu(cpu);
>> +        qemu_tcg_init_vcpu(cpu, &local_err);
>>       } else if (whpx_enabled()) {
>> -        qemu_whpx_start_vcpu(cpu);
>> +        qemu_whpx_start_vcpu(cpu, &local_err);
>>       } else {
>> -        qemu_dummy_start_vcpu(cpu);
>> +        qemu_dummy_start_vcpu(cpu, &local_err);
>> +    }
>> +
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>>       }
> I'd be inclined to make this method return a boolean, so....
>
>
>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>> index b08078e7fc..5b0b4892f2 100644
>> --- a/target/alpha/cpu.c
>> +++ b/target/alpha/cpu.c
>> @@ -66,7 +66,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>>           return;
>>       }
>>  =20
>> -    qemu_init_vcpu(cs);
>> +    qemu_init_vcpu(cs, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
> ...this can be simplified to get rid of the local error object
Emm, for these arch_cpu_realizefn() functions, I notice they already=20
have the local_err
and use error_propagate to handle the error. I guess the reason is what=20
I explained in
patch1: considering their initial caller passes the &error_fatal, then=20
just propagate and
let the further caller handle such error instead of exit() here.
So maybe just keep their tradition here?

Have a nice day, thanks
Fei
>
>    if (!qemu_init_vcpu(cs, errp)) {
>        return;
>    }
>
> likewise for the rest of the patch below...
>
>
> Regards,
> Daniel
