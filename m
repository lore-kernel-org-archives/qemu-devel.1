Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CFCC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1DE20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1DE20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAkuS-0002UF-7e
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAktn-00022H-Nu
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:10:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:42706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAktj-0006XU-6Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 22:10:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kAkth-00022r-0l
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:10:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F33672E80DB
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2020 02:04:05 -0000
From: Alexander Bulekov <1892963@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159840744589.657.13420808045865515102.malonedeb@wampee.canonical.com>
Subject: [Bug 1892963] [NEW] Heap-use-after-free in put_dwords through
 ehci_flush_qh
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: f7f18c81ff147f2eeb3464cbb1ff921ec95205c5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 20:10:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1892963 <1892963@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
Reproducer:

cat << EOF | ./qemu-system-i386 -machine q35 \
-device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,\
multifunction=3Don,id=3Dich9-ehci-1 \
-drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom \
-device usb-storage,bus=3Dich9-ehci-1.0,\
port=3D2,drive=3Dusbcdrom \
-display none -nodefaults -qtest stdio -accel qtest
outl 0xcf8 0x8000ef02
outl 0xcfc 0xfbff0061
outl 0xcf8 0x8000ef11
outl 0xcfc 0x60606060
writeq 0x60606065 0xb70560ff84ffff7f
writeq 0x60606065 0xff0004fe050000ff
writeq 0x60606020 0xff015e5c057b0039
writeq 0x60606033 0x846c8a0200000611
write 0x2000004 0x4 0x4a606060
write 0x8 0x4 0x97a98095
write 0x0 0x4 0x4a606060
write 0x4 0x4 0x97a98095
write 0xc 0x4 0x4a606060
write 0x10 0x4 0x97a98095
write 0x14 0x4 0x4a606060
write 0x18 0x4 0x97a98095
write 0x1c 0x4 0x4a606060
clock_step
EOF

The trace:
797726@1598407357.169284:usb_port_claim bus 0, port 2
797726@1598407357.169585:usb_port_attach bus 0, port 2, devspeed full+high+=
super, portspeed high
797726@1598407357.169598:usb_ehci_port_attach attach port #1, owner ehci, d=
evice QEMU USB MSD
797726@1598407357.169608:usb_ehci_irq level 0, frindex 0x0000, sts 0x4, mas=
k 0x0
797726@1598407357.186943:usb_ehci_reset =3D=3D=3D RESET =3D=3D=3D
797726@1598407357.186960:usb_ehci_port_detach detach port #1, owner ehci
797726@1598407357.186968:usb_ehci_irq level 0, frindex 0x0000, sts 0x4, mas=
k 0x0
797726@1598407357.186976:usb_ehci_irq level 0, frindex 0x0000, sts 0x1000, =
mask 0x0
797726@1598407357.186984:usb_ehci_port_attach attach port #1, owner ehci, d=
evice QEMU USB MSD
797726@1598407357.186989:usb_ehci_irq level 0, frindex 0x0000, sts 0x1004, =
mask 0x0
[R +0.073737] outl 0xcf8 0x8000ef02
OK
[S +0.073774] OK
[R +0.073801] outl 0xcfc 0xfbff0061
OK
[S +0.075074] OK
[R +0.075108] outl 0xcf8 0x8000ef11
OK
[S +0.075126] OK
[R +0.075135] outl 0xcfc 0x60606060
OK
[S +0.076290] OK
[R +0.076317] writeq 0x60606065 0xb70560ff84ffff7f
797726@1598407357.194959:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =3D =
0x560ff84
797726@1598407357.194967:usb_ehci_port_reset reset port #1 - 1
797726@1598407357.194971:usb_ehci_port_suspend port #1
797726@1598407357.194975:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =3D=
 0x601183 (old: 0x1003)
OK
[S +0.076363] OK
[R +0.076377] writeq 0x60606065 0xff0004fe050000ff
797726@1598407357.195005:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =3D =
0x4fe05
797726@1598407357.195011:usb_ehci_port_reset reset port #1 - 0
797726@1598407357.195019:usb_ehci_port_detach detach port #1, owner ehci
797726@1598407357.195026:usb_ehci_irq level 0, frindex 0x0000, sts 0x1004, =
mask 0x0
797726@1598407357.195034:usb_ehci_port_attach attach port #1, owner ehci, d=
evice QEMU USB MSD
797726@1598407357.195038:usb_ehci_irq level 0, frindex 0x0000, sts 0x1004, =
mask 0x0
797726@1598407357.195049:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =3D=
 0x1005 (old: 0x601183)
OK
[S +0.076439] OK
[R +0.076457] writeq 0x60606020 0xff015e5c057b0039
797726@1598407357.195087:usb_ehci_opreg_write wr mmio 0x0020 [USBCMD] =3D 0=
x57b0039
attempt to set frame list size -- value 8
797726@1598407357.195097:usb_ehci_usbsts usbsts HALT 0
797726@1598407357.195105:usb_ehci_opreg_change ch mmio 0x0020 [USBCMD] =3D =
0x57b0031 (old: 0x80000)
797726@1598407357.195111:usb_ehci_opreg_write wr mmio 0x0024 [USBSTS] =3D 0=
xff015e5c
797726@1598407357.195117:usb_ehci_usbsts usbsts PCD 0
797726@1598407357.195120:usb_ehci_usbsts usbsts FLR 0
797726@1598407357.195124:usb_ehci_usbsts usbsts HSE 0
797726@1598407357.195127:usb_ehci_irq level 0, frindex 0x0000, sts 0x0, mas=
k 0x0
797726@1598407357.195132:usb_ehci_opreg_change ch mmio 0x0024 [USBSTS] =3D =
0x0 (old: 0x4)
OK
[S +0.076519] OK
[R +0.076534] writeq 0x60606033 0x846c8a0200000611
797726@1598407357.195164:usb_ehci_opreg_write wr mmio 0x0034 [P-LIST BASE] =
=3D 0x2000006
ehci: PERIODIC list base register set while periodic schedule
      is enabled and HC is enabled
797726@1598407357.195174:usb_ehci_opreg_change ch mmio 0x0034 [P-LIST BASE]=
 =3D 0x2000006 (old: 0x0)
OK
[S +0.076562] OK
[R +0.076574] write 0x2000004 0x4 0x4a606060
OK
[S +0.076855] OK
[R +0.076869] write 0x8 0x4 0x97a98095
OK
[S +0.077214] OK
[R +0.077225] write 0x0 0x4 0x4a606060
OK
[S +0.077233] OK
[R +0.077242] write 0x4 0x4 0x97a98095
OK
[S +0.077250] OK
[R +0.077258] write 0xc 0x4 0x4a606060
OK
[S +0.077266] OK
[R +0.077274] write 0x10 0x4 0x97a98095
OK
[S +0.077281] OK
[R +0.077289] write 0x14 0x4 0x4a606060
OK
[S +0.077295] OK
[R +0.077304] write 0x18 0x4 0x97a98095
OK
[S +0.077310] OK
[R +0.077325] write 0x1c 0x4 0x4a606060
OK
[S +0.077333] OK
[R +0.077340] clock_step
OK 27462700
[S +0.077415] OK 27462700
797726@1598407357.196115:usb_ehci_state periodic schedule ACTIVE
797726@1598407357.196123:usb_ehci_usbsts usbsts PSS 1
797726@1598407357.196137:usb_ehci_state periodic schedule FETCH ENTRY
797726@1598407357.196145:usb_ehci_state periodic schedule FETCH QH
797726@1598407357.196154:usb_ehci_queue_action q 0x60d0000050b0: alloc
797726@1598407357.196168:usb_ehci_opreg_read rd mmio 0x0040 [unknown] =3D 0=
x0
797726@1598407357.196176:usb_ehci_opreg_read rd mmio 0x0044 [unknown] =3D 0=
x0
797726@1598407357.196182:usb_ehci_opreg_read rd mmio 0x0048 [unknown] =3D 0=
x0
797726@1598407357.196188:usb_ehci_opreg_read rd mmio 0x004c [unknown] =3D 0=
x0
797726@1598407357.196195:usb_ehci_opreg_read rd mmio 0x0050 [unknown] =3D 0=
x0
797726@1598407357.196201:usb_ehci_opreg_read rd mmio 0x0054 [unknown] =3D 0=
x0
797726@1598407357.196206:usb_ehci_opreg_read rd mmio 0x0058 [unknown] =3D 0=
x0
797726@1598407357.196211:usb_ehci_opreg_read rd mmio 0x005c [unknown] =3D 0=
x0
797726@1598407357.196217:usb_ehci_opreg_read rd mmio 0x0060 [CONFIGFLAG] =
=3D 0x0
797726@1598407357.196224:usb_ehci_portsc_read rd mmio 0x0044 [port 0] =3D 0=
x1000
797726@1598407357.196230:usb_ehci_portsc_read rd mmio 0x0048 [port 1] =3D 0=
x1005
797726@1598407357.196237:usb_ehci_portsc_read rd mmio 0x004c [port 2] =3D 0=
x1000
797726@1598407357.196243:usb_ehci_qh_ptrs q 0x60d0000050b0 - QH @ 0x6060604=
0: next 0x00000000 qtds 0x00000000,0x00000000,0x00000000
797726@1598407357.196249:usb_ehci_qh_fields QH @ 0x60606040 - rl 0, mplen 0=
, eps 0, ep 0, dev 0
797726@1598407357.196255:usb_ehci_qh_bits QH @ 0x60606040 - c 0, h 0, dtc 0=
, i 0
797726@1598407357.196262:usb_ehci_queue_action q 0x60d0000050b0: reset
797726@1598407357.196275:usb_ehci_state periodic schedule ADVANCEQUEUE
797726@1598407357.196281:usb_ehci_state periodic schedule FETCH QTD
797726@1598407357.196300:usb_ehci_qtd_ptrs q 0x60d0000050b0 - QTD @ 0x00000=
000: next 0x6060604a altnext 0x9580a997
797726@1598407357.196306:usb_ehci_qtd_fields QTD @ 0x00000000 - tbytes 5504=
, cpage 2, cerr 2, pid 1
797726@1598407357.196311:usb_ehci_qtd_bits QTD @ 0x00000000 - ioc 1, active=
 1, halt 0, babble 1, xacterr 0
797726@1598407357.196323:usb_ehci_packet_action q 0x60d0000050b0 p 0x611000=
044380: alloc
797726@1598407357.196327:usb_ehci_state periodic schedule EXECUTE
797726@1598407357.196346:usb_ehci_opreg_write wr mmio 0x004c [unknown] =3D =
0x0
797726@1598407357.196351:usb_ehci_opreg_change ch mmio 0x004c [unknown] =3D=
 0x0 (old: 0x0)
797726@1598407357.196359:usb_ehci_opreg_write wr mmio 0x0050 [unknown] =3D =
0x6060604a
797726@1598407357.196363:usb_ehci_opreg_change ch mmio 0x0050 [unknown] =3D=
 0x6060604a (old: 0x0)
797726@1598407357.196370:usb_ehci_opreg_write wr mmio 0x0054 [unknown] =3D =
0x9580a981
797726@1598407357.196374:usb_ehci_opreg_change ch mmio 0x0054 [unknown] =3D=
 0x9580a981 (old: 0x0)
797726@1598407357.196380:usb_ehci_opreg_write wr mmio 0x0058 [unknown] =3D =
0x1580a997
797726@1598407357.196385:usb_ehci_opreg_change ch mmio 0x0058 [unknown] =3D=
 0x1580a997 (old: 0x0)
797726@1598407357.196392:usb_ehci_opreg_write wr mmio 0x005c [unknown] =3D =
0x6060604a
797726@1598407357.196396:usb_ehci_opreg_change ch mmio 0x005c [unknown] =3D=
 0x6060604a (old: 0x0)
797726@1598407357.196403:usb_ehci_opreg_write wr mmio 0x0060 [CONFIGFLAG] =
=3D 0x9580a900
797726@1598407357.196407:usb_ehci_opreg_change ch mmio 0x0060 [CONFIGFLAG] =
=3D 0x0 (old: 0x0)
797726@1598407357.196415:usb_ehci_portsc_write wr mmio 0x0044 [port 0] =3D =
0x60606040
797726@1598407357.196422:usb_ehci_portsc_change ch mmio 0x0044 [port 0] =3D=
 0x601040 (old: 0x1000)
797726@1598407357.196428:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =3D =
0x9580a997
797726@1598407357.196432:usb_ehci_port_reset reset port #1 - 1
797726@1598407357.196437:usb_ehci_port_suspend port #1
797726@1598407357.196441:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =3D=
 0x1185 (old: 0x1005)
797726@1598407357.196448:usb_ehci_portsc_write wr mmio 0x004c [port 2] =3D =
0x6060604a
797726@1598407357.196453:usb_ehci_portsc_change ch mmio 0x004c [port 2] =3D=
 0x601040 (old: 0x1000)
797726@1598407357.196474:usb_packet_state_change bus 0, port 2, ep 0, packe=
t 0x6110000443c0, state undef -> setup
797726@1598407357.196505:usb_ehci_opreg_write wr mmio 0x004c [unknown] =3D =
0xbebebebe
797726@1598407357.196509:usb_ehci_opreg_change ch mmio 0x004c [unknown] =3D=
 0xbebebebe (old: 0x0)
797726@1598407357.196516:usb_ehci_opreg_write wr mmio 0x0050 [unknown] =3D =
0xbebebebe
797726@1598407357.196520:usb_ehci_opreg_change ch mmio 0x0050 [unknown] =3D=
 0xbebebebe (old: 0x6060604a)
797726@1598407357.196527:usb_ehci_opreg_write wr mmio 0x0054 [unknown] =3D =
0xbebebebe
797726@1598407357.196530:usb_ehci_opreg_change ch mmio 0x0054 [unknown] =3D=
 0xbebebebe (old: 0x9580a981)
797726@1598407357.196540:usb_ehci_opreg_write wr mmio 0x0058 [unknown] =3D =
0xbebebebe
797726@1598407357.196544:usb_ehci_opreg_change ch mmio 0x0058 [unknown] =3D=
 0xbebebebe (old: 0x1580a997)
797726@1598407357.196550:usb_ehci_opreg_write wr mmio 0x005c [unknown] =3D =
0xbebebebe
797726@1598407357.196554:usb_ehci_opreg_change ch mmio 0x005c [unknown] =3D=
 0xbebebebe (old: 0x6060604a)
797726@1598407357.196560:usb_ehci_opreg_write wr mmio 0x0060 [CONFIGFLAG] =
=3D 0xbebebebe
797726@1598407357.196563:usb_ehci_opreg_change ch mmio 0x0060 [CONFIGFLAG] =
=3D 0x0 (old: 0x0)
797726@1598407357.196569:usb_ehci_portsc_write wr mmio 0x0044 [port 0] =3D =
0xbebebebe
797726@1598407357.196573:usb_ehci_port_suspend port #0
797726@1598407357.196577:usb_ehci_port_resume port #0
797726@1598407357.196580:usb_ehci_portsc_change ch mmio 0x0044 [port 0] =3D=
 0x301000 (old: 0x601040)
797726@1598407357.196586:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =3D =
0xbebebebe
797726@1598407357.196590:usb_ehci_port_reset reset port #1 - 0
797726@1598407357.196596:usb_ehci_port_detach detach port #1, owner ehci
797726@1598407357.196602:usb_ehci_queue_action q 0x60d0000050b0: free
797726@1598407357.196606:usb_ehci_queue_action q 0x60d0000050b0: cancel
797726@1598407357.196610:usb_ehci_packet_action q 0x60d0000050b0 p 0x611000=
044380: free
797726@1598407357.196626:usb_ehci_irq level 0, frindex 0x0008, sts 0x4004, =
mask 0x0
797726@1598407357.196636:usb_ehci_port_attach attach port #1, owner ehci, d=
evice QEMU USB MSD
797726@1598407357.196642:usb_ehci_irq level 0, frindex 0x0008, sts 0x4004, =
mask 0x0
797726@1598407357.196655:usb_ehci_port_suspend port #1
797726@1598407357.196659:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =3D=
 0x301085 (old: 0x1185)
797726@1598407357.196669:usb_ehci_portsc_write wr mmio 0x004c [port 2] =3D =
0xbebebebe
797726@1598407357.196674:usb_ehci_port_suspend port #2
797726@1598407357.196679:usb_ehci_port_resume port #2
797726@1598407357.196684:usb_ehci_portsc_change ch mmio 0x004c [port 2] =3D=
 0x301000 (old: 0x601040)
797726@1598407357.196694:usb_ehci_portsc_write wr mmio 0x0050 [port 3] =3D =
0xbebebebe
797726@1598407357.196699:usb_ehci_port_suspend port #3
797726@1598407357.196704:usb_ehci_portsc_change ch mmio 0x0050 [port 3] =3D=
 0x301080 (old: 0x1000)
797726@1598407357.196712:usb_ehci_portsc_write wr mmio 0x0054 [port 4] =3D =
0xbebebebe
797726@1598407357.196716:usb_ehci_port_suspend port #4
797726@1598407357.196718:usb_ehci_portsc_change ch mmio 0x0054 [port 4] =3D=
 0x301080 (old: 0x1000)
797726@1598407357.196724:usb_ehci_portsc_write wr mmio 0x0058 [port 5] =3D =
0xbebebebe
797726@1598407357.196729:usb_ehci_port_suspend port #5
797726@1598407357.196733:usb_ehci_portsc_change ch mmio 0x0058 [port 5] =3D=
 0x301080 (old: 0x1000)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D797726=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x6110000443e8 at pc 0x5574af0ef59d bp 0x7fff5b343a00 sp 0x7fff5b3439f8
READ of size 4 at 0x6110000443e8 thread T0
    #0 0x5574af0ef59c in usb_packet_unmap /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../hw/usb/libhw.c:64:28
    #1 0x5574af0ee924 in usb_packet_map /home/alxndr/Development/qemu/gener=
al-fuzz/build/../hw/usb/libhw.c:54:5
    #2 0x5574ae630c2f in ehci_execute /home/alxndr/Development/qemu/general=
-fuzz/build/../hw/usb/hcd-ehci.c:1376:9
    #3 0x5574ae619cfe in ehci_state_execute /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/hcd-ehci.c:1942:13
    #4 0x5574ae60e8d9 in ehci_advance_state /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/hcd-ehci.c:2083:21
    #5 0x5574ae60c753 in ehci_advance_periodic_state /home/alxndr/Developme=
nt/qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:2213:9
    #6 0x5574ae5d9df3 in ehci_work_bh /home/alxndr/Development/qemu/general=
-fuzz/build/../hw/usb/hcd-ehci.c:2299:17
    #7 0x5574b21013c2 in aio_bh_call /home/alxndr/Development/qemu/general-=
fuzz/build/../util/async.c:136:5
    #8 0x5574b2102dc2 in aio_bh_poll /home/alxndr/Development/qemu/general-=
fuzz/build/../util/async.c:164:13
    #9 0x5574b211a84b in aio_dispatch /home/alxndr/Development/qemu/general=
-fuzz/build/../util/aio-posix.c:380:5
    #10 0x5574b210c29e in aio_ctx_dispatch /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../util/async.c:306:5
    #11 0x7f44ce9dc5fc in g_main_context_dispatch (/usr/lib/x86_64-linux-gn=
u/libglib-2.0.so.0+0x505fc)
    #12 0x5574b2339c67 in glib_pollfds_poll /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../util/main-loop.c:217:9
    #13 0x5574b2337567 in os_host_main_loop_wait /home/alxndr/Development/q=
emu/general-fuzz/build/../util/main-loop.c:240:5
    #14 0x5574b2336f47 in main_loop_wait /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../util/main-loop.c:516:11
    #15 0x5574b0b1508d in qemu_main_loop /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../softmmu/vl.c:1676:9
    #16 0x5574ae4a751c in main /home/alxndr/Development/qemu/general-fuzz/b=
uild/../softmmu/main.c:50:5
    #17 0x7f44ce1e5cc9 in __libc_start_main csu/../csu/libc-start.c:308:16
    #18 0x5574ae3fccf9 in _start (/home/alxndr/Development/qemu/general-fuz=
z/build/qemu-system-i386+0x2cb0cf9)

0x6110000443e8 is located 104 bytes inside of 248-byte region [0x6110000443=
80,0x611000044478)
freed by thread T0 here:
    #0 0x5574ae4751bd in free (/home/alxndr/Development/qemu/general-fuzz/b=
uild/qemu-system-i386+0x2d291bd)
    #1 0x5574ae5e71a1 in ehci_free_packet /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../hw/usb/hcd-ehci.c:541:5
    #2 0x5574ae5e3662 in ehci_cancel_queue /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../hw/usb/hcd-ehci.c:584:9
    #3 0x5574ae5e174c in ehci_free_queue /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../hw/usb/hcd-ehci.c:611:17
    #4 0x5574ae608300 in ehci_queues_rip_device /home/alxndr/Development/qe=
mu/general-fuzz/build/../hw/usb/hcd-ehci.c:674:9
    #5 0x5574ae6034ba in ehci_detach /home/alxndr/Development/qemu/general-=
fuzz/build/../hw/usb/hcd-ehci.c:732:5
    #6 0x5574af06427f in usb_detach /home/alxndr/Development/qemu/general-f=
uzz/build/../hw/usb/core.c:70:5
    #7 0x5574af064607 in usb_port_reset /home/alxndr/Development/qemu/gener=
al-fuzz/build/../hw/usb/core.c:79:5
    #8 0x5574ae63af7a in ehci_port_write /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../hw/usb/hcd-ehci.c:993:13
    #9 0x5574b0e31de0 in memory_region_write_accessor /home/alxndr/Developm=
ent/qemu/general-fuzz/build/../softmmu/memory.c:483:5
    #10 0x5574b0e312bd in access_with_adjusted_size /home/alxndr/Developmen=
t/qemu/general-fuzz/build/../softmmu/memory.c:544:18
    #11 0x5574b0e2ef70 in memory_region_dispatch_write /home/alxndr/Develop=
ment/qemu/general-fuzz/build/../softmmu/memory.c:1466:16
    #12 0x5574b0a8d8a6 in flatview_write_continue /home/alxndr/Development/=
qemu/general-fuzz/build/../exec.c:3176:23
    #13 0x5574b0a76878 in flatview_write /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../exec.c:3216:14
    #14 0x5574b0a763a8 in address_space_write /home/alxndr/Development/qemu=
/general-fuzz/build/../exec.c:3308:18
    #15 0x5574b0a7dff7 in address_space_unmap /home/alxndr/Development/qemu=
/general-fuzz/build/../exec.c:3634:9
    #16 0x5574af0f0262 in dma_memory_unmap /home/alxndr/Development/qemu/ge=
neral-fuzz/include/sysemu/dma.h:145:5
    #17 0x5574af0f0143 in usb_packet_unmap /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../hw/usb/libhw.c:65:9
    #18 0x5574af0ee924 in usb_packet_map /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../hw/usb/libhw.c:54:5
    #19 0x5574ae630c2f in ehci_execute /home/alxndr/Development/qemu/genera=
l-fuzz/build/../hw/usb/hcd-ehci.c:1376:9
    #20 0x5574ae619cfe in ehci_state_execute /home/alxndr/Development/qemu/=
general-fuzz/build/../hw/usb/hcd-ehci.c:1942:13
    #21 0x5574ae60e8d9 in ehci_advance_state /home/alxndr/Development/qemu/=
general-fuzz/build/../hw/usb/hcd-ehci.c:2083:21
    #22 0x5574ae60c753 in ehci_advance_periodic_state /home/alxndr/Developm=
ent/qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:2213:9
    #23 0x5574ae5d9df3 in ehci_work_bh /home/alxndr/Development/qemu/genera=
l-fuzz/build/../hw/usb/hcd-ehci.c:2299:17
    #24 0x5574b21013c2 in aio_bh_call /home/alxndr/Development/qemu/general=
-fuzz/build/../util/async.c:136:5
    #25 0x5574b2102dc2 in aio_bh_poll /home/alxndr/Development/qemu/general=
-fuzz/build/../util/async.c:164:13
    #26 0x5574b211a84b in aio_dispatch /home/alxndr/Development/qemu/genera=
l-fuzz/build/../util/aio-posix.c:380:5
    #27 0x5574b210c29e in aio_ctx_dispatch /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../util/async.c:306:5
    #28 0x7f44ce9dc5fc in g_main_context_dispatch (/usr/lib/x86_64-linux-gn=
u/libglib-2.0.so.0+0x505fc)

previously allocated by thread T0 here:
    #0 0x5574ae4755b2 in calloc (/home/alxndr/Development/qemu/general-fuzz=
/build/qemu-system-i386+0x2d295b2)
    #1 0x7f44ce9e2210 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.s=
o.0+0x56210)
    #2 0x5574ae6175be in ehci_state_fetchqtd /home/alxndr/Development/qemu/=
general-fuzz/build/../hw/usb/hcd-ehci.c:1844:13
    #3 0x5574ae60e7f1 in ehci_advance_state /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/hcd-ehci.c:2073:21
    #4 0x5574ae60c753 in ehci_advance_periodic_state /home/alxndr/Developme=
nt/qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:2213:9
    #5 0x5574ae5d9df3 in ehci_work_bh /home/alxndr/Development/qemu/general=
-fuzz/build/../hw/usb/hcd-ehci.c:2299:17
    #6 0x5574b21013c2 in aio_bh_call /home/alxndr/Development/qemu/general-=
fuzz/build/../util/async.c:136:5
    #7 0x5574b2102dc2 in aio_bh_poll /home/alxndr/Development/qemu/general-=
fuzz/build/../util/async.c:164:13
    #8 0x5574b211a84b in aio_dispatch /home/alxndr/Development/qemu/general=
-fuzz/build/../util/aio-posix.c:380:5
    #9 0x5574b210c29e in aio_ctx_dispatch /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../util/async.c:306:5
    #10 0x7f44ce9dc5fc in g_main_context_dispatch (/usr/lib/x86_64-linux-gn=
u/libglib-2.0.so.0+0x505fc)

SUMMARY: AddressSanitizer: heap-use-after-free /home/alxndr/Development/qem=
u/general-fuzz/build/../hw/usb/libhw.c:64:28 in usb_packet_unmap
Shadow bytes around the buggy address:
  0x0c2280000820: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c2280000830: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c2280000840: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c2280000850: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c2280000860: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
=3D>0x0c2280000870: fd fd fd fd fd fd fd fd fd fd fd fd fd[fd]fd fd
  0x0c2280000880: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c2280000890: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c22800008a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c22800008b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c22800008c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 =

  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D797726=3D=3DABORTING

-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892963

Title:
  Heap-use-after-free in put_dwords through ehci_flush_qh

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./qemu-system-i386 -machine q35 \
  -device ich9-usb-ehci1,bus=3Dpcie.0,addr=3D1d.7,\
  multifunction=3Don,id=3Dich9-ehci-1 \
  -drive if=3Dnone,id=3Dusbcdrom,media=3Dcdrom \
  -device usb-storage,bus=3Dich9-ehci-1.0,\
  port=3D2,drive=3Dusbcdrom \
  -display none -nodefaults -qtest stdio -accel qtest
  outl 0xcf8 0x8000ef02
  outl 0xcfc 0xfbff0061
  outl 0xcf8 0x8000ef11
  outl 0xcfc 0x60606060
  writeq 0x60606065 0xb70560ff84ffff7f
  writeq 0x60606065 0xff0004fe050000ff
  writeq 0x60606020 0xff015e5c057b0039
  writeq 0x60606033 0x846c8a0200000611
  write 0x2000004 0x4 0x4a606060
  write 0x8 0x4 0x97a98095
  write 0x0 0x4 0x4a606060
  write 0x4 0x4 0x97a98095
  write 0xc 0x4 0x4a606060
  write 0x10 0x4 0x97a98095
  write 0x14 0x4 0x4a606060
  write 0x18 0x4 0x97a98095
  write 0x1c 0x4 0x4a606060
  clock_step
  EOF

  The trace:
  797726@1598407357.169284:usb_port_claim bus 0, port 2
  797726@1598407357.169585:usb_port_attach bus 0, port 2, devspeed full+hig=
h+super, portspeed high
  797726@1598407357.169598:usb_ehci_port_attach attach port #1, owner ehci,=
 device QEMU USB MSD
  797726@1598407357.169608:usb_ehci_irq level 0, frindex 0x0000, sts 0x4, m=
ask 0x0
  797726@1598407357.186943:usb_ehci_reset =3D=3D=3D RESET =3D=3D=3D
  797726@1598407357.186960:usb_ehci_port_detach detach port #1, owner ehci
  797726@1598407357.186968:usb_ehci_irq level 0, frindex 0x0000, sts 0x4, m=
ask 0x0
  797726@1598407357.186976:usb_ehci_irq level 0, frindex 0x0000, sts 0x1000=
, mask 0x0
  797726@1598407357.186984:usb_ehci_port_attach attach port #1, owner ehci,=
 device QEMU USB MSD
  797726@1598407357.186989:usb_ehci_irq level 0, frindex 0x0000, sts 0x1004=
, mask 0x0
  [R +0.073737] outl 0xcf8 0x8000ef02
  OK
  [S +0.073774] OK
  [R +0.073801] outl 0xcfc 0xfbff0061
  OK
  [S +0.075074] OK
  [R +0.075108] outl 0xcf8 0x8000ef11
  OK
  [S +0.075126] OK
  [R +0.075135] outl 0xcfc 0x60606060
  OK
  [S +0.076290] OK
  [R +0.076317] writeq 0x60606065 0xb70560ff84ffff7f
  797726@1598407357.194959:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =
=3D 0x560ff84
  797726@1598407357.194967:usb_ehci_port_reset reset port #1 - 1
  797726@1598407357.194971:usb_ehci_port_suspend port #1
  797726@1598407357.194975:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =
=3D 0x601183 (old: 0x1003)
  OK
  [S +0.076363] OK
  [R +0.076377] writeq 0x60606065 0xff0004fe050000ff
  797726@1598407357.195005:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =
=3D 0x4fe05
  797726@1598407357.195011:usb_ehci_port_reset reset port #1 - 0
  797726@1598407357.195019:usb_ehci_port_detach detach port #1, owner ehci
  797726@1598407357.195026:usb_ehci_irq level 0, frindex 0x0000, sts 0x1004=
, mask 0x0
  797726@1598407357.195034:usb_ehci_port_attach attach port #1, owner ehci,=
 device QEMU USB MSD
  797726@1598407357.195038:usb_ehci_irq level 0, frindex 0x0000, sts 0x1004=
, mask 0x0
  797726@1598407357.195049:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =
=3D 0x1005 (old: 0x601183)
  OK
  [S +0.076439] OK
  [R +0.076457] writeq 0x60606020 0xff015e5c057b0039
  797726@1598407357.195087:usb_ehci_opreg_write wr mmio 0x0020 [USBCMD] =3D=
 0x57b0039
  attempt to set frame list size -- value 8
  797726@1598407357.195097:usb_ehci_usbsts usbsts HALT 0
  797726@1598407357.195105:usb_ehci_opreg_change ch mmio 0x0020 [USBCMD] =
=3D 0x57b0031 (old: 0x80000)
  797726@1598407357.195111:usb_ehci_opreg_write wr mmio 0x0024 [USBSTS] =3D=
 0xff015e5c
  797726@1598407357.195117:usb_ehci_usbsts usbsts PCD 0
  797726@1598407357.195120:usb_ehci_usbsts usbsts FLR 0
  797726@1598407357.195124:usb_ehci_usbsts usbsts HSE 0
  797726@1598407357.195127:usb_ehci_irq level 0, frindex 0x0000, sts 0x0, m=
ask 0x0
  797726@1598407357.195132:usb_ehci_opreg_change ch mmio 0x0024 [USBSTS] =
=3D 0x0 (old: 0x4)
  OK
  [S +0.076519] OK
  [R +0.076534] writeq 0x60606033 0x846c8a0200000611
  797726@1598407357.195164:usb_ehci_opreg_write wr mmio 0x0034 [P-LIST BASE=
] =3D 0x2000006
  ehci: PERIODIC list base register set while periodic schedule
        is enabled and HC is enabled
  797726@1598407357.195174:usb_ehci_opreg_change ch mmio 0x0034 [P-LIST BAS=
E] =3D 0x2000006 (old: 0x0)
  OK
  [S +0.076562] OK
  [R +0.076574] write 0x2000004 0x4 0x4a606060
  OK
  [S +0.076855] OK
  [R +0.076869] write 0x8 0x4 0x97a98095
  OK
  [S +0.077214] OK
  [R +0.077225] write 0x0 0x4 0x4a606060
  OK
  [S +0.077233] OK
  [R +0.077242] write 0x4 0x4 0x97a98095
  OK
  [S +0.077250] OK
  [R +0.077258] write 0xc 0x4 0x4a606060
  OK
  [S +0.077266] OK
  [R +0.077274] write 0x10 0x4 0x97a98095
  OK
  [S +0.077281] OK
  [R +0.077289] write 0x14 0x4 0x4a606060
  OK
  [S +0.077295] OK
  [R +0.077304] write 0x18 0x4 0x97a98095
  OK
  [S +0.077310] OK
  [R +0.077325] write 0x1c 0x4 0x4a606060
  OK
  [S +0.077333] OK
  [R +0.077340] clock_step
  OK 27462700
  [S +0.077415] OK 27462700
  797726@1598407357.196115:usb_ehci_state periodic schedule ACTIVE
  797726@1598407357.196123:usb_ehci_usbsts usbsts PSS 1
  797726@1598407357.196137:usb_ehci_state periodic schedule FETCH ENTRY
  797726@1598407357.196145:usb_ehci_state periodic schedule FETCH QH
  797726@1598407357.196154:usb_ehci_queue_action q 0x60d0000050b0: alloc
  797726@1598407357.196168:usb_ehci_opreg_read rd mmio 0x0040 [unknown] =3D=
 0x0
  797726@1598407357.196176:usb_ehci_opreg_read rd mmio 0x0044 [unknown] =3D=
 0x0
  797726@1598407357.196182:usb_ehci_opreg_read rd mmio 0x0048 [unknown] =3D=
 0x0
  797726@1598407357.196188:usb_ehci_opreg_read rd mmio 0x004c [unknown] =3D=
 0x0
  797726@1598407357.196195:usb_ehci_opreg_read rd mmio 0x0050 [unknown] =3D=
 0x0
  797726@1598407357.196201:usb_ehci_opreg_read rd mmio 0x0054 [unknown] =3D=
 0x0
  797726@1598407357.196206:usb_ehci_opreg_read rd mmio 0x0058 [unknown] =3D=
 0x0
  797726@1598407357.196211:usb_ehci_opreg_read rd mmio 0x005c [unknown] =3D=
 0x0
  797726@1598407357.196217:usb_ehci_opreg_read rd mmio 0x0060 [CONFIGFLAG] =
=3D 0x0
  797726@1598407357.196224:usb_ehci_portsc_read rd mmio 0x0044 [port 0] =3D=
 0x1000
  797726@1598407357.196230:usb_ehci_portsc_read rd mmio 0x0048 [port 1] =3D=
 0x1005
  797726@1598407357.196237:usb_ehci_portsc_read rd mmio 0x004c [port 2] =3D=
 0x1000
  797726@1598407357.196243:usb_ehci_qh_ptrs q 0x60d0000050b0 - QH @ 0x60606=
040: next 0x00000000 qtds 0x00000000,0x00000000,0x00000000
  797726@1598407357.196249:usb_ehci_qh_fields QH @ 0x60606040 - rl 0, mplen=
 0, eps 0, ep 0, dev 0
  797726@1598407357.196255:usb_ehci_qh_bits QH @ 0x60606040 - c 0, h 0, dtc=
 0, i 0
  797726@1598407357.196262:usb_ehci_queue_action q 0x60d0000050b0: reset
  797726@1598407357.196275:usb_ehci_state periodic schedule ADVANCEQUEUE
  797726@1598407357.196281:usb_ehci_state periodic schedule FETCH QTD
  797726@1598407357.196300:usb_ehci_qtd_ptrs q 0x60d0000050b0 - QTD @ 0x000=
00000: next 0x6060604a altnext 0x9580a997
  797726@1598407357.196306:usb_ehci_qtd_fields QTD @ 0x00000000 - tbytes 55=
04, cpage 2, cerr 2, pid 1
  797726@1598407357.196311:usb_ehci_qtd_bits QTD @ 0x00000000 - ioc 1, acti=
ve 1, halt 0, babble 1, xacterr 0
  797726@1598407357.196323:usb_ehci_packet_action q 0x60d0000050b0 p 0x6110=
00044380: alloc
  797726@1598407357.196327:usb_ehci_state periodic schedule EXECUTE
  797726@1598407357.196346:usb_ehci_opreg_write wr mmio 0x004c [unknown] =
=3D 0x0
  797726@1598407357.196351:usb_ehci_opreg_change ch mmio 0x004c [unknown] =
=3D 0x0 (old: 0x0)
  797726@1598407357.196359:usb_ehci_opreg_write wr mmio 0x0050 [unknown] =
=3D 0x6060604a
  797726@1598407357.196363:usb_ehci_opreg_change ch mmio 0x0050 [unknown] =
=3D 0x6060604a (old: 0x0)
  797726@1598407357.196370:usb_ehci_opreg_write wr mmio 0x0054 [unknown] =
=3D 0x9580a981
  797726@1598407357.196374:usb_ehci_opreg_change ch mmio 0x0054 [unknown] =
=3D 0x9580a981 (old: 0x0)
  797726@1598407357.196380:usb_ehci_opreg_write wr mmio 0x0058 [unknown] =
=3D 0x1580a997
  797726@1598407357.196385:usb_ehci_opreg_change ch mmio 0x0058 [unknown] =
=3D 0x1580a997 (old: 0x0)
  797726@1598407357.196392:usb_ehci_opreg_write wr mmio 0x005c [unknown] =
=3D 0x6060604a
  797726@1598407357.196396:usb_ehci_opreg_change ch mmio 0x005c [unknown] =
=3D 0x6060604a (old: 0x0)
  797726@1598407357.196403:usb_ehci_opreg_write wr mmio 0x0060 [CONFIGFLAG]=
 =3D 0x9580a900
  797726@1598407357.196407:usb_ehci_opreg_change ch mmio 0x0060 [CONFIGFLAG=
] =3D 0x0 (old: 0x0)
  797726@1598407357.196415:usb_ehci_portsc_write wr mmio 0x0044 [port 0] =
=3D 0x60606040
  797726@1598407357.196422:usb_ehci_portsc_change ch mmio 0x0044 [port 0] =
=3D 0x601040 (old: 0x1000)
  797726@1598407357.196428:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =
=3D 0x9580a997
  797726@1598407357.196432:usb_ehci_port_reset reset port #1 - 1
  797726@1598407357.196437:usb_ehci_port_suspend port #1
  797726@1598407357.196441:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =
=3D 0x1185 (old: 0x1005)
  797726@1598407357.196448:usb_ehci_portsc_write wr mmio 0x004c [port 2] =
=3D 0x6060604a
  797726@1598407357.196453:usb_ehci_portsc_change ch mmio 0x004c [port 2] =
=3D 0x601040 (old: 0x1000)
  797726@1598407357.196474:usb_packet_state_change bus 0, port 2, ep 0, pac=
ket 0x6110000443c0, state undef -> setup
  797726@1598407357.196505:usb_ehci_opreg_write wr mmio 0x004c [unknown] =
=3D 0xbebebebe
  797726@1598407357.196509:usb_ehci_opreg_change ch mmio 0x004c [unknown] =
=3D 0xbebebebe (old: 0x0)
  797726@1598407357.196516:usb_ehci_opreg_write wr mmio 0x0050 [unknown] =
=3D 0xbebebebe
  797726@1598407357.196520:usb_ehci_opreg_change ch mmio 0x0050 [unknown] =
=3D 0xbebebebe (old: 0x6060604a)
  797726@1598407357.196527:usb_ehci_opreg_write wr mmio 0x0054 [unknown] =
=3D 0xbebebebe
  797726@1598407357.196530:usb_ehci_opreg_change ch mmio 0x0054 [unknown] =
=3D 0xbebebebe (old: 0x9580a981)
  797726@1598407357.196540:usb_ehci_opreg_write wr mmio 0x0058 [unknown] =
=3D 0xbebebebe
  797726@1598407357.196544:usb_ehci_opreg_change ch mmio 0x0058 [unknown] =
=3D 0xbebebebe (old: 0x1580a997)
  797726@1598407357.196550:usb_ehci_opreg_write wr mmio 0x005c [unknown] =
=3D 0xbebebebe
  797726@1598407357.196554:usb_ehci_opreg_change ch mmio 0x005c [unknown] =
=3D 0xbebebebe (old: 0x6060604a)
  797726@1598407357.196560:usb_ehci_opreg_write wr mmio 0x0060 [CONFIGFLAG]=
 =3D 0xbebebebe
  797726@1598407357.196563:usb_ehci_opreg_change ch mmio 0x0060 [CONFIGFLAG=
] =3D 0x0 (old: 0x0)
  797726@1598407357.196569:usb_ehci_portsc_write wr mmio 0x0044 [port 0] =
=3D 0xbebebebe
  797726@1598407357.196573:usb_ehci_port_suspend port #0
  797726@1598407357.196577:usb_ehci_port_resume port #0
  797726@1598407357.196580:usb_ehci_portsc_change ch mmio 0x0044 [port 0] =
=3D 0x301000 (old: 0x601040)
  797726@1598407357.196586:usb_ehci_portsc_write wr mmio 0x0048 [port 1] =
=3D 0xbebebebe
  797726@1598407357.196590:usb_ehci_port_reset reset port #1 - 0
  797726@1598407357.196596:usb_ehci_port_detach detach port #1, owner ehci
  797726@1598407357.196602:usb_ehci_queue_action q 0x60d0000050b0: free
  797726@1598407357.196606:usb_ehci_queue_action q 0x60d0000050b0: cancel
  797726@1598407357.196610:usb_ehci_packet_action q 0x60d0000050b0 p 0x6110=
00044380: free
  797726@1598407357.196626:usb_ehci_irq level 0, frindex 0x0008, sts 0x4004=
, mask 0x0
  797726@1598407357.196636:usb_ehci_port_attach attach port #1, owner ehci,=
 device QEMU USB MSD
  797726@1598407357.196642:usb_ehci_irq level 0, frindex 0x0008, sts 0x4004=
, mask 0x0
  797726@1598407357.196655:usb_ehci_port_suspend port #1
  797726@1598407357.196659:usb_ehci_portsc_change ch mmio 0x0048 [port 1] =
=3D 0x301085 (old: 0x1185)
  797726@1598407357.196669:usb_ehci_portsc_write wr mmio 0x004c [port 2] =
=3D 0xbebebebe
  797726@1598407357.196674:usb_ehci_port_suspend port #2
  797726@1598407357.196679:usb_ehci_port_resume port #2
  797726@1598407357.196684:usb_ehci_portsc_change ch mmio 0x004c [port 2] =
=3D 0x301000 (old: 0x601040)
  797726@1598407357.196694:usb_ehci_portsc_write wr mmio 0x0050 [port 3] =
=3D 0xbebebebe
  797726@1598407357.196699:usb_ehci_port_suspend port #3
  797726@1598407357.196704:usb_ehci_portsc_change ch mmio 0x0050 [port 3] =
=3D 0x301080 (old: 0x1000)
  797726@1598407357.196712:usb_ehci_portsc_write wr mmio 0x0054 [port 4] =
=3D 0xbebebebe
  797726@1598407357.196716:usb_ehci_port_suspend port #4
  797726@1598407357.196718:usb_ehci_portsc_change ch mmio 0x0054 [port 4] =
=3D 0x301080 (old: 0x1000)
  797726@1598407357.196724:usb_ehci_portsc_write wr mmio 0x0058 [port 5] =
=3D 0xbebebebe
  797726@1598407357.196729:usb_ehci_port_suspend port #5
  797726@1598407357.196733:usb_ehci_portsc_change ch mmio 0x0058 [port 5] =
=3D 0x301080 (old: 0x1000)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D797726=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=
 0x6110000443e8 at pc 0x5574af0ef59d bp 0x7fff5b343a00 sp 0x7fff5b3439f8
  READ of size 4 at 0x6110000443e8 thread T0
      #0 0x5574af0ef59c in usb_packet_unmap /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/libhw.c:64:28
      #1 0x5574af0ee924 in usb_packet_map /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../hw/usb/libhw.c:54:5
      #2 0x5574ae630c2f in ehci_execute /home/alxndr/Development/qemu/gener=
al-fuzz/build/../hw/usb/hcd-ehci.c:1376:9
      #3 0x5574ae619cfe in ehci_state_execute /home/alxndr/Development/qemu=
/general-fuzz/build/../hw/usb/hcd-ehci.c:1942:13
      #4 0x5574ae60e8d9 in ehci_advance_state /home/alxndr/Development/qemu=
/general-fuzz/build/../hw/usb/hcd-ehci.c:2083:21
      #5 0x5574ae60c753 in ehci_advance_periodic_state /home/alxndr/Develop=
ment/qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:2213:9
      #6 0x5574ae5d9df3 in ehci_work_bh /home/alxndr/Development/qemu/gener=
al-fuzz/build/../hw/usb/hcd-ehci.c:2299:17
      #7 0x5574b21013c2 in aio_bh_call /home/alxndr/Development/qemu/genera=
l-fuzz/build/../util/async.c:136:5
      #8 0x5574b2102dc2 in aio_bh_poll /home/alxndr/Development/qemu/genera=
l-fuzz/build/../util/async.c:164:13
      #9 0x5574b211a84b in aio_dispatch /home/alxndr/Development/qemu/gener=
al-fuzz/build/../util/aio-posix.c:380:5
      #10 0x5574b210c29e in aio_ctx_dispatch /home/alxndr/Development/qemu/=
general-fuzz/build/../util/async.c:306:5
      #11 0x7f44ce9dc5fc in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x505fc)
      #12 0x5574b2339c67 in glib_pollfds_poll /home/alxndr/Development/qemu=
/general-fuzz/build/../util/main-loop.c:217:9
      #13 0x5574b2337567 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/general-fuzz/build/../util/main-loop.c:240:5
      #14 0x5574b2336f47 in main_loop_wait /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../util/main-loop.c:516:11
      #15 0x5574b0b1508d in qemu_main_loop /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../softmmu/vl.c:1676:9
      #16 0x5574ae4a751c in main /home/alxndr/Development/qemu/general-fuzz=
/build/../softmmu/main.c:50:5
      #17 0x7f44ce1e5cc9 in __libc_start_main csu/../csu/libc-start.c:308:16
      #18 0x5574ae3fccf9 in _start (/home/alxndr/Development/qemu/general-f=
uzz/build/qemu-system-i386+0x2cb0cf9)

  0x6110000443e8 is located 104 bytes inside of 248-byte region [0x61100004=
4380,0x611000044478)
  freed by thread T0 here:
      #0 0x5574ae4751bd in free (/home/alxndr/Development/qemu/general-fuzz=
/build/qemu-system-i386+0x2d291bd)
      #1 0x5574ae5e71a1 in ehci_free_packet /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../hw/usb/hcd-ehci.c:541:5
      #2 0x5574ae5e3662 in ehci_cancel_queue /home/alxndr/Development/qemu/=
general-fuzz/build/../hw/usb/hcd-ehci.c:584:9
      #3 0x5574ae5e174c in ehci_free_queue /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../hw/usb/hcd-ehci.c:611:17
      #4 0x5574ae608300 in ehci_queues_rip_device /home/alxndr/Development/=
qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:674:9
      #5 0x5574ae6034ba in ehci_detach /home/alxndr/Development/qemu/genera=
l-fuzz/build/../hw/usb/hcd-ehci.c:732:5
      #6 0x5574af06427f in usb_detach /home/alxndr/Development/qemu/general=
-fuzz/build/../hw/usb/core.c:70:5
      #7 0x5574af064607 in usb_port_reset /home/alxndr/Development/qemu/gen=
eral-fuzz/build/../hw/usb/core.c:79:5
      #8 0x5574ae63af7a in ehci_port_write /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../hw/usb/hcd-ehci.c:993:13
      #9 0x5574b0e31de0 in memory_region_write_accessor /home/alxndr/Develo=
pment/qemu/general-fuzz/build/../softmmu/memory.c:483:5
      #10 0x5574b0e312bd in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/general-fuzz/build/../softmmu/memory.c:544:18
      #11 0x5574b0e2ef70 in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/general-fuzz/build/../softmmu/memory.c:1466:16
      #12 0x5574b0a8d8a6 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/general-fuzz/build/../exec.c:3176:23
      #13 0x5574b0a76878 in flatview_write /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../exec.c:3216:14
      #14 0x5574b0a763a8 in address_space_write /home/alxndr/Development/qe=
mu/general-fuzz/build/../exec.c:3308:18
      #15 0x5574b0a7dff7 in address_space_unmap /home/alxndr/Development/qe=
mu/general-fuzz/build/../exec.c:3634:9
      #16 0x5574af0f0262 in dma_memory_unmap /home/alxndr/Development/qemu/=
general-fuzz/include/sysemu/dma.h:145:5
      #17 0x5574af0f0143 in usb_packet_unmap /home/alxndr/Development/qemu/=
general-fuzz/build/../hw/usb/libhw.c:65:9
      #18 0x5574af0ee924 in usb_packet_map /home/alxndr/Development/qemu/ge=
neral-fuzz/build/../hw/usb/libhw.c:54:5
      #19 0x5574ae630c2f in ehci_execute /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../hw/usb/hcd-ehci.c:1376:9
      #20 0x5574ae619cfe in ehci_state_execute /home/alxndr/Development/qem=
u/general-fuzz/build/../hw/usb/hcd-ehci.c:1942:13
      #21 0x5574ae60e8d9 in ehci_advance_state /home/alxndr/Development/qem=
u/general-fuzz/build/../hw/usb/hcd-ehci.c:2083:21
      #22 0x5574ae60c753 in ehci_advance_periodic_state /home/alxndr/Develo=
pment/qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:2213:9
      #23 0x5574ae5d9df3 in ehci_work_bh /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../hw/usb/hcd-ehci.c:2299:17
      #24 0x5574b21013c2 in aio_bh_call /home/alxndr/Development/qemu/gener=
al-fuzz/build/../util/async.c:136:5
      #25 0x5574b2102dc2 in aio_bh_poll /home/alxndr/Development/qemu/gener=
al-fuzz/build/../util/async.c:164:13
      #26 0x5574b211a84b in aio_dispatch /home/alxndr/Development/qemu/gene=
ral-fuzz/build/../util/aio-posix.c:380:5
      #27 0x5574b210c29e in aio_ctx_dispatch /home/alxndr/Development/qemu/=
general-fuzz/build/../util/async.c:306:5
      #28 0x7f44ce9dc5fc in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x505fc)

  previously allocated by thread T0 here:
      #0 0x5574ae4755b2 in calloc (/home/alxndr/Development/qemu/general-fu=
zz/build/qemu-system-i386+0x2d295b2)
      #1 0x7f44ce9e2210 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0=
.so.0+0x56210)
      #2 0x5574ae6175be in ehci_state_fetchqtd /home/alxndr/Development/qem=
u/general-fuzz/build/../hw/usb/hcd-ehci.c:1844:13
      #3 0x5574ae60e7f1 in ehci_advance_state /home/alxndr/Development/qemu=
/general-fuzz/build/../hw/usb/hcd-ehci.c:2073:21
      #4 0x5574ae60c753 in ehci_advance_periodic_state /home/alxndr/Develop=
ment/qemu/general-fuzz/build/../hw/usb/hcd-ehci.c:2213:9
      #5 0x5574ae5d9df3 in ehci_work_bh /home/alxndr/Development/qemu/gener=
al-fuzz/build/../hw/usb/hcd-ehci.c:2299:17
      #6 0x5574b21013c2 in aio_bh_call /home/alxndr/Development/qemu/genera=
l-fuzz/build/../util/async.c:136:5
      #7 0x5574b2102dc2 in aio_bh_poll /home/alxndr/Development/qemu/genera=
l-fuzz/build/../util/async.c:164:13
      #8 0x5574b211a84b in aio_dispatch /home/alxndr/Development/qemu/gener=
al-fuzz/build/../util/aio-posix.c:380:5
      #9 0x5574b210c29e in aio_ctx_dispatch /home/alxndr/Development/qemu/g=
eneral-fuzz/build/../util/async.c:306:5
      #10 0x7f44ce9dc5fc in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x505fc)

  SUMMARY: AddressSanitizer: heap-use-after-free /home/alxndr/Development/q=
emu/general-fuzz/build/../hw/usb/libhw.c:64:28 in usb_packet_unmap
  Shadow bytes around the buggy address:
    0x0c2280000820: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
    0x0c2280000830: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
    0x0c2280000840: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
    0x0c2280000850: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
    0x0c2280000860: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
  =3D>0x0c2280000870: fd fd fd fd fd fd fd fd fd fd fd fd fd[fd]fd fd
    0x0c2280000880: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
    0x0c2280000890: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0c22800008a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0c22800008b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0c22800008c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07 =

    Heap left redzone:       fa
    Freed heap region:       fd
    Stack left redzone:      f1
    Stack mid redzone:       f2
    Stack right redzone:     f3
    Stack after return:      f5
    Stack use after scope:   f8
    Global redzone:          f9
    Global init order:       f6
    Poisoned by user:        f7
    Container overflow:      fc
    Array cookie:            ac
    Intra object redzone:    bb
    ASan internal:           fe
    Left alloca redzone:     ca
    Right alloca redzone:    cb
    Shadow gap:              cc
  =3D=3D797726=3D=3DABORTING

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892963/+subscriptions

