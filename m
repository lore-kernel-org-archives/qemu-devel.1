Received: from eggs.gnu.org ([2001:4830:134:3::10]:49089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cihfQ-0000Th-KA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cihfM-00037z-Il
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:18:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cihfM-00037o-9m
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:18:08 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B29E3A76A3
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 13:18:08 +0000 (UTC)
References: <1488201146-19580-1-git-send-email-marcel@redhat.com>
	<20170227223512-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <299357b3-0b00-37b9-0c4e-f5f6c46aab94@redhat.com>
Date: Tue, 28 Feb 2017 15:18:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170227223512-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] hw/pxb-pcie: fix PCI Express hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On 02/27/2017 10:57 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 27, 2017 at 03:12:26PM +0200, Marcel Apfelbaum wrote:
>> Add the missing osc method for pxb-pcie devices as APCI spec recommends,
>> see 6.2.10.3 OSC Implementation Example for PCI Host Bridge Devices, ACPI 5.0:
>>
>>     It is recommended that a machine with multiple host bridge devices
>>     should report the same capabilities for all host bridges, and also
>>     negotiate control of the features described in the Control Field in
>>     the same way for all host bridges.
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>
>> Note to maintainer:
>>  Please update ACPI test files.
>>
>> V2 -> V3:
>>       - Modified comment (Igor)
>>
>> V1 -> V2:
>>     Addressed Michael S. Tsirkin's comments:
>>       - Added documentation to q35 osc function
>>       - Made _osc serialized. I did not add compat property
>>         since it seems guest OSs do not care anyway about the OSC
>>         being serialized.
>>       - Kept the SUPP field even if is not used and also
>>         left both SUPP and CTRL out of the _osc because all
>>         systems I checked and the ACPI spec keep them that way,
>>         maybe is some kind of documentation contract.
>>
>> Thanks,
>> Marcel
>>
>>
>>  hw/i386/acpi-build.c | 41 +++++++++++++++++++++++++++++++++++------
>>  1 file changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 1c928ab..ad3f233 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1796,7 +1796,7 @@ static void build_piix4_pci_hotplug(Aml *table)
>>      aml_append(table, scope);
>>  }
>>
>> -static Aml *build_q35_osc_method(void)
>> +static void build_q35_osc_method(Aml *dev)
>
> This does more than just build _OSC so please
> give it a better name.
>
>>  {
>>      Aml *if_ctx;
>>      Aml *if_ctx2;
>> @@ -1805,7 +1805,35 @@ static Aml *build_q35_osc_method(void)
>>      Aml *a_cwd1 = aml_name("CDW1");
>>      Aml *a_ctrl = aml_name("CTRL");
>>
>> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>> +    /*
>> +     * Bits defined in the Support Field provide information
>> +     * regarding OS supported features.
>> +     *
>> +     * This field is not actually used and can be removed,
>> +     * however it appears even if unused on most DSDTs.
>
> What does this mean? Our _OSC method uses these,
> that's why we have them. How can you just remove them?
>
> I think you mean we could remove the code writing to it.
> I don't think keeping it around is justified.
> Same applies to CTRL btw. We could use a local variable
> instead.
>
>
>> +     *
>> +     * See:
>> +     *     Table 6-148 Interpretation of _OSC Support Field,
>> +     *     Passed in via the 2nd dword in Arg3, APCI 5.0
>
> Why 5.0? This is not how we do it. Pls find the earliest spec version
> that has this. 3.0?
>
>> +     */
>> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> +
>> +    /*
>> +     * Bits defined in the Control Field are used to submit
>> +     * request by the OS for control/handling of the associated feature
>> +     *
>> +     * See: Table 6-149 Interpretation of _OSC Control Field,
>> +     *      Passed in via Arg3, ACPI 5.0
>> +     *      Table 6-150 Interpretation of _OSC Control Field,
>> +     *      Returned Value, APCI 5.0
>> +     */
>> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>> +
>> +
>> +   /*
>> +    * 6.2.10 _OSC (Operating System Capabilities), APCI 5.0
>> +    */
>
> Same here.
>
>> +    method = aml_method("_OSC", 4, AML_SERIALIZED);
>>      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
>>
>>      if_ctx = aml_if(aml_equal(
>> @@ -1842,7 +1870,7 @@ static Aml *build_q35_osc_method(void)
>>      aml_append(method, else_ctx);
>>
>>      aml_append(method, aml_return(aml_arg(3)));
>> -    return method;
>> +    aml_append(dev, method);
>
> If you drop SUPP and CTRL then you can keep it simple, right?
>
>>  }
>>
>>  static void
>> @@ -1898,9 +1926,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>> -        aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> -        aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>> -        aml_append(dev, build_q35_osc_method());
>> +        build_q35_osc_method(dev);
>>          aml_append(sb_scope, dev);
>>          aml_append(dsdt, sb_scope);
>>
>> @@ -1964,6 +1990,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>>              aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>> +            if (pci_bus_is_express(bus)) {
>> +                build_q35_osc_method(dev);
>> +            }
>>
>>              if (numa_node != NUMA_NODE_UNASSIGNED) {
>>                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
>> --
>> 2.5.5
>
>
> so how about
>
> --->
>
> acpi: simplify _OSC
>
> Our _OSC method has a bunch of unused code loading data
> into external CTRL and SUPP fields which are then never
> used. Drop this in favor of a single local variable.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index db04cf5..efbbfcb 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1804,7 +1804,7 @@ static Aml *build_q35_osc_method(void)
>      Aml *else_ctx;
>      Aml *method;
>      Aml *a_cwd1 = aml_name("CDW1");
> -    Aml *a_ctrl = aml_name("CTRL");
> +    Aml *a_ctrl = aml_local(0);
>
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -1814,7 +1814,6 @@ static Aml *build_q35_osc_method(void)
>      aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
>      aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>
> -    aml_append(if_ctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>      aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
>
>      /*
> @@ -1899,8 +1898,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> -        aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> -        aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>


Hi Michael,

Thanks, I'll use the above patch and send a new simplified version.
Marcel
