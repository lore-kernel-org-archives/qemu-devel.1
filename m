Received: from eggs.gnu.org ([2001:4830:134:3::10]:37742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZKz7-0007vk-JQ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZKz4-0001zF-98
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:20:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eZKz3-0001uh-Qg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:20:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0AIKBV6140981
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:20:15 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fdny4efqe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:20:12 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 13:20:02 -0500
References: <1515506288-32291-1-git-send-email-mst@redhat.com>
	<20180110122535.3cc0d223@igors-macbook-pro.local>
	<20180110132751-mutt-send-email-mst@kernel.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2018 13:19:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180110132751-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <7141e528-0fae-6d38-990f-fbc7f443dfd1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] acpi: switch to a dummy SSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 01/10/2018 06:29 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 10, 2018 at 12:25:34PM +0100, Igor Mammedov wrote:
>> On Tue, 9 Jan 2018 15:58:11 +0200
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> We prefer not changing table sizes depending on parameters,
>>> that's why we create a dummy table rather than just drop
>>> the MCFG table.
>>>
>>> However, a table named "QEMU" could be put to a better
>>> use than just a stub, e.g. we could use it to pass
>>> some QEMU specific info to guests.
>>>
>>> Replace with an SSDT and pad with the Nop opcode
>>> to preserve the length.
>> Not sure it's useful, do you have patches on top of that, which will use this?
> Yes but not me - Stefan (Cc'd) wants to add a custom table.

With the virtual device at a well known address I don't need the custom 
table anymore...

    Stefan
>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>   hw/i386/acpi-build.c | 17 ++++++++++++-----
>>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 73519ab..d0afb31e 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2419,6 +2419,8 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>>>   {
>>>       AcpiTableMcfg *mcfg;
>>>       const char *sig;
>>> +    const char *oem;
>>> +    const char *oem_id;
>>>       int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>>>   
>>>       mcfg = acpi_data_push(table_data, len);
>>> @@ -2431,16 +2433,21 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>>>       /* MCFG is used for ECAM which can be enabled or disabled by guest.
>>>        * To avoid table size changes (which create migration issues),
>>>        * always create the table even if there are no allocations,
>>> -     * but set the signature to a reserved value in this case.
>>> -     * ACPI spec requires OSPMs to ignore such tables.
>>> +     * but fill it with Noop values.
>>> +     * OSPMs ignore such tables.
>>>        */
>>>       if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>>> -        /* Reserved signature: ignored by OSPM */
>>> -        sig = "QEMU";
>>> +        sig = "SSDT";
>>> +        oem = "QEMU ";
>>> +        oem_id = "NOOP";
>>> +        /* 0xa3 - NoopOp */
>>> +        memset(&mcfg->reserved, 0xa3, len - offsetof(AcpiTableMcfg, reserved));
>>>       } else {
>>>           sig = "MCFG";
>>> +        oem = NULL;
>>> +        oem_id = NULL;
>>>       }
>>> -    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
>>> +    build_header(linker, table_data, (void *)mcfg, sig, len, 1, oem, oem_id);
>>>   }
>>>   
>>>   /*
