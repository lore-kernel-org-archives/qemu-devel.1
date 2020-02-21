Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC42CC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6740B222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsYL1jdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6740B222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54v3-00071z-B9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j54tg-0005Dr-HW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j54td-00054X-EM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:47:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j54td-0004yC-5r
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582278416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSAgfOBTqkiIaSmZpX/jA/8Mlz9uXM+aAXlGiRLcp5c=;
 b=IsYL1jdDKRO5e0Du2/pFqt9eGBEGfqogQR4l398Yg+IUvfEIUFp/Va5xwWGblQl+uMAc9Q
 RKYsPtldZZVya3Jg6ZVKgNlvSmxQ2utf+q5jfrN26l8hNTR6xTdMooUhVI6wg9mJiNqx1a
 31yLyKCEG0QgcD6aAURxJeG5r0ZnV0E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-fw7IX6SqP-uLW8SULa8wPw-1; Fri, 21 Feb 2020 04:46:51 -0500
X-MC-Unique: fw7IX6SqP-uLW8SULa8wPw-1
Received: by mail-wm1-f69.google.com with SMTP id z7so355073wmi.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 01:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0kSwO52we38KXXa8ARvhQI0vvqLCyfuR/FFktu8mhns=;
 b=nOHn3k2E4H9KITVRA1sAll4RmcZG4DNRfOGnr4prkrES0tEDSECeW5LeV3oB3/Ckbq
 Fr3VFUy5OmV27S8+kCJLSM1HYUrufKXcLTGadxw2oIxJIedOWGGiyWVxrYuS/w4bJx52
 QP+lXT9e9aw4KBNgp/Z1JpFtyWNBiDQPmi1nzMznUHJj8vVsnyFdPYM6Mai2sZCwi7aO
 9Ox5MWekeEELv3jclesfUXPIbiInUJF8H9aqtdaREhlsN3XKwXmEKIXVWHSVI/t6hbws
 etCu4pDRvnpGcHBFYUUbtMOf+ONZtNfFmYOw3p+x9jRtJ+nIRmPiNXsNWz+7IHGWGesN
 Jv1g==
X-Gm-Message-State: APjAAAX0SDmnpMdMVHdDnn/kApkCcPoRveVjW92b3BC2OWXOF7sOHq26
 cQxsGj9pDKidSu0bt1pzVJ06GsbMYuhj5zOkZFQTlf9TxkURR1giogvA0gVAI+F2pKDaTRLWFyh
 OWwb+RSYSBU1f508=
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr2766128wmg.70.1582278408065; 
 Fri, 21 Feb 2020 01:46:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTmQZqROGfOZYIEE/X3VRQ40eXN7RVjUncgAsZRPJsyGCZDXSWi41Mgm5Njvg+8w8U9+2+eA==
X-Received: by 2002:a1c:e2c3:: with SMTP id z186mr2766032wmg.70.1582278407217; 
 Fri, 21 Feb 2020 01:46:47 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id u8sm3132331wmm.15.2020.02.21.01.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 01:46:46 -0800 (PST)
Subject: Re: [PATCH] hw/char/pl011: Enable TxFIFO and async transmission
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, gshan@redhat.com
References: <158226649422.712.7285415168506294704@a1bbccc8075a>
 <5d569175-55de-b182-a338-cc04ba9b0afd@redhat.com>
Message-ID: <e24f7030-a703-0887-7dc3-0024af63678b@redhat.com>
Date: Fri, 21 Feb 2020 10:46:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5d569175-55de-b182-a338-cc04ba9b0afd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, maz@kernel.org, qemu-arm@nongnu.org,
 shan.gavin@gmail.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing Igor & Drew.
>=20
> On 2/21/20 7:28 AM, no-reply@patchew.org wrote:
>> Patchew URL:=20
>> https://patchew.org/QEMU/20200221044908.266883-1-gshan@redhat.com/
>  >
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> make docker-image-centos7 V=3D1 NETWORK=3D1
>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> [...]
>  =C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-aarch64: tests/qtest/bios-tabl=
es-test
>> **
>> ERROR:/tmp/qemu-test/src/tests/qtest/acpi-utils.c:145:acpi_find_rsdp_add=
ress_uefi:=20
>> code should not be reached
>> ERROR - Bail out!=20
>> ERROR:/tmp/qemu-test/src/tests/qtest/acpi-utils.c:145:acpi_find_rsdp_add=
ress_uefi:=20
>> code should not be reached
>> make: *** [check-qtest-aarch64] Error 1
>=20
> The virt machine is not happy, busy-looping?
>=20
> $ QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64 \
>  =C2=A0 tests/qtest/bios-tables-test
> /aarch64/acpi/virt: ^C

So this test runs:

$ qemu-system-aarch64 -M virt -pflash pc-bios/edk2-aarch64-code.fd=20
-pflash pc-bios/edk2-arm-vars.fd -cdrom=20
tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 -cpu=20
cortex-a57 -serial stdio
[...]
[Bds]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEnd Load Options Dumping=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
=20
=20

[Bds]BdsWait ...Zzzzzzzzzzzz...=20
=20
=20

[Bds]BdsWait(3)..Zzzz...=20
=20
=20

[Bds]BdsWait(2)..Zzzz...=20
=20
=20

[Bds]BdsWait(1)..Zzzz...=20
=20
=20

[Bds]Exit the waiting!=20
=20
=20

[Bds]Stop Hotkey Service!=20
=20
=20

[Bds]UnregisterKeyNotify: 000C/0000 Success=20
=20
=20

[Bds]UnregisterKeyNotify: 0017/0000 Success=20
=20
=20

[Bds]UnregisterKeyNotify: 0000/000D Success=20
=20
=20

Memory  Previous  Current    Next
  Type    Pages     Pages     Pages
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D
   09    00000000  00000080  000000A0
   0A    00000000  00000020  00000028
   00    00000000  00000000  00000000
   06    0000012C  00000370  0000044C
   05    00000096  00000280  00000320
   03    000003E8  000003AB  000003E8
   04    00002EE0  00002000  00002EE0
   01    00000014  00000000  00000014
   02    00000000  00000000  00000000
Memory Type Information settings change.
[Bds]Booting UEFI Misc Device
  BlockSize : 262144
  LastBlock : FF
[Bds] Expand VenHw(93E34C7E-B50E-11DF-9223-2443DFD72085,00) -> <null string=
>
BdsDxe: failed to load Boot0001 "UEFI Misc Device" from=20
VenHw(93E34C7E-B50E-11DF-9223-2443DFD72085,00): Not Found
Memory  Previous  Current    Next
  Type    Pages     Pages     Pages
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D
   09    00000000  00000080  000000A0
   0A    00000000  00000020  00000028
   00    00000000  00000000  00000000
   06    0000012C  00000370  0000044C
   05    00000096  00000280  00000320
   03    000003E8  000003AB  000003E8
   04    00002EE0  00002040  00002EE0
   01    00000014  00000000  00000014
   02    00000000  00000000  00000000
Memory Type Information settings change.
[Bds]Booting UEFI Misc Device 2
  BlockSize : 512
  LastBlock : 33F
FatDiskIo: Cache Page OutBound occurred!
FSOpen: Open '\EFI\BOOT\BOOTAA64.EFI' Success
[Bds] Expand PciRoot(0x0)/Pci(0x2,0x0) ->=20
PciRoot(0x0)/Pci(0x2,0x0)/CDROM(0x0,0x68,0x200)/\EFI\BOOT\BOOTAA64.EFI
BdsDxe: loading Boot0002 "UEFI Misc Device 2" from PciRoot(0x0)/Pci(0x2,0x0=
)
[Security] 3rd party image[0] can be loaded after EndOfDxe:=20
PciRoot(0x0)/Pci(0x2,0x0)/CDROM(0x0,0x68,0x200)/\EFI\BOOT\BOOTAA64.EFI.
InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 452B5840
add-symbol-file=20
/home/lacos/src/upstream/qemu/tests/uefi-test-tools/Build/UefiTestTools/DEB=
UG_GCC5/AARCH64/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest/DEBUG/BiosTa=
blesTest.dll=20
0x442C3000
Loading driver at 0x000442C2000 EntryPoint=3D0x000442C47AC BiosTablesTest.e=
fi
InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 4654E718
ProtectUefiImageCommon - 0x452B5840
   - 0x00000000442C2000 - 0x0000000000006000
SetUefiImageMemoryAttributes - 0x00000000442C2000 - 0x0000000000001000=20
(0x0000000000004008)
SetUefiImageMemoryAttributes - 0x00000000442C3000 - 0x0000000000003000=20
(0x0000000000020008)
SetUefiImageMemoryAttributes - 0x00000000442C6000 - 0x0000000000002000=20
(0x0000000000004008)
BdsDxe: starting Boot0002 "UEFI Misc Device 2" from=20
PciRoot(0x0)/Pci(0x2,0x0)
BiosTablesTest: BiosTablesTest=3D45100000 Rsdp10=3D0 Rsdp20=3D44020000
BiosTablesTest: Smbios21=3D0 Smbios30=3D47640000
BiosTablesTest: press any key to exit
qemu-system-aarch64: terminating on signal 2

Using -d in_asm -trace pl011\* you see after "press any key to exit" it=20
is looping for a key on the uart:

12638@1582277983.168226:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168229:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168233:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168236:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168239:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168242:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168246:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168249:pl011_write addr 0x00000000 value 0x00000020
12638@1582277983.168252:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168255:pl011_write addr 0x00000000 value 0x0000002d
12638@1582277983.168259:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168262:pl011_write addr 0x00000000 value 0x00000020
12638@1582277983.168265:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168268:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168272:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168275:pl011_write addr 0x00000000 value 0x00000078
12638@1582277983.168279:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168281:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168285:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168288:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168292:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168295:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168298:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168303:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168307:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168310:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168313:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168316:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168320:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168323:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168327:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168329:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168333:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168336:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168340:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168342:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168346:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168349:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168353:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168356:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168359:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168362:pl011_write addr 0x00000000 value 0x00000036
12638@1582277983.168366:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168369:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168372:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168375:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168379:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168382:pl011_write addr 0x00000000 value 0x00000030
12638@1582277983.168385:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168388:pl011_write addr 0x00000000 value 0x0000000d
12638@1582277983.168392:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.168395:pl011_write addr 0x00000000 value 0x0000000a
----------------
IN:
0x4753da98:  a9bc7bfd  stp      x29, x30, [sp, #-0x40]!
0x4753da9c:  910003fd  mov      x29, sp
0x4753daa0:  a9025bf5  stp      x21, x22, [sp, #0x20]
0x4753daa4:  d0000015  adrp     x21, #0x4753f000
0x4753daa8:  a90153f3  stp      x19, x20, [sp, #0x10]
0x4753daac:  aa0003f6  mov      x22, x0
0x4753dab0:  aa0103f3  mov      x19, x1
0x4753dab4:  910082b5  add      x21, x21, #0x20
0x4753dab8:  a90363f7  stp      x23, x24, [sp, #0x30]
0x4753dabc:  d2800014  movz     x20, #0
0x4753dac0:  d2800318  movz     x24, #0x18
0x4753dac4:  f9403660  ldr      x0, [x19, #0x68]
0x4753dac8:  eb00029f  cmp      x20, x0
0x4753dacc:  54000083  b.lo     #0x4753dadc

----------------
IN:
0x4753dadc:  f9403a61  ldr      x1, [x19, #0x70]
0x4753dae0:  9b187e97  mul      x23, x20, x24
0x4753dae4:  aa1503e0  mov      x0, x21
0x4753dae8:  8b170021  add      x1, x1, x23
0x4753daec:  97ffff85  bl       #0x4753d900

----------------
IN:
0x4753d900:  a9be7bfd  stp      x29, x30, [sp, #-0x20]!
0x4753d904:  910003fd  mov      x29, sp
0x4753d908:  a90153f3  stp      x19, x20, [sp, #0x10]
0x4753d90c:  aa0003f3  mov      x19, x0
0x4753d910:  aa0103f4  mov      x20, x1
0x4753d914:  97ffff9d  bl       #0x4753d788

----------------
IN:
0x4753d788:  52800020  movz     w0, #0x1
0x4753d78c:  d65f03c0  ret

----------------
IN:
0x4753d918:  72001c1f  tst      w0, #0xff
0x4753d91c:  540001e0  b.eq     #0x4753d958

----------------
IN:
0x4753d920:  b50000f3  cbnz     x19, #0x4753d93c

----------------
IN:
0x4753d93c:  b50000f4  cbnz     x20, #0x4753d958

----------------
IN:
0x4753d958:  aa1403e1  mov      x1, x20
0x4753d95c:  aa1303e0  mov      x0, x19
0x4753d960:  a94153f3  ldp      x19, x20, [sp, #0x10]
0x4753d964:  a8c27bfd  ldp      x29, x30, [sp], #0x20
0x4753d968:  1400011e  b        #0x4753dde0

----------------
IN:
0x4753dde0:  aa1f03e2  mov      x2, xzr
0x4753dde4:  a9401003  ldp      x3, x4, [x0]
0x4753dde8:  b4000041  cbz      x1, #0x4753ddf0

----------------
IN:
0x4753ddec:  a9400821  ldp      x1, x2, [x1]
0x4753ddf0:  eb03003f  cmp      x1, x3
0x4753ddf4:  fa440040  ccmp     x2, x4, #0, eq
0x4753ddf8:  1a9f17e0  cset     w0, eq
0x4753ddfc:  d65f03c0  ret

----------------
IN:
0x4753daf0:  72001c1f  tst      w0, #0xff
0x4753daf4:  540013c0  b.eq     #0x4753dd6c

----------------
IN:
0x4753dd6c:  91000694  add      x20, x20, #1
0x4753dd70:  17ffff55  b        #0x4753dac4

----------------
IN:
0x4753dac4:  f9403660  ldr      x0, [x19, #0x68]
0x4753dac8:  eb00029f  cmp      x20, x0
0x4753dacc:  54000083  b.lo     #0x4753dadc

----------------
IN:
0x4753daf8:  f9403a60  ldr      x0, [x19, #0x70]
0x4753dafc:  d2800014  movz     x20, #0
0x4753db00:  8b170000  add      x0, x0, x23
0x4753db04:  f9400801  ldr      x1, [x0, #0x10]
0x4753db08:  d0000000  adrp     x0, #0x4753f000
0x4753db0c:  f9007801  str      x1, [x0, #0xf0]
0x4753db10:  97ffff1e  bl       #0x4753d788

----------------
IN:
0x4753db14:  53001c15  uxtb     w21, w0
0x4753db18:  34000275  cbz      w21, #0x4753db64

----------------
IN:
0x4753db1c:  b6f80254  tbz      x20, #0x3f, #0x4753db64

----------------
IN:
0x4753db64:  97ffff82  bl       #0x4753d96c

----------------
IN:
0x4753d96c:  a9bb7bfd  stp      x29, x30, [sp, #-0x50]!
0x4753d970:  d0000000  adrp     x0, #0x4753f000
0x4753d974:  910003fd  mov      x29, sp
0x4753d978:  a90153f3  stp      x19, x20, [sp, #0x10]
0x4753d97c:  f9407813  ldr      x19, [x0, #0xf0]
0x4753d980:  f90013f5  str      x21, [sp, #0x20]
0x4753d984:  b5000053  cbnz     x19, #0x4753d98c

----------------
IN:
0x4753d98c:  d0000014  adrp     x20, #0x4753f000
0x4753d990:  529ffff5  movz     w21, #0xffff
0x4753d994:  91000294  add      x20, x20, #0
0x4753d998:  b5000053  cbnz     x19, #0x4753d9a0

----------------
IN:
0x4753d9a0:  79400260  ldrh     w0, [x19]
0x4753d9a4:  6b15001f  cmp      w0, w21
0x4753d9a8:  54000141  b.ne     #0x4753d9d0

----------------
IN:
0x4753d9d0:  7100101f  cmp      w0, #4
0x4753d9d4:  54000080  b.eq     #0x4753d9e4

----------------
IN:
0x4753d9d8:  79400660  ldrh     w0, [x19, #2]
0x4753d9dc:  8b000273  add      x19, x19, x0
0x4753d9e0:  17fffff0  b        #0x4753d9a0

----------------
IN:
0x4753d9e4:  91002261  add      x1, x19, #8
0x4753d9e8:  aa1403e0  mov      x0, x20
0x4753d9ec:  97ffffc5  bl       #0x4753d900

----------------
IN:
0x4753d9f0:  72001c1f  tst      w0, #0xff
0x4753d9f4:  54fffe80  b.eq     #0x4753d9c4

----------------
IN:
0x4753d9c4:  79400660  ldrh     w0, [x19, #2]
0x4753d9c8:  8b000273  add      x19, x19, x0
0x4753d9cc:  17fffff3  b        #0x4753d998

----------------
IN:
0x4753d998:  b5000053  cbnz     x19, #0x4753d9a0

----------------
IN:
0x4753d9f8:  79400660  ldrh     w0, [x19, #2]
0x4753d9fc:  7100801f  cmp      w0, #0x20
0x4753da00:  54fffd61  b.ne     #0x4753d9ac

----------------
IN:
0x4753da04:  d0000001  adrp     x1, #0x4753f000
0x4753da08:  f9400e60  ldr      x0, [x19, #0x18]
0x4753da0c:  f9006820  str      x0, [x1, #0xd0]
0x4753da10:  b4fffce0  cbz      x0, #0x4753d9ac

----------------
IN:
0x4753da14:  d292c001  movz     x1, #0x9600
0x4753da18:  910143a5  add      x5, x29, #0x50
0x4753da1c:  52800102  movz     w2, #0x8
0x4753da20:  9100efa4  add      x4, x29, #0x3b
0x4753da24:  f90027a1  str      x1, [x29, #0x48]
0x4753da28:  52800021  movz     w1, #0x1
0x4753da2c:  3900efa2  strb     w2, [x29, #0x3b]
0x4753da30:  910103a3  add      x3, x29, #0x40
0x4753da34:  b81ecca1  str      w1, [x5, #-0x14]!
0x4753da38:  910113a2  add      x2, x29, #0x44
0x4753da3c:  b90043a1  str      w1, [x29, #0x40]
0x4753da40:  910123a1  add      x1, x29, #0x48
0x4753da44:  b90047bf  str      wzr, [x29, #0x44]
0x4753da48:  97fffd4d  bl       #0x4753cf7c

----------------
IN:
0x4753cf7c:  a9bb7bfd  stp      x29, x30, [sp, #-0x50]!
0x4753cf80:  910003fd  mov      x29, sp
0x4753cf84:  a90153f3  stp      x19, x20, [sp, #0x10]
0x4753cf88:  aa0003f4  mov      x20, x0
0x4753cf8c:  913fa000  add      x0, x0, #0xfe8
0x4753cf90:  a9025bf5  stp      x21, x22, [sp, #0x20]
0x4753cf94:  aa0203f5  mov      x21, x2
0x4753cf98:  a90363f7  stp      x23, x24, [sp, #0x30]
0x4753cf9c:  f90023f9  str      x25, [sp, #0x40]
0x4753cfa0:  aa0303f8  mov      x24, x3
0x4753cfa4:  aa0103f9  mov      x25, x1
0x4753cfa8:  aa0403f7  mov      x23, x4
0x4753cfac:  aa0503f6  mov      x22, x5
0x4753cfb0:  97ffffe0  bl       #0x4753cf30

----------------
IN:
0x4753cf30:  a9be7bfd  stp      x29, x30, [sp, #-0x20]!
0x4753cf34:  910003fd  mov      x29, sp
0x4753cf38:  f9000bf3  str      x19, [sp, #0x10]
0x4753cf3c:  aa0003f3  mov      x19, x0
0x4753cf40:  94000212  bl       #0x4753d788

----------------
IN:
0x4753cf44:  72001c1f  tst      w0, #0xff
0x4753cf48:  54000120  b.eq     #0x4753cf6c

----------------
IN:
0x4753cf4c:  f240067f  tst      x19, #3
0x4753cf50:  540000e0  b.eq     #0x4753cf6c

----------------
IN:
0x4753cf6c:  aa1303e0  mov      x0, x19
0x4753cf70:  f9400bf3  ldr      x19, [sp, #0x10]
0x4753cf74:  a8c27bfd  ldp      x29, x30, [sp], #0x20
0x4753cf78:  140003ae  b        #0x4753de30

----------------
IN:
0x4753de30:  b9400000  ldr      w0, [x0]
0x4753de34:  d5033dbf  dmb      ld
0x4753de38:  d65f03c0  ret

12638@1582277983.170601:pl011_read addr 0x00000fe8 value 0x00000014
----------------
IN:
0x4753cfb4:  b94002a1  ldr      w1, [x21]
0x4753cfb8:  d3441c00  ubfx     x0, x0, #4, #4
0x4753cfbc:  7100081f  cmp      w0, #2
0x4753cfc0:  52800213  movz     w19, #0x10
0x4753cfc4:  52800400  movz     w0, #0x20
0x4753cfc8:  1a938000  csel     w0, w0, w19, hi
0x4753cfcc:  7100003f  cmp      w1, #0
0x4753cfd0:  7a401022  ccmp     w1, w0, #2, ne
0x4753cfd4:  54000163  b.lo     #0x4753d000

----------------
IN:
0x4753cfd8:  b90002a0  str      w0, [x21]
0x4753cfdc:  b9400302  ldr      w2, [x24]
0x4753cfe0:  7100145f  cmp      w2, #5
0x4753cfe4:  54000508  b.hi     #0x4753d084

----------------
IN:
0x4753cfe8:  b0000000  adrp     x0, #0x4753d000
0x4753cfec:  91398000  add      x0, x0, #0xe60
0x4753cff0:  38624800  ldrb     w0, [x0, w2, uxtw]
0x4753cff4:  10000061  adr      x1, #0x4753d000
0x4753cff8:  8b208820  add      x0, x1, w0, sxtb #2
0x4753cffc:  d61f0000  br       x0

----------------
IN:
0x4753d018:  394002e2  ldrb     w2, [x23]
0x4753d01c:  7100205f  cmp      w2, #8
0x4753d020:  54000328  b.hi     #0x4753d084

----------------
IN:
0x4753d024:  90000000  adrp     x0, #0x4753d000
0x4753d028:  9139a000  add      x0, x0, #0xe68
0x4753d02c:  38624800  ldrb     w0, [x0, w2, uxtw]
0x4753d030:  10000061  adr      x1, #0x4753d03c
0x4753d034:  8b208820  add      x0, x1, w0, sxtb #2
0x4753d038:  d61f0000  br       x0

----------------
IN:
0x4753d068:  321b0673  orr      w19, w19, #0x60
0x4753d06c:  b94002c0  ldr      w0, [x22]
0x4753d070:  7100041f  cmp      w0, #1
0x4753d074:  540001a0  b.eq     #0x4753d0a8

----------------
IN:
0x4753d0a8:  f9400320  ldr      x0, [x25]
0x4753d0ac:  b5000080  cbnz     x0, #0x4753d0bc

----------------
IN:
0x4753d0bc:  f9400320  ldr      x0, [x25]
0x4753d0c0:  d29b0015  movz     x21, #0xd800
0x4753d0c4:  f2a0b715  movk     x21, #0x5b8, lsl #16
0x4753d0c8:  9100c296  add      x22, x20, #0x30
0x4753d0cc:  9ac00ab5  udiv     x21, x21, x0
0x4753d0d0:  aa1603e0  mov      x0, x22
0x4753d0d4:  53067eb7  lsr      w23, w21, #6
0x4753d0d8:  120016b5  and      w21, w21, #0x3f
0x4753d0dc:  97ffff95  bl       #0x4753cf30

12638@1582277983.171071:pl011_read addr 0x00000030 value 0x00000301
----------------
IN:
0x4753d0e0:  37000360  tbnz     w0, #0, #0x4753d14c

----------------
IN:
0x4753d14c:  9100b280  add      x0, x20, #0x2c
0x4753d150:  97ffff78  bl       #0x4753cf30

12638@1582277983.171143:pl011_read addr 0x0000002c value 0x00000070
----------------
IN:
0x4753d154:  6b13001f  cmp      w0, w19
0x4753d158:  54fffc61  b.ne     #0x4753d0e4

----------------
IN:
0x4753d15c:  91009280  add      x0, x20, #0x24
0x4753d160:  97ffff74  bl       #0x4753cf30

12638@1582277983.171221:pl011_read addr 0x00000024 value 0x00000027
----------------
IN:
0x4753d164:  6b0002ff  cmp      w23, w0
0x4753d168:  54fffbe1  b.ne     #0x4753d0e4

----------------
IN:
0x4753d16c:  9100a280  add      x0, x20, #0x28
0x4753d170:  97ffff70  bl       #0x4753cf30

12638@1582277983.171300:pl011_read addr 0x00000028 value 0x00000004
----------------
IN:
0x4753d174:  6b0002bf  cmp      w21, w0
0x4753d178:  d2800001  movz     x1, #0
0x4753d17c:  54fffb41  b.ne     #0x4753d0e4

----------------
IN:
0x4753d180:  aa0103e0  mov      x0, x1
0x4753d184:  f94023f9  ldr      x25, [sp, #0x40]
0x4753d188:  a94153f3  ldp      x19, x20, [sp, #0x10]
0x4753d18c:  a9425bf5  ldp      x21, x22, [sp, #0x20]
0x4753d190:  a94363f7  ldp      x23, x24, [sp, #0x30]
0x4753d194:  a8c57bfd  ldp      x29, x30, [sp], #0x50
0x4753d198:  d65f03c0  ret

----------------
IN:
0x4753da4c:  17ffffda  b        #0x4753d9b4

----------------
IN:
0x4753d9b4:  a94153f3  ldp      x19, x20, [sp, #0x10]
0x4753d9b8:  f94013f5  ldr      x21, [sp, #0x20]
0x4753d9bc:  a8c57bfd  ldp      x29, x30, [sp], #0x50
0x4753d9c0:  d65f03c0  ret

----------------
IN:
0x4753db68:  aa0003f4  mov      x20, x0
0x4753db6c:  34000275  cbz      w21, #0x4753dbb8

----------------
IN:
0x4753db70:  b6f80240  tbz      x0, #0x3f, #0x4753dbb8

----------------
IN:
0x4753dbb8:  97fffd9e  bl       #0x4753d230

----------------
IN:
0x4753d230:  d2800000  movz     x0, #0
0x4753d234:  d65f03c0  ret

----------------
IN:
0x4753dbbc:  aa0003f4  mov      x20, x0
0x4753dbc0:  34000275  cbz      w21, #0x4753dc0c

----------------
IN:
0x4753dbc4:  b6f80240  tbz      x0, #0x3f, #0x4753dc0c

----------------
IN:
0x4753dc0c:  d0000000  adrp     x0, #0x4753f000
0x4753dc10:  710002bf  cmp      w21, #0
0x4753dc14:  1a9f07f4  cset     w20, ne
0x4753dc18:  f10002df  cmp      x22, #0
0x4753dc1c:  f9007016  str      x22, [x0, #0xe0]
0x4753dc20:  1a9f17e0  cset     w0, eq
0x4753dc24:  6a00029f  tst      w20, w0
0x4753dc28:  540000e0  b.eq     #0x4753dc44

----------------
IN:
0x4753dc44:  d0000000  adrp     x0, #0x4753f000
0x4753dc48:  d0000017  adrp     x23, #0x4753f000
0x4753dc4c:  f9007413  str      x19, [x0, #0xe8]
0x4753dc50:  f9403260  ldr      x0, [x19, #0x60]
0x4753dc54:  f100001f  cmp      x0, #0
0x4753dc58:  f9006ee0  str      x0, [x23, #0xd8]
0x4753dc5c:  1a9f17e0  cset     w0, eq
0x4753dc60:  6a00029f  tst      w20, w0
0x4753dc64:  540000e0  b.eq     #0x4753dc80

----------------
IN:
0x4753dc80:  d0000000  adrp     x0, #0x4753f000
0x4753dc84:  d0000013  adrp     x19, #0x4753f000
0x4753dc88:  d0000016  adrp     x22, #0x4753f000
0x4753dc8c:  9101c000  add      x0, x0, #0x70
0x4753dc90:  91010273  add      x19, x19, #0x40
0x4753dc94:  910242d6  add      x22, x22, #0x90
0x4753dc98:  52800021  movz     w1, #0x1
0x4753dc9c:  52800102  movz     w2, #0x8
0x4753dca0:  d292c003  movz     x3, #0x9600
0x4753dca4:  29020801  stp      w1, w2, [x0, #0x10]
0x4753dca8:  29030401  stp      w1, w1, [x0, #0x18]
0x4753dcac:  39009661  strb     w1, [x19, #0x25]
0x4753dcb0:  39009a61  strb     w1, [x19, #0x26]
0x4753dcb4:  f94006c1  ldr      x1, [x22, #8]
0x4753dcb8:  f9000403  str      x3, [x0, #8]
0x4753dcbc:  aa1603e0  mov      x0, x22
0x4753dcc0:  39009262  strb     w2, [x19, #0x24]
0x4753dcc4:  f801c263  stur     x3, [x19, #0x1c]
0x4753dcc8:  d63f0020  blr      x1

----------------
IN:
0x4753d250:  a9bf7bfd  stp      x29, x30, [sp, #-0x10]!
0x4753d254:  aa0003e7  mov      x7, x0
0x4753d258:  910003fd  mov      x29, sp
0x4753d25c:  97fffff3  bl       #0x4753d228

----------------
IN:
0x4753d228:  d2800000  movz     x0, #0
0x4753d22c:  d65f03c0  ret

----------------
IN:
0x4753d260:  b7f801c0  tbnz     x0, #0x3f, #0x4753d298

----------------
IN:
0x4753d264:  f9401ce0  ldr      x0, [x7, #0x38]
0x4753d268:  f94008e8  ldr      x8, [x7, #0x10]
0x4753d26c:  f9400401  ldr      x1, [x0, #8]
0x4753d270:  39405005  ldrb     w5, [x0, #0x14]
0x4753d274:  b9400403  ldr      w3, [x0, #4]
0x4753d278:  b9401002  ldr      w2, [x0, #0x10]
0x4753d27c:  29431804  ldp      w4, w6, [x0, #0x18]
0x4753d280:  aa0703e0  mov      x0, x7
0x4753d284:  d63f0100  blr      x8

----------------
IN:
0x4753d51c:  a9b97bfd  stp      x29, x30, [sp, #-0x70]!
0x4753d520:  910003fd  mov      x29, sp
0x4753d524:  a90153f3  stp      x19, x20, [sp, #0x10]
0x4753d528:  aa0003f3  mov      x19, x0
0x4753d52c:  9101c3a0  add      x0, x29, #0x70
0x4753d530:  a9025bf5  stp      x21, x22, [sp, #0x20]
0x4753d534:  a90363f7  stp      x23, x24, [sp, #0x30]
0x4753d538:  2a0303f5  mov      w21, w3
0x4753d53c:  f90023f9  str      x25, [sp, #0x40]
0x4753d540:  aa0103f8  mov      x24, x1
0x4753d544:  b81e8c06  str      w6, [x0, #-0x18]!
0x4753d548:  2a0203f7  mov      w23, w2
0x4753d54c:  290c0ba4  stp      w4, w2, [x29, #0x60]
0x4753d550:  2a0403f6  mov      w22, w4
0x4753d554:  f90037a1  str      x1, [x29, #0x68]
0x4753d558:  aa0003e4  mov      x4, x0
0x4753d55c:  91017fa3  add      x3, x29, #0x5f
0x4753d560:  910183a2  add      x2, x29, #0x60
0x4753d564:  910193a1  add      x1, x29, #0x64
0x4753d568:  9101a3a0  add      x0, x29, #0x68
0x4753d56c:  39017fa5  strb     w5, [x29, #0x5f]
0x4753d570:  2a0603f4  mov      w20, w6
0x4753d574:  53001cb9  uxtb     w25, w5
0x4753d578:  97ffff09  bl       #0x4753d19c

----------------
IN:
0x4753d19c:  aa0003e6  mov      x6, x0
0x4753d1a0:  d0000000  adrp     x0, #0x4753f000
0x4753d1a4:  f9406800  ldr      x0, [x0, #0xd0]
0x4753d1a8:  b40000e0  cbz      x0, #0x4753d1c4

----------------
IN:
0x4753d1ac:  aa0403e5  mov      x5, x4
0x4753d1b0:  aa0303e4  mov      x4, x3
0x4753d1b4:  aa0203e3  mov      x3, x2
0x4753d1b8:  aa0103e2  mov      x2, x1
0x4753d1bc:  aa0603e1  mov      x1, x6
0x4753d1c0:  17ffff6f  b        #0x4753cf7c

12638@1582277983.172418:pl011_read addr 0x00000fe8 value 0x00000014
----------------
IN:
0x4753d000:  52800020  movz     w0, #0x1
0x4753d004:  52800013  movz     w19, #0
0x4753d008:  b90002a0  str      w0, [x21]
0x4753d00c:  17fffff4  b        #0x4753cfdc

----------------
IN:
0x4753cfdc:  b9400302  ldr      w2, [x24]
0x4753cfe0:  7100145f  cmp      w2, #5
0x4753cfe4:  54000508  b.hi     #0x4753d084

12638@1582277983.172518:pl011_read addr 0x00000030 value 0x00000301
12638@1582277983.172523:pl011_read addr 0x0000002c value 0x00000070
----------------
IN:
0x4753d0e4:  91006298  add      x24, x20, #0x18
0x4753d0e8:  aa1803e0  mov      x0, x24
0x4753d0ec:  97ffff91  bl       #0x4753cf30

12638@1582277983.172561:pl011_read addr 0x00000018 value 0x00000010
----------------
IN:
0x4753d0f0:  363fffc0  tbz      w0, #7, #0x4753d0e8

----------------
IN:
0x4753d0e8:  aa1803e0  mov      x0, x24
0x4753d0ec:  97ffff91  bl       #0x4753cf30

12638@1582277983.172625:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172629:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172633:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172636:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172640:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172643:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172647:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172650:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172654:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172658:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172661:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172665:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172668:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172672:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172675:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172679:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172682:pl011_read addr 0x00000018 value 0x00000010
12638@1582277983.172686:pl011_read addr 0x00000018 value 0x00000010
[keep looping]


