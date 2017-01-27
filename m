Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6MI-0004tS-El
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6MH-0002Ky-8F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:14:30 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX6MH-0002Kq-3G
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:14:29 -0500
Received: by mail-vk0-x22f.google.com with SMTP id k127so174570105vke.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:14:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87bmusadr3.fsf@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-4-git-send-email-peter.maydell@linaro.org>
	<87bmusadr3.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:14:08 +0000
Message-ID: <CAFEAcA9huvBSMMpShBRMkbfhW_4pdyCJs=t2CUA18Gx_BAQj8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] armv7m: add state for v7M CCR, CFSR,
 HFSR, DFSR, MMFAR, BFAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Liviu Ionescu <ilg@livius.net>

On 27 January 2017 at 12:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Add the structure fields, VMState fields, reset code and macros for
>> the v7M system control registers CCR, CFSR, HFSR, DFSR, MMFAR and
>> BFAR.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.h     | 54 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  target/arm/cpu.c     |  7 +++++++
>>  target/arm/machine.c | 10 ++++++++--
>>  3 files changed, 69 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index b2cc329..4b062d2 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -21,6 +21,7 @@
>>  #define ARM_CPU_H
>>
>>  #include "kvm-consts.h"
>> +#include "hw/registerfields.h"
>>
>>  #if defined(TARGET_AARCH64)
>>    /* AArch64 definitions */
>> @@ -405,6 +406,12 @@ typedef struct CPUARMState {
>>          uint32_t vecbase;
>>          uint32_t basepri;
>>          uint32_t control;
>> +        uint32_t ccr; /* Configuration and Control */
>> +        uint32_t cfsr; /* Configurable Fault Status */
>> +        uint32_t hfsr; /* HardFault Status */
>> +        uint32_t dfsr; /* Debug Fault Status Register */
>> +        uint32_t mmfar; /* MemManage Fault Address */
>> +        uint32_t bfar; /* BusFault Address */
>
> Given the CPUARMState needs to be accessed via env do we need to start
> getting concerned about its size?

We only care that accesses to the front of it are within easy
reach (specifically, accesses to fields via frequently used
TCG globals); it doesn't matter if more things are added at
the end.

thanks
-- PMM
