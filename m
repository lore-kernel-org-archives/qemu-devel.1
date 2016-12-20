Received: from eggs.gnu.org ([2001:4830:134:3::10]:48772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJNmX-0006ER-6X
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cJNmT-0002Te-8P
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:00:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cJNmT-0002TS-2O
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:00:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7AB567BBF
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 17:00:47 +0000 (UTC)
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-2-git-send-email-imammedo@redhat.com>
	<ccb1531b-0bee-7d68-529b-5e6246c34fc1@redhat.com>
	<20161220171749.518bdd3c@Igors-MacBook-Pro.local>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9c37a13e-d62d-0dd0-89ef-d21b92ce7977@redhat.com>
Date: Tue, 20 Dec 2016 19:00:45 +0200
MIME-Version: 1.0
In-Reply-To: <20161220171749.518bdd3c@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 01/10] tests: pc: add memory
 hotplug acpi tables tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/20/2016 06:17 PM, Igor Mammedov wrote:
> On Tue, 20 Dec 2016 12:40:21 +0200
> Marcel Apfelbaum <marcel@redhat.com> wrote:
>
>> On 12/06/2016 01:32 AM, Igor Mammedov wrote:
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  tests/bios-tables-test.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>>> index 812f830..5404805 100644
>>> --- a/tests/bios-tables-test.c
>>> +++ b/tests/bios-tables-test.c
>>> @@ -867,6 +867,28 @@ static void test_acpi_piix4_tcg_ipmi(void)
>>>      free_test_data(&data);
>>>  }
>>>
>>
>> Hi Igor,
>>
>>
>>> +static void test_acpi_q35_tcg_memhp(void)
>>> +{
>>> +    test_data data;
>>> +
>>> +    memset(&data, 0, sizeof(data));
>>> +    data.machine = MACHINE_Q35;
>>> +    data.variant = ".memhp";
>>> +    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
>>
>> Why do we need the "-numa node" ? (I am sure you put it there for a reason, but I don't know it :))
> I added it to expose SRAT table to guest
> so we could detect unexpected changes caused by memory hotplug changes
>

Thanks

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>


>>
>> Thanks,
>> Marcel
>>
>>> +    free_test_data(&data);
>>> +}
>>> +
>>> +static void test_acpi_piix4_tcg_memhp(void)
>>> +{
>>> +    test_data data;
>>> +
>>> +    memset(&data, 0, sizeof(data));
>>> +    data.machine = MACHINE_PC;
>>> +    data.variant = ".memhp";
>>> +    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
>>> +    free_test_data(&data);
>>> +}
>>> +
>>>  int main(int argc, char *argv[])
>>>  {
>>>      const char *arch = qtest_get_arch();
>>> @@ -887,6 +909,8 @@ int main(int argc, char *argv[])
>>>          qtest_add_func("acpi/q35/ipmi", test_acpi_q35_tcg_ipmi);
>>>          qtest_add_func("acpi/piix4/cpuhp", test_acpi_piix4_tcg_cphp);
>>>          qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
>>> +        qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
>>> +        qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
>>>      }
>>>      ret = g_test_run();
>>>      boot_sector_cleanup(disk);
>>>
>
