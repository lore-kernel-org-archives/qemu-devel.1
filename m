Received: from eggs.gnu.org ([2001:4830:134:3::10]:50901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkVoq-0001F8-Pf
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkVol-0006L1-WD
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:35:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23155
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dkVok-0006HQ-Nq
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:35:35 -0400
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170823104051.36488fcb@nial.brq.redhat.com>
	<9b19623e-55e9-ebac-11d3-6ff5fff176fe@cn.fujitsu.com>
	<20170823144502.17203857@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
Date: Wed, 23 Aug 2017 21:35:29 +0800
MIME-Version: 1.0
In-Reply-To: <20170823144502.17203857@nial.brq.redhat.com>
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

At 08/23/2017 08:45 PM, Igor Mammedov wrote:
> On Wed, 23 Aug 2017 20:12:51 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>> Hi Igor,
>>
>> At 08/23/2017 04:40 PM, Igor Mammedov wrote:
>>> On Tue, 22 Aug 2017 11:24:10 +0800
>>> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>>>
>>>> As QEMU supports the memory-less node, it is possible that there is
>>>> no RAM in the first numa node(also be called as node0). eg:
>>>>   ... \
>>>>   -m 128,slots=3,maxmem=1G \
>>>>   -numa node -numa node,mem=128M \
>>>>
>>>> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
>>>> table. Only fixing it is not enough.
>>>>
>>>> Add a testcase for this situation to make sure the ACPI table is
>>>> correct for guest.
>>>>
>>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>>> ---
>>>>  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
>>>>  tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
>>>>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
>>>>  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
>>>>  tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
>>>>  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
>>>>  tests/bios-tables-test.c              |  30 ++++++++++++++++++++++++++++++
>>>>  7 files changed, 30 insertions(+)
>>>>  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
>>>>  create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
>>>>  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
>>>>  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
>>>>  create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
>>>>  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem
>>>
>>>
>>> considering only SRAT table has been changed and the other
>>> tables match with default blobs, I'd suggest to keep only
>>
>>
>> Our testcase is：
>>
>> +    test_acpi_one(" -m 128,slots=3,maxmem=1G"
>> +                  " -numa node -numa node,mem=128"
>> +                  " -numa dist,src=0,dst=1,val=21",
>> +                  &data);
>>
>> The DSDT and SLIT don't match with default blobs.
> do you actually need SLIT table /i.e. -numa dist/ for test at all?
> it looks not relevant for the test case at the hand,
> I'd suggest to drop '-numa dist' option for the test.
>

OK, Got it, will drop '-numa dist' option in next version.

>>
>> So, they can't be dropped.
>
> I wonder what's changed, could you post DSDT diff here?
>

Just like memory hot-plug cases, when we use the '-m
128,slots=3,maxmem=1G' option, As the ACPI spec said, There may be some
Memory Device in the DSDT table.

> (to get diff run 'make V=1 check' without DSDT.numamem being present)

diff --git a/asl-YJ034Y.dsl b/asl-JLX34Y.dsl
index c7b187b..6cd9e5d 100644
--- a/asl-YJ034Y.dsl
+++ b/asl-JLX34Y.dsl
@@ -5,13 +5,13 @@
   *
   * Disassembling to symbolic ASL+ operators
   *
- * Disassembly of tests/acpi-test-data/pc/DSDT, Wed Aug 23 21:22:56 2017
+ * Disassembly of /tmp/aml-8IX34Y, Wed Aug 23 21:22:56 2017
   *
   * Original Table Header:
   *     Signature        "DSDT"
- *     Length           0x000013EA (5098)
+ *     Length           0x0000193F (6463)
   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math 
support
- *     Checksum         0x78
+ *     Checksum         0x7B
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
@@ -792,6 +794,310 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", 
"BXPCDSDT", 0x00000001)
          \_SB.CPUS.CSCN ()
      }

+    Device (\_SB.PCI0.MHPD)
+    {
+        Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: 
Hardware ID
+        Name (_UID, "Memory hotplug resources")  // _UID: Unique ID
+        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+        {
+            IO (Decode16,
+                0x0A00,             // Range Minimum
+                0x0A00,             // Range Maximum
+                0x00,               // Alignment
+                0x18,               // Length
+                )
+        })
+        OperationRegion (HPMR, SystemIO, 0x0A00, 0x18)
+    }
+
+    Device (\_SB.MHPC)
+    {
+        Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: 
Hardware ID
+        Name (_UID, "DIMM devices")  // _UID: Unique ID
+        Name (MDNR, 0x03)
+        Field (\_SB.PCI0.MHPD.HPMR, DWordAcc, NoLock, Preserve)
+        {
+            MRBL,   32,
+            MRBH,   32,
+            MRLL,   32,
+            MRLH,   32,
+            MPX,    32
+        }
+
+        Field (\_SB.PCI0.MHPD.HPMR, ByteAcc, NoLock, WriteAsZeros)
+        {
+            Offset (0x14),
+            MES,    1,
+            MINS,   1,
+            MRMV,   1,
+            MEJ,    1
+        }
+
+        Field (\_SB.PCI0.MHPD.HPMR, DWordAcc, NoLock, Preserve)
+        {
+            MSEL,   32,
+            MOEV,   32,
+            MOSC,   32
+        }
+
+        Method (_STA, 0, NotSerialized)  // _STA: Status
+        {
+            If (MDNR == Zero)
+            {
+                Return (Zero)
+            }
+
+            Return (0x0B)
+        }
+
+        Mutex (MLCK, 0x00)
+        Method (MSCN, 0, NotSerialized)
+        {
+            If (MDNR == Zero)
+            {
+                Return (Zero)
+            }
+
+            Local0 = Zero
+            Acquire (MLCK, 0xFFFF)
+            While (Local0 < MDNR)
+            {
+                MSEL = Local0
+                If (MINS == One)
+                {
+                    MTFY (Local0, One)
+                    MINS = One
+                }
+                ElseIf (MRMV == One)
+                {
+                    MTFY (Local0, 0x03)
+                    MRMV = One
+                }
+
+                Local0 += One
+            }
+
+            Release (MLCK)
+            Return (One)
+        }
+
+        Method (MRST, 1, NotSerialized)
+        {
+            Local0 = Zero
+            Acquire (MLCK, 0xFFFF)
+            MSEL = ToInteger (Arg0)
+            If (MES == One)
+            {
+                Local0 = 0x0F
+            }
+
+            Release (MLCK)
+            Return (Local0)
+        }
+
+        Method (MCRS, 1, Serialized)
+        {
+            Acquire (MLCK, 0xFFFF)
+            MSEL = ToInteger (Arg0)
+            Name (MR64, ResourceTemplate ()
+            {
+                QWordMemory (ResourceProducer, PosDecode, MinFixed, 
MaxFixed, Cacheable, ReadWrite,
+                    0x0000000000000000, // Granularity
+                    0x0000000000000000, // Range Minimum
+                    0xFFFFFFFFFFFFFFFE, // Range Maximum
+                    0x0000000000000000, // Translation Offset
+                    0xFFFFFFFFFFFFFFFF, // Length
+                    ,, _Y01, AddressRangeMemory, TypeStatic)
+            })
+            CreateDWordField (MR64, \_SB.MHPC.MCRS._Y01._MIN, MINL)  // 
_MIN: Minimum Base Address
+            CreateDWordField (MR64, 0x12, MINH)
+            CreateDWordField (MR64, \_SB.MHPC.MCRS._Y01._LEN, LENL)  // 
_LEN: Length
+            CreateDWordField (MR64, 0x2A, LENH)
+            CreateDWordField (MR64, \_SB.MHPC.MCRS._Y01._MAX, MAXL)  // 
_MAX: Maximum Base Address
+            CreateDWordField (MR64, 0x1A, MAXH)
+            MINH = MRBH /* \_SB_.MHPC.MRBH */
+            MINL = MRBL /* \_SB_.MHPC.MRBL */
+            LENH = MRLH /* \_SB_.MHPC.MRLH */
+            LENL = MRLL /* \_SB_.MHPC.MRLL */
+            MAXL = (MINL + LENL) /* \_SB_.MHPC.MCRS.LENL */
+            MAXH = (MINH + LENH) /* \_SB_.MHPC.MCRS.LENH */
+            If (MAXL < MINL)
+            {
+                MAXH += One
+            }
+
+            If (MAXL < One)
+            {
+                MAXH -= One
+            }
+
+            MAXL -= One
+            If (MAXH == Zero)
+            {
+                Name (MR32, ResourceTemplate ()
+                {
+                    DWordMemory (ResourceProducer, PosDecode, MinFixed, 
MaxFixed, Cacheable, ReadWrite,
+                        0x00000000,         // Granularity
+                        0x00000000,         // Range Minimum
+                        0xFFFFFFFE,         // Range Maximum
+                        0x00000000,         // Translation Offset
+                        0xFFFFFFFF,         // Length
+                        ,, _Y02, AddressRangeMemory, TypeStatic)
+                })
+                CreateDWordField (MR32, \_SB.MHPC.MCRS._Y02._MIN, MIN) 
// _MIN: Minimum Base Address
+                CreateDWordField (MR32, \_SB.MHPC.MCRS._Y02._MAX, MAX) 
// _MAX: Maximum Base Address
+                CreateDWordField (MR32, \_SB.MHPC.MCRS._Y02._LEN, LEN) 
// _LEN: Length
+                MIN = MINL /* \_SB_.MHPC.MCRS.MINL */
+                MAX = MAXL /* \_SB_.MHPC.MCRS.MAXL */
+                LEN = LENL /* \_SB_.MHPC.MCRS.LENL */
+                Release (MLCK)
+                Return (MR32) /* \_SB_.MHPC.MCRS.MR32 */
+            }
+
+            Release (MLCK)
+            Return (MR64) /* \_SB_.MHPC.MCRS.MR64 */
+        }
+
+        Method (MPXM, 1, NotSerialized)
+        {
+            Acquire (MLCK, 0xFFFF)
+            MSEL = ToInteger (Arg0)
+            Local0 = MPX /* \_SB_.MHPC.MPX_ */
+            Release (MLCK)
+            Return (Local0)
+        }
+
+        Method (MOST, 4, NotSerialized)
+        {
+            Acquire (MLCK, 0xFFFF)
+            MSEL = ToInteger (Arg0)
+            MOEV = Arg1
+            MOSC = Arg2
+            Release (MLCK)
+        }
+
+        Method (MEJ0, 2, NotSerialized)
+        {
+            Acquire (MLCK, 0xFFFF)
+            MSEL = ToInteger (Arg0)
+            MEJ = One
+            Release (MLCK)
+        }
+
+        Device (MP00)
+        {
+            Name (_UID, "0x00")  // _UID: Unique ID
+            Name (_HID, EisaId ("PNP0C80") /* Memory Device */)  // 
_HID: Hardware ID
+            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
+            {
+                Return (MCRS (_UID))
+            }
+
+            Method (_STA, 0, NotSerialized)  // _STA: Status
+            {
+                Return (MRST (_UID))
+            }
+
+            Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
+            {
+                Return (MPXM (_UID))
+            }
+
+            Method (_OST, 3, NotSerialized)  // _OST: OSPM Status 
Indication
+            {
+                Return (MOST (_UID, Arg0, Arg1, Arg2))
+            }
+
+            Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
+            {
+                Return (MEJ0 (_UID, Arg0))
+            }
+        }
+
+        Device (MP01)
+        {
+            Name (_UID, "0x01")  // _UID: Unique ID
+            Name (_HID, EisaId ("PNP0C80") /* Memory Device */)  // 
_HID: Hardware ID
+            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
+            {
+                Return (MCRS (_UID))
+            }
+
+            Method (_STA, 0, NotSerialized)  // _STA: Status
+            {
+                Return (MRST (_UID))
+            }
+
+            Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
+            {
+                Return (MPXM (_UID))
+            }
+
+            Method (_OST, 3, NotSerialized)  // _OST: OSPM Status 
Indication
+            {
+                Return (MOST (_UID, Arg0, Arg1, Arg2))
+            }
+
+            Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
+            {
+                Return (MEJ0 (_UID, Arg0))
+            }
+        }
+
+        Device (MP02)
+        {
+            Name (_UID, "0x02")  // _UID: Unique ID
+            Name (_HID, EisaId ("PNP0C80") /* Memory Device */)  // 
_HID: Hardware ID
+            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
+            {
+                Return (MCRS (_UID))
+            }
+
+            Method (_STA, 0, NotSerialized)  // _STA: Status
+            {
+                Return (MRST (_UID))
+            }
+
+            Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
+            {
+                Return (MPXM (_UID))
+            }
+
+            Method (_OST, 3, NotSerialized)  // _OST: OSPM Status 
Indication
+            {
+                Return (MOST (_UID, Arg0, Arg1, Arg2))
+            }
+
+            Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
+            {
+                Return (MEJ0 (_UID, Arg0))
+            }
+        }
+
+        Method (MTFY, 2, NotSerialized)
+        {
+            If (Arg0 == Zero)
+            {
+                Notify (MP00, Arg1)
+            }
+
+            If (Arg0 == One)
+            {
+                Notify (MP01, Arg1)
+            }
+
+            If (Arg0 == 0x02)
+            {
+                Notify (MP02, Arg1)
+            }
+        }
+    }
+
+    Method (\_GPE._E03, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
+    {
+        \_SB.MHPC.MSCN ()
+    }
+
      Scope (_GPE)
      {
          Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: 
Hardware ID

>
>
>>
>> Thanks,
>> 	dou.
>>
>>>   tests/acpi-test-data/[pc|q35]/SRAT.numamem
>>> in this patch and drop the rest of *.numamem tables
>>> as test case should fallback to default tables
>>> when .numamem variant doesn't exists
>>>
>>>
>>>
>>
>>
>
>
>
>
