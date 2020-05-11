Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,SUBJ_OBFU_PUNCT_MANY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B518C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 03:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB0620746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 03:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB0620746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXzAG-0005D6-6m
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 23:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jXz9f-0004em-Bv
 for qemu-devel@nongnu.org; Sun, 10 May 2020 23:30:59 -0400
Received: from relay64.bu.edu ([128.197.228.104]:58013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jXz9Z-0001zi-MM
 for qemu-devel@nongnu.org; Sun, 10 May 2020 23:30:58 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B3U1gn010537
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 10 May 2020 23:30:04 -0400
Date: Sun, 10 May 2020 23:30:01 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Assertion failure through virtio_lduw_phys_cached
Message-ID: <20200511033001.dzvtbdhl3oz5pgiy@mozz.bu.edu>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
While fuzzing, I found an input that triggers an assertion failure in
address_space_lduw_le_cached:

void address_space_stw_le_cached(MemoryRegionCache *, hwaddr, uint32_t, MemTxAttrs, MemTxResult *): Assertion `addr < cache->len && 2 <= cache->len - addr' failed.
#8 0x7f53dabda091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
#9 0x55f01d844a59 in address_space_lduw_le_cached include/exec/memory_ldst_cached.inc.h:54:5
#10 0x55f01d8436c9 in lduw_le_phys_cached include/exec/memory_ldst_phys.inc.h:91:12
#11 0x55f01d842c92 in virtio_lduw_phys_cached include/hw/virtio/virtio-access.h:166:12
#12 0x55f01d84d754 in vring_avail_ring hw/virtio/virtio.c:311:12
#13 0x55f01d853c00 in vring_get_used_event hw/virtio/virtio.c:317:12
#14 0x55f01d853274 in virtio_split_should_notify hw/virtio/virtio.c:2391:35
#15 0x55f01d81fc6c in virtio_should_notify hw/virtio/virtio.c:2438:16
#16 0x55f01d820237 in virtio_notify hw/virtio/virtio.c:2480:14
#17 0x55f01d5cd6f0 in virtio_net_flush_tx hw/net/virtio-net.c:2212:9
#18 0x55f01d5c9633 in virtio_net_tx_bh hw/net/virtio-net.c:2319:11
#19 0x55f020ed0ca7 in aio_bh_call util/async.c:136:5

I can reproduce it in a qemu 5.0 build with:
cat << EOF | qemu-system-i386 -M pc-q35-5.0 -netdev user,id=qtest-bn0 -device virtio-net-pci,netdev=qtest-bn0 -display none -nodefaults -nographic -qtest stdio
outl 0xcf8 0x80000820
outl 0xcfc 0xe0004000
outl 0xcf8 0x80000824
outl 0xcfc 0xc021
outl 0xcf8 0x80000804
outw 0xcfc 0x7
outl 0xcf8 0x80000814
write 0xc021e0004016 0x1 0x01
write 0xc021e0004024 0x1 0x06
write 0xc021e000401c 0x1 0x37
write 0xc021e0004016 0x1 0x27
write 0xc021e000400c 0x9 0xffffffffffffffffff
EOF

I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146088 | qemu-system-i386 -M pc-q35-5.0 -netdev user,id=qtest-bn0 -device virtio-net-pci,netdev=qtest-bn0 -display none -nodefaults -nographic -qtest stdio

Please let me know if I can provide any further info.
-Alex

