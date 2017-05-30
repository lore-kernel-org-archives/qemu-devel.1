Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFioP-0007vQ-Jz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFioO-00072N-Bl
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:11:57 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFioO-00071v-28
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:11:56 -0400
Received: by mail-wm0-x22b.google.com with SMTP id d127so100724267wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:11:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c9954451-ad9b-2365-5ed7-bc4c29f40abe@amsat.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-10-git-send-email-peter.maydell@linaro.org>
	<c9954451-ad9b-2365-5ed7-bc4c29f40abe@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 16:11:34 +0100
Message-ID: <CAFEAcA8aAwM-_9h1L23kjmfoabvivYdbKcC5e6YEkMXyUfTt5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/13] armv7m: Implement M
 profile default memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "patches@linaro.org" <patches@linaro.org>

On 30 May 2017 at 15:56, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Hi Peter,
>
> On 04/25/2017 09:07 AM, Peter Maydell wrote:
>>
>> From: Michael Davidsaver <mdavidsaver@gmail.com>
>>
>> Add support for the M profile default memory map which is used
>> if the MPU is not present or disabled.
>>
>> The main differences in behaviour from implementing this
>> correctly are that we set the PAGE_EXEC attribute on
>> the right regions of memory, such that device regions
>> are not executable.
>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>> [PMM: rephrased comment and commit message; don't mark
>>  the flash memory region as not-writable]
>
>
> "not-writable by system caches" maybe to clarify?

(Note that this is a comment describing something I
deleted from Michael's original patch.)
No, by 'not-writable' here I mean "not writeable by the CPU".

>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/helper.c | 35 ++++++++++++++++++++++++++---------
>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 9e1ed1c..51662ad 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -8129,18 +8129,35 @@ static inline void
>> get_phys_addr_pmsav7_default(CPUARMState *env,
>>                                                  ARMMMUIdx mmu_idx,
>>                                                  int32_t address, int
>> *prot)
>>  {
>> -    *prot =3D PAGE_READ | PAGE_WRITE;
>> -    switch (address) {
>> -    case 0xF0000000 ... 0xFFFFFFFF:
>> -        if (regime_sctlr(env, mmu_idx) & SCTLR_V) { /* hivecs execing i=
s
>> ok */
>> +    if (!arm_feature(env, ARM_FEATURE_M)) {
>> +        *prot =3D PAGE_READ | PAGE_WRITE;
>> +        switch (address) {
>> +        case 0xF0000000 ... 0xFFFFFFFF:
>> +            if (regime_sctlr(env, mmu_idx) & SCTLR_V) {
>> +                /* hivecs execing is ok */
>> +                *prot |=3D PAGE_EXEC;
>> +            }
>> +            break;
>> +        case 0x00000000 ... 0x7FFFFFFF:
>
>>              *prot |=3D PAGE_EXEC;
>
> I checked at Table B3-1 on the ARMv7-M Architecture Reference Manual I go=
t
> at https://static.docs.arm.com/ddi0403/e/DDI0403E_B_armv7m_arm.pdf and th=
e
> on-chip peripheral address space at 0x40000000 is eXecute Never.

This is the arm of the if() that deals with R profile, and R profile's
background region is completely different to M profile. (In any
case the patch shouldn't change the behaviour there.)

>> +            break;
>> +        }
>> +    } else {
>> +        /* Default system address map for M profile cores.
>> +         * The architecture specifies which regions are execute-never;
>> +         * at the MPU level no other checks are defined.
>> +         */
>> +        switch (address) {
>> +        case 0x00000000 ... 0x1fffffff: /* ROM */
>> +        case 0x20000000 ... 0x3fffffff: /* SRAM */
>> +        case 0x60000000 ... 0x7fffffff: /* RAM */
>> +        case 0x80000000 ... 0x9fffffff: /* RAM */
>> +            *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>> +            break;
>> +        default: /* Peripheral, 2x Device, and System */
>> +            *prot =3D PAGE_READ | PAGE_WRITE;
>
>
> This body is correct, however what do you think about using cases with
> comments instead of 'default'? This would be clearer.

Yeah, we could do that. I think this is one of those cases where
I opted to go with how Michael had already written the code rather
than rewriting it.

        /* Default system address map for M profile cores.
         * The architecture specifies which regions are execute-never;
         * at the MPU level no other checks are defined.
         */
        switch (address) {
        case 0x00000000 ... 0x1fffffff: /* ROM */
        case 0x20000000 ... 0x3fffffff: /* SRAM */
        case 0x60000000 ... 0x7fffffff: /* RAM */
        case 0x80000000 ... 0x9fffffff: /* RAM */
            *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
            break;
        case 0x40000000 ... 0x5fffffff: /* Peripheral */
        case 0xa0000000 ... 0xbfffffff: /* Device */
        case 0xc0000000 ... 0xdfffffff: /* Device */
        case 0xe0000000 ... 0xffffffff: /* System */
            *prot =3D PAGE_READ | PAGE_WRITE;
            break;
        default:
            g_assert_not_reached();
        }

would be the explicit version.

>>          }
>> -        break;
>> -    case 0x00000000 ... 0x7FFFFFFF:
>> -        *prot |=3D PAGE_EXEC;
>> -        break;
>>      }
>> -
>>  }
>>
>>  static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,

thanks
-- PMM
