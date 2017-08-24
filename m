Received: from eggs.gnu.org ([2001:4830:134:3::10]:38525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkhAJ-0005aM-Pc
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkhAG-0000wk-Jr
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:42:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30510
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkhAF-0000w8-Od
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:42:32 -0400
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170823104051.36488fcb@nial.brq.redhat.com>
	<9b19623e-55e9-ebac-11d3-6ff5fff176fe@cn.fujitsu.com>
	<20170823144502.17203857@nial.brq.redhat.com>
	<f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
	<20170823194734.518d5cb3@Igors-MacBook-Pro.local>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <033764b9-6098-1949-e4e7-a21cafcc6901@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 09:42:28 +0800
MIME-Version: 1.0
In-Reply-To: <20170823194734.518d5cb3@Igors-MacBook-Pro.local>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

Hi Igor,

At 08/24/2017 01:47 AM, Igor Mammedov wrote:
> On Wed, 23 Aug 2017 21:35:29 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
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
>> Just like memory hot-plug cases, when we use the '-m 128
>> 128,slots=3,maxmem=1G' option, As the ACPI spec said, There may be some
>> Memory Device in the DSDT table.
> for your case '-numa node -numa node,mem=128', there is no need in enabling memory hotplug.

Thank you very much for your kind explanation.

Yes, I understood.

> If I recall it correctly the default memory for x86 is 128Mb,
> hence removing "-m" would probably make DSDT match default one.

Yes, I removed the "-m":

test_acpi_one(" -numa node -numa node,mem=128", &data);

but, the DSDT didn't match the default one. because, if we support
NUMA, the DSDT will give us "_PXM" to map the CPU to node.


--- a/tmp/asl-7QO54Y.dsl
+++ b/tmp/asl-EWM54Y.dsl
@@ -5,13 +5,13 @@
   *
   * Disassembling to symbolic ASL+ operators
   *
- * Disassembly of tests/acpi-test-data/pc/DSDT, Thu Aug 24 09:20:29 2017
+ * Disassembly of /tmp/aml-1YM54Y, Thu Aug 24 09:20:29 2017
   *
   * Original Table Header:
   *     Signature        "DSDT"
- *     Length           0x000013EA (5098)
+ *     Length           0x000013F0 (5104)
   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math 
support
- *     Checksum         0x78
+ *     Checksum         0x13
   *     OEM ID           "BOCHS "
   *     OEM Table ID     "BXPCDSDT"
   *     OEM Revision     0x00000001 (1)
@@ -783,6 +783,8 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", 
"BXPCDSDT", 0x00000001)
                  {
                      COST (Zero, Arg0, Arg1, Arg2)
                  }
+
+                Name (_PXM, Zero)  // _PXM: Device Proximity
              }
          }
      }


Thanks,
	dou.
>

> [...]
>
>
>
>
