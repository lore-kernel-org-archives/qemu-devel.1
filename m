Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96A9C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8601B20724
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Rc6WNOj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8601B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUGP-0003VN-PJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33950 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jQUFJ-0002l8-BC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:05:53 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jQUF4-0001vb-Fo
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:05:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:1452)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jQUF4-0001tB-24
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:05:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03KB3WXb011104; Mon, 20 Apr 2020 04:05:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Pc4F1nUFzUr932218U9gb2WZsGCRl/1hTpEfOKYXCmE=;
 b=Rc6WNOj8Hx3dLEyDtcl9aIDWUHILPyoQoyVfCVZ/7TVEba3yfv/KO1t7UvH6XrXUS6AN
 IMFaBG2x7307PIdoQRnF5F0X9fQyfRHkgZ5YWN6pMkJm7Ch4S3MIsotjNHNBXOq5c6kQ
 vZ6OAE3TLtThlVE+qr7vwL6pdE9+0C6x+qbgr85+reKRvl3aJZ0mgUBKdpeav4P49r2E
 HdtHS5JfbLixGku6xRYbY1GV80nZkaSbNxtGFfa9bgLur7uJJ6QZiPT4JQh1y31FWkIE
 6rnGF0pp3L6U0PXkqefnC5QW7IfGLnvHJGZRhvbZXiwwRSbPigIoLyga4rxx38+6h/ML Ew== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30g0vg35wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 04:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRFy3t+elDh7p1fSvw5suPxGUFnrjHFsaNaOmwOSuSpNLs/jmpOIJhatWz6pnYi5mvp0ACWfdR/Ybqm4Vd9t/QlLeDLamGPpm42OaP6tXzd0OGvNjP7hFPJQhDdn38EfopY30RWGYP1xbcQiARC4gR/M0Cyy3VkI2TSllJneaXEfMBkO1FaGamsTYx1xnu36T8cYsCU7jIiUlu+psYHroq+LtwaoLN3waqW5UTsDoKevFODLFqyq5oevgyj2jqiXqhSLdRDdzU1vbuVG1SlBmiZJp6wIIyND2obD8UYs2FnfQ0HyGU1ltZ0UH3rBxGtVVd/obGTSX7GefyBfSIc6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc4F1nUFzUr932218U9gb2WZsGCRl/1hTpEfOKYXCmE=;
 b=EpJrhh/e2ql81+NnqgbEhS9e96FrHRuOps7p1kVfb0F8niXD1vtqgKoe4OlRAHrRNovfKnlWZV/QjMEM+cUvKmu1kt0GqargLg+grgb+rWsJ5d02brgA6bA89rkLZV0m/3x5XUdfx0U5US7sAfu3eD0mNQsLnDmjHUpCByIxEA6gyvTxUNXExeXnOCqJpF7t5jqje3zUG6xw9KESkCD19YiY/kbLnQ+ZF3CzD8HtQ6CTvihAiM0m9N3E6MOyUTZsCobLm76KDG/r2E6iAUb7SJfS6gRvSgYj6cDLPFwYsxmkUL0metI4xCFyE3G/Ih9wVXI0Zwv2uViV6oqMHxbCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MW2PR02MB3739.namprd02.prod.outlook.com (2603:10b6:907:9::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 11:05:25 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 11:05:25 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: RE: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QEsuagAA77zu+A=
Date: Mon, 20 Apr 2020 11:05:25 +0000
Message-ID: <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
In-Reply-To: <20200401091712.GA221892@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38da976d-9793-428a-44f7-08d7e51aba60
x-ms-traffictypediagnostic: MW2PR02MB3739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB37398AC7766F02D5B92DD3B18BD40@MW2PR02MB3739.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(376002)(39860400002)(346002)(396003)(136003)(366004)(86362001)(186003)(316002)(6506007)(2906002)(54906003)(52536014)(478600001)(8936002)(81156014)(26005)(6916009)(44832011)(966005)(8676002)(33656002)(71200400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(7416002)(4326008)(76116006)(7696005)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BaKCsWLV67OAHbdUEiFwPuMBKuk3ulQvJYHx7zJ7lZgkuHgzzHprJED7h/cXvSqMnWTgllBO7JumazKFzl7QRVjuReEo6ZGE97pGgPnqUZH5OXK7zs5C6o8c04GCFHdIRP1ATijZ8ebBgKV/WJK5mpaPec8B05gbdK72+M10E5W7wrf6zRO5rThaMvS6jmr1y/oLyry+A5/guGLj8zgUh1TFMQ2c2O2iwDi8T/WQZ83XOQLhHj/kjlTG1Eg8C3U0LdTlkIRbeg5hXm4na8CZFqBZTsfyK3sOTWQybejSDEp61MTm4vvEOfMQDfUSKdlluk2/2hUbCbndWebLe6kw4foGmF2UKfWbVJCxl11/9xfNyQWUvP4MqcjBCiVrL6zLKGzdR9nyKJQTXSzUcVuJPR/cDr12Xqz8UQlDUtygckksaxl8GnloqsQcd7lSxCe8eJ9r9D6QZJc8HAWZNql9ITa8VvLhSJmSQ9Q8Bp174yI7nfEqFt3Gx3LaJjp+4fksYSVoz6mGbPoJO57dta85Cg==
x-ms-exchange-antispam-messagedata: 3t5oeRVabuRC4EezVQaPfL6dkNe9cwzLqwoz6Z28uhjP70gFFb/37VP0oTAFE9BfrleqrIIs5eI83/9KTPZ7h/u6dRZA/RVgCyuWAmHPXFeQAFY8QJzLpsrAKThSFHvQxMTl8UFjXzMNNvxsmPhdZQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38da976d-9793-428a-44f7-08d7e51aba60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 11:05:25.2737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ8z74YuCS52I9fXWn8eUmjt1IfOe8RsVqEBZ8P4g2ztUruohUYs9QomXYrRqkjP5GHWq+UU1pyb769+nbi1y+MFLBpjQ+de7rnVaF05FAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3739
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_03:2020-04-20,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 06:33:52
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Jag Raman <jag.raman@oracle.com>, "Harris, 
 James R" <james.r.harris@intel.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> In order to interoperate we'll need to maintain a protocol
> specification.  Mayb You and JJ could put that together and CC the vfio,
> rust-vmm, and QEMU communities for discussion?
>=20
> It should cover the UNIX domain socket connection semantics (does a
> listen socket only accept 1 connection at a time?  What happens when the
> client disconnects?  What happens when the server disconnects?), how
> VFIO structs are exchanged, any vfio-over-socket specific protocol
> messages, etc.  Basically everything needed to write an implementation
> (although it's not necessary to copy the VFIO struct definitions from
> the kernel headers into the spec or even document their semantics if
> they are identical to kernel VFIO).
>=20
> The next step beyond the LD_PRELOAD library is a native vfio-over-socket
> client implementation in QEMU.  There is a prototype here:
> https://github.com/elmarco/qemu/blob/wip/vfio-user/hw/vfio/libvfio-
> user.c
>=20
> If there are any volunteers for working on that then this would be a
> good time to discuss it.

Hi,

I've just shared with you the Google doc we've working on with John where w=
e've
been drafting the protocol specification, we think it's time for some first
comments. Please feel free to comment/edit and suggest more people to be on=
 the
reviewers list.

You can also find the Google doc here:

https://docs.google.com/document/d/1FspkL0hVEnZqHbdoqGLUpyC38rSk_7HhY471TsV=
wyK8/edit?usp=3Dsharing

If a Google doc doesn't work for you we're open to suggestions.

Thanks

