Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A72C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20672082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HeXRhkxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20672082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUB5Z-0001L2-1C
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jUB2i-0006DB-KQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jUAzM-0007Gj-UB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:24:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:57144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jUAzM-0007DA-DM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:20:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03UFIXFu023533; Thu, 30 Apr 2020 08:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=IwFBojMMVDbkZzXbJj5jLjNf4hbVx/v3PujGzUKDeBM=;
 b=HeXRhkxoQ/xPCh9ZKAa4OSsiV+oN8IK7UES8UAs+FWCXxwnhE/7Zam6f43jvZ8wnrGRo
 0jw+6QKUOCpjpb3HyDsUaFFiTaMtC41shT4+ICwxNVpaWQl45F+ddgzqA71OT6WpYT7Q
 uwiZdJOnUPCQnQn2OagGXTqogHRMBJRcJ7LOeWHOv205vFWa4JxmKalbUsQj9n/poOLu
 soeuCvs3Kq6+Ihfn4XFs1uQKKzh7rvkGiVtW0zSIorF/F2coCoVR6woqn3JoLfzJJiZ9
 GaPr7XIsGPJWydVEZBbBsBK0LA+zM2bY19pXz0wilmt+Z74MvfhZ2GiUfWo4woUzHKzX kw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mmhjbp91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2020 08:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEZfiVecXpaG0GEJWMouseyiMYBkBdSFDpi/gXl57rueKOxwb0rM0YjDFCIaywvjYCvrAxbHmSkPQQv+6VkoPgGchi74dt5BidmrtA7yyNCo6Jl6JBE50OT5/SUrg8VwgGQSTN+lvbrz+bZxLf5j9fwoUYw+ZiO9Hfw0+rL1HcQQz4WrsNMWCeHQGxBXjs7lcToobPo/sQsvTzlqDK3xqhLk2L6rV31Kxxcx8TqGhAcObSdc9Rn15BSLllt1vppKlpCSA2HMERvvdr5srFrOtCA0TwNVEbkLg4ufgHHKwSqpgjMCAxKsqIA5fdPRBOLL9luhwp/NO0nhbEuubMdkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwFBojMMVDbkZzXbJj5jLjNf4hbVx/v3PujGzUKDeBM=;
 b=JVEBjBY1+Ftv8Np/FQYwJI7OHCRFLZHCczH6y0SVDke61gTOKy0iib56jfkNNQ/alMA4UvljMfiMRevu3t2avaUk7o4jMTAt8s1sUT9vzYkchjdjJInmAnj+4tVKB83UGXFJMqxo1QZgFwXEGQUi6jB0h29HT0BFmd/yBtZZRXK5EhFTS8y1Q2Ifjbt/8UN0/ViaAPnZDCuPzQ2JWLku870GqSl6jY20g5XRYrdwd3M1gkWtf6SbGtctKnCmrB7KDk0KifWnrsxiLjQaQmN66645efcra0IHspgot+efmq0o6KZ0W2c0UuwJ838+dh2dPICZi29lwNjVGXhQ5mfw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MW2PR02MB3659.namprd02.prod.outlook.com (2603:10b6:907:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 15:20:28 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b90a:dbb6:2412:266e%5]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 15:20:28 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QEsuagAA77zu+AAbiuPAADxCFGgAJikHLAAAKqfgAAHJa0Q
Date: Thu, 30 Apr 2020 15:20:28 +0000
Message-ID: <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200430114041.GN2084570@redhat.com>
In-Reply-To: <20200430114041.GN2084570@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 192562bf-fb9e-452b-c89f-08d7ed1a03cf
x-ms-traffictypediagnostic: MW2PR02MB3659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB36596F227D9E242E02B9E8628BAA0@MW2PR02MB3659.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6ntjgfpNhjvRiw1NQmps/Cj5CAloFoCAnrUCtvDQJ+AzGCRjw2l0Yx38CWABpDPRrvTTn94RbzFMBFQwF0E0ajSQHCUXEKg1BYyvKKgC3vSmNIdSsoyNtcMOVF2xez2CEgWQZFfKKLIs8XbEj9QrXwyeEu3GQLxxCt3sqrkVXS1UyrbtQpdDDrQBr5hPXE8YKmI0M6tkKia6vixeYkJVgwPQ0l2/Y+84pOJCs5QGPGe/zZSMwiS3xMYpQDBucLni433RUz3Lbn8xR/sW4ow1aX/lBo5d/OhqgQUKo3gmF2P8CiZnEXV3qtown632pLztYKWdH1PzSHrtpU6WZyM17Ngs35uAPFiN0d+S/nGWlRjCMuYLzGEMMbc7JxcXidwYSCx6sPo4p5GCHpSxwLJ27Czxz0X/pe7FtDVnK0Fn9lxjGOEUccpSR7wMlVyVUae5mJ/e8fvA3fqUUfULAsvEMMmzQs6Tl/70iVq+Ac4RoEtXO/ewFeL50ZMlBjLoAym/Qm6JtFp7lNh7xah285NBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(396003)(136003)(376002)(39860400002)(346002)(316002)(7416002)(6916009)(71200400001)(44832011)(33656002)(64756008)(66946007)(76116006)(8936002)(66476007)(8676002)(478600001)(66446008)(66556008)(966005)(19627235002)(2906002)(52536014)(26005)(6506007)(5660300002)(9686003)(54906003)(86362001)(186003)(7696005)(55016002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: LTYuUWSxRV1EXimf69CX+BbvbzqX0IVmVpYR+nPH1Qh6NmWn9YZReGok4YM8X7lwEL/N+aBgrj46ou0rdz6FKbtPdCGK1M3TJtg2IJ0biH+F8eRwQlWc9Mj4KjzY38EzsrXO3EvoFfuuNBOG7W73JZ/VNqOhkkzaNHnC9r/K31KHD0vnqNUUKDVOiUfoXPSssGy8QIpg+qFMxYf7jDO/bMNBY8yidOeEQ1SbqtaAMAtcndguyDztJjJP50/RVELWAvn6W6nQYTvu3J8AKc9YG7G9zrbRaEL/rX4KgKcLHdiaLxz3mevSX+cpx1jmbHXe7Kofsn3szgzcWVTq32mHygblTFRtmoje/Uo8bDGFfYSKwUrDoWpin0Rue7EtboKApe2T1t4apajIw6QXoUWRy3mPwYlJNzBJ2D/7ueOz2H9zJjefk+E2wMNwarGnnVKXPFkQl3Ya2cS0SpyhJmzEFk3jcUHF2X13UsTY+11kKQpD0zut9x93yLgSX9Z3kzVersgvulxrVhJo5AITqIPa4h1Xw0AHFMV6777Z/FpkbZlQ0G1lYq/9xGZTPz8qHj8YwE9ZyoJJD1muDFPSLSaYG1RYN8sosZgjLWiHOjZsCXxe4JuZ/Z2jfWt9ljjW37K//9+OzxARGzi/ycrad4IeYS9StNMfcJb5DAQqMA1pcA749jzNaiUM/o7r0IKpCEkGvCY4QgZwffRYELAYAcZGgAHWbFiK5fCFqAnJZmrGJd0le+cX+l7IbAhIGa+jMkGEKS/RRzllE7H+H7oBos5m/mXH5fWDWG2BWEJCF1JJkZ0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192562bf-fb9e-452b-c89f-08d7ed1a03cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 15:20:28.3806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5H//zhNMTLmyoS3NlyeDVh2DCPjuuck5zgnw9/PjlM1Jw0c2kLft2gCzp4Plrt9skbS9yGydEc188MbpHmkvwa3zqwbiI05ACMGr6l4/Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-30_09:2020-04-30,
 2020-04-30 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 11:20:34
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
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, 
 James R" <james.r.harris@intel.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+ID4gTW9yZSBpbXBvcnRhbnRseSwgY29uc2lkZXJpbmc6DQo+ID4gPiBhKSBNYXJjLUFuZHLD
qSdzIGNvbW1lbnRzIGFib3V0IGRhdGEgYWxpZ25tZW50IGV0Yy4sIGFuZA0KPiA+ID4gYikgdGhl
IHBvc3NpYmlsaXR5IHRvIHJ1biB0aGUgc2VydmVyIG9uIGFub3RoZXIgZ3Vlc3Qgb3IgaG9zdCwN
Cj4gPiA+IHdlIHdvbid0IGJlIGFibGUgdG8gdXNlIG5hdGl2ZSBWRklPIHR5cGVzLiBJZiB3ZSBk
byB3YW50IHRvIHN1cHBvcnQgdGhhdA0KPiA+ID4gdGhlbg0KPiA+ID4gd2UnbGwgaGF2ZSB0byBy
ZWRlZmluZSBhbGwgZGF0YSBmb3JtYXRzLCBzaW1pbGFyIHRvDQo+ID4gPiBodHRwczovL3VybGRl
ZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+ID4gPiAzQV9fZ2l0aHViLmNv
bV9xZW11X3FlbXVfYmxvYl9tYXN0ZXJfZG9jc19pbnRlcm9wX3Zob3N0LQ0KPiA+ID4NCj4gMkR1
c2VyLnJzdCZkPUR3SUZBdyZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1YVHBZc2g1UHMyekp2
dHc2DQo+ID4gPg0KPiBvZ3R0aTQ2YXRrNzM2U0k0dmdzSmlVS0l5REUmbT1sSkM3WWVNTXNBYVZz
cjk5dG1UWW5jUWRqRWZPWGlKUWtSa0oNCj4gPiA+IFc3Tk1nUmcmcz0xZF9rQjdWV1EtDQo+IDhk
NHQ2SWtnYTVLU1Z3d3M0dndpVk12VHlXVmFTNlBSVSZlPSAuDQo+ID4gPg0KPiA+ID4gU28gdGhl
IHByb3RvY29sIHdpbGwgYmUgbW9yZSBsaWtlIGFuIGVuaGFuY2VkIHZlcnNpb24gb2YgdGhlIFZo
b3N0LXVzZXINCj4gPiA+IHByb3RvY29sDQo+ID4gPiB0aGFuIFZGSU8uIEknbSBmaW5lIHdpdGgg
ZWl0aGVyIGRpcmVjdGlvbiAoVkZJTyB2cy4gZW5oYW5jZWQgVmhvc3QtdXNlciksDQo+ID4gPiBz
byB3ZSBuZWVkIHRvIGRlY2lkZSBiZWZvcmUgcHJvY2VlZGluZyBhcyB0aGUgcmVxdWVzdCBmb3Jt
YXQgaXMNCj4gPiA+IHN1YnN0YW50aWFsbHkNCj4gPiA+IGRpZmZlcmVudC4NCj4gPg0KPiA+IFJl
Z2FyZGluZyB0aGUgYWJpbGl0eSB0byB1c2UgdGhlIHByb3RvY29sIG9uIG5vbi1BRl9VTklYIHNv
Y2tldHMsIHdlIGNhbg0KPiA+IHN1cHBvcnQgdGhpcyBmdXR1cmUgdXNlIGNhc2Ugd2l0aG91dCB1
bm5lY2Vzc2FyaWx5IGNvbXBsaWNhdGluZyB0aGUNCj4gcHJvdG9jb2wgYnkNCj4gPiBkZWZpbmlu
ZyB0aGUgQyBzdHJ1Y3RzIGFuZCBzdGF0aW5nIHRoYXQgZGF0YSBhbGlnbm1lbnQgYW5kIGVuZGlh
bm5lc3MgZm9yDQo+IHRoZQ0KPiA+IG5vbiBBRl9VTklYIGNhc2UgbXVzdCBiZSB0aGUgb25lIHVz
ZWQgYnkgR0NDIG9uIGEgeDg2XzY0IGJpdCBtYWNoaW5lLA0KPiBvciBjYW4NCj4gPiBiZSBvdmVy
cmlkZGVuIGFzIHJlcXVpcmVkLg0KPiANCj4gRGVmaW5pbmcgaXQgdG8gYmUgeDg2XzY0IHNlbWFu
dGljcyBpcyBlZmZlY3RpdmVseSBzYXlpbmcgIndlJ3JlIG5vdCBnb2luZw0KPiB0byBkbyBhbnl0
aGluZyBhbmQgaXQgaXMgdXAgdG8gb3RoZXIgYXJjaCBtYWludGFpbmVycyB0byBmaXggdGhlIGlu
ZXZpdGFibGUNCj4gcG9ydGFiaWxpdHkgcHJvYmxlbXMgdGhhdCBhcmlzZSIuDQoNClByZXR0eSBt
dWNoLg0KIA0KPiBTaW5jZSB0aGlzIGlzIGEgbmV3IHByb3RvY29sIHNob3VsZCB3ZSB0YWtlIHRo
ZSBvcHBvcnR1bml0eSB0byBtb2RlbCBpdA0KPiBleHBsaWNpdGx5IGluIHNvbWUgY29tbW9uIHN0
YW5kYXJkIFJQQyBwcm90b2NvbCBsYW5ndWFnZS4gVGhpcyB3b3VsZCBoYXZlDQo+IHRoZSBiZW5l
Zml0IG9mIGFsbG93aW5nIGltcGxlbWVudG9ycyB0byB1c2Ugb2ZmIHRoZSBzaGVsZiBBUElzIGZv
ciB0aGVpcg0KPiB3aXJlIHByb3RvY29sIG1hcnNoYWxsaW5nLCBhbmQgZWxpbWluYXRlIHF1ZXN0
aW9ucyBhYm91dCBlbmRpYW5uZXNzIGFuZA0KPiBhbGlnbm1lbnQgYWNyb3NzIGFyY2hpdGVjdHVy
ZXMuDQoNClRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2ZW4ndCBkZWZpbmVkIHRoZSBzY29wZSB2
ZXJ5IHdlbGwuIE15IGluaXRpYWwgaW1wcmVzc2lvbiANCndhcyB0aGF0IHdlIHNob3VsZCB1c2Ug
dGhlIGV4aXN0aW5nIFZGSU8gc3RydWN0cyBhbmQgY29uc3RhbnRzLCBob3dldmVyIHRoYXQncyAN
CmltcG9zc2libGUgaWYgd2UncmUgdG8gc3VwcG9ydCBub24gQUZfVU5JWC4gV2UgbmVlZCBjb25z
ZW5zdXMgb24gdGhpcywgd2UncmUgDQpvcGVuIHRvIGlkZWFzIGhvdyB0byBkbyB0aGlzLg0KDQoN
Cg==

