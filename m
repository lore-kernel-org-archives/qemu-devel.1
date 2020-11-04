Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76231C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF64920825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR8nUJTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF64920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQdV-0008I2-Ep
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaQcV-0007PA-U0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaQcT-0007uP-It
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604526424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VfA75Wzi2zjZl6G2MaspB5yBKGQr8LDzaBPy6rJVzY=;
 b=KR8nUJTVaRqvFOLm4RB1Qms3uNwxVvCNuQlzW3AH9SKnMZh0ay125TJAWlmp/vrNXoljar
 mrdtn7JA23a2NGKwqRPBC6wBPRsa70YJnEhT7EB2upg/09Ex/RBmPDMy/PjHilOw8D2230
 ZzuqGR+UdRdlK2gW1BiAzS/eSZu5oBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-izsKXGCzP86ODJJSDc4Jmw-1; Wed, 04 Nov 2020 16:47:00 -0500
X-MC-Unique: izsKXGCzP86ODJJSDc4Jmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 225338049C3;
 Wed,  4 Nov 2020 21:46:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-163.ams2.redhat.com
 [10.36.112.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A357A75129;
 Wed,  4 Nov 2020 21:46:56 +0000 (UTC)
Subject: Re: Question on UEFI ACPI tables setup and probing on arm64
To: Igor Mammedov <imammedo@redhat.com>, Ying Fang <fangying1@huawei.com>
References: <ee3b7fdf-f6ba-cafc-5b44-42b0bcda01c5@huawei.com>
 <20201103133913.1fee3337@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a79383a6-92d4-5b10-d143-414543caab70@redhat.com>
Date: Wed, 4 Nov 2020 22:46:55 +0100
MIME-Version: 1.0
In-Reply-To: <20201103133913.1fee3337@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Drew Jones <drjones@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "wangzhigang17@huawei.com" <wangzhigang17@huawei.com>,
 "Ard Biesheuvel \(ARM address\)" <ard.biesheuvel@arm.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Ard, +Drew

On 11/03/20 13:39, Igor Mammedov wrote:
> On Fri, 30 Oct 2020 10:50:01 +0800
> Ying Fang <fangying1@huawei.com> wrote:
> 
>> Hi,
>>
>> I have a question on UEFI/ACPI tables setup and probing on arm64 platform.
> 
> CCing Laszlo,
> who might know how it's implemented.
>  
>> Currently on arm64 platform guest can be booted with both fdt and ACPI
>> supported. If ACPI is enabled, [1] says the only defined method for
>> passing ACPI tables to the kernel is via the UEFI system configuration
>> table. So AFAIK, ACPI Should be dependent on UEFI.

That's correct. The ACPI entry point (RSD PTR) on AARCH64 is defined in
terms of UEFI.

>>
>> What's more [2] says UEFI kernel support on the ARM architectures
>> is only available through a *stub*. The stub populates the FDT /chosen
>> node with some UEFI parameters describing the UEFI location info.

Yes.

>>
>> So i dump /sys/firmware/fdt from the guest, it does have something like:
>>
>> /dts-v1/;
>>
>> / {
>> 	#size-cells = <0x02>;
>> 	#address-cells = <0x02>;
>>
>> 	chosen {
>> 		linux,uefi-mmap-desc-ver = <0x01>;
>> 		linux,uefi-mmap-desc-size = <0x30>;
>> 		linux,uefi-mmap-size = <0x810>;
>> 		linux,uefi-mmap-start = <0x04 0x3c0ce018>;
>> 		linux,uefi-system-table = <0x04 0x3f8b0018>;
>> 		bootargs = "BOOT_IMAGE=/vmlinuz-4.19.90-2003.4.0.0036.oe1.aarch64 
>> root=/dev/mapper/openeuler-root ro rd.lvm.lv=openeuler/root 
>> rd.lvm.lv=openeuler/swap video=VGA-1:640x480-32@60me 
>> smmu.bypassdev=0x1000:0x17 smmu.bypassdev=0x1000:0x15 
>> crashkernel=1024M,high video=efifb:off video=VGA-1:640x480-32@60me";
>> 		linux,initrd-end = <0x04 0x3a85a5da>;
>> 		linux,initrd-start = <0x04 0x392f2000>;
>> 	};
>> };
>>
>> But the question is that I did not see any code adding the uefi
>> in fdt chosen node in *arm_load_dtb* or anywhere else.

That's because the "UEFI stub" is a part of the guest kernel. It wraps
the guest kernel image into a UEFI application binary. For a while, the
guest kernel runs as a UEFI application, stashing some UEFI artifacts in
*a* device tree, and then (after some other heavy lifting) jumping into
the kernel proper.

>> Qemu only maps the OVMF binary file into a pflash device.
>> So I'm really confused on how UEFI information is provided to
>> guest by qemu. Does anybody know of the details about it ?

It's complex, unfortunately.

(1) QEMU always generates a DTB for the guest firmware. This DTB is
placed at the base of the guest RAM.

See the arm_load_dtb() call in virt_machine_done() [hw/arm/virt.c] in
QEMU. I think.


(2) QEMU generates ACPI content, and exposes it via fw_cfg.

See the virt_acpi_setup() call in the same virt_machine_done() function
[hw/arm/virt.c] in QEMU.


(3) The fw_cfg device itself is apparent to the guest firmware via the
DTB from point (1). See the following steps in edk2:

(3a) "ArmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.c"

This saves the initial DTB (from the base of guest RAM, where it could
be overwritten by whatever) to a dynamically allocated area. This
"stashing" occurs early.

(3b) "ArmVirtPkg/FdtClientDxe/FdtClientDxe.c"

This driver exposes the (dynamically reallocated / copied) DTB via a
custom UEFI protocol to the rest of the firmware. (This happens much
later.) This protocol / driver can be considered the "owner" of the
stashed DTB from (3a).

(3c) "ArmVirtPkg/Library/QemuFwCfgLib/QemuFwCfgLib.c"

This is the fw_cfg device access library, discovering the fw_cfg
registers via the above UEFI protocol. The library is linked into each
firmware module that needs fw_cfg access.


(4) The firmware interprets QEMU's DTB for actual content (parsing
values, configuring hardware, accessing devices).

This occurs in a whole bunch of locations, mostly via consuming the
custom protocol from (3b). Some info that's needed very early is parsed
out of the DTB right in step (3a).


(5) The guest firmware has a dedicated driver that checks whether QEMU
was configured with ACPI enabled or disabled, and publishes that choice
to the rest of the firmware. This is necessary because some firmware
actions / infrastructure parts cannot (must not) proceed until this
decision has been interpreted.

See in edk2:

- ArmVirtPkg/PlatformHasAcpiDtDxe

This driver keys off of the presence of the "etc/table-loader" fw_cfg
file, coming from step (2), using the fw_cfg access library from step (3c).

If ACPI was enabled on the QEMU cmdline, then the rest of the firmware
is "level-triggered" to proceed with the ACPI infrastructure.

Otherwise, the rest of the firmware is "level-triggered" that DT was
chosen for the OS.

("Level-triggering" means the installation of custom NULL protocols,
which permits drivers dependent on DT vs ACPI to be dispatched.)


(6) If DT was selected (ACPI was disabled), per step (5), then
FdtClientDxe (introduced under step (3b)) has another job: it forwards
the original stashed DTB (see (3a)) to the guest OS.

This "DTB forwarding" occurs through a particular UEFI config table; the
GUID is B1B621D5-F19C-41A5-830B-D9152C69AAE0 -- known as
DEVICE_TREE_GUID in the kernel ("include/linux/efi.h").

See the OnPlatformHasDeviceTree() function in
"ArmVirtPkg/FdtClientDxe/FdtClientDxe.c", in edk2.


(7) If ACPI was selected instead, according to step (5), then through
the fw_cfg access described in (3c), the guest firmware "blindly"
processes the ACPI payload from QEMU (from step (2)).

This "blind processing" means that the guest firmware runs the "ACPI
linker/loader script" (the "etc/table-loader" fw_cfg file), installing a
number of ACPI tables for the guest OS. The guest firmware does not
interpret the ACPI tables.

"Installing ACPI tables" ultimately means exposing stuff under the
particular UEFI config table that stands for the RSD PTR -- the GUID is
8868E871-E4F1-11D3-BC22-0080C73C8881. (Known as ACPI_20_TABLE_GUID in
Linux, "include/linux/efi.h".)

See the following in edk2:

- OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpiPlatformDxe.inf

In this case, the guest firmware does not forward QEMU's original DTB to
the guest OS.


(8) Ultimately, from the guest OS's point of view, a UEFI config table
for *either* the RSD PTR (ACPI_20_TABLE_GUID) *or* QEMU's DTB
(DEVICE_TREE_GUID) is going to exist.


(9) (Ard, please correct the below if necessary; thanks.)

The UEFI stub of the guest kernel (which is a UEFI application) uses a
device tree as its main communication channel to the (later-started)
kernel entry point, AIUI.

The UEFI stub basically inverts the importance of the UEFI system table
versus the device tree -- the UEFI stub *converts* the UEFI system table
(the multitude of UEFI config tables) into a device tree. This is my
understanding anyway.

(9a) If ACPI was disabled on the QEMU command line, then the guest
kernel *adopts* the device tree that was forwarded to it in (6), via the
UEFI config table marked with DEVICE_TREE_GUID.

(9b) If ACPI was enabled on the QEMU command line, then the UEFI stub
creates a brand new (empty) device tree (AIUI).

Either way, the UEFI system table is linked *under* the -- adopted or
new -- device tree, through the "chosen" node. And so, if ACPI was
enabled, the ACPI RSD PTR (coming from step (7)) becomes visible to the
kernel proper as well, through the UEFI config table with
ACPI_20_TABLE_GUID.

I believe this is implemented under "drivers/firmware/efi/libstub" in
the kernel tree.

Thanks,
Laszlo


