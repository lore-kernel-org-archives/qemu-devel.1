Received: from eggs.gnu.org ([2001:4830:134:3::10]:39356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fXIlX-0005dE-F5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 00:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fXIlW-0007aB-F8
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 00:06:11 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:38497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fXIlW-0007Zt-8M
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 00:06:10 -0400
Received: by mail-io0-x242.google.com with SMTP id l19-v6so11180701ioj.5
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 21:06:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Bx7b_0zUxbdxFgtANFycVkUiSiemAwHpr0wpyxuLKmw@mail.gmail.com>
References: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8Bx7b_0zUxbdxFgtANFycVkUiSiemAwHpr0wpyxuLKmw@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Mon, 25 Jun 2018 12:06:08 +0800
Message-ID: <CAHmQWvCczwh0Yto=9s2j7d00ULokZ0=VrxykAyXBvvHzQaUEMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix psci conduit in acpi when
 el3 enabled
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

Hi Peter,
Yes, your considerations reasonable.
But in practice of hardware platforms, programmer checks that Arm TF
is using SMC for PSCI call conduit, then fix it manually in the ACPI
table, reason may be that Arm TF is lack of ACPI support, if device
tree used, there should be no such thing because Arm TF can support
it.
On QEMU, I just mimic the situation, if a complete reasonable
solution, further efforts are needed to figure it out.

On 22 June 2018 at 18:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 June 2018 at 11:37, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> When QEMU_PSCI_CONDUIT_DISABLED is set, it doesn't mean all the PSCI
>> conduits are totally disabled, it only mean the QEMU built-in PSCI
>> support is disabled, in such a case, e.g. EL3 is enabled and external
>> firmware (it is usually Arm Trusted Firmware) is loaded, SMC should be
>> used for the guest to trigger PSCI functions.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>>  hw/arm/virt-acpi-build.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 74f5744..e5b4947 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -715,7 +715,11 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
>>
>>      switch (vms->psci_conduit) {
>>      case QEMU_PSCI_CONDUIT_DISABLED:
>> -        fadt.arm_boot_arch = 0;
>> +        /* This case means QEMU's internal EL3 implementation is disabled,
>> +         * but when firmware is loaded, the guest can still use SMC as PSCI
>> +         * conduit to call external firmware PSCI services
>> +         */
>> +        fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT;
>>          break;
>>      case QEMU_PSCI_CONDUIT_HVC:
>>          fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT |
>
> I think this means we end up reporting different things for ACPI
> and DT in this case, doesn't it?
>
> I think that if QEMU isn't providing the PSCI implementation it
> shouldn't advertise it in the ACPI tables. It would seem more
> logical that the firmware itself does that (QEMU can't know if
> it really does provide PSCI, after all...)
>
> thanks
> -- PMM
