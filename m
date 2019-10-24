Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C3CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6D72070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="lHgyX2jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6D72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeeO-000063-Iw
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1iNeMt-0005ps-SD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1iNeMr-00030g-OY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:45:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:53212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1iNeMr-0002un-1Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:45:37 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9OEj40W005410; Thu, 24 Oct 2019 07:45:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=MIY/YWAWPgD9nHSqRCmpvHenRsEvs/B9c2bUX7BbSdM=;
 b=lHgyX2jMYzeAe47SVLhavIHO3j5bBovqstGz7Pymbm3BOWpVBG+lGs40afqABlAfhBcI
 bp87LrQUtwMtSWUaDYBhXyKz4p28HdfsEHaeOj5l1DolwyC3JLwR2ubacgcJ4xZ9CQFG
 GL8i3ZIx4gN1W+YGfbk9VgGnMsHFuh5m9MWb+lEXk2JruaTOXtX/lhrW3oCrMtNvVNd2
 uKUdlSjbdcbnEq1IU+1RFnjrshZPLZRt2J2516bYeJpjxaDEwhWzbaanWZjYKaGSj146
 LnReVDKTx7dHq9HCA6+G/OilcszWhsiUQkSII3cC4dPPrEAYduU2b50EsNwz05YZgqsQ XA== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2vt9u2cg10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2019 07:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faJsUb2piPIlvUbR+kub7CH9D69EiVqaEGjHc0pqL+X1NBNoKKfvzrJIREZml/siY0+mgdMHP37+437h+pPF+eiDV7b2U0ACrpcy1D0+LfgjLWQ/yeCM/BoCGLTgv9Y2L8EnIZ6s9phzivTFQsWliIQ3gq1sahhXC+p/LSbW+UTevsKMO1KarTtwD1J4BxHt6+oIxtmBB2UBlQUGmkGK68oFstvNQA8qdLFH8pYxyRWCchRUn39Qws7JKNOwlukK7SH2kVKoQxZlG02ltL2czb4g5Zg1H9JcN3mhueoww/vJifg2S+zhtOZrdSyw6C+lj33A2BUbI7vgslor0ajoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIY/YWAWPgD9nHSqRCmpvHenRsEvs/B9c2bUX7BbSdM=;
 b=VOSjKSMqDnFa1S2g0PpR/A4OXXIf/fYjqImGYIdqHQ8MoyHtZEtFyBI96JHiJsQgWY17UWaqsjqaq9HinKWyOVr8FcfvR+pUTIFX2iIXsic+vcspBaEPWXRP5P/R/HgiXZaNxl+uSM1i6e04SdlbMMtsAK0yHG8POiUY9Hb+saEW36FFbcx8+saylgMyUVbyzoGRyacgV9+Kt8P4H2+UyYsUEBe1UoMzMsN3wRu32Ox1J5paZv02feSz3mWNgPf/LPtL10fK/WQsNE7K4F2B9W5RWlL35ydGjFAuedB8SGXTl1qmgcZ/WxVcN/gYDrTS7Tdm7kZ3FwYjvvFaergzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.173.215) by
 MN2PR02MB6431.namprd02.prod.outlook.com (52.132.173.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 14:45:28 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::bd68:2037:bfce:606e]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::bd68:2037:bfce:606e%5]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 14:45:28 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Cannot use more than one MSI interrupts
Thread-Topic: Cannot use more than one MSI interrupts
Thread-Index: AdWKeV6DWl0//QYRTJSQlIj1KY7Jaw==
Date: Thu, 24 Oct 2019 14:45:28 +0000
Message-ID: <MN2PR02MB62053C534A3F1406267EBC4C8B6A0@MN2PR02MB6205.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [37.235.116.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e983cb-7e0a-4be7-f71f-08d75890cffa
x-ms-traffictypediagnostic: MN2PR02MB6431:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB643113BA04830AD2DE4A27728B6A0@MN2PR02MB6431.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(478600001)(14454004)(74316002)(81166006)(6116002)(71190400001)(8676002)(71200400001)(3846002)(81156014)(66066001)(6436002)(5640700003)(86362001)(107886003)(2906002)(25786009)(8936002)(52536014)(4326008)(2501003)(76116006)(476003)(102836004)(55016002)(54906003)(316002)(6506007)(6916009)(305945005)(33656002)(7736002)(44832011)(2351001)(7696005)(9686003)(256004)(99286004)(26005)(186003)(5660300002)(486006)(66446008)(66556008)(64756008)(66476007)(66946007)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6431;
 H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1krSr0GKtNuyerP7aV0svzZlNOJBvjZshkSnXZmtcLMhQ4yg4m3E3N82WugBUcO5Ex8rmgb1bRdj+pgzn8KnbNtJh0WDyyvVsiK6bRuUYOYoXXE/JRs+4bO2uNwf8fJQTvG2dINsyQM2Y3XUnLKxImjK+tGv3oBGmdfvWq57mxLuZODj8DCVvISHbBzHGDPxPifTfQvZ1Zidho/UpfNpa+r/s+N2y2J7vQxKX5GWNrtyk4v8IKjSnXr3DTkDvLxuWb+y1CqO3L3PWyFA1ehsyQqvRJ+LiTUjLNGDtVkoRACeEKAeNcNzz6gPlNjoKtKs70hPTPWWEl+AsbKaGf5YpD4FgLLv4+2GILvHIMVGCNpDQ2xEPdrcPhaU2sWu1v16jyr5nbzolDTbTduraiQqZeDj62tfbdZHV8aa3r7VkX6Jjzn8pp1zFePJA+uy8bk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e983cb-7e0a-4be7-f71f-08d75890cffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 14:45:28.2711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykVxkM1KEQuFFJrxZ8cQqohJoWfGf2ywBXvfzg11KbKjrbBWiuJjuYcrZTw3YjTnY8CPWEErYoE6TPt4unx6fphs5l117oTALQxn3dSwxaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6431
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_09:2019-10-23,2019-10-24 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have a Ubuntu VM (4.15.0-48-generic) to which I pass through a PCI device=
,
specifically a virtual NVMe controller. The problem I have is that only one=
 I/O queue
is initialized, while there should be more (e.g. four). I'm using upstream =
QEMU
v4.1.0 confgiured without any additional options. Most likely there's somet=
hing
broken with my virtual device implementation but I can't figure out exactly
what, I was hoping to get some debugging directions.

I run QEMU as follows:

~/src/qemu/x86_64-softmmu/qemu-system-x86_64 \
        -kernel bionic-server-cloudimg-amd64-vmlinuz-generic \
        -smp cores=3D2,sockets=3D2 \
        -nographic \
        -append "console=3DttyS0 root=3D/dev/sda1 single nvme.sgl_threshold=
=3D0 nokaslr nvme.io_queue_depth=3D4" \
        -initrd bionic-server-cloudimg-amd64-initrd-generic \
        -hda bionic-server-cloudimg-amd64.raw \
        -hdb data.raw \
        -m 1G \
        -object memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=
=3Dmem,share=3Dyes,size=3D1073741824 -numa node,nodeid=3D0,cpus=3D0-3,memde=
v=3Dram-node0 \
        -device vfio-pci,sysfsdev=3D/sys/bus/mdev/devices/00000000-0000-000=
0-0000-000000000000 \
        -trace enable=3Dvfio*,file=3Dqemu.trace \
        -net none \
        -s

This is what QEMU thinks of the devices:

(qemu) info pci
  Bus  0, device   0, function 0:
    Host bridge: PCI device 8086:1237
      PCI subsystem 1af4:1100
      id ""
  Bus  0, device   1, function 0:
    ISA bridge: PCI device 8086:7000
      PCI subsystem 1af4:1100
      id ""
  Bus  0, device   1, function 1:
    IDE controller: PCI device 8086:7010
      PCI subsystem 1af4:1100
      BAR4: I/O at 0xc000 [0xc00f].
      id ""
  Bus  0, device   1, function 3:
    Bridge: PCI device 8086:7113
      PCI subsystem 1af4:1100
      IRQ 9.
      id ""
  Bus  0, device   2, function 0:
    VGA controller: PCI device 1234:1111
      PCI subsystem 1af4:1100
      BAR0: 32 bit prefetchable memory at 0xfd000000 [0xfdffffff].
      BAR2: 32 bit memory at 0xfebf4000 [0xfebf4fff].
      BAR6: 32 bit memory at 0xffffffffffffffff [0x0000fffe].
      id ""
  Bus  0, device   3, function 0:
    Class 0264: PCI device 4e58:0001
      PCI subsystem 0000:0000
      IRQ 11.
      BAR0: 32 bit memory at 0xfebf0000 [0xfebf3fff].
      id ""

And this is what the guest thinks of the device in question:

root@ubuntu:~# lspci -vvv -s 00:03.0
00:03.0 Non-Volatile memory controller: Device 4e58:0001 (prog-if 02 [NVM E=
xpress])
        Physical Slot: 3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 24
        NUMA node: 0
        Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=3D16K=
]
        Capabilities: [40] Power Management version 0
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [48] MSI: Enable+ Count=3D1/4 Maskable- 64bit+
                Address: 00000000fee01004  Data: 4023
        Capabilities: [60] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64n=
s, L1 <1us
                        ExtTag- AttnBtn+ AttnInd- PwrInd- RBE- FLReset- Slo=
tPowerLimit 128.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM not supporte=
d, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLA=
ctive- BWMgmt- ABWMgmt-
        Kernel driver in use: nvme
        Kernel modules: nvme

I tried debugging the guest kernel and I think the following if is taken in
pci_msi_domain_check_cap():

if (pci_msi_desc_is_multi_msi(desc) &&
    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))                    =20
        return 1;

because flags is 0x3b (MSI_FLAG_MULTI_PCI_MSI is 0x4). And this I think mea=
ns
that MSI_FLAG_MULTI_PCI_MSI is not set for that msi_domain_info.

# grep -i msi qemu.trace
1327@1571926064.595365:vfio_msi_setup 00000000-0000-0000-0000-000000000000 =
PCI MSI CAP @0x48
1334@1571926073.489691:vfio_msi_enable  (00000000-0000-0000-0000-0000000000=
00) Enabled 1 MSI vectors
1334@1571926073.501741:vfio_msi_disable  (00000000-0000-0000-0000-000000000=
000)
1334@1571926073.507127:vfio_msi_enable  (00000000-0000-0000-0000-0000000000=
00) Enabled 1 MSI vectors
1327@1571926073.520840:vfio_msi_interrupt  (00000000-0000-0000-0000-0000000=
00000) vector 0 0xfee01004/0x4023
... more vfio_msi_interrupt ...

How can I further debug this?

