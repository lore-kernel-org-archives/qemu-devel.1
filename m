Received: from eggs.gnu.org ([2001:4830:134:3::10]:41491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cwQeI-0001me-6T
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cwQeF-0004KS-0m
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cwQeE-0004K2-Oc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:57:42 -0400
References: <20170406212209.22788-1-ard.biesheuvel@linaro.org>
	<20170407085513.czs6tsbwhkecfjrq@kamzik.brq.redhat.com>
	<64d6ad1d-d9ce-2bbb-dfb9-35938f9593ec@redhat.com>
	<CAAibmn3D_vWCv0HwZ607ejESDEnf2i5QVZTfJBM29hRgqqdu_A@mail.gmail.com>
	<CAKv+Gu8aRUOSvne8B=Uk1g7QByyNeNOY1o-A7ap_L1dqeOG5_g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fbb22baa-4d6f-63ca-cf49-bfdfc2bdc712@redhat.com>
Date: Fri, 7 Apr 2017 11:57:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8aRUOSvne8B=Uk1g7QByyNeNOY1o-A7ap_L1dqeOG5_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: generate 64-bit addressable
 ACPI objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>

On 04/07/17 11:44, Ard Biesheuvel wrote:
> On 7 April 2017 at 10:36, Phil Dennis-Jordan <phil@philjordan.eu> wrote:
>> On 7 April 2017 at 21:11, Laszlo Ersek <lersek@redhat.com> wrote:
>>> On 04/07/17 10:55, Andrew Jones wrote:
>>>> On Thu, Apr 06, 2017 at 10:22:09PM +0100, Ard Biesheuvel wrote:

>>>>> @@ -712,7 +712,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
>>>>>
>>>>>      /* DSDT address to be filled by Guest linker */
>>>>>      bios_linker_loader_add_pointer(linker,
>>>>> -        ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>>>>> +        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->Xdsdt),
>>>>>          ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>>>>>
>>>>>      build_header(linker, table_data,
>>
>> I don't know what it's like in ARM-Land, but X64 Windows does not take
>> kindly to a zero DSDT pointer in my experience. It might make sense to
>> make the choice between DSDT and XDSDT conditional on whether the
>> pointer is actually above 4GB? Mind you, I don't even know if
>> Microsoft makes ARM variants of Windows generally available, and
>> whether they currently work in Qemu; the FOSS OSes are typically more
>> lenient.
>>
> 
> Documentation/arm64/acpi_object_usage.txt in the kernel contains this under FADT
> 
>    For the DSDT that is also required, the X_DSDT field is to be used,
>    not the DSDT field.
> 
> and so we should be using xdsdt anyway. *However*, this is all moot
> given that UEFI is in charge of populating these fields. What we
> generate here and what the guest sees are two different things that
> are almost completely disconnected when it comes to RSDP, RSDT/XSDT
> and the DSDT field in FADT.

Agreed; in ARM guests, there is no ACPI without UEFI, and UEFI handles
the above stuff internally. For UEFI guests, some of the linker/loader
commands have a somewhat indirect meaning.

Laszlo
