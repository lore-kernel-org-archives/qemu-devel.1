Received: from eggs.gnu.org ([2001:4830:134:3::10]:36702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZQ76-0001vp-Gc
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZQ73-0007d0-Dg
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:44:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cZQ73-0007cg-7N
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:44:21 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BD4727486F
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 22:44:21 +0000 (UTC)
References: <1486073152-27152-1-git-send-email-marcel@redhat.com>
	<20170203001441-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <dc10fe8b-7769-efae-1f32-ad8644cfd565@redhat.com>
Date: Fri, 3 Feb 2017 00:44:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170203001441-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pxb-pcie: fix PCI Express hotplug
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

On 02/03/2017 12:34 AM, Michael S. Tsirkin wrote:
> On Fri, Feb 03, 2017 at 12:05:52AM +0200, Marcel Apfelbaum wrote:
>> Add the missing osc method for pxb-pcie devices
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>
>> Note: The patch is based on the fact that Q35's osc method is quite generic.
>>
>> Thanks,
>> Marcel
>>
>>  hw/i386/acpi-build.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 1c928ab..555aab3 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1964,6 +1964,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>>              aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>> +            if (pci_bus_is_express(bus)) {
>> +                aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> +                aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>> +                aml_append(dev, build_q35_osc_method());
>> +            }
>

Hi Michael,
Thanks for the review.

> I think we want to move this stuff into build_q35_osc_method:
> "SUPP" seems to be 0, CTRL should be a variable passed in.
>

Sure

>
>>              if (numa_node != NUMA_NODE_UNASSIGNED) {
>>                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
>
>
> In fact build_q35_osc_method needs to be cleaned up.
> It stores result in "CTRL" which should be documented.
>
> "SUPP" seems to be unused.
>
> A bunch of comments missing.
>
> More importantly, its an unserialized method but it creates a bunch of
> fields so attempts to run two of these in parallel will crash.

I don't see how this code will run in parallel. (the code that calls the _OSC method)

> I see the same in ACPI spec which probably means it should be
> revisited with a critical eye.
>

I am in PTO next week, then I'll revisit the build_q35_osc_method and (try to) clean it up.

Thanks,
Marcel

>
>> --
>> 2.5.5
