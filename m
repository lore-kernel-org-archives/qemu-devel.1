Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEBC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F862063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gc3b5F4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F862063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1Zw-0001PD-TQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jT1TB-00042c-3u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jT1T8-0006jF-DI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:58:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:10894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jT1T7-0006iZ-Oi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:58:34 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03RAvBNb017357; Mon, 27 Apr 2020 03:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=q/REmZMg/S+rbarczIBpbJTGlngJ0Pyjh8bhWYZ5gec=;
 b=gc3b5F4LW2zLP+I/jDJs3qN6gfY2kbiKa85nhwqde7M6vzG4PIgEH0pcpfeV4gUtPodL
 itsrnT6v7mWppUhrYlwdXXe6dS/1b2TLr22HiQa3suQX6LJs5vPiM1JSBfdalfdmS2AQ
 zzhaNmalXs9sUbifbpnoZvEDXcO3y9nfojxIH9fVvpYgEOZVvae8dyJ68NYCLc4dIFae
 GioCZIiVcAYZxT7aC63czpDjMy/n+ESWzLpKuvvPK0tW8zIB/exQj8mnEJc6wDaUdDx5
 WjVrlTfgN/VNIvWjGrtffVZcJjiY+5cR3iI03YNbdQRAvIw9ixHoVaZL/HKapZCrr7yW Og== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30mnh1b9e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2020 03:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmj/Ley4ngaMMeNBfLP+xk5iQUIT890XirX9Zi5ZWyFmaXzWDMRITmglxGUo0JrZOpJCpG0c+LLkCPcPz9MWf0whjkHTl4caKzldZTe1qe2bPrQo0WuMFxHgNnJky186R4TQV0UfGQn6mVf8QGQGVbHOscJpPGfxoi0zgyPvhHstasU3ycGX5YpMHXcXoOY8U/LkGrcNy/xMrUT8Ry3PA4k0yBGhI2i467F+rfh6Q5T/yzPkkzqq+Lq8DK9U/15GVrH2mXggTOkrnErSJ7JdLW/is++mQVTnDhNPbXOrU17wS3Jn/3cqkSy23dOdG6tKEXqTnHieXty+qt85O9zpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/REmZMg/S+rbarczIBpbJTGlngJ0Pyjh8bhWYZ5gec=;
 b=kGy68mbLQdnMxXYOsdISicCSiMcfah0RWchxVA9hupF8QxEW22yODS+r4ed/57OOfl/zv2mtPawe6VL4MrK7qbhWz+DVGaYY6JOLcRBMYWrO/7u5ZpjCuAQ0eAw4KwcQOeqPqPBHjoT9MIdVpks+yeXjcF4dIihC8pBcpsslR8CeH4z6hXWL9OCrM4nVgCcPIaoNY49MVZzhiaXJqzgftCldxs5p2sJ7bRRuyzSUlJHK8iyV7DsLB4t2Zf+UKuLP0rvK64zFJkuy4fRm8TQX1qksRm9x5cQETS2UWfEVS+lGgR81MPy6vMAzWoOiMT0yMTevoQI/xNxlKiyJo+nf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MW2PR02MB3802.namprd02.prod.outlook.com (2603:10b6:907:4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 10:58:26 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 10:58:26 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: RE: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QEsuagAA77zu+AAbiuPAADxCFGg
Date: Mon, 27 Apr 2020 10:58:26 +0000
Message-ID: <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
In-Reply-To: <20200422152930.GC47385@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc21d560-47b0-4d3c-bd4c-08d7ea99e9ac
x-ms-traffictypediagnostic: MW2PR02MB3802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB3802ED1E0BE975ED973A4A8C8BAF0@MW2PR02MB3802.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(186003)(55016002)(71200400001)(64756008)(8936002)(66556008)(966005)(66446008)(7696005)(478600001)(81156014)(5660300002)(52536014)(8676002)(76116006)(66476007)(66946007)(6916009)(44832011)(26005)(86362001)(7416002)(6506007)(54906003)(316002)(4326008)(2906002)(33656002)(9686003);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OVdxWmt5oJy914EGGFag4qyLP0hMqGWGdbkXN8zESVFISpDbKr7QWqiGnF3NkQ8hT43iefUVWxumE1L8XGdMWwJaLLqEIX3Gjo9GPRfLiZSuO93zYfwUoTDCyMd60Qs3hExMzx97dtm2PfrO7bStFFWV6CxUTGKdXQo81TrC1kaA+Y5p0keNn0geWLU3tWJBOm0uU7IqhN2N5V8cJSClq8JYzz5MkftyNIumkWsTux+f1+jeyz0KKpQkeQwm9MpQ4NpRIDbE/xTSOy/CFiCtH9DIvdhSgxjdaMpyUMsG+mG6e1Alz4gP3c1P8ToeJjHi9mA0ewRb+kuyB+x21NgxKBgVp2MCqFKe5x5TUKI9IK8gI+5xVw+0yrh1mcKlxSaMsnPXriE415HUq8fwxaMY8LDqmJfBdfHJae3VBXt9PdBoBhCfWxGw1OocmU1a3msO54IPO+FLUS0CiQbrXLTGtFp8lJx7cFr+d5K0uVlriO6AnQjWXIwz9uUEyQnvgtcDESQuIhnQFE/sA1QpF9ocg==
x-ms-exchange-antispam-messagedata: YVFwaXvDxzB+nmUWv9Zb7M2EQY9eIjq0LWFQ3kQ57XtRujVuhicFMR9KsYWN75kTZS4Bp5yMql6MbhOFOv8zO2+6Hot5HqygMUSQpn+yP9pBfW5dPQzgNOy7OKQN99n1RsZpMTUfFlUixolK1wbyBFnjk1I5m6az0oapj6BFgWCDa8iG1UOfzMYDKB0BoUWT1qy6DMhga7mbsbZey0ADc/On/QQ89Gl4xj7t16X5O1vet5py9WY2ciSvqlkdmKVJMWlqHHDCdkM0TI9gDT1H1dGBokdbXmzK9n4F8/TJGHFXWcBDzva6eS+mHnX29rQWc9/GxZbT8w8ESKlMjVPohxXyxKZ+NbcTQJyrTS8NXmZ7yE7RVHGF2Ih7q064I40mH4Zb1WGevINvsK8XSQLyL6nQ7inyV9NqvoLKGKQ2w2jDaMh6Pq8jgswKpYrOHMlSl9UkrgJJGNxI6OVuvujUdUkqFO55QvfkUBX5ugBdoT7RthQLTgf3fQ8EBcqxAxzagZdLbz5Rsdv7X4eA7ZnPXIxIcaGQcz034Xc6b2QCoFnxFHk6uAJ0ChwCdkl1L7EueJlj5GeetGWHngumNhXkvte7Q96yhIrghSJzr9N+JUeQJ4DrmFYuvx2HXYgguMCsrBXLMu/LtswK/0NbtnQF2g5ZNl5MaRF0naoh1GoXfQnFTBZV057QX5ELJjBJW01Jov1xTNKfBULrseeCfHwZGvCVp1cagKHEZtxVpvU5IpygBjv3NTv6w/JzS6EcsivButV0U5ct/CZzqxUHo9Ott/x5qEdoY4DYBXBUNQ+6VdA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc21d560-47b0-4d3c-bd4c-08d7ea99e9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 10:58:26.5853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLdVG2JPWnVa7TMFz++uXe+KjU1wLk0jOuLUm2Keb+GfQSXitMrFYsE6XY2xHb89bA1so3XRt0bAp/7WT4uQaXBwllwscA7eCMrOTUpZm5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3802
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-27_07:2020-04-24,
 2020-04-27 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 06:58:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > I've just shared with you the Google doc we've working on with John
> where we've
> > been drafting the protocol specification, we think it's time for some f=
irst
> > comments. Please feel free to comment/edit and suggest more people to
> be on the
> > reviewers list.
> >
> > You can also find the Google doc here:
> >
> >
> https://docs.google.com/document/d/1FspkL0hVEnZqHbdoqGLUpyC38rSk_
> 7HhY471TsVwyK8/edit?usp=3Dsharing
> >
> > If a Google doc doesn't work for you we're open to suggestions.
>=20
> I can't add comments to the document so I've inlined them here:
>=20
> The spec assumes the reader is already familiar with VFIO and does not
> explain concepts like the device lifecycle, regions, interrupts, etc.
> We don't need to duplicate detailed VFIO information, but I think the
> device model should be explained so that anyone can start from the
> VFIO-user spec and begin working on an implementation.  Right now I
> think they would have to do some serious investigation of VFIO first in
> order to be able to write code.

I've added a high-level overview of how VFIO is used in this context.

> "only the source header files are used"
> I notice the current <linux/vfio.h> header is licensed "GPL-2.0 WITH
> Linux-syscall-note".  I'm not a lawyer but I guess this means there are
> some restrictions on using this header file.  The <linux/virtio*.h>
> header files were explicitly licensed under the BSD license to make it
> easy to use the non __KERNEL__ parts.

My impression is that this note actually relaxes the licensing requirements=
, so
that proprietary software can use the system call headers and run on Linux
without being considered derived work. In any case I'll double check with o=
ur
legal team.
=20
> VFIO-user Command Types: please indicate for each request type whether
> it is client->server, server->client, or both.  Also is it a "command"
> or "request"?

Will do. It's a command.

=20
> vfio_user_req_type <-- is this an extension on top of <linux/vfio.h>?
> Please make it clear what is part of the base <linux/vfio.h> protocol
> and what is specific to vfio-user.

Correct, it's an extension over <linux/vfio.h>. I've clarified the two symb=
ol
namespaces.

=20
> VFIO_USER_READ/WRITE serve completely different purposes depending on
> whether they are sent client->server or server->client.  I suggest
> defining separate request type constants instead of overloading them.

Fixed.

> What is the difference between VFIO_USER_MAP_DMA and
> VFIO_USER_REG_MEM?
> They both seem to be client->server messages for setting up memory but
> I'm not sure why two request types are needed.

John will provide more information on this.

> struct vfio_user_req->data.  Is this really a union so that every
> message has the same size, regardless of how many parameters are passed
> in the data field?

Correct, it's a union so that every message has the same length.

> "a framebuffer where the guest does multiple stores to the virtual
> device."  Do you mean in SMP guests?  Or even in a single CPU guest?

@John

> Also, is there any concurrency requirement on the client and server
> side?  Can I implement a client/server that processes requests
> sequentially and completes them before moving on to the next request or
> would that deadlock for certain message types?

I believe that this might also depend on the device semantics, will need to
think about it in greater detail.

More importantly, considering:
a) Marc-Andr=E9's comments about data alignment etc., and
b) the possibility to run the server on another guest or host,
we won't be able to use native VFIO types. If we do want to support that th=
en
we'll have to redefine all data formats, similar to
https://github.com/qemu/qemu/blob/master/docs/interop/vhost-user.rst.

So the protocol will be more like an enhanced version of the Vhost-user pro=
tocol
than VFIO. I'm fine with either direction (VFIO vs. enhanced Vhost-user),
so we need to decide before proceeding as the request format is substantial=
ly
different.

