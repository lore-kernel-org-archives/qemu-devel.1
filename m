Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,SUBJ_OBFU_PUNCT_MANY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB64C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B492137B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B492137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY0iR-0005SU-4R
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0he-0004bt-Li
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:10:10 -0400
Received: from relay64.bu.edu ([128.197.228.104]:60427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0hd-0001cp-Ed
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:10:10 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B58wAN027929
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 11 May 2020 01:09:01 -0400
Date: Mon, 11 May 2020 01:08:58 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Assertion failure in pci_bus_get_irq_level through
 ich9_lpc_update_apic
Message-ID: <20200511050858.uy4aebywadbudwhw@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 23:01:23
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
While fuzzing, I found an input that triggers an assertion failure in
pci_bus_get_irq_level through ich9_lpc_update_apic:

int pci_bus_get_irq_level(PCIBus *, int): Assertion `irq_num < bus->nirq' failed.

#8 0x7fc7d4fa4091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
#9 0x5557c8639fe1 in pci_bus_get_irq_level hw/pci/pci.c:268:5
#10 0x5557c6b05693 in ich9_lpc_update_apic hw/isa/lpc_ich9.c:250:14
#11 0x5557c6b09167 in ich9_set_sci hw/isa/lpc_ich9.c:355:9
#12 0x5557c7c96f42 in qemu_set_irq hw/core/irq.c:44:5
#13 0x5557c7959379 in acpi_update_sci hw/acpi/core.c:723:5
#14 0x5557c7977dc3 in ich9_pm_update_sci_fn hw/acpi/ich9.c:56:5
#15 0x5557c795a80f in acpi_pm_evt_write hw/acpi/core.c:456:9
#16 0x5557c671a17b in memory_region_write_accessor memory.c:496:5

I can reproduce it in a qemu 5.0 build using:
cat << EOF | qemu-system-i386 -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
outl 0xcf8 0x8400f841
outl 0xcfc 0xebed205d
outl 0x5d02 0xedf82049
EOF

I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146096 | qemu-system-i386 -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio

Please let me know if I can provide any further info.
-Alex

