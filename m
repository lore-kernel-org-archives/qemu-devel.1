Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,SUBJ_OBFU_PUNCT_MANY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF0C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA752075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 04:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA752075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXzjP-00067E-VT
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 00:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jXzif-0005YS-Cn
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:07:09 -0400
Received: from relay64.bu.edu ([128.197.228.104]:58928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jXzie-0005Rc-8p
 for qemu-devel@nongnu.org; Mon, 11 May 2020 00:07:08 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B46NYF007720
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 11 May 2020 00:06:27 -0400
Date: Mon, 11 May 2020 00:06:22 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Assertion failure through virtio_blk_req_complete
Message-ID: <20200511040622.xus3eqvsxbjkfum2@mozz.bu.edu>
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
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
While fuzzing, I found an input that triggers an assertion through
virtio-blk.c:

void address_space_unmap(AddressSpace *, void *, hwaddr, int, hwaddr): Assertion `mr != NULL' failed

#8 0x7fa947707091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
#9 0x55ec68a73a97 in address_space_unmap exec.c:3619:9
#10 0x55ec6943ffab in dma_memory_unmap include/sysemu/dma.h:145:5
#11 0x55ec693e2df6 in virtqueue_unmap_sg hw/virtio/virtio.c:640:9
#12 0x55ec693e435b in virtqueue_fill hw/virtio/virtio.c:789:5
#13 0x55ec693e8cf0 in virtqueue_push hw/virtio/virtio.c:863:5
#14 0x55ec68ff73ce in virtio_blk_req_complete hw/block/virtio-blk.c:83:5
#15 0x55ec68ff037e in virtio_blk_handle_request hw/block/virtio-blk.c:671:13
#16 0x55ec68fec4c0 in virtio_blk_handle_vq hw/block/virtio-blk.c:780:17
#17 0x55ec6901ae79 in virtio_blk_handle_output_do hw/block/virtio-blk.c:803:5
#18 0x55ec6901a336 in virtio_blk_handle_output hw/block/virtio-blk.c:819:5
#19 0x55ec694168f0 in virtio_queue_notify hw/virtio/virtio.c:2284:9
#20 0x55ec6b55abc5 in virtio_mmio_write hw/virtio/virtio-mmio.c:369:13
#21 0x55ec68d9e17b in memory_region_write_accessor memory.c:496:5

I can reproduce it in a qemu 5.0 build using:
cat << EOF | qemu-system-i386 -M pc-q35-5.0 -M microvm,x-option-roms=off,pit=off,pic=off,isa-serial=off,rtc=off -nographic -device virtio-blk-device,drive=mydrive,scsi=true -drive file=null-co://,id=mydrive,if=none,format=raw -nographic -monitor none -display none -serial none -qtest stdio
write 0x1ba000b 0x12 0x01820040bf07f0ffffffffffff3328000101
write 0x1ba1003 0x2 0x0101
write 0xc0000e28 0x2c 0x000046dd000000000049dd00000000004cdd00000000004fdd000000000052dd000000000055dd0000000000
EOF

I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146092 | qemu-system-i386 -M pc-q35-5.0 -M microvm,x-option-roms=off,pit=off,pic=off,isa-serial=off,rtc=off -nographic -device virtio-blk-device,drive=mydrive,scsi=true -drive file=null-co://,id=mydrive,if=none,format=raw -nographic -monitor none -display none -serial none -qtest stdio

Please let me know if I can provide any further info.
-Alex

