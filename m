Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE23C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C2120771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C2120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycIJ-00052R-3d
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.lauterer@proxmox.com>)
 id 1jycHK-0004DB-AS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:32:58 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:26993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.lauterer@proxmox.com>)
 id 1jycHI-00087G-5m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:32:57 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CA6114333E;
 Thu, 23 Jul 2020 16:24:06 +0200 (CEST)
To: qemu-devel <qemu-devel@nongnu.org>
From: Aaron Lauterer <a.lauterer@proxmox.com>
Subject: Possible regression with VGA and resolutions in Windows 10?
Message-ID: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
Date: Thu, 23 Jul 2020 16:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=a.lauterer@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 10:24:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

I think we have a regression introduced in commit 0221d73ce6.

Once I start a Windows 10 VM (build 18363) with `-device VGA` I have only the following resolutions to choose from instead of the much longer list:

1920x1080
1024x768
800x600

Linux guests work fine.

qemu-system-x86_64 \
   -name windows-resolution-test \
   -smp '2,sockets=1,cores=2,maxcpus=2' \
   -nodefaults \
   -cpu host,+kvm_pv_eoi,+kvm_pv_unhalt \
   -m 3072 \
   -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
   -device 'usb-tablet,id=tablet,bus=uhci.0,port=1' \
   -device 'VGA,id=vga,vgamem_mb=32,bus=pci.0,addr=0x2' \
   -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
   -drive 'file=/dev/zvol/rpool/data/vm-102-disk-0,if=none,id=drive-scsi0,discard=on,format=raw,cache=none,aio=native,detect-zeroes=unmap' \
   -device 'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,rotation_rate=1,bootindex=100' \
   -machine pc,accel=kvm


I have not yet gotten around to bisect the SeaBIOS repository to know exactly which commit there is causing it.

If this is better handled at the SeaBIOS mailing list, let me know.


Aaron


