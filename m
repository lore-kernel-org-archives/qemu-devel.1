Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C888C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFF8207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFF8207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY0ZP-0007fy-Dc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0YE-0007A8-8I
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:00:26 -0400
Received: from relay64.bu.edu ([128.197.228.104]:60206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0YC-0006ba-7E
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:00:24 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B4xC8l019165
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 11 May 2020 00:59:13 -0400
Date: Mon, 11 May 2020 00:59:12 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Abort in mch_update_pciexbar
Message-ID: <20200511045912.keffhizkobgwqcag@mozz.bu.edu>
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
mch_update_pciexbar:

#6 0x7f38d387c55a in abort /build/glibc-GwnBeO/glibc-2.30/stdlib/abort.c:79:7
#7 0x55c27e94ffd0 in mch_update_pciexbar hw/pci-host/q35.c:331:9
#8 0x55c27e94db38 in mch_write_config hw/pci-host/q35.c:487:9
#9 0x55c27e9e3f4c in pci_host_config_write_common hw/pci/pci_host.c:81:5
#10 0x55c27e9e5307 in pci_data_write hw/pci/pci_host.c:118:5
#11 0x55c27e9e6601 in pci_host_data_write hw/pci/pci_host.c:165:9
#12 0x55c27ca3b17b in memory_region_write_accessor memory.c:496:5
#13 0x55c27ca3a5e4 in access_with_adjusted_size memory.c:557:18
#14 0x55c27ca38177 in memory_region_dispatch_write memory.c:1488:16
#15 0x55c27c721325 in flatview_write_continue exec.c:3174:23
#16 0x55c27c70994d in flatview_write exec.c:3214:14
#17 0x55c27c709462 in address_space_write exec.c:3305:18

I can reproduce it in a qemu 5.0 build using:
cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
outl 0xcf8 0xf2000060
outl 0xcfc 0x8400056e
EOF

I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146095 | qemu-system-i386 -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio

Please let me know if I can provide any further info.
-Alex

