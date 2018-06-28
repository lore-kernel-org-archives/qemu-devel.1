Received: from eggs.gnu.org ([2001:4830:134:3::10]:49356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYY5H-000295-JJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYY5E-0005Pz-Gd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:39:43 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYY5D-0005PG-V9
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:39:40 -0400
Received: by mail-wr0-x244.google.com with SMTP id p12-v6so5774846wrn.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:39:39 -0700 (PDT)
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-3-alex.bennee@linaro.org>
	<CAFEAcA8JHHp2oVvUqX0oGhc+R7u1PNCWW1Q052ujpTx9WbVNDw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8JHHp2oVvUqX0oGhc+R7u1PNCWW1Q052ujpTx9WbVNDw@mail.gmail.com>
Date: Thu, 28 Jun 2018 15:39:37 +0100
Message-ID: <87po0bug9i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: relax permission checks
 for HWCAP_CPUID registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 25 June 2018 at 17:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> Although technically not visible to userspace the kernel does make
>> them visible via trap and emulate. For user mode we can provide the
>> value directly but we need to relax our permission checks to do this.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/helper.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 6e6b1762e8..9d81feb124 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -5813,7 +5813,19 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cp=
u,
>>      if (r->state !=3D ARM_CP_STATE_AA32) {
>>          int mask =3D 0;
>>          switch (r->opc1) {
>> -        case 0: case 1: case 2:
>> +        case 0:
>> +#ifdef CONFIG_USER_ONLY
>> +            /* Some AArch64 CPU ID/feature are exported to userspace
>> +             * by the kernel (see HWCAP_CPUID) */
>> +            if (r->opc0 =3D=3D 3 && r->crn =3D=3D 0 &&
>> +                (r->crm =3D=3D 0 ||
>> +                 (r->crm >=3D 4 && r->crm <=3D 7))) {
>> +                mask =3D PL0_R;
>> +                break;
>> +            }
>> +#endif
>> +            /* fall-through */
>> +        case 1: case 2:
>>              /* min_EL EL1 */
>>              mask =3D PL1_RW;
>>              break;
>
> This looks like a rather inelegant place to shove a CONFIG_USER_ONLY
> special case. Isn't there a cleaner way to do whatever this is trying
> to achieve?

Well technically those registers aren't accessible to user space and
this is a sanity check to ensure we don't accidentally make them
accessible. But it does get in the way of emulating the traps for
USER_ONLY.


>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
