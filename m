Received: from eggs.gnu.org ([2001:4830:134:3::10]:35298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8649-0001TO-P0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f8646-00058u-KR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:29:13 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f8646-00058T-Ck
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:29:10 -0400
Received: by mail-wr0-x241.google.com with SMTP id z73so27227469wrb.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:29:10 -0700 (PDT)
References: <20180416140322.904-1-alex.bennee@linaro.org>
	<CAFEAcA-1GVMOSJVQ5p8+qpo8P-+fBq0-6TaA2mdvLDbk3fiihg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-1GVMOSJVQ5p8+qpo8P-+fBq0-6TaA2mdvLDbk3fiihg@mail.gmail.com>
Date: Mon, 16 Apr 2018 16:29:07 +0100
Message-ID: <874lkbb264.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: support reading of
 CNTVCT_EL0 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, takeharu.kato@linaro.org, Renato Golin <renato.golin@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 16 April 2018 at 15:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>> Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
>> trap..) user-space has been able to read this system register. This
>> patch enables access to that register although currently it always
>> returns 0 as we don't yet have a mechanism for managing timers in
>> linux-user mode.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/helper.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index b14fdab140..8244badd63 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2121,11 +2121,25 @@ static const ARMCPRegInfo generic_timer_cp_regin=
fo[] =3D {
>>  };
>>
>>  #else
>> -/* In user-mode none of the generic timer registers are accessible,
>> - * and their implementation depends on QEMU_CLOCK_VIRTUAL and qdev gpio=
 outputs,
>> - * so instead just don't register any of them.
>> +
>> +/* In user-mode most of the generic timer registers are inaccessible
>> + * however modern kernels (4.12+) allow access to cntvct_el0
>>   */
>> +
>> +static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *=
ri)
>> +{
>> +    /* Currently we have no support for QEMUTimer in linux-user so we
>> +     * can't call gt_get_countervalue(env).
>> +     */
>> +    return 0;
>> +}
>> +
>>  static const ARMCPRegInfo generic_timer_cp_reginfo[] =3D {
>> +    { .name =3D "CNTVCT_EL0", .state =3D ARM_CP_STATE_AA64,
>> +      .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 2,
>> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
>> +      .readfn =3D gt_virt_cnt_read,
>> +    },
>>      REGINFO_SENTINEL
>>  };
>
> CNTVCT_EL0 isn't much use without CNTFRQ_EL0 which tells
> you how fast it ticks...

I've added it but of course:

    /* Note that CNTFRQ is purely reads-as-written for the benefit
     * of software; writing it doesn't actually change the timer frequency.
     * Our reset value matches the fixed frequency we implement the timer a=
t.
     */

So it's not like we do anything with it internally. I assume in real
life you could mess with this but still have a monotonically increasing
counter.

>
> It looks like other targets use cpu_get_host_ticks() for an
> arbitrary time-counter thingy. Not sure you can get the frequency
> for it, though :-(

Hmm I've just used:

  return cpu_get_clock()/GTIMER_SCALE;

For now....

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
