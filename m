Received: from eggs.gnu.org ([2001:4830:134:3::10]:43179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dTOhC-0000dS-W4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dTOhB-00061s-O6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:33:03 -0400
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
	<4dde45bb-a730-82b1-dc49-ad00a6b73d85@redhat.com>
	<accf8880-f4b0-85f1-9f33-4103c8c26d7a@redhat.com>
	<e90c5fb8-e68b-a620-9023-f4fcfdd68e97@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <dbbab7f6-18c4-9b6c-799e-8267797a31bd@huawei.com>
Date: Fri, 7 Jul 2017 16:32:09 +0800
MIME-Version: 1.0
In-Reply-To: <e90c5fb8-e68b-a620-9023-f4fcfdd68e97@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, mtsirkin@redhat.com, kvm@vger.kernel.org, rkrcmar@redhat.com, tbaicar@codeaurora.org, qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu, ben@skyportsystems.com, linux@armlinux.org.uk, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, zhaoshenglong@huawei.com, songwenjun@huawei.com, drjones@redhat.com, wuquanming@huawei.com, xiexiuqi@huawei.com, marc.zyngier@arm.com, qemu-arm@nongnu.org, imammedo@redhat.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, james.morse@arm.com, pbonzini@redhat.com, christoffer.dall@linaro.org

Hi Laszlo,
   sorry for my late response.

On 2017/6/3 20:01, Laszlo Ersek wrote:
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
 Ok, it is no problem.

> 
>>>> +
>>>> +        bios_linker_loader_add_pointer(linker, GHES_ERRORS_FW_CFG_FILE,
>>>> +                                sizeof(uint64_t) * i, sizeof(uint64_t),
>>>> +                                GHES_ERRORS_FW_CFG_FILE,
>>>> +                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
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
I understand your idear. but I have a question:
how about we exchange the two function's place, such as shown below:
then it still meets ours needs, the change is easy.
For every loop:
(1)when patch address in ACPI_BUILD_TABLE_FILE to the "address registers", the address register is zero-filed.
(2)when patch address in GHES_ERRORS_FW_CFG_FILE to the error status data blocks, the error status data block is still zero-filed.

    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++) {
        .....................................
        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                    address_registers_offset
                    + i * sizeof(AcpiGenericHardwareErrorSource),
                    sizeof(uint32_t), GHES_ERRORS_FW_CFG_FILE,
                    i * sizeof(uint64_t));


        bios_linker_loader_add_pointer(linker, GHES_ERRORS_FW_CFG_FILE,
                                sizeof(uint64_t) * i, sizeof(uint64_t),
                                GHES_ERRORS_FW_CFG_FILE,
                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
                                i * MAX_RAW_DATA_LENGTH);
	.........................................

     }

thanks

> 
> Thanks
> Laszlo
> 
> 
> .
> 
