Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC41C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A626E2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="t7aisRy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHP8W-0002Iw-RX
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jHP74-0001ax-Ml
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jHP72-0007kb-EH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:47:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:31386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jHP71-0007jz-S2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:47:44 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02Q9l6o0006169; Thu, 26 Mar 2020 02:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=XWMkSbysC4H4YSTS4RgaZsIgmps3BCKCukF7iRTUv+s=;
 b=t7aisRy4yUdweM6wQ5HgIXlOzNxLb3TNENwScc5XFTlwIg+ku7AJWKbqgv8tUN0BQYDH
 jn3D4Q5lm3oV7CxHb5ZTDt2EHW7VK0/1DLDjoqvWo17fDAxc6MnytXvJPycIlgMZGjzY
 YjolFB24rz2Zd7ha5zeV+zsjU996dyAIhUZOKdTT7lDuy9NX6CZ2dtG1NkqrjSl+TDZD
 Nqu3ZKmlqcHOJUFxL8TJeE9EQkYIeh5XoOxL9Oa2O1UPviFmoGwmq+EvDtrYY7pzMdST
 k3GypcvCBFm4aXVpLh/+7UwT35ILxCK86XJklVw4VBPTLyiXUFLCwrUlfTXc6pPWdgIA aw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2yweua2gxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2020 02:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgoOnwfVV5dCpTYHFY5DM0Uef6cPCHTZ4YqMy7f052xXVz3cgo3RZl1YKr3GzgH/ynzEsLogEczJ0u7iAQlUDSqTnrFymrY0emSbIr4UtA+u2OG1VOr6ZjIwtcvvtQ4+JcFgJw7IvuWS1vyva79nJzGK/mQ6a5S+MzUMIgg480ooPAKsZuu0/cKbies3YTPRP72vfwRoOKYrWqHYGKuXKygjgxlRGvsGXdyF0LU6dsL9A3PJCp1xYH9rD/4sto6W7P59TVG4Bw42qVBUdlm5GxoEuVw7bF8MSLKQJm9HtbU2oLslpraXhZEuIYQo/Sa85CU5dnCbyD6HGvSSXDHNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWMkSbysC4H4YSTS4RgaZsIgmps3BCKCukF7iRTUv+s=;
 b=ONduPY1IvGIqYb2/UFdny9l5K/p/zpFLklHc5bOo/PfBKWADSFuvisCRM1lTbEVw9E4p/ksk5oJLzKgO8830BrBM5pfv7BjZ5ok8ClaqZlmuOgLMGj7fjS4DY/ep8Rwh35t4qKdx+PRGv8sheVQlppXqj4fUCpAX7Gi5VN/fe6FY9iWji39JnsNlU0K4ycbkTTVpN1wqmz6Te2Kb/cVjt844p6cvL8yPg/49D+8Eq7QixJ49pkDkxz3+hD1qvQjrIh/X5VZs8m2UfYtfVj0RLSYAnXps3ojQL2wyFALQynYqI8OCvcFsEymP7zwT0DvR0GJBvQEi2cvAqpEBaDPGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (2603:10b6:208:1bf::17)
 by MN2PR02MB6639.namprd02.prod.outlook.com (2603:10b6:208:15f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 26 Mar
 2020 09:47:39 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9%5]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 09:47:39 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RFC: use VFIO over a UNIX domain socket to implement device offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9Q==
Date: Thu, 26 Mar 2020 09:47:38 +0000
Message-ID: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82d9649d-a187-489f-a47d-08d7d16ab8b2
x-ms-traffictypediagnostic: MN2PR02MB6639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6639681CD0DFB3F68E7ECCBB8BCF0@MN2PR02MB6639.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(8676002)(54906003)(44832011)(316002)(2906002)(55016002)(6506007)(5660300002)(7696005)(52536014)(26005)(76116006)(8936002)(66476007)(86362001)(66556008)(966005)(9686003)(81166006)(4326008)(186003)(6916009)(71200400001)(81156014)(66446008)(33656002)(64756008)(7416002)(478600001)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6639;
 H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qqg+/c5UzmqQ6WuyElS9gDocRNp5zE8SVmZBsVm6HL4Mf9QCD9gnAdg6aFRM4A+2eSYTnh/7TUlYKtoqsJGts4VUbzMMFMfDU6FeirHHoIvEaSmoDFf71MuTf7mmRsfd5B1kHPna8MyCxKb5PySbkT8Nrye10nJXrM8l6QukktJ+yKXTEUwf0TnDdkzomULKey2gsEPTgpuSPZjBTiIK5A6bJ51UOJ+IgYDA7mJQoJh+Caq3HC75Ed807NroqXR8QxKQ/4ta1egZofTmVRW77M2QdY/j6yFJgshcAJBIZxLGSfzAAA8kg1D1Qq5wN6D2LQ4dX6/fvlXvM7ceBPhpx9GJ3xeu5Og/RHXCPFg4ZvJQv2MHWzPdQqbsSBsWUaU13zdZIiBWJKqtmORGRQQ0fku6fQx4YxZR0JB5k6acX56RSxsbEu+KwwltYFXWbgAlhtJiL/GoUf225VfVIGR9p+g42345+dJY02bvJPtAJMUUkDoinV5uto9Z2SVNjPxnF8BvhLnYMLYXBs2viQDQ9Q==
x-ms-exchange-antispam-messagedata: l2+aZxy80SjdslsanbYtoM0wFLCfdJ58B9VG1dvNo1vlGVhwdLTRyO55RGOfv2Elx86EV0zfxploNsP7UtLgefz3nulqxylyRQ//2//3/geOtSATJOZFZPpVfpQ5niXO/1avu/7TAyrtiaGYyw8RRQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d9649d-a187-489f-a47d-08d7d16ab8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 09:47:38.9709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6iEtNBgrGUrZPSnZIdpCKfaPuSsJyVXxWaK43pmnsdRcJVY+9Dxk2CRmXMF+nTinzQp3eB73SFSjllX1n7ixhHjbis+RCKSmRBovU5qBaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6639
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-26_01:2020-03-24,
 2020-03-26 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, 
 James R" <james.r.harris@intel.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "Zhang, Tina" <tina.zhang@intel.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I want to continue the discussion regarding using MUSER
(https://github.com/nutanix/muser) as a device offloading mechanism. The ma=
in
drawback of MUSER is that it requires a kernel module, so I've experimented
with a proof of concept of how MUSER would look like if we somehow didn't n=
eed
a kernel module. I did this by implementing a wrapper library
(https://github.com/tmakatos/libpathtrap) that intercepts accesses to
VFIO-related paths and forwards them to the MUSER process providing device
emulation over a UNIX domain socket. This does not require any changes to Q=
EMU
(4.1.0). Obviously this is a massive hack and is done only for the needs of
this PoC.

The result is a fully working PCI device in QEMU (the gpio sample explained=
 in
https://github.com/nutanix/muser/blob/master/README.md#running-gpio-pci-idi=
o-16),
which is as simple as possible. I've also tested with a much more complicat=
ed
device emulation, https://github.com/tmakatos/spdk, which provides NVMe dev=
ice
emulation and requires accessing guest memory for DMA, allowing BAR0 to be
memory mapped into the guest, using MSI-X interrupts, etc.

The changes required in MUSER are fairly small, all that is needed is to
introduce a new concept of "transport" to receive requests from a UNIX doma=
in
socket instead of the kernel (from a character device) and to send/receive =
file
descriptors for sharing memory and firing interrupts.

My experience is that VFIO is so intuitive to use for offloading device
emulation from one process to another that makes this feature quite
straightforward. There's virtually nothing specific to the kernel in the VF=
IO
API. Therefore I strongly agree with Stefan's suggestion to use it for devi=
ce
offloading when interacting with QEMU. Using 'muser.ko' is still interestin=
g
when QEMU is not the client, but if everyone is happy to proceed with the
vfio-over-socket alternative the kernel module can become a second-class
citizen. (QEMU is, after all, our first and most relevant client.)

Next I explain how to test the PoC.

Build MUSER with vfio-over-socket:

        git clone --single-branch --branch vfio-over-socket git@github.com:=
tmakatos/muser.git
        cd muser/
        git submodule update --init
        make

Run device emulation, e.g.

        ./build/dbg/samples/gpio-pci-idio-16 -s <N>

Where <N> is an available IOMMU group, essentially the device ID, which mus=
t not
previously exist in /dev/vfio/.

Run QEMU using the vfio wrapper library and specifying the MUSER device:

        LD_PRELOAD=3Dmuser/build/dbg/libvfio/libvfio.so qemu-system-x86_64 =
\
                ... \
                -device vfio-pci,sysfsdev=3D/dev/vfio/<N> \
                -object memory-backend-file,id=3Dram-node0,prealloc=3Dyes,m=
em-path=3Dmem,share=3Dyes,size=3D1073741824 \
                -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0

Bear in mind that since this is just a PoC lots of things can break, e.g. s=
ome
system call not intercepted etc.

