Received: from eggs.gnu.org ([2001:4830:134:3::10]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9V0y-00057N-3Q
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9V0x-0004Lq-7y
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:47:28 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:53909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9V0w-0004Kp-Vv
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:47:27 -0400
Received: by mail-wr0-x242.google.com with SMTP id u40so15623743wrf.10
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 04:47:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zXAmNPL8TsLKSPbm8Er_KLK8Ubwth6=nL6WD87OmBQw@mail.gmail.com>
References: <alpine.DEB.2.10.1710171708130.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA9zXAmNPL8TsLKSPbm8Er_KLK8Ubwth6=nL6WD87OmBQw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 11:47:04 +0000
Message-ID: <CAFEAcA8jwN81ZBCLA8HW=q5GAWKmZ=kAZAP9vGNN8RYkzYe=Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] aarch64: advertise the GIC system register
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, julien.grall@arm.com, qemu-arm <qemu-arm@nongnu.org>

On 19 October 2017 at 15:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 October 2017 at 01:10, Stefano Stabellini <sstabellini@kernel.org> wrote:
>> Advertise the presence of the GIC system register interface (1<<24)
>> according to H9.248 of the ARM ARM.
>>
>> This patch allows Xen to boot on QEMU aarch64.
>>
>> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 670c07a..a451763 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -136,7 +136,7 @@ static void aarch64_a57_initfn(Object *obj)
>>      cpu->id_isar3 = 0x01112131;
>>      cpu->id_isar4 = 0x00011142;
>>      cpu->id_isar5 = 0x00011121;
>> -    cpu->id_aa64pfr0 = 0x00002222;
>> +    cpu->id_aa64pfr0 = 0x01002222;
>>      cpu->id_aa64dfr0 = 0x10305106;
>>      cpu->pmceid0 = 0x00000000;
>>      cpu->pmceid1 = 0x00000000;
>> @@ -196,7 +196,7 @@ static void aarch64_a53_initfn(Object *obj)
>>      cpu->id_isar3 = 0x01112131;
>>      cpu->id_isar4 = 0x00011142;
>>      cpu->id_isar5 = 0x00011121;
>> -    cpu->id_aa64pfr0 = 0x00002222;
>> +    cpu->id_aa64pfr0 = 0x01002222;
>>      cpu->id_aa64dfr0 = 0x10305106;
>>      cpu->id_aa64isar0 = 0x00011120;
>>      cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
>
> Whoops -- we missed this when we added the GICv3 support, because
> Linux doesn't check it.
>
> Applied to target-arm.next, thanks.

Unfortunately I've just noticed that this breaks booting Linux
in the "not using gicv3" case. This is because we don't actually
define the GICv3 cpu interface registers unless the board
instantiates a GICv3. We mustn't advertise the GICv3 sysregs
in the ID register unless we actually have them.

Not sure how best to fix this -- it's a consequence of the
design decision we made to have the sysregs implementation
be in the gicv3 code. There's no useful feature bit in the CPU
to hang this off either, it's an effect of whether the board
model happens to wire up a gicv3 or not. So we can only figure
this out fairly late on (probably at CPU reset time), which
is a bit tedious for getting ID reg values right.

In the meantime I've dropped this patch from target-arm.next.

thanks
-- PMM
