Received: from eggs.gnu.org ([2001:4830:134:3::10]:49424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dWxsj-0003U6-Ve
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dWxsi-0001KG-Vj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:43:42 -0400
References: <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com>
	<1499825297-20335-3-git-send-email-gengdongjiu@huawei.com>
	<20170713201407-mutt-send-email-mst@kernel.org>
	<660d600a-107c-e44a-7322-ae4a74bc5565@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <eb1be690-8ce7-1cbd-069d-36116eeeff93@huawei.com>
Date: Mon, 17 Jul 2017 12:43:05 +0800
MIME-Version: 1.0
In-Reply-To: <660d600a-107c-e44a-7322-ae4a74bc5565@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, james.morse@arm.com, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

Laszlo,
  Thanks for the comments.

On 2017/7/14 3:41, Laszlo Ersek wrote:
snip

> 
> snip
> 
>>> +
>>> +    error_source_table = (AcpiHardwareErrorSourceTable *)(table_data->data
>>> +                        + table_data->len - buffer->len);
>>> +    error_source_table->error_source_count = GHES_ACPI_HEST_NOTIFY_RESERVED;
>>> +    error_source = (AcpiGenericHardwareErrorSource *)
>>> +        ((AcpiHardwareErrorSourceTable *)error_source_table + 1);
>>
>> Concern with all these casts and pointer math is that it is barely readable.
>> We can easily overflow the array and get hard to debug heap corruption
>> errors.
>>
>> What can I suggest?  Just add this to the array in steps. Then you will
>> not need all the math.
>>
>> Or again, you can just add things as you init them using build_append_int_noprefix.
>>
>>
>>> +
>>> +    bios_linker_loader_write_pointer(linker, GHES_DATA_ADDR_FW_CFG_FILE,
>>> +        0, sizeof(uint64_t), GHES_ERRORS_FW_CFG_FILE,
>>> +        GHES_ACPI_HEST_NOTIFY_RESERVED * sizeof(uint64_t));
>>
>> What does this uint64_t refer to? It's repeated everywhere.
>>
>>> +
>>> +    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++) {
>>> +        error_source->type = ACPI_HEST_SOURCE_GENERIC_ERROR;
>>> +        error_source->source_id = cpu_to_le16(i);
>>> +        error_source->related_source_id = 0xffff;
>>> +        error_source->flags = 0;
>>> +        error_source->enabled = 1;
>>> +        /* The number of error status block per Generic Hardware Error Source */
>>
>> number of ... blocks ?
>>
>>> +        error_source->number_of_records = 1;
>>> +        error_source->max_sections_per_record = 1;
>>> +        error_source->max_raw_data_length = GHES_MAX_RAW_DATA_LENGTH;
>>> +        error_source->error_status_address.space_id =
>>> +                                    AML_SYSTEM_MEMORY;
>>> +        error_source->error_status_address.bit_width = 64;
>>> +        error_source->error_status_address.bit_offset = 0;
>>> +        error_source->error_status_address.access_width = 4;
>>> +        error_source->notify.type = i;
>>> +        error_source->notify.length = sizeof(AcpiHestNotify);
>>> +
>>> +        error_source->error_status_block_length = GHES_MAX_RAW_DATA_LENGTH;
>>> +
>>> +        bios_linker_loader_add_pointer(linker,
>>> +            ACPI_BUILD_TABLE_FILE, address_registers_offset + i *
>>> +            sizeof(AcpiGenericHardwareErrorSource), sizeof(uint64_t),
>>> +            GHES_ERRORS_FW_CFG_FILE, i * sizeof(uint64_t));
>>
>> and what's this math for?
>>
>>> +
>>> +        error_source++;
>>> +    }
>>> +
>>> +    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++) {
>>> +        bios_linker_loader_add_pointer(linker,
>>> +            GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i, sizeof(uint64_t),
>>> +            GHES_ERRORS_FW_CFG_FILE, GHES_ACPI_HEST_NOTIFY_RESERVED *
>>> +            sizeof(uint64_t) + i * GHES_MAX_RAW_DATA_LENGTH);
>>> +    }
> 
> So basically all this math exists to set up the pointers that are shown
> in the diagram in the commit message. It is a bit tricky because most of
> those pointer fields (all 8-bytes wide) are individually embedded into
> their own containing structures. In the previous version of this patch
> set, I painstakingly verified the math, and pointed out wherever I
> thought updates were necessary.
Laszlo, you are right. it is indeed a bit tricky. Michael also has a concern
about it. I am changing to make it clear

> 
> I agree the math is hard to read, the code is very "dense". My
> suggestion (supporting yours) would be to calculate the fw_cfg blob
> offsets that should be patched in more fine-grained steps, possibly with
> multiple separate increments, using:
> - structure type names,
> - sizeof operators,
> - offsetof macros,
> - and possibly a separate comment for each offset increment.
good suggestion. I will follow that.

> 
> Thanks,
> Laszlo
> 
> .
> 
