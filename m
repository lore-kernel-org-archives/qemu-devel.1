Received: from eggs.gnu.org ([2001:4830:134:3::10]:36877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkgyT-0001rC-3d
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkgyP-0003rN-Sb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:30:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2924
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkgyP-0003qK-0w
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:30:17 -0400
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170823104051.36488fcb@nial.brq.redhat.com>
	<9b19623e-55e9-ebac-11d3-6ff5fff176fe@cn.fujitsu.com>
	<20170823144502.17203857@nial.brq.redhat.com>
	<f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
	<20170823172511.GR19998@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <b19cc271-0b67-d795-8c96-96d0d5bbd455@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 09:30:10 +0800
MIME-Version: 1.0
In-Reply-To: <20170823172511.GR19998@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] ACPI/unit-test: Add a new testcase
 for RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

Hi Eduardo,

At 08/24/2017 01:25 AM, Eduardo Habkost wrote:
> On Wed, Aug 23, 2017 at 09:35:29PM +0800, Dou Liyang wrote:
>> Hi Igor,
>>
>> At 08/23/2017 08:45 PM, Igor Mammedov wrote:
>>> On Wed, 23 Aug 2017 20:12:51 +0800
>>> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>>>
>>>> Hi Igor,
>>>>
>>>> At 08/23/2017 04:40 PM, Igor Mammedov wrote:
>>>>> On Tue, 22 Aug 2017 11:24:10 +0800
>>>>> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>>>>>
>>>>>> As QEMU supports the memory-less node, it is possible that there is
>>>>>> no RAM in the first numa node(also be called as node0). eg:
>>>>>>   ... \
>>>>>>   -m 128,slots=3,maxmem=1G \
>>>>>>   -numa node -numa node,mem=128M \
>>>>>>
>>>>>> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
>>>>>> table. Only fixing it is not enough.
>>>>>>
>>>>>> Add a testcase for this situation to make sure the ACPI table is
>>>>>> correct for guest.
>>>>>>
>>>>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>>>>> ---
>>>>>>  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
>>>>>>  tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
>>>>>>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
>>>>>>  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
>>>>>>  tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
>>>>>>  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
>>>>>>  tests/bios-tables-test.c              |  30 ++++++++++++++++++++++++++++++
>>>>>>  7 files changed, 30 insertions(+)
>>>>>>  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
>>>>>>  create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
>>>>>>  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
>>>>>>  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
>>>>>>  create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
>>>>>>  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem
>>>>>
>>>>>
>>>>> considering only SRAT table has been changed and the other
>>>>> tables match with default blobs, I'd suggest to keep only
>>>>
>>>>
>>>> Our testcase is：
>>>>
>>>> +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
>>>> +                  " -numa node -numa node,mem=128"
>>>> +                  " -numa dist,src=0,dst=1,val=21",
>>>> +                  &data);
>>>>
>>>> The DSDT and SLIT don't match with default blobs.
>>> do you actually need SLIT table /i.e. -numa dist/ for test at all?
>>> it looks not relevant for the test case at the hand,
>>> I'd suggest to drop '-numa dist' option for the test.
>>>
>>
>> OK, Got it, will drop '-numa dist' option in next version.
>>
>>>>
>>>> So, they can't be dropped.
>>>
>>> I wonder what's changed, could you post DSDT diff here?
>>>
>>
>> Just like memory hot-plug cases, when we use the '-m
>> 128,slots=3,maxmem=1G' option, As the ACPI spec said, There may be some
>> Memory Device in the DSDT table.
>
> Do you really need to use -m 128,slots=3,maxmem=1G to test your
> bug fix?
>

I was wrong, As the default memory for x86 is 128Mb, I will remove this 
option to make one case just do one thing.

Thanks,
	dou.
