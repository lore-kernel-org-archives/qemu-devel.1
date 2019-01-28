Received: from eggs.gnu.org ([209.51.188.92]:38654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1go9Yi-0000GI-Qc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1go9Yh-0000Eh-Ta
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:14:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1go9Yh-00009N-Gy
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:14:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SG8qH4121607
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 11:14:39 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qa3mnnc6n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 11:14:38 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 28 Jan 2019 16:14:37 -0000
References: <20190125210058.1092551-1-stefanb@linux.ibm.com>
	<20190128154553.583f79a3@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 28 Jan 2019 11:14:34 -0500
MIME-Version: 1.0
In-Reply-To: <20190128154553.583f79a3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <f7fc884b-0a7f-17d5-ada4-fc44c08bfba1@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mst@redhat.com

On 1/28/19 9:45 AM, Igor Mammedov wrote:
> On Fri, 25 Jan 2019 16:00:58 -0500
> Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>> This patch makes the a TPM 2.0 with TIS interface available under the
>> HID 'MSF0101'. This is supported by Linux and also Windows now
> MSF0101 is relatively recent addition to Linux,
> are there in wild (old) kernels that worked with PNP0C31 but won't work
> with MSF0101?


Linux 4.3.4 and later references this HID here: 
https://elixir.bootlin.com/linux/v4.3.4/source/drivers/char/tpm/tpm_tis.c 
. I don't see it before that. A 3.10 kernel works with this patch as well.


>
>> recognizes the TPM 2.0 with TIS interface. Leave the TPM 1.2 as before.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   hw/i386/acpi-build.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 2e21a31f82..f51225b4a7 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2141,8 +2141,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>               build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>>   
>>               if (TPM_IS_TIS(tpm)) {
>> -                dev = aml_device("ISA.TPM");
>> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
>> +                if (misc->tpm_version == TPM_VERSION_2_0) {
>> +                    dev = aml_device("TPM");
>> +                    aml_append(dev, aml_name_decl("_HID",
>> +                                                  aml_string("MSFT0101")));
>> +                } else {
>> +                    dev = aml_device("ISA.TPM");
>> +                    aml_append(dev, aml_name_decl("_HID",
>> +                                                  aml_eisaid("PNP0C31")));
>> +                }
>> +
>>                   aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
>>                   crs = aml_resource_template();
>>                   aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
