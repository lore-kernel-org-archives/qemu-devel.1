Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1dOlv2-0007qp-8D
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 10:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1dOlv1-0004eJ-0g
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 10:20:12 -0400
MIME-Version: 1.0
In-Reply-To: <e90c5fb8-e68b-a620-9023-f4fcfdd68e97@redhat.com>
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
	<4dde45bb-a730-82b1-dc49-ad00a6b73d85@redhat.com>
	<accf8880-f4b0-85f1-9f33-4103c8c26d7a@redhat.com>
	<e90c5fb8-e68b-a620-9023-f4fcfdd68e97@redhat.com>
From: gengdongjiu <gengdj.1984@gmail.com>
Date: Sat, 24 Jun 2017 22:20:07 +0800
Message-ID: <CAMj-D2DvCXd9TLM5+6OT=aUN1fV3vt1Uyni0PDFQstJmf+HiRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>, mtsirkin@redhat.com, kvm@vger.kernel.org, tbaicar@codeaurora.org, qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu, ben@skyportsystems.com, linux@armlinux.org.uk, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, marc.zyngier@arm.com, qemu-arm@nongnu.org, imammedo@redhat.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, pbonzini@redhat.com

Laszlo,

  Thank you very much  for your carefully review again and again. I am
following your suggestion.


2017-06-03 20:01 GMT+08:00, Laszlo Ersek <lersek@redhat.com>:
> On 05/22/17 16:23, Laszlo Ersek wrote:
>> Keeping some context:
>>
>> On 05/12/17 23:00, Laszlo Ersek wrote:
>>> On 04/30/17 07:35, Dongjiu Geng wrote:
>
>> (68) In the code below, you are not taking an "OVMF header probe
>> suppressor" into account.
>>
>> But, we have already planned to replace that quirk with a separate,
>> dedicated allocation hint or command, so I'm not going to describe what
>> an "OVMF header probe suppressor" is; instead, I'll describe the
>> replacement for it.
>>
>> [...]
>
> So, the NOACPI allocation hint is a no-go at the moment, based on the
> discussion in the following threads:
>
> http://mid.mail-archive.com/20170601112241.2580-1-ard.biesheuvel@linaro.org
>
> http://mid.mail-archive.com/c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com
>
> Therefore the header probe suppression remains necessary.
>
> In this case, it is not hard to do, you just have to reorder the
> following two ADD_POINTER additions a bit:
>
>>>> +
>>>> +        bios_linker_loader_add_pointer(linker,
>>>> GHES_ERRORS_FW_CFG_FILE,
>>>> +                                sizeof(uint64_t) * i,
>>>> sizeof(uint64_t),
>>>> +                                GHES_ERRORS_FW_CFG_FILE,
>>>> +                                MAX_ERROR_SOURCE_COUNT_V6 *
>>>> sizeof(uint64_t) +
>>>> +                                i * MAX_RAW_DATA_LENGTH);
>
> This one should be moved out to a separate loop, after the current loop.
>
>>>> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>>> +                    address_registers_offset
>>>> +                    + i * sizeof(AcpiGenericHardwareErrorSource),
>>>> +                    sizeof(uint32_t), GHES_ERRORS_FW_CFG_FILE,
>>>> +                    i * sizeof(uint64_t));
>
> This one should be kept in the first (i.e., current) loop.
>
> The idea is, when you first point the HEST/GHES_n entries in
> ACPI_BUILD_TABLE_FILE to the "address registers" in
> GHES_ERRORS_FW_CFG_FILE, all those address registers will still be
> zero-filled. This will fail the ACPI table header probe in
> OvmfPkg/AcpiPlatformDxe, which is what we want.
>
> After this is done, the address registers in GHES_ERRORS_FW_CFG_FILE
> should be pointed to the error status data blocks in the same fw_cfg
> blob, in a separate loop. (Those error status data blocks will again be
> zero-filled, so no ACPI table headers will be mistakenly recognized in
> them.)
>
> Thanks
> Laszlo
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>
