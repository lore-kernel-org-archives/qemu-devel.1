Received: from eggs.gnu.org ([2001:4830:134:3::10]:60717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef6Yh-0007bQ-UI
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef6Yg-0005b9-VZ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:08:55 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef6Yg-0005b1-QV
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:08:54 -0500
Received: by mail-oi0-x243.google.com with SMTP id l8so627967oig.0
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:08:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d8c2c2ca-5046-f19b-9514-d3cbef3b7c3a@amsat.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<1512670493-18114-5-git-send-email-peter.maydell@linaro.org>
	<d8c2c2ca-5046-f19b-9514-d3cbef3b7c3a@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 14:33:21 +0000
Message-ID: <CAFEAcA9k2KKrXk+2LQd+X7-RFuDQO96bYSo8xi81zfb80+ApFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 26 January 2018 at 14:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Peter,
>
> On 12/07/2017 03:14 PM, Peter Maydell wrote:
>> Add support for "-cpu max" for ARM guests. This CPU type behaves
>> like "-cpu host" when KVM is enabled, and like a system CPU with
>> the maximum possible feature set otherwise. (Note that this means
>> it won't be migratable across versions, as we will likely add
>> features to it in future.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---

>> +#ifndef TARGET_AARCH64
>> +/* -cpu max: if KVM is enabled, like -cpu host (best possible with this=
 host);
>> + * otherwise, a CPU with as many features enabled as our emulation supp=
orts.
>> + * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu6=
4.c;
>> + * this only needs to handle 32 bits.
>> + */
>> +static void arm_max_initfn(Object *obj)
>> +{
>> +    ARMCPU *cpu =3D ARM_CPU(obj);
>> +
>> +    if (kvm_enabled()) {
>> +        kvm_arm_set_cpu_features_from_host(cpu);
>> +    } else {
>> +        cortex_a15_initfn(obj);> +        /* In future we might add fea=
ture bits here even if the
>> +         * real-world A15 doesn't implement them.
>> +         */
>
> Why not use arm_any_initfn() here?

That function (and the 'any' cpu) are deliberately only
included in the linux-user binaries, not the system-emulation binaries.
(Also arm_any_initfn() only initializes userspace-visible stuff, it
doesn't provide ID register values etc for kernel-visible things.)

> Actually what seems cleaner is to move "any" features here, and kill the
> "any" cpu, using "max" for this purpose.

We can't kill 'any', that would break back-compatibility
of command lines.

thanks
-- PMM
