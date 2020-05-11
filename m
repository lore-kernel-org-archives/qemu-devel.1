Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983B3C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 03:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664852496A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 03:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664852496A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXyi2-0002Tx-LE
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 23:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jXyh8-0001Yr-Dd
 for qemu-devel@nongnu.org; Sun, 10 May 2020 23:01:30 -0400
Received: from relay64.bu.edu ([128.197.228.104]:57295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jXyh7-00009e-0e
 for qemu-devel@nongnu.org; Sun, 10 May 2020 23:01:29 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B2xuj8018668
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 10 May 2020 23:00:00 -0400
Date: Sun, 10 May 2020 22:59:56 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Assertion Failure in virtio_net_reset
Message-ID: <20200511025956.uojost3s6vxcecdf@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Cc: jasowang@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
While fuzzing, I found an input that triggers an assertion failure in
virtio-net.c:

hw/net/virtio-net.c:533: void virtio_net_reset(VirtIODevice *): Assertion `=
!virtio_net_get_subqueue(nc)->async_tx.elem' failed.

#9 0x55a33fa31b78 in virtio_net_reset hw/net/virtio-net.c:533:13
#10 0x55a33fc88412 in virtio_reset hw/virtio/virtio.c:1919:9
#11 0x55a341d82764 in virtio_bus_reset hw/virtio/virtio-bus.c:95:9
#12 0x55a341dba2de in virtio_pci_reset hw/virtio/virtio-pci.c:1824:5
#13 0x55a341db3e02 in virtio_pci_common_write hw/virtio/virtio-pci.c:1252:13
#14 0x55a33f62117b in memory_region_write_accessor memory.c:496:5
#15 0x55a33f6205e4 in access_with_adjusted_size memory.c:557:18
#16 0x55a33f61e177 in memory_region_dispatch_write memory.c:1488:16

I can reproduce it in a qemu 5.0 build using:
cat << EOF | qemu-system-i386 -M pc-q35-5.0 -netdev user,id=3Dqtest-bn0 -de=
vice virtio-net-pci,netdev=3Dqtest-bn0 -display none -nodefaults -nographic=
 -qtest stdio
outl 0xcf8 0x80000820
outl 0xcfc 0xe0004000
outl 0xcf8 0x80000824
outl 0xcfc 0xc021
outl 0xcf8 0x80000804
outw 0xcfc 0x7
outl 0xcf8 0x8000089a
write 0xc021e0004016 0x16 0x0100000000ff4f000100cd003d00000000000000f600
write 0x3d00d8 0xae 0x0100007a000a00000000000d00840100007a000a00000000000f0=
0840100007a000a00000000001100840100007a000a00000000001300840100007a000a0000=
0000001500840100007a000a00000000001700840100007a000a00000000001900840100007=
a000a00000000001b00840100007a000a00000000001d00840100007a000a00000000001f00=
840100007a000a00000000002100840100007a000a00000000002300840100007a000a
write 0xf60002 0x7 0x0a00000000000b
write 0xc021e0004014 0x9 0x95a4b3c2d1e0effe0d
write 0xc021e0004014 0x2a3 0x0000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000
EOF

I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146086 | qemu-system-i386 -M pc-q35-5.=
0 -netdev user,id=3Dqtest-bn0 -device virtio-net-pci,netdev=3Dqtest-bn0 -di=
splay none -nodefaults -nographic -qtest stdio

Please let me know if I can provide any further info.
-Alex

