Received: from eggs.gnu.org ([2001:4830:134:3::10]:40729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1etLsn-0001BN-9W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1etLsm-00027B-3a
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:20:33 -0500
MIME-Version: 1.0
In-Reply-To: <45793d45-f736-28ec-6346-0d8b4d4b8ed9@vivier.eu>
References: <20180306193418.28095-1-jcmvbkbc@gmail.com>
	<45793d45-f736-28ec-6346-0d8b4d4b8ed9@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 6 Mar 2018 15:20:30 -0800
Message-ID: <CAMo8BfL7ufC=vhVfO4AURr+66xKCJgPpTysrC3+P3x8U2UnkXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 05/11] linux-user: fix
 mmap/munmap/mprotect/mremap/shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Tue, Mar 6, 2018 at 1:40 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 06/03/2018 =C3=A0 20:34, Max Filippov a =C3=A9crit :
>> In linux-user QEMU that runs for a target with TARGET_ABI_BITS bigger
>> than L1_MAP_ADDR_SPACE_BITS an assertion in page_set_flags fires when
>> mmap, munmap, mprotect, mremap or shmat is called for an address outside
>> the guest address space. mmap and mprotect should return ENOMEM in such
>> case.
>>
>> Introduce macro guest_range_valid that verifies if address range is
>> within guest address space and does not wrap around. Use that macro in
>> mmap/munmap/mprotect/mremap/shmat for error checking.
>>
>> Cc: qemu-stable@nongnu.org
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>> Changes v3->v4:
>> - change GUEST_ADDR_MAX and h2g_valid definitions as suggested by Lauren=
t
>>   Vivier.
>>
>> Changes v2->v3:
>> - fix comparison in guest_valid: it must be 'less' to preserve the exist=
ing
>>   functionality, not 'less or equal'.
>> - fix guest_range_valid: it may not use guest_valid, because single rang=
e
>>   that occupies all of the guest address space is valid.
>>
>>  include/exec/cpu-all.h  |  4 ++++
>>  include/exec/cpu_ldst.h | 14 ++++++++------
>>  linux-user/mmap.c       | 20 +++++++++++++++-----
>>  linux-user/syscall.c    |  3 +++
>>  4 files changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index 0b141683f095..6304cfa7e171 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -159,8 +159,12 @@ extern unsigned long guest_base;
>>  extern int have_guest_base;
>>  extern unsigned long reserved_va;
>>
>> +#if HOST_LONG_BITS <=3D TARGET_VIRT_ADDR_SPACE_BITS
>> +#define GUEST_ADDR_MAX (reserved_va ? reserved_va : ~0ul)
>
> In fact, below, for h2g_valid(), reserved_va is ignored in this case, so
> it should be:
>
> #define GUEST_ADDR_MAX (~0ul)
>
> [I know, my bad]
>
>> +#else
>>  #define GUEST_ADDR_MAX (reserved_va ? reserved_va : \
>
> I think it should become "reserved_va ? reserved_va - 1 : \"
> as "reserved_va" is a size but GUEST_ADDR_MAX is the maximum value
> available. See below.

Agree.

>>                                      (1ul << TARGET_VIRT_ADDR_SPACE_BITS=
) - 1)
>> +#endif
>>  #else
>>
>>  #include "exec/hwaddr.h"
>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>> index 191f2e962a3c..22f5df9c8a92 100644
>> --- a/include/exec/cpu_ldst.h
>> +++ b/include/exec/cpu_ldst.h
>> @@ -52,15 +52,17 @@
>>  #define g2h(x) ((void *)((unsigned long)(target_ulong)(x) + guest_base)=
)
>>
>>  #if HOST_LONG_BITS <=3D TARGET_VIRT_ADDR_SPACE_BITS
>> -#define h2g_valid(x) 1
>> +#define guest_valid(x) 1
>>  #else
>> -#define h2g_valid(x) ({ \
>> -    unsigned long __guest =3D (unsigned long)(x) - guest_base; \
>> -    (__guest < (1ul << TARGET_VIRT_ADDR_SPACE_BITS)) && \
>> -    (!reserved_va || (__guest < reserved_va)); \
>> -})
>> +#define guest_valid(x) ((x) < GUEST_ADDR_MAX)
>
> I think it should be ((x) <=3D GUEST_ADDR_MAX), because
>
>     (__guest < (1ul << TARGET_VIRT_ADDR_SPACE_BITS))
> ->  (__guest <=3D ((1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
> ->  (__guest <=3D GUEST_ADDR_MAX)

Ok

> To work with reserved_va, it has also to be defined as "reserved_va -
> 1". And in open_self_maps() we should have "max =3D ... :
> (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;" and then we have a "h2g(max - 1)"
> that will correctly return GUEST_ADDR_MAX.

Ok

> Then you don't need the "#if" because if "HOST_LONG_BITS <=3D
> TARGET_VIRT_ADDR_SPACE_BITS", x is 32bit and GUEST_ADDR_MAX) is ~0uk,
> and then ((x) <=3D GUEST_ADDR_MAX) is always true.

Ok.

>>  #endif
>>
>> +#define h2g_valid(x) guest_valid((unsigned long)(x) - guest_base)
>> +
>> +#define guest_range_valid(start, len) \
>> +    ({unsigned long l =3D (len); \
>> +     l <=3D GUEST_ADDR_MAX && (start) <=3D GUEST_ADDR_MAX - l; })
>> +
>>  #define h2g_nocheck(x) ({ \
>>      unsigned long __ret =3D (unsigned long)(x) - guest_base; \
>>      (abi_ulong)__ret; \
> ...
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index e24f43c4a259..79245e73784f 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4900,6 +4900,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu=
_env,
>>              return -TARGET_EINVAL;
>>          }
>>      }
>> +    if (!guest_range_valid(shmaddr, shm_info.shm_segsz)) {
>
> if shmaddr is NULL, "the system chooses a suitable (unused) address" so
> you can't check this as is.

Why not? guest_range_valid will be true for shmaddr =3D=3D NULL and all
valid sizes.

--=20
Thanks.
-- Max
