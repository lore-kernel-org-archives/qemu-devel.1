Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E228C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172A62072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZcmhPyMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172A62072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTg0W-0004or-7A
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTfwa-0006Vi-JT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTfwY-00032v-On
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:51986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTfwY-00032o-AT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:38 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T66gRj025537; Tue, 28 Apr 2020 23:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=8NipuqD8lrE82oQdFfamqDWdpttgy14ci7VATtdpGPg=;
 b=ZcmhPyMANX4ngFqOQl/xL7ElNf405lM5gzaanfIN3SD3ZCmInU51dvyDaUNh1xUU/rFB
 +iLe88f+aVfaoz53BZx31MWgGQ+sbs0+T5MaXZJ7QDib2dKmIqAnwB2SOSrCqS/s2FPK
 4g4/dwC79oybG+mbFo89+s8N3djkq/YBMhiPmY+AzGObBS+yjOWcMN94CYyOaayHlyVc
 wYCS4Drw676zf9GhUd/PdSIhVE1jaftUBPcqZXhzUjmfa/E3EGGdKEUY72EfjML0u8sd
 kdTvaDkQBJEnHHwURcXunw7HgEq5nrCDmvcNNtOTI28XcFMJZ/PrSW8DAh3p1+3vmKiw sQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mkak0221-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 23:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Lzk0MuZ9NGuri/khWLOjj1zNj76r5CwcKVlACL1oMMMRD8ixaXIDFO1P18m8vQBeZp2GbFnXiwBaNblBf07Rqqjn/APdKYLSpTo5DX3e7HnKRoj3oxJvrWhbxvU/ASIeUY5nOetKV9zifJ6QQiZTnDlYujS/2r6TLgT1TWL1aF8GZjV7mjM80/fmGr6AuFfsTnJ96BtXWiiE9Vb62LBSgvKOS5zdqybIpD/1nlQaQ9pqTvtBq2372WQqStYYgze+J+4qSLJyZYnCngGqQcIKbwk0wGs2IF1aBkfKqxisQCbK9d4hvg1bmjAUsLH7Fpau9kGPJVAN6GFK5pw9CfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NipuqD8lrE82oQdFfamqDWdpttgy14ci7VATtdpGPg=;
 b=DZrjEWN5OrRPozz5bHjgn4Pbzm8a0oeZWarED9+xFldxI/A8s0Lda7qyPZFDGuLfy5kMw6AqPjzkAVpA68yFPVx3LH3BvLjQhE3hDSWZhAHB25bOiZxBluIDuRqJ8s/at6tLhzKXWQVEKctAU64oVDYV/z1TzExWs7FnXCulJtHqksxWigz84cBBJspmQwBXDcMQuywhG4nptS7SIqAp43eu98Ykv597osDkLkTzb9mddK311OJoz836aaLW1DjbpsxZZ7+tA5ZiUy1e4q4e4wFarBQig/x4pCzHhivTnLajFTUWBxgpP4jnaYPZMYtrV5o5QD82IpL9FcDsO/1MkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6221.namprd02.prod.outlook.com (2603:10b6:208:1be::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 06:11:20 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 06:11:20 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQA=
Date: Wed, 29 Apr 2020 06:11:20 +0000
Message-ID: <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429011228-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ac6a644-fbe1-4374-e5d3-08d7ec04231f
x-ms-traffictypediagnostic: MN2PR02MB6221:
x-microsoft-antispam-prvs: <MN2PR02MB62215F9A175872348EA6C21EF1AD0@MN2PR02MB6221.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(4326008)(8676002)(86362001)(7416002)(2906002)(8936002)(91956017)(6506007)(53546011)(6512007)(76116006)(36756003)(66446008)(71200400001)(66946007)(26005)(64756008)(66556008)(66476007)(186003)(54906003)(316002)(33656002)(478600001)(2616005)(4744005)(6916009)(5660300002)(6486002)(44832011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhRDLLYTLYwsHxswbjyXKd1lBgAkiSQ+Nz/mzmdPGx9etf94RIXAFSW0HdTNCAFBTdpPfp2JeE7j1onRGmiKdzQIoLDCmrEho02t5jeH4X2YVtPgUW3U9ayYziviuaX7yInJcMyFhA67j8zSIJj4yY0tOK65oZWJv9WMTM2wrR4iLIfcgE9U4n/20H4HJ2UKzkMqYKBZrxiBKtFMhvF+zbom6Bv2IT1A0RWg6PbGuyvQySkQUmgPr/gk7AiL7V9DslQJWsk0TPC5upjZRhL4p/bC6w2moWWTZLeNTegNw+E2on+sydvANjv1i3cZqgAvAwP8j6C3JGNgUIGxIUlaXlSLW+QyaRpIzS/md8sxjcR0agW75w2JuFTf/PD4N4xmFVjKOpYcgnep4ekfgbfIEltYNT1KzXhlBedpanGFRTAfEyhBcW4z3+FMnTv7pb55
x-ms-exchange-antispam-messagedata: dCaR2WEvQP+dK3eE9YDrwyorDK+CXlgNt6t2u5Zm/6+3jrSn5Pr4NuDHWi9YFwqUUxNyiEVYKNDQhpjlwCs0tjGzcLOZj0/U0xLApYrMmxbbrFTgfbuyVxmqdHiX4Kc5g+CFtqxV/5efUncEn/uOvjQxr8wcOHNrOfB+X2z4GoCcx3ODie2DwNrOwwyolsKuIR/r+AGHri4IEEFgbx/k5sVUdVwmOeU/0R8fe36M3oDYQ6c/NjfOfxRZ82PKqTDnjOAgfU7PsOm/Jg/v1EP1nsLBAv6Irueky7SOObmUitzI9YmoQ8bKoIbxoCjAnlYsimlKG3PTJWR4/91V7okTVE33AJY+KIvLGBDE4Rtn27+rrjnxqdiomGWudtYnmOZi1HZ3pKHR/YQZfR+Ybq90D8Z4BakU8jDrI6rgokOFqtFlC06IPnuABEK70FM1O+3XY4SBhWnyjxZ6jMWjPbHB7VBZx2ov9J2OhSIvn72/+g0+GeCF5ycU8TH6BiQtgEsH0CqO6zosG91VlMFEjANlN47A18W2y7u0kg7uCDUqTN077zW4ye/ODWv8gVmseFdyI1QvIEq0GszTJujjBiz0kzFIEapPB66ziYPzMcikxJdycUnttu12+zeDGnSpHBLV0lH/EXKgodWTJ9czpuXvGgOd2pVmRRAucPjmDooLRGrhJDIf3H3u+EaOnJ516SNz3IKA7nIBvgqqc0zZEGeRdqQm5yLItSDPohyISkX6QWpdKfoEmf3WQA2EA4Zj17lao+taUklTwh4aRRUKrTfRusuMi4muLhYi9ZnfUwyZ20M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1C5790FA77BB1043AD38ECC017638C3C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac6a644-fbe1-4374-e5d3-08d7ec04231f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 06:11:20.8782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eochdu/c6YBCnAEwt25WJKyKWrju1ckFBY+oX1TqO2jyXAAzc6we80lyIMXKz+osyzrljyNVrBFDUW2tC2vhcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6221
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_01:2020-04-28,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 29, 2020, at 10:58 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> o if there's a need to disable
> just one of these, commit log needs to do a better job documenting the
> usecase.

The use case is simple. With this feature admins will be able to do what th=
ey were forced to do from Windows driver level but now at the bus level. He=
nce,=20
(a) They need not have access to the guest VM to change or update windows d=
river registry settings. They can enable the same setting from admin manage=
ment console without any access to VM.
(b) It is more robust. No need to mess with driver settings. Incorrect sett=
ings can brick guest OS. Also no guest specific knowhow required.
(c) It is more scalable since a single cluster wide setting can be used for=
 all VM power ons and the management plane can take care of the rest automa=
tically. No need to access individual VMs to enforce this.
(d) I am told that the driver level solution does not persist across a rebo=
ot.=20

Ani=

