Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC5C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1AB218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1AB218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47463 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6PQW-0003ZI-H5
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j6PO8-0000UH-2N
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j6PO4-0002hm-HC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:51:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3164 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j6PNz-0002dV-50
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 20:51:51 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3DB3BCE495CB07FCCF32;
 Tue, 25 Feb 2020 09:50:52 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 09:50:46 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>
Subject: [PATCH v4 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Date: Tue, 25 Feb 2020 09:50:26 +0800
Message-ID: <20200225015026.940-4-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200225015026.940-1-miaoyubo@huawei.com>
References: <20200225015026.940-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Currently, pxb-pcie could be defined by the cmdline like
    --device pxb-pcie,id=3Dpci.9,bus_nr=3D128
However pxb-pcie is not described in acpi tables for arm.

The formal two patches support pxb-pcie for arm, escpcially the
specification for pxb-pcie in DSDT table.

Add a testcase to make sure the ACPI table is correct for guest.

The following table need to be added for this test:
    tests/data/acpi/virt/DSDT.pxb
Since the ASL diff has 1000+ lines, it would be presented in
commit log with the simply diff. the diff are:
    Device (PC80) is presented in DSDT.
    Resources allocated for Device (PCI0) is changed.

  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of /home/DSDT, Mon Feb 24 19:35:28 2020
+ * Disassembly of /home/DSDT.pxb, Mon Feb 24 19:33:38 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014BB (5307)
+ *     Length           0x00001F70 (8048)
  *     Revision         0x02
- *     Checksum         0xD1
+ *     Checksum         0xCF
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
             })
         }

+        Device (PC80)
+        {
+            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardw=
are ID
+            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
+            Name (_ADR, Zero)  // _ADR: Address
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_SEG, Zero)  // _SEG: PCI Segment
+            Name (_BBN, 0x80)  // _BBN: BIOS Bus Number
+            Name (_UID, 0x80)  // _UID: Unique ID
+            Name (_STR, Unicode ("pxb Device"))  // _STR: Description St=
ring
+            Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
+            {
+                Package (0x04)
+                {
+                    0xFFFF,
+                    Zero,
+                    GSI0,
+                    Zero
+                },

Packages are omitted.

+
+                Package (0x04)
+                {
+                    0x001FFFFF,
+                    0x03,
+                    GSI2,
+                    Zero
+                }
+            })
+            Device (GSI0)
+            {
+                Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  =
// _HID: Hardware ID
+                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resou=
rce Settings
+                {
+                    Interrupt (ResourceConsumer, Level, ActiveHigh, Excl=
usive, ,, )
+                    {
+                        0x00000023,
+                    }
+                })
+                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resour=
ce Settings
+                {
+                    Interrupt (ResourceConsumer, Level, ActiveHigh, Excl=
usive, ,, )
+                    {
+                        0x00000023,
+                    }
+                })
+                Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource S=
ettings
+                {
+                }
+            }
+

GSI1,2,3 are omitted.

+            Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base=
 Address
+            {
+                Return (0x0000004010000000)
+            }
+
+            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource S=
ettings
+            {
+                Name (RBUF, ResourceTemplate ()
+                {
+                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed,=
 PosDecode,
+                        0x0000,             // Granularity
+                        0x0080,             // Range Minimum
+                        0x0081,             // Range Maximum
+                        0x0000,             // Translation Offset
+                        0x0002,             // Length
+                        ,, )
+                    DWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
+                        0x00000000,         // Granularity
+                        0x3E9F0000,         // Range Minimum
+                        0x3EFEFFFF,         // Range Maximum
+                        0x00000000,         // Translation Offset
+                        0x00600000,         // Length
+                        ,, , AddressRangeMemory, TypeStatic)
+                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDe=
code, EntireRange,
+                        0x00000000,         // Granularity
+                        0x0000C000,         // Range Minimum
+                        0x0000FFFF,         // Range Maximum
+                        0x3EFF0000,         // Translation Offset
+                        0x00004000,         // Length
+                        ,, , TypeStatic, DenseTranslation)
+                    QWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
+                        0x0000000000000000, // Granularity
+                        0x000000FFFFA00000, // Range Minimum
+                        0x000000FFFFFFFFFF, // Range Maximum
+                        0x0000000000000000, // Translation Offset
+                        0x0000000000600000, // Length
+                        ,, , AddressRangeMemory, TypeStatic)
+                })
+                Return (ResourceTemplate ()
+                {
+                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed,=
 PosDecode,
+                        0x0000,             // Granularity
+                        0x0080,             // Range Minimum
+                        0x0081,             // Range Maximum
+                        0x0000,             // Translation Offset
+                        0x0002,             // Length
+                        ,, )
+                    DWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
+                        0x00000000,         // Granularity
+                        0x3E9F0000,         // Range Minimum
+                        0x3EFEFFFF,         // Range Maximum
+                        0x00000000,         // Translation Offset
+                        0x00600000,         // Length
+                        ,, , AddressRangeMemory, TypeStatic)
+                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDe=
code, EntireRange,
+                        0x00000000,         // Granularity
+                        0x0000C000,         // Range Minimum
+                        0x0000FFFF,         // Range Maximum
+                        0x3EFF0000,         // Translation Offset
+                        0x00004000,         // Length
+                        ,, , TypeStatic, DenseTranslation)
+                    QWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
+                        0x0000000000000000, // Granularity
+                        0x000000FFFFA00000, // Range Minimum
+                        0x000000FFFFFFFFFF, // Range Maximum
+                        0x0000000000000000, // Translation Offset
+                        0x0000000000600000, // Length
+                        ,, , AddressRangeMemory, TypeStatic)
+                })
+            }
+
+            Name (SUPP, Zero)
+            Name (CTRL, Zero)
+            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System C=
apabilities
+            {
+                CreateDWordField (Arg3, Zero, CDW1)
+                If ((Arg0 =3D=3D ToUUID ("33db4d5b-1ff7-401c-9657-7441c0=
3dd766") /* PCI Host Bridge Device */))
+                {
+                    CreateDWordField (Arg3, 0x04, CDW2)
+                    CreateDWordField (Arg3, 0x08, CDW3)
+                    SUPP =3D CDW2 /* \_SB_.PC80._OSC.CDW2 */
+                    CTRL =3D CDW3 /* \_SB_.PC80._OSC.CDW3 */
+                    CTRL &=3D 0x1F
+                    If ((Arg1 !=3D One))
+                    {
+                        CDW1 |=3D 0x08
+                    }
+
+                    If ((CDW3 !=3D CTRL))
+                    {
+                        CDW1 |=3D 0x10
+                    }
+
+                    CDW3 =3D CTRL /* \_SB_.PC80.CTRL */
+                    Return (Arg3)
+                }
+                Else
+                {
+                    CDW1 |=3D 0x04
+                    Return (Arg3)
+                }
+            }
+
+            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Me=
thod
+            {
+                If ((Arg0 =3D=3D ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19=
c3434d") /* Device Labeling Interface */))
+                {
+                    If ((Arg2 =3D=3D Zero))
+                    {
+                        Return (Buffer (One)
+                        {
+                             0x01                                       =
      // .
+                        })
+                    }
+                }
+
+                Return (Buffer (One)
+                {
+                     0x00                                             //=
 .
+                })
+            }
+        }
+
         Device (PCI0)
         {
             Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardw=
are ID
                     WordBusNumber (ResourceProducer, MinFixed, MaxFixed,=
 PosDecode,
                         0x0000,             // Granularity
                         0x0000,             // Range Minimum
-                        0x00FF,             // Range Maximum
+                        0x007F,             // Range Maximum
                         0x0000,             // Translation Offset
-                        0x0100,             // Length
+                        0x0080,             // Length
                         ,, )
                     DWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
                         0x00000000,         // Granularity
                         0x10000000,         // Range Minimum
-                        0x3EFEFFFF,         // Range Maximum
+                        0x3E9EFFFF,         // Range Maximum
                         0x00000000,         // Translation Offset
-                        0x2EFF0000,         // Length
+                        0x2E9F0000,         // Length
                         ,, , AddressRangeMemory, TypeStatic)
                     DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDe=
code, EntireRange,
                         0x00000000,         // Granularity
                         0x00000000,         // Range Minimum
-                        0x0000FFFF,         // Range Maximum
+                        0x0000BFFF,         // Range Maximum
                         0x3EFF0000,         // Translation Offset
-                        0x00010000,         // Length
+                        0x0000C000,         // Length
                         ,, , TypeStatic, DenseTranslation)
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 tests/data/acpi/virt/DSDT.pxb               | Bin 0 -> 8048 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 +
 tests/qtest/bios-tables-test.c              |  54 +++++++++++++++++---
 3 files changed, 49 insertions(+), 6 deletions(-)
 create mode 100644 tests/data/acpi/virt/DSDT.pxb

diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.px=
b
new file mode 100644
index 0000000000000000000000000000000000000000..6ac0b5212db49513c27ef50da=
838240826c2deb7
GIT binary patch
literal 8048
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
E0}->6TL1t6

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
index dfb8523c8b..90c53925fc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/DSDT.pxb",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
index b4752c644c..91e91e0fec 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -620,12 +620,21 @@ static void test_acpi_one(const char *params, test_=
data *data)
          * TODO: convert '-drive if=3Dpflash' to new syntax (see e33763b=
e7cd3)
          * when arm/virt boad starts to support it.
          */
-        args =3D g_strdup_printf("-machine %s %s -accel tcg -nodefaults =
-nographic "
-            "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly "
-            "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=3Don -cd=
rom %s %s",
-            data->machine, data->tcg_only ? "" : "-accel kvm",
-            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : =
"");
-
+        if (data->cd) {
+            args =3D g_strdup_printf("-machine %s %s -accel tcg "
+                "-nodefaults -nographic "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=3Don=
 -cdrom %s %s",
+                data->machine, data->tcg_only ? "" : "-accel kvm",
+                data->uefi_fl1, data->uefi_fl2, data->cd, params ? param=
s : "");
+        } else {
+            args =3D g_strdup_printf("-machine %s %s -accel tcg "
+                "-nodefaults -nographic "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly "
+                "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=3Don=
 %s",
+                data->machine, data->tcg_only ? "" : "-accel kvm",
+                data->uefi_fl1, data->uefi_fl2, params ? params : "");
+        }
     } else {
         /* Disable kernel irqchip to be able to override apic irq0. */
         args =3D g_strdup_printf("-machine %s,kernel-irqchip=3Doff %s -a=
ccel tcg "
@@ -960,6 +969,38 @@ static void test_acpi_virt_tcg_numamem(void)
=20
 }
=20
+static void test_acpi_virt_tcg_pxb(void)
+{
+    test_data data =3D {
+        .machine =3D "virt",
+        .tcg_only =3D true,
+        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
+        .ram_start =3D 0x40000000ULL,
+        .scan_len =3D 128ULL * 1024 * 1024,
+    };
+    /*
+     * While using -cdrom, the cdrom would auto plugged into pxb-pcie,
+     * the reason is the bus of pxb-pcie is also root bus, it would lead
+     * to the error only PCI/PCIE bridge could plug onto pxb.
+     * Therefore,thr cdrom is defined and plugged onto the scsi controll=
er
+     * to solve the conflicts.
+     */
+    data.variant =3D ".pxb";
+    test_acpi_one(" -device pcie-root-port,chassis=3D1,id=3Dpci.1"
+                  " -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.1"
+                  " -drive file=3D"
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2,"
+                  "if=3Dnone,media=3Dcdrom,id=3Ddrive-scsi0-0-0-1,readon=
ly=3Don"
+                  " -device scsi-cd,bus=3Dscsi0.0,scsi-id=3D0,"
+                  "drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1,bootindex=3D=
1"
+                  " -cpu cortex-a57"
+                  " -device pxb-pcie,bus_nr=3D128",
+                  &data);
+
+    free_test_data(&data);
+}
+
 static void test_acpi_tcg_acpi_hmat(const char *machine)
 {
     test_data data;
@@ -1052,6 +1093,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
         qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
         qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
+        qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
     }
     ret =3D g_test_run();
     boot_sector_cleanup(disk);
--=20
2.19.1



