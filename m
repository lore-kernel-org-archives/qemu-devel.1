Received: from eggs.gnu.org ([2001:4830:134:3::10]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMUlg-00065Q-N2
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMUgc-00047Y-DE
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:08:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gMUgb-00042T-F3
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:08:41 -0500
References: <20180629145347.652-1-peter.maydell@linaro.org>
	<20180629145347.652-41-peter.maydell@linaro.org>
	<e8d62bcd-f8a9-2a6a-7765-0cf69cc8c1b5@redhat.com>
	<87d0radjx1.fsf@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <60ae3ee3-6b16-66e6-3981-73f310023e55@redhat.com>
Date: Tue, 13 Nov 2018 10:08:35 +0100
MIME-Version: 1.0
In-Reply-To: <87d0radjx1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 40/55] target/arm: Enable SVE for
 aarch64-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On 12/11/2018 23:12, Alex Benn=C3=A9e wrote:
>=20
> Laurent Vivier <lvivier@redhat.com> writes:
>=20
>> On 29/06/2018 16:53, Peter Maydell wrote:
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> Enable ARM_FEATURE_SVE for the generic "max" cpu.
>>>
>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-id: 20180627043328.11531-35-richard.henderson@linaro.org
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  linux-user/elfload.c | 1 +
>>>  target/arm/cpu.c     | 7 +++++++
>>>  target/arm/cpu64.c   | 1 +
>>>  3 files changed, 9 insertions(+)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index 13bc78d0c86..d1231ad07a3 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -584,6 +584,7 @@ static uint32_t get_elf_hwcap(void)
>>>      GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
>>>      GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
>>>      GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
>>> +    GET_FEATURE(ARM_FEATURE_SVE, ARM_HWCAP_A64_SVE);
>>>  #undef GET_FEATURE
>>>
>>>      return hwcaps;
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 2ae4fffafb9..6dcc552e143 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -164,6 +164,13 @@ static void arm_cpu_reset(CPUState *s)
>>>          env->cp15.sctlr_el[1] |=3D SCTLR_UCT | SCTLR_UCI | SCTLR_DZE=
;
>>>          /* and to the FP/Neon instructions */
>>>          env->cp15.cpacr_el1 =3D deposit64(env->cp15.cpacr_el1, 20, 2=
, 3);
>>> +        /* and to the SVE instructions */
>>> +        env->cp15.cpacr_el1 =3D deposit64(env->cp15.cpacr_el1, 16, 2=
, 3);
>>> +        env->cp15.cptr_el[3] |=3D CPTR_EZ;
>>> +        /* with maximum vector length */
>>> +        env->vfp.zcr_el[1] =3D ARM_MAX_VQ - 1;
>>> +        env->vfp.zcr_el[2] =3D ARM_MAX_VQ - 1;
>>> +        env->vfp.zcr_el[3] =3D ARM_MAX_VQ - 1;
>>>  #else
>>>          /* Reset into the highest available EL */
>>>          if (arm_feature(env, ARM_FEATURE_EL3)) {
>>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>>> index c50dcd4077d..0360d7efc5e 100644
>>> --- a/target/arm/cpu64.c
>>> +++ b/target/arm/cpu64.c
>>> @@ -252,6 +252,7 @@ static void aarch64_max_initfn(Object *obj)
>>>          set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>>>          set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>>>          set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>>> +        set_feature(&cpu->env, ARM_FEATURE_SVE);
>>>          /* For usermode -cpu max we can use a larger and more effici=
ent DCZ
>>>           * blocksize since we don't have to follow what the hardware=
 does.
>>>           */
>>>
>>
>> Running some tests for my pull request, I've found this commit breaks
>> ltp-full-20180515 sigaltstack01 tests with ubuntu arm64/trusty.
>>
>> sigaltstack01  274  TBROK  :  tst_sig.c:233: unexpected signal
>> SIGIOT/SIGABRT(6) received (pid =3D 15241).
>> *** Error in `/opt/ltp/testcases/bin/sigaltstack01': free(): invalid
>> pointer: 0x000000000042a010 ***
>=20
> I wonder if that is the test case not handling the full frame size (or
> us not checking the allocated size). What syscall or signal delivery wa=
s
> happening at the time?
>=20

The signal is an abort() triggered by the libc.

But I think the first problem happens because memory is corrupted: it=20
crashes in the cleanup() function when the test is over and the memory=20
is freed.

#4149 <signal handler called>
#4150 __GI_abort () at abort.c:91
#4151 0x00000040008a1448 in __libc_message (do_abort=3D1,=20
    fmt=3Dfmt@entry=3D0x4000950cb0 "*** Error in `%s': %s: 0x%s ***\n")
    at ../sysdeps/posix/libc_fatal.c:175
#4152 0x00000040008ab71c in malloc_printerr (action=3D1,=20
    str=3D0x4000950ed8 "free(): invalid pointer", ptr=3D<optimized out>)
    at malloc.c:4996
#4153 0x00000040008ac4f4 in _int_free (av=3D0x400097a560 <main_arena>,=20
    p=3D<optimized out>, have_lock=3D0) at malloc.c:3840
#4154 0x0000000000403340 in cleanup () at sigaltstack01.c:236
#4155 main (ac=3D<optimized out>, av=3D<optimized out>) at sigaltstack01.=
c:165

    233 void cleanup(void)
    234 {
    235=20
    236         free(sigstk.ss_sp);
    237=20
    238 }

Thanks,
Laurent
