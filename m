Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CFE20820
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CFE20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY0HT-0008Lg-9y
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 00:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0Gu-0007XE-Fk
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:42:32 -0400
Received: from relay64.bu.edu ([128.197.228.104]:59789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0Gt-0000UH-94
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:42:32 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B4fL1M004046
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 11 May 2020 00:41:26 -0400
Date: Mon, 11 May 2020 00:41:21 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Null-pointer dereference through virtio-balloon
Message-ID: <20200511044121.eihns2tdimdzgi4i@mozz.bu.edu>
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
While fuzzing, I found an input that triggers a null-ptr dereference in
aio_bh_enqueue, through virtio-balloon. Based on the stacktrace below,
I am not positive that this is specific to virtio-balloon, however
I have not encountered the same issue for any of the other virtio
devices I am fuzzing.

AddressSanitizer: SEGV on unknown address 0x000000000000

#0 0x55ee5b93eb28 in aio_bh_enqueue util/async.c:69:27
#1 0x55ee5b93eb28 in qemu_bh_schedule util/async.c:181:5
#2 0x55ee5ae71465 in virtio_queue_notify hw/virtio/virtio.c:2364:9
#3 0x55ee5b51142d in virtio_mmio_write hw/virtio/virtio-mmio.c:369:13
#4 0x55ee5ad0d2d6 in memory_region_write_accessor memory.c:483:5
#5 0x55ee5ad0cc7f in access_with_adjusted_size memory.c:544:18
#6 0x55ee5ad0cc7f in memory_region_dispatch_write memory.c:1476:16
#7 0x55ee5ac221d3 in flatview_write_continue exec.c:3137:23
#8 0x55ee5ac1ab97 in flatview_write exec.c:3177:14
#9 0x55ee5ac1ab97 in address_space_write exec.c:3268:18

I can reproduce it in a qemu 5.0 build using:
cat << EOF | qemu-system-i386 -M pc-q35-5.0 -M microvm,x-option-roms=off,pit=off,pic=off,isa-serial=off,rtc=off -nographic -device virtio-balloon-device,free-page-hint=true,deflate-on-oom=true -nographic -monitor none -display none -serial none -qtest stdio
write 0xc0000e30 0x24 0x030000000300000003000000030000000300000003000000030000000300000003000000
EOF


I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146094 | qemu-system-i386 -M pc-q35-5.0 -M microvm,x-option-roms=off,pit=off,pic=off,isa-serial=off,rtc=off -nographic -device virtio-balloon-device,free-page-hint=true,deflate-on-oom=true -nographic -monitor none -display none -serial none -qtest stdio

Please let me know if I can provide any further info.
-Alex

