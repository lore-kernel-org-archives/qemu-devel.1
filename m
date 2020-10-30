Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97766C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D37220782
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D37220782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKVs-0005ww-2a
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kYKUh-0005If-IL; Thu, 29 Oct 2020 22:50:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kYKUf-0003U7-J4; Thu, 29 Oct 2020 22:50:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMmxw0yrsz15L2G;
 Fri, 30 Oct 2020 10:50:12 +0800 (CST)
Received: from [10.174.186.67] (10.174.186.67) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 10:50:01 +0800
From: Ying Fang <fangying1@huawei.com>
Subject: Question on UEFI ACPI tables setup and probing on arm64
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <ee3b7fdf-f6ba-cafc-5b44-42b0bcda01c5@huawei.com>
Date: Fri, 30 Oct 2020 10:50:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 20:41:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 philmd@redhat.com, "wangzhigang17@huawei.com" <wangzhigang17@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I have a question on UEFI/ACPI tables setup and probing on arm64 platform.

Currently on arm64 platform guest can be booted with both fdt and ACPI
supported. If ACPI is enabled, [1] says the only defined method for
passing ACPI tables to the kernel is via the UEFI system configuration
table. So AFAIK, ACPI Should be dependent on UEFI.

What's more [2] says UEFI kernel support on the ARM architectures
is only available through a *stub*. The stub populates the FDT /chosen
node with some UEFI parameters describing the UEFI location info.

So i dump /sys/firmware/fdt from the guest, it does have something like:

/dts-v1/;

/ {
	#size-cells = <0x02>;
	#address-cells = <0x02>;

	chosen {
		linux,uefi-mmap-desc-ver = <0x01>;
		linux,uefi-mmap-desc-size = <0x30>;
		linux,uefi-mmap-size = <0x810>;
		linux,uefi-mmap-start = <0x04 0x3c0ce018>;
		linux,uefi-system-table = <0x04 0x3f8b0018>;
		bootargs = "BOOT_IMAGE=/vmlinuz-4.19.90-2003.4.0.0036.oe1.aarch64 
root=/dev/mapper/openeuler-root ro rd.lvm.lv=openeuler/root 
rd.lvm.lv=openeuler/swap video=VGA-1:640x480-32@60me 
smmu.bypassdev=0x1000:0x17 smmu.bypassdev=0x1000:0x15 
crashkernel=1024M,high video=efifb:off video=VGA-1:640x480-32@60me";
		linux,initrd-end = <0x04 0x3a85a5da>;
		linux,initrd-start = <0x04 0x392f2000>;
	};
};

But the question is that I did not see any code adding the uefi
in fdt chosen node in *arm_load_dtb* or anywhere else.
Qemu only maps the OVMF binary file into a pflash device.
So I'm really confused on how UEFI information is provided to
guest by qemu. Does anybody know of the details about it ?

[1] https://www.kernel.org/doc/html/latest/arm64/arm-acpi.html
[2] https://www.kernel.org/doc/Documentation/arm/uefi.rst

Thanks.
Ying

