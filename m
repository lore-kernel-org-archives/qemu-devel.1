Received: from eggs.gnu.org ([2001:4830:134:3::10]:46828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhhQ-0006wL-L6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhhP-0007tH-Pz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:00:40 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFhhP-0007sp-JA
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:00:39 -0400
Received: by mail-wr0-x234.google.com with SMTP id j27so1179575wre.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 07:00:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <82878b52-ee9d-e427-f1f3-d112c693cc49@amsat.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-6-git-send-email-peter.maydell@linaro.org>
	<82878b52-ee9d-e427-f1f3-d112c693cc49@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 15:00:15 +0100
Message-ID: <CAFEAcA94KvkXXzhnnhEKK=YswGc7qa7VGMwHZjuM2hXWAHXxvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/13] arm: Don't clear ARM_FEATURE_PMSA
 for no-mpu configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 13 May 2017 at 23:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> On 04/25/2017 09:07 AM, Peter Maydell wrote:
>>
>> Fix the handling of QOM properties for PMSA CPUs with no MPU:
>>
>> Allow no-MPU to be specified by either:
>>  * has-mpu =3D false
>>  * pmsav7_dregion =3D 0
>> and make setting one imply the other. Don't clear the PMSA
>> feature bit in this situation.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index f17e279..8e57498 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -757,8 +757,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or
>> **errp)
>>          cpu->id_pfr1 &=3D ~0xf000;
>>      }
>>
>> +    /* MPU can be configured out of a PMSA CPU either by setting has-mp=
u
>> +     * to false or by setting pmsav7-dregion to 0.
>> +     */
>>      if (!cpu->has_mpu) {
>> -        unset_feature(ARM_FEATURE_PMSA);
>
>
> Oh, fixed here.

Ah, yes, I was wondering why I hadn't noticed an obvious
compile error. I'll fix up patch 4 so we don't break bisection.

thanks
-- PMM
