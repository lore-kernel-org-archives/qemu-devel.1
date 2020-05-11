Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,SUBJ_OBFU_PUNCT_MANY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57152C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2624520708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2624520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY0zQ-0004f9-2R
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0yp-0004EE-LG
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:27:55 -0400
Received: from relay64.bu.edu ([128.197.228.104]:60834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jY0yo-0004RZ-9k
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:27:54 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04B5Qktq011814
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 11 May 2020 01:26:47 -0400
Date: Mon, 11 May 2020 01:26:46 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Assertion failure in net_tx_pkt_add_raw_fragment through e1000e
Message-ID: <20200511052646.dvrpsgb2i4bkiuga@mozz.bu.edu>
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
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
While fuzzing, I found an input that triggers an assertion failure in
net_tx_pkt_add_raw_fragment through the e1000e:

_Bool net_tx_pkt_add_raw_fragment(struct NetTxPkt *, hwaddr, size_t): Asser=
tion `pkt->max_raw_frags > pkt->raw_frags' failed.

#8 0x7f2930b0d091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/as=
sert.c:101:3
#9 0x55a2900f9d9f in net_tx_pkt_add_raw_fragment hw/net/net_tx_pkt.c:382:5
#10 0x55a2901a4ab6 in e1000e_process_tx_desc hw/net/e1000e_core.c:731:14
#11 0x55a2901a331d in e1000e_start_xmit hw/net/e1000e_core.c:934:9
#12 0x55a2901899c2 in e1000e_set_tctl hw/net/e1000e_core.c:2431:9
#13 0x55a29014490a in e1000e_core_write hw/net/e1000e_core.c:3256:9
#14 0x55a29012c83b in e1000e_mmio_write hw/net/e1000e.c:109:5
#15 0x55a28e48617b in memory_region_write_accessor memory.c:496:5
#16 0x55a28e4855e4 in access_with_adjusted_size memory.c:557:18
#17 0x55a28e483177 in memory_region_dispatch_write memory.c:1488:16
#18 0x55a28e16c325 in flatview_write_continue exec.c:3174:23
#19 0x55a28e15494d in flatview_write exec.c:3214:14
#20 0x55a28e154462 in address_space_write exec.c:3305:18
#21 0x55a28e154d3a in address_space_rw exec.c:3315:16
#22 0x55a2901644ec in dma_memory_rw_relaxed include/sysemu/dma.h:87:18
#23 0x55a290163de1 in dma_memory_rw include/sysemu/dma.h:110:12
#24 0x55a290163cc2 in pci_dma_rw include/hw/pci/pci.h:786:5
#25 0x55a290161f1f in pci_dma_write include/hw/pci/pci.h:799:12
#26 0x55a29013f97c in e1000e_write_packet_to_guest hw/net/e1000e_core.c:160=
9:9
#27 0x55a2901391e0 in e1000e_receive_iov hw/net/e1000e_core.c:1709:9
#28 0x55a290132a80 in e1000e_nc_receive_iov hw/net/e1000e.c:213:12
#29 0x55a2900ff52b in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544:9
#30 0x55a2900fde76 in net_tx_pkt_send hw/net/net_tx_pkt.c:620:9
#31 0x55a290100f2d in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633:11
#32 0x55a2901a93d6 in e1000e_tx_pkt_send hw/net/e1000e_core.c:664:16
#33 0x55a2901a57b6 in e1000e_process_tx_desc hw/net/e1000e_core.c:743:17
#34 0x55a2901a331d in e1000e_start_xmit hw/net/e1000e_core.c:934:9
#35 0x55a2901899c2 in e1000e_set_tctl hw/net/e1000e_core.c:2431:9
#36 0x55a29014490a in e1000e_core_write hw/net/e1000e_core.c:3256:9
#37 0x55a29012c83b in e1000e_mmio_write hw/net/e1000e.c:109:5
=2E.. Much Later ...
#244 0x55a29012c83b in e1000e_mmio_write hw/net/e1000e.c:109:5
#245 0x55a28e48617b in memory_region_write_accessor memory.c:496:5
#246 0x55a28e4855e4 in access_with_adjusted_size memory.c:557:18
#247 0x55a28e483177 in memory_region_dispatch_write memory.c:1488:16
#248 0x55a28e16c325 in flatview_write_continue exec.c:3174:23
#249 0x55a28e15494d in flatview_write exec.c:3214:14
#250 0x55a28e154462 in address_space_write exec.c:3305:18
#251 0x55a28e154d3a in address_space_rw exec.c:3315:16
#252 0x55a2901644ec in dma_memory_rw_relaxed include/sysemu/dma.h:87:18
#253 0x55a290163de1 in dma_memory_rw include/sysemu/dma.h:110:12
#254 0x55a290163cc2 in pci_dma_rw include/hw/pci/pci.h:786:5

I can reproduce it in a qemu 5.0 build using:
cat << EOF | qemu-system-i386 -M pc-q35-5.0 -nographic -display none -seria=
l none -monitor none -qtest stdio
outl 0xcf8 0x80001010
outl 0xcfc 0xe1020000
outl 0xcf8 0x80001014
outl 0xcf8 0x80001004
outw 0xcfc 0x7
outl 0xcf8 0x800010a2
write 0xe10207e8 0x4 0x25ff13ff
write 0xe10200b8 0x382 0xe3055e411b0202e10000000006ffe5055e411b0202e1000000=
0006ffe7055e411b0202e10000000006ffe9055e411b0202e10000000006ffeb055e411b020=
2e10000000006ffed055e411b0202e10000000006ffef055e411b0202e10000000006fff105=
5e411b0202e10000000006fff3055e411b0202e10000000006fff5055e411b0202e10000000=
006fff7055e411b0202e10000000006fff9055e411b0202e10000000006fffb055e411b0202=
e10000000006fffd055e411b0202e10000000006ffff055e411b0202e10000000006ff01055=
e411b0202e10000000006ff03055e411b0202e10000000006ff05055e411b0202e100000000=
06ff07055e411b0202e10000000006ff09055e411b0202e10000000006ff0b055e411b0202e=
10000000006ff0d055e411b0202e10000000006ff0f055e411b0202e10000000006ff11055e=
411b0202e10000000006ff13055e411b0202e10000000006ff15055e411b0202e1000000000=
6ff17055e411b0202e10000000006ff19055e411b0202e10000000006ff1b055e411b0202e1=
0000000006ff1d055e411b0202e10000000006ff1f055e411b0202e10000000006ff21055e4=
11b0202e10000000006ff23055e411b0202e10000000006ff25055e411b0202e10000000006=
ff27055e411b0202e10000000006ff29055e411b0202e10000000006ff2b055e411b0202e10=
000000006ff2d055e411b0202e10000000006ff2f055e411b0202e10000000006ff31055e41=
1b0202e10000000006ff33055e411b0202e10000000006ff35055e411b0202e10000000006f=
f37055e411b0202e10000000006ff39055e411b0202e10000000006ff3b055e411b0202e100=
00000006ff3d055e411b0202e10000000006ff3f055e411b0202e10000000006ff41055e411=
b0202e10000000006ff43055e411b0202e10000000006ff45055e411b0202e10000000006ff=
47055e411b0202e10000000006ff49055e411b0202e10000000006ff4b055e411b0202e1000=
0000006ff4d055e411b0202e10000000006ff4f055e411b0202e10000000006ff51055e411b=
0202e10000000006ff53055e411b0202e10000000006ff55055e411b0202e10000000006ff5=
7055e411b0202e10000000006ff59055e411b0202e10000000006ff5b055e411b0202e10000=
000006ff5d055e411b0202e10000000006ff5f055e411b0202e10000000006ff61055e411b0=
202e10000000006ff6305
EOF

I also uploaded the above trace, in case the formatting is broken:

curl https://paste.debian.net/plain/1146097 | qemu-system-i386 -M pc-q35-5.=
0 -nographic -display none -serial none -monitor none -qtest stdio

Please let me know if I can provide any further info.
-Alex

