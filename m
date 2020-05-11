Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE38C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4DA206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZmRmTePP";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="sVCmCh0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4DA206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY420-0003aV-3U
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4400c99de5=bbhushan2@marvell.com>)
 id 1jY41F-0002wb-4s; Mon, 11 May 2020 04:42:37 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4400c99de5=bbhushan2@marvell.com>)
 id 1jY41D-0001Rd-1I; Mon, 11 May 2020 04:42:36 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04B8ZtPi020177; Mon, 11 May 2020 01:42:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mwOE/vNkghnMqU32Xm9b73owBl1LFddPyk0Aeq5jnnw=;
 b=ZmRmTePP6RS3mdbVT7eJgo52ac5O3+azEC68LYvkLeQDsDBRMT/TrPtRZkD5hGmmxsFq
 jT2I3EUquOiEvB4xtUoRxlYViP1HTSwRZLBsNsq0v3MjLcaB3w5UXFNQNVapV4T24jT9
 q5xou6lix6oxlV3IAUSpRVZcW/M8yPM6F4qQn1XNgq7UPocy91avd4dnoLqkrClq03PT
 7/zBcdGfIMgxY7gida+t+mrMm7rSQOoM2v9ZQfVFBtPdImT/4bzu0I3OgT98vStoY9Eq
 uQO6+xKsgIFWhF1EkqDd9mTZv0zEqzcSXGMs5M09C+ZgzfeFhoRbWWx+/woJM6Hkl6gh 9A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0b-0016f401.pphosted.com with ESMTP id 30wv1n5mjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2020 01:42:32 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 11 May 2020 01:42:30 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 11 May 2020 01:42:28 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 11 May 2020 01:42:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+x9V2XrYN4t1s383+gNuMdsXeZPCGnQBNWPzSIew8PZAbK4jPg9R1XkDv0gZ2JGU5didLsWJeu+umUDKvsGHi+QdQ6nL5wCRoIc4M1QeOewE1sJGU2DVGO0u67Pzj/PGe4BWHqhh5XeS1Aul/WxukxRsVFAYfCu4wnytxyqBxJ0BAR36p8f7ZrGuCJLbHapIFiSbFXYyIgFw4aqpxNMgWFy8iUGcfY1uqPHqdEdoBGAW1w+2G6+p4Ab7hjG5bYwMb8ds8NApu1quMGz1iM7Ap29ziLixu9sGes4+6UqCDneGB9NWbk5mFvBVO0uO7xGhMoKipW/iNC6q/W6hnA7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwOE/vNkghnMqU32Xm9b73owBl1LFddPyk0Aeq5jnnw=;
 b=Kk8LQA5iNp87ADIgCJZfIUqroztKtuyhcRlE+Gdh5vF01Dc6XrZAbKG6J/0YadfSp7djCZO09c2WNl8WOyyFXlnJ/Ngw1MhWAHhqRdLWCkq8Fyv+6vCtDIXsBXZW03tii97UVbSwjnPBvKgFaLWm99fY0RuatVU/3AQJrSTcd/URKOZjbtM8ubqs9YhyULGFovAp7QBF5lvKNjUmnRE+oOWlMdoMlrb3fimzguLYIp8IWmM3Cga3T3MxFQWyfdlHhHqUF7COJm5tXEoMssREkuFBjwmyH/gsKs6XJ+gyk0QlakXg+al0J8bXu1DvTJBV9d4r8fNF1uO+YgPGgJDGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwOE/vNkghnMqU32Xm9b73owBl1LFddPyk0Aeq5jnnw=;
 b=sVCmCh0+ndpZZiwhzwBf4kVYaFGiEKQJqu4LxARj6p3eUfjZEuEcvtBcuGLPD0A83PcFNlnmWTtttgfGpi2ASc2ZvssP7wCNw1mEX2kw+LhjeJ8pKA9NfksE8JOyvjIiHM9JBVe3i42JCwtlNTkbA/Gqn2FFpK550Ll1lAEvqU0=
Received: from CY4PR1801MB1959.namprd18.prod.outlook.com
 (2603:10b6:910:75::25) by CY4PR1801MB1959.namprd18.prod.outlook.com
 (2603:10b6:910:75::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Mon, 11 May
 2020 08:42:27 +0000
Received: from CY4PR1801MB1959.namprd18.prod.outlook.com
 ([fe80::5535:d9ff:9933:5071]) by CY4PR1801MB1959.namprd18.prod.outlook.com
 ([fe80::5535:d9ff:9933:5071%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 08:42:27 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [EXT] [PATCH v2 2/5] virtio-iommu: Implement RESV_MEM probe
 request
Thread-Topic: [EXT] [PATCH v2 2/5] virtio-iommu: Implement RESV_MEM probe
 request
Thread-Index: AQHWJV6G7q81t6809kGgvGezOKtQUqiicegggAAFugCAAB0QEA==
Date: Mon, 11 May 2020 08:42:27 +0000
Message-ID: <CY4PR1801MB1959F371C327FDBEE4EE7B64E3A10@CY4PR1801MB1959.namprd18.prod.outlook.com>
References: <20200508173057.32215-1-eric.auger@redhat.com>
 <20200508173057.32215-3-eric.auger@redhat.com>
 <MWHPR1801MB19669FBFAD49AD36460B0756E3A10@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <ba80143c-e053-5323-70a0-72a1dcc04376@redhat.com>
In-Reply-To: <ba80143c-e053-5323-70a0-72a1dcc04376@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.171.209.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e170307-a74c-4bc9-ffe1-08d7f5873c2a
x-ms-traffictypediagnostic: CY4PR1801MB1959:
x-microsoft-antispam-prvs: <CY4PR1801MB1959DCDA2694FD769DA59021E3A10@CY4PR1801MB1959.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:115;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lb8hED0YQ7jhCYTK0UUFPXlWX1dwu8/AtMRrxOIe3Rgk1T4ynIsNSAYDDSgfoNcacLgQ7JCYt0/L6b8xOl1zmXtSLkjWIBNwNh4pQ5DE7EJ8+rEEr7w3t7lDg4kJTuLXFLpuHaL00MzZ4PLWVxgoEWrtirgUiR6COzE/aQ0Gm6XtDMeu+4btpxxkogwsMn6qbbSu7j8HWFg3nEBMwM4suD58OW/D0ZJthPZlRwWfZLl4ZG7O/YHhJMiWjG0KNnMsiNyLlO05X6amXYbrKIGr7uIiapqnFg9/Ol/BtKi3Wtrv0yU1oaJU7ULx+xi85KRdLiVoJWTgOFPpL7X5Ux627/9ua+xYPRDjdRtnoimcqOLkBv8RKrvXWaX55tZ9d5G8Tiam+oC88pEE7+JcZO66zmV9Ym0rsSravJND27MiR9oOMFs7a5ebYWUqqXJSk3YxFr19p+b1YtajWs7mdVAi5rKKVDPjgqHFORid2Z3CYEU57TRY1uVtsVpG7XccNu81t1QpSYnkEaQJmqFLh2c+OVhnjNpDjI34HfMejaSeQj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1801MB1959.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(33430700001)(5660300002)(66946007)(66446008)(64756008)(66556008)(71200400001)(52536014)(55016002)(7416002)(2906002)(9686003)(8676002)(110136005)(33440700001)(8936002)(66476007)(76116006)(478600001)(33656002)(86362001)(316002)(7696005)(26005)(186003)(6506007)(53546011)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wmhK/QF2hgb3HeJ/wdMzry/ubRtBo6IM3xHax5oKqyJnHY6qVajXDN6AcB49xO/BXaG2xCoLtkZG2EViAOLm4ZJEliU42u/9+cddkOKRWg56ehOTlNCrhh6IRQA9mGOs/yvzQx6Mvzk8NMOIOkaiT/yIHGQeYoT4XtF7NcY4hmo68QkqMEA5qyTAvbYdwQYGI6HU4Oxuc8Qvd/KqKGO3ovDYeGzeffx5hmEk4MoMz9dkt+vaWv0p5ECyXkonnvzwqHa2KQ+oY51rPrHORo/2qPiO8mCTFF8XnZkt8G664fOgkRc6pz/I8DFwW6OOw5+E3p0VYuctGMNC1eXacu0ag55kbRiv3weSSsV/B9bLvTeXprtUyeujrwPsAcwmpMeHyLexWofFvgrm7xc4F8d2HYxS5LhLj+HWsf5ktCAIUfmVa8W0K4NkDh0CujNBvebb7zHuEY6xpP5ziyqk61vXNXTTIbkm4Z0SFosBhDYjtzFIuyAGMlHmmNl7m/RbAfdg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e170307-a74c-4bc9-ffe1-08d7f5873c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 08:42:27.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zkovo8/WV1C9LVw/+RKreImU3MyVi18UNK8MoY4xWdcctV9SU2/1Sr0Z/BbdE+/81gNAdEMOvRN9bEmCOr51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1959
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-11_03:2020-05-11,
 2020-05-11 signatures=0
Received-SPF: pass client-ip=67.231.156.173;
 envelope-from=prvs=4400c99de5=bbhushan2@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 04:42:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDExLCAyMDIw
IDEyOjI2IFBNDQo+IFRvOiBCaGFyYXQgQmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29tPjsg
ZXJpYy5hdWdlci5wcm9AZ21haWwuY29tOw0KPiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
YXJtQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4gbXN0QHJlZGhhdC5j
b207IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgcGV0ZXJ4QHJlZGhhdC5jb207DQo+IGFybWJy
dUByZWRoYXQuY29tOyBwYm9uemluaUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBb
UEFUQ0ggdjIgMi81XSB2aXJ0aW8taW9tbXU6IEltcGxlbWVudCBSRVNWX01FTSBwcm9iZQ0KPiBy
ZXF1ZXN0DQo+IA0KPiBIaSBCaGFyYXQsDQo+IE9uIDUvMTEvMjAgODozOCBBTSwgQmhhcmF0IEJo
dXNoYW4gd3JvdGU6DQo+ID4gSGkgRXJpYywNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+
ID4+IFNlbnQ6IEZyaWRheSwgTWF5IDgsIDIwMjAgMTE6MDEgUE0NCj4gPj4gVG86IGVyaWMuYXVn
ZXIucHJvQGdtYWlsLmNvbTsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiA+PiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IHFlbXUtYXJtQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9y
ZzsNCj4gPj4gbXN0QHJlZGhhdC5jb207IGplYW4tIHBoaWxpcHBlQGxpbmFyby5vcmc7IEJoYXJh
dCBCaHVzaGFuDQo+ID4+IDxiYmh1c2hhbjJAbWFydmVsbC5jb20+OyBwZXRlcnhAcmVkaGF0LmNv
bTsgYXJtYnJ1QHJlZGhhdC5jb207DQo+ID4+IHBib256aW5pQHJlZGhhdC5jb20NCj4gPj4gU3Vi
amVjdDogW0VYVF0gW1BBVENIIHYyIDIvNV0gdmlydGlvLWlvbW11OiBJbXBsZW1lbnQgUkVTVl9N
RU0gcHJvYmUNCj4gPj4gcmVxdWVzdA0KPiA+Pg0KPiA+PiBFeHRlcm5hbCBFbWFpbA0KPiA+Pg0K
PiA+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gLSBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIFBST0JF
IHJlcXVlc3QuIEF0IHRoZSBtb21lbnQsIG9ubHkgVEhFDQo+ID4+IFJFU1ZfTUVNIHByb3BlcnR5
IGlzIGhhbmRsZWQuIFRoZSBmaXJzdCBnb2FsIGlzIHRvIHJlcG9ydCBpb21tdSB3aWRlDQo+ID4+
IHJlc2VydmVkIHJlZ2lvbnMgc3VjaCBhcyB0aGUgTVNJIHJlZ2lvbnMgc2V0IGJ5IHRoZSBtYWNo
aW5lIGNvZGUuIE9uDQo+ID4+IHg4NiB0aGlzIHdpbGwgYmUgdGhlIElPQVBJQyBNU0kgcmVnaW9u
LA0KPiA+PiBbMHhGRUUwMDAwMCAtIDB4RkVFRkZGRkZdLCBvbiBBUk0gdGhpcyBtYXkgYmUgdGhl
IElUUyBkb29yYmVsbC4NCj4gPj4NCj4gPj4gSW4gdGhlIGZ1dHVyZSB3ZSBtYXkgaW50cm9kdWNl
IHBlciBkZXZpY2UgcmVzZXJ2ZWQgcmVnaW9ucy4NCj4gPj4gVGhpcyB3aWxsIGJlIHVzZWZ1bCB3
aGVuIHByb3RlY3RpbmcgaG9zdCBhc3NpZ25lZCBkZXZpY2VzIHdoaWNoIG1heQ0KPiA+PiBleHBv
c2UgdGhlaXIgb3duIHJlc2VydmVkIHJlZ2lvbnMNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+Pg0KPiA+PiAtLS0NCj4gPj4N
Cj4gPj4gdjEgLT4gdjI6DQo+ID4+IC0gbW92ZSB0aGUgdW5sb2NrIGJhY2sgdG8gdGhlIHNhbWUg
cGxhY2UNCj4gPj4gLSByZW1vdmUgdGhlIHB1c2ggbGFiZWwgYW5kIGZhY3Rvcml6ZSB0aGUgY29k
ZSBhZnRlciB0aGUgb3V0IGxhYmVsDQo+ID4+IC0gZml4IGEgYnVuY2ggb2YgY3B1X3RvX2xlWCBh
Y2NvcmRpbmcgdG8gdGhlIGxhdGVzdCBzcGVjIHJldmlzaW9uDQo+ID4+IC0gZG8gbm90IHJlbW92
ZSBzaXplb2YobGFzdCkgZnJvbSBmcmVlIHNwYWNlDQo+ID4+IC0gY2hlY2sgdGhlIGVwIGV4aXN0
cw0KPiA+PiAtLS0NCj4gPj4gIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oIHwgIDIg
Kw0KPiA+PiAgaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jICAgICAgICAgfCA5NCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLQ0KPiA+PiAgaHcvdmlydGlvL3RyYWNlLWV2ZW50cyAgICAg
ICAgICAgfCAgMSArDQo+ID4+ICAzIGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92
aXJ0aW8taW9tbXUuaA0KPiA+PiBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oDQo+
ID4+IGluZGV4IGU2NTMwMDRkN2MuLjQ5ZWIxMDVjZDggMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlv
L3ZpcnRpby1pb21tdS5oDQo+ID4+IEBAIC01Myw2ICs1Myw4IEBAIHR5cGVkZWYgc3RydWN0IFZp
cnRJT0lPTU1VIHsNCj4gPj4gICAgICBHSGFzaFRhYmxlICphc19ieV9idXNwdHI7DQo+ID4+ICAg
ICAgSU9NTVVQY2lCdXMgKmlvbW11X3BjaWJ1c19ieV9idXNfbnVtW1BDSV9CVVNfTUFYXTsNCj4g
Pj4gICAgICBQQ0lCdXMgKnByaW1hcnlfYnVzOw0KPiA+PiArICAgIFJlc2VydmVkUmVnaW9uICpy
ZXNlcnZlZF9yZWdpb25zOw0KPiA+PiArICAgIHVpbnQzMl90IG5iX3Jlc2VydmVkX3JlZ2lvbnM7
DQo+ID4+ICAgICAgR1RyZWUgKmRvbWFpbnM7DQo+ID4+ICAgICAgUWVtdU11dGV4IG11dGV4Ow0K
PiA+PiAgICAgIEdUcmVlICplbmRwb2ludHM7DQo+ID4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8v
dmlydGlvLWlvbW11LmMgYi9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4gPj4gaW5kZXgNCj4g
Pj4gMjJiYTg4NDhjMi4uMzVkNzcyZTAyMSAxMDA2NDQNCj4gPj4gLS0tIGEvaHcvdmlydGlvL3Zp
cnRpby1pb21tdS5jDQo+ID4+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPiA+PiBA
QCAtMzgsNiArMzgsNyBAQA0KPiA+Pg0KPiA+PiAgLyogTWF4IHNpemUgKi8NCj4gPj4gICNkZWZp
bmUgVklPTU1VX0RFRkFVTFRfUVVFVUVfU0laRSAyNTYNCj4gPj4gKyNkZWZpbmUgVklPTU1VX1BS
T0JFX1NJWkUgNTEyDQo+ID4+DQo+ID4+ICB0eXBlZGVmIHN0cnVjdCBWaXJ0SU9JT01NVURvbWFp
biB7DQo+ID4+ICAgICAgdWludDMyX3QgaWQ7DQo+ID4+IEBAIC0zNzgsNiArMzc5LDY1IEBAIHN0
YXRpYyBpbnQgdmlydGlvX2lvbW11X3VubWFwKFZpcnRJT0lPTU1VICpzLA0KPiA+PiAgICAgIHJl
dHVybiByZXQ7DQo+ID4+ICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMgc3NpemVfdCB2aXJ0aW9faW9t
bXVfZmlsbF9yZXN2X21lbV9wcm9wKFZpcnRJT0lPTU1VICpzLCB1aW50MzJfdCBlcCwNCj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAq
YnVmLCBzaXplX3QNCj4gPj4gK2ZyZWUpIHsNCj4gPj4gKyAgICBzdHJ1Y3QgdmlydGlvX2lvbW11
X3Byb2JlX3Jlc3ZfbWVtIHByb3AgPSB7fTsNCj4gPj4gKyAgICBzaXplX3Qgc2l6ZSA9IHNpemVv
Zihwcm9wKSwgbGVuZ3RoID0gc2l6ZSAtIHNpemVvZihwcm9wLmhlYWQpLCB0b3RhbDsNCj4gPj4g
KyAgICBpbnQgaTsNCj4gPj4gKw0KPiA+PiArICAgIHRvdGFsID0gc2l6ZSAqIHMtPm5iX3Jlc2Vy
dmVkX3JlZ2lvbnM7DQo+ID4+ICsNCj4gPj4gKyAgICBpZiAodG90YWwgPiBmcmVlKSB7DQo+ID4+
ICsgICAgICAgIHJldHVybiAtRU5PU1BDOw0KPiA+PiArICAgIH0NCj4gPj4gKw0KPiA+PiArICAg
IGZvciAoaSA9IDA7IGkgPCBzLT5uYl9yZXNlcnZlZF9yZWdpb25zOyBpKyspIHsNCj4gPj4gKyAg
ICAgICAgcHJvcC5oZWFkLnR5cGUgPSBjcHVfdG9fbGUxNihWSVJUSU9fSU9NTVVfUFJPQkVfVF9S
RVNWX01FTSk7DQo+ID4+ICsgICAgICAgIHByb3AuaGVhZC5sZW5ndGggPSBjcHVfdG9fbGUxNihs
ZW5ndGgpOw0KPiA+PiArICAgICAgICBwcm9wLnN1YnR5cGUgPSBzLT5yZXNlcnZlZF9yZWdpb25z
W2ldLnR5cGU7DQo+ID4+ICsgICAgICAgIHByb3Auc3RhcnQgPSBjcHVfdG9fbGU2NChzLT5yZXNl
cnZlZF9yZWdpb25zW2ldLmxvdyk7DQo+ID4+ICsgICAgICAgIHByb3AuZW5kID0gY3B1X3RvX2xl
NjQocy0+cmVzZXJ2ZWRfcmVnaW9uc1tpXS5oaWdoKTsNCj4gPj4gKw0KPiA+PiArICAgICAgICBt
ZW1jcHkoYnVmLCAmcHJvcCwgc2l6ZSk7DQo+ID4+ICsNCj4gPj4gKyAgICAgICAgdHJhY2Vfdmly
dGlvX2lvbW11X2ZpbGxfcmVzdl9wcm9wZXJ0eShlcCwgcHJvcC5zdWJ0eXBlLA0KPiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb3Auc3RhcnQsIHBy
b3AuZW5kKTsNCj4gPj4gKyAgICAgICAgYnVmICs9IHNpemU7DQo+ID4+ICsgICAgfQ0KPiA+PiAr
ICAgIHJldHVybiB0b3RhbDsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiArLyoqDQo+ID4+ICsgKiB2
aXJ0aW9faW9tbXVfcHJvYmUgLSBGaWxsIHRoZSBwcm9iZSByZXF1ZXN0IGJ1ZmZlciB3aXRoDQo+
ID4+ICsgKiB0aGUgcHJvcGVydGllcyB0aGUgZGV2aWNlIGlzIGFibGUgdG8gcmV0dXJuIGFuZCBh
ZGQgYSBOT05FDQo+ID4+ICsgKiBwcm9wZXJ0eSBhdCB0aGUgZW5kLg0KPiA+PiArICovDQo+ID4+
ICtzdGF0aWMgaW50IHZpcnRpb19pb21tdV9wcm9iZShWaXJ0SU9JT01NVSAqcywNCj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9faW9tbXVfcmVxX3Byb2Jl
ICpyZXEsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90ICpidWYp
IHsNCj4gPj4gKyAgICB1aW50MzJfdCBlcF9pZCA9IGxlMzJfdG9fY3B1KHJlcS0+ZW5kcG9pbnQp
Ow0KPiA+PiArICAgIHNpemVfdCBmcmVlID0gVklPTU1VX1BST0JFX1NJWkU7DQo+ID4+ICsgICAg
c3NpemVfdCBjb3VudDsNCj4gPj4gKw0KPiA+PiArICAgIGlmICghdmlydGlvX2lvbW11X21yKHMs
IGVwX2lkKSkgew0KPiA+PiArICAgICAgICByZXR1cm4gVklSVElPX0lPTU1VX1NfTk9FTlQ7DQo+
ID4+ICsgICAgfQ0KPiA+PiArDQo+ID4+ICsgICAgY291bnQgPSB2aXJ0aW9faW9tbXVfZmlsbF9y
ZXN2X21lbV9wcm9wKHMsIGVwX2lkLCBidWYsIGZyZWUpOw0KPiA+PiArICAgIGlmIChjb3VudCA8
IDApIHsNCj4gPj4gKyAgICAgICAgcmV0dXJuIFZJUlRJT19JT01NVV9TX0lOVkFMOw0KPiA+PiAr
ICAgIH0NCj4gPj4gKyAgICBidWYgKz0gY291bnQ7DQo+ID4+ICsgICAgZnJlZSAtPSBjb3VudDsN
Cj4gPj4gKw0KPiA+PiArICAgIC8qIEZpbGwgdGhlIHJlc3Qgd2l0aCB6ZXJvZXMgKi8NCj4gPj4g
KyAgICBtZW1zZXQoYnVmLCAwLCBmcmVlKTsNCj4gPg0KPiA+IE5vIG5lZWQgdG8gZmlsbCB3aXRo
IHplcm8gaGVyZSBhcyAiYnVmIiBpcyBzZXQgdG8gemVybyBvbiBhbGxvY2F0aW9uLCBubz8NCj4g
DQo+IFlvdSdyZSByaWdodC4gSSB3aWxsIHJlbW92ZSB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24u
DQo+IA0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCj4gPg0KPiA+IFRoYW5rcw0KPiA+IC1CaGFyYXQN
Cj4gPg0KPiA+PiArDQo+ID4+ICsgICAgcmV0dXJuIFZJUlRJT19JT01NVV9TX09LOw0KPiA+PiAr
fQ0KPiA+PiArDQo+ID4+ICBzdGF0aWMgaW50IHZpcnRpb19pb21tdV9pb3ZfdG9fcmVxKHN0cnVj
dCBpb3ZlYyAqaW92LA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBpbnQgaW92X2NudCwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdm9pZCAqcmVxLCBzaXplX3QgcmVxX3N6KSBAQA0KPiA+PiAtNDA3LDE1ICs0NjcsMjcg
QEANCj4gPj4gdmlydGlvX2lvbW11X2hhbmRsZV9yZXEoZGV0YWNoKQ0KPiA+PiAgdmlydGlvX2lv
bW11X2hhbmRsZV9yZXEobWFwKQ0KPiA+PiAgdmlydGlvX2lvbW11X2hhbmRsZV9yZXEodW5tYXAp
DQo+ID4+DQo+ID4+ICtzdGF0aWMgaW50IHZpcnRpb19pb21tdV9oYW5kbGVfcHJvYmUoVmlydElP
SU9NTVUgKnMsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGlvdmVjICppb3YsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgaW50IGlvdl9jbnQsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDhfdCAqYnVmKSB7DQo+ID4+ICsgICAgc3RydWN0IHZpcnRpb19pb21t
dV9yZXFfcHJvYmUgcmVxOw0KPiA+PiArICAgIGludCByZXQgPSB2aXJ0aW9faW9tbXVfaW92X3Rv
X3JlcShpb3YsIGlvdl9jbnQsICZyZXEsDQo+ID4+ICtzaXplb2YocmVxKSk7DQo+ID4+ICsNCj4g
Pj4gKyAgICByZXR1cm4gcmV0ID8gcmV0IDogdmlydGlvX2lvbW11X3Byb2JlKHMsICZyZXEsIGJ1
Zik7IH0NCj4gPj4gKw0KPiA+PiAgc3RhdGljIHZvaWQgdmlydGlvX2lvbW11X2hhbmRsZV9jb21t
YW5kKFZpcnRJT0RldmljZSAqdmRldiwgVmlydFF1ZXVlDQo+ICp2cSkgIHsNCj4gPj4gICAgICBW
aXJ0SU9JT01NVSAqcyA9IFZJUlRJT19JT01NVSh2ZGV2KTsNCj4gPj4gICAgICBzdHJ1Y3Qgdmly
dGlvX2lvbW11X3JlcV9oZWFkIGhlYWQ7DQo+ID4+ICAgICAgc3RydWN0IHZpcnRpb19pb21tdV9y
ZXFfdGFpbCB0YWlsID0ge307DQo+ID4+ICsgICAgc2l6ZV90IG91dHB1dF9zaXplID0gc2l6ZW9m
KHRhaWwpLCBzejsNCj4gPj4gICAgICBWaXJ0UXVldWVFbGVtZW50ICplbGVtOw0KPiA+PiAgICAg
IHVuc2lnbmVkIGludCBpb3ZfY250Ow0KPiA+PiAgICAgIHN0cnVjdCBpb3ZlYyAqaW92Ow0KPiA+
PiAtICAgIHNpemVfdCBzejsNCj4gPj4gKyAgICB2b2lkICpidWYgPSBOVUxMOw0KPiA+Pg0KPiA+
PiAgICAgIGZvciAoOzspIHsNCj4gPj4gICAgICAgICAgZWxlbSA9IHZpcnRxdWV1ZV9wb3AodnEs
IHNpemVvZihWaXJ0UXVldWVFbGVtZW50KSk7IEBADQo+ID4+IC00NTIsNiArNTI0LDE3IEBAIHN0
YXRpYyB2b2lkIHZpcnRpb19pb21tdV9oYW5kbGVfY29tbWFuZChWaXJ0SU9EZXZpY2UNCj4gKnZk
ZXYsIFZpcnRRdWV1ZSAqdnEpDQo+ID4+ICAgICAgICAgIGNhc2UgVklSVElPX0lPTU1VX1RfVU5N
QVA6DQo+ID4+ICAgICAgICAgICAgICB0YWlsLnN0YXR1cyA9IHZpcnRpb19pb21tdV9oYW5kbGVf
dW5tYXAocywgaW92LCBpb3ZfY250KTsNCj4gPj4gICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiAr
ICAgICAgICBjYXNlIFZJUlRJT19JT01NVV9UX1BST0JFOg0KDQpBcyBwZXIgc3BlYw0KICAiDQog
ICBJZiB0aGUgZGV2aWNlIGRvZXMgbm90IG9mZmVyIHRoZSBWSVJUSU9fSU9NTVVfRl9QUk9CRSBm
ZWF0dXJlLCBhbmQgaWYgdGhlIGRyaXZlciBzZW5kcyBhIFZJUlRJT18tDQogICBJT01NVV9UX1BS
T0JFIHJlcXVlc3QsIHRoZW4gdGhlIGRldmljZSBTSE9VTEQgTk9UIHdyaXRlIHRoZSBidWZmZXIg
YW5kIFNIT1VMRCBzZXQgdGhlIHVzZWQNCiAgIGxlbmd0aCB0byB6ZXJvLg0KICAiDQpTbyB3ZSBz
aG91bGQgY2hlY2sgaWYgZGV2aWNlIHN1cHBvcnRzICJWSVJUSU9fSU9NTVVfRl9QUk9CRSIgYmVm
b3JlIHByb2NlZWQ/DQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+ID4+ICsgICAgICAgIHsNCj4gPj4g
KyAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9faW9tbXVfcmVxX3RhaWwgKnB0YWlsOw0KPiA+PiAr
DQo+ID4+ICsgICAgICAgICAgICBvdXRwdXRfc2l6ZSA9IHMtPmNvbmZpZy5wcm9iZV9zaXplICsg
c2l6ZW9mKHRhaWwpOw0KPiA+PiArICAgICAgICAgICAgYnVmID0gZ19tYWxsb2MwKG91dHB1dF9z
aXplKTsNCj4gPj4gKw0KPiA+PiArICAgICAgICAgICAgcHRhaWwgPSAoc3RydWN0IHZpcnRpb19p
b21tdV9yZXFfdGFpbCAqKQ0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgKGJ1ZiArIHMt
PmNvbmZpZy5wcm9iZV9zaXplKTsNCj4gPj4gKyAgICAgICAgICAgIHB0YWlsLT5zdGF0dXMgPSB2
aXJ0aW9faW9tbXVfaGFuZGxlX3Byb2JlKHMsIGlvdiwgaW92X2NudCwgYnVmKTsNCj4gPj4gKyAg
ICAgICAgfQ0KPiA+PiAgICAgICAgICBkZWZhdWx0Og0KPiA+PiAgICAgICAgICAgICAgdGFpbC5z
dGF0dXMgPSBWSVJUSU9fSU9NTVVfU19VTlNVUFA7DQo+ID4+ICAgICAgICAgIH0NCj4gPj4gQEAg
LTQ1OSwxMiArNTQyLDEzIEBAIHN0YXRpYyB2b2lkDQo+ID4+IHZpcnRpb19pb21tdV9oYW5kbGVf
Y29tbWFuZChWaXJ0SU9EZXZpY2UgKnZkZXYsIFZpcnRRdWV1ZSAqdnEpDQo+ID4+DQo+ID4+ICBv
dXQ6DQo+ID4+ICAgICAgICAgIHN6ID0gaW92X2Zyb21fYnVmKGVsZW0tPmluX3NnLCBlbGVtLT5p
bl9udW0sIDAsDQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICZ0YWlsLCBzaXplb2Yo
dGFpbCkpOw0KPiA+PiAtICAgICAgICBhc3NlcnQoc3ogPT0gc2l6ZW9mKHRhaWwpKTsNCj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmID8gYnVmIDogJnRhaWwsIG91dHB1dF9zaXpl
KTsNCj4gPj4gKyAgICAgICAgYXNzZXJ0KHN6ID09IG91dHB1dF9zaXplKTsNCj4gPj4NCj4gPj4g
LSAgICAgICAgdmlydHF1ZXVlX3B1c2godnEsIGVsZW0sIHNpemVvZih0YWlsKSk7DQo+ID4+ICsg
ICAgICAgIHZpcnRxdWV1ZV9wdXNoKHZxLCBlbGVtLCBzeik7DQo+ID4+ICAgICAgICAgIHZpcnRp
b19ub3RpZnkodmRldiwgdnEpOw0KPiA+PiAgICAgICAgICBnX2ZyZWUoZWxlbSk7DQo+ID4+ICsg
ICAgICAgIGdfZnJlZShidWYpOw0KPiA+PiAgICAgIH0NCj4gPj4gIH0NCj4gPj4NCj4gPj4gQEAg
LTY2Nyw2ICs3NTEsNyBAQCBzdGF0aWMgdm9pZA0KPiA+PiB2aXJ0aW9faW9tbXVfZGV2aWNlX3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+PiAgICAgIHMtPmNvbmZp
Zy5wYWdlX3NpemVfbWFzayA9IFRBUkdFVF9QQUdFX01BU0s7DQo+ID4+ICAgICAgcy0+Y29uZmln
LmlucHV0X3JhbmdlLmVuZCA9IC0xVUw7DQo+ID4+ICAgICAgcy0+Y29uZmlnLmRvbWFpbl9yYW5n
ZS5lbmQgPSAzMjsNCj4gPj4gKyAgICBzLT5jb25maWcucHJvYmVfc2l6ZSA9IFZJT01NVV9QUk9C
RV9TSVpFOw0KPiA+Pg0KPiA+PiAgICAgIHZpcnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMs
IFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYKTsNCj4gPj4gICAgICB2aXJ0aW9fYWRkX2ZlYXR1cmUo
JnMtPmZlYXR1cmVzLCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpOw0KPiA+PiBAQCAtNjc2
LDYNCj4gPj4gKzc2MSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19pb21tdV9kZXZpY2VfcmVhbGl6
ZShEZXZpY2VTdGF0ZSAqZGV2LA0KPiA+PiArRXJyb3INCj4gPj4gKiplcnJwKQ0KPiA+PiAgICAg
IHZpcnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMsIFZJUlRJT19JT01NVV9GX01BUF9VTk1B
UCk7DQo+ID4+ICAgICAgdmlydGlvX2FkZF9mZWF0dXJlKCZzLT5mZWF0dXJlcywgVklSVElPX0lP
TU1VX0ZfQllQQVNTKTsNCj4gPj4gICAgICB2aXJ0aW9fYWRkX2ZlYXR1cmUoJnMtPmZlYXR1cmVz
LCBWSVJUSU9fSU9NTVVfRl9NTUlPKTsNCj4gPj4gKyAgICB2aXJ0aW9fYWRkX2ZlYXR1cmUoJnMt
PmZlYXR1cmVzLCBWSVJUSU9fSU9NTVVfRl9QUk9CRSk7DQo+ID4+DQo+ID4+ICAgICAgcWVtdV9t
dXRleF9pbml0KCZzLT5tdXRleCk7DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8v
dHJhY2UtZXZlbnRzIGIvaHcvdmlydGlvL3RyYWNlLWV2ZW50cyBpbmRleA0KPiA+PiBlODM1MDBi
ZWU5Li41NTUwNDc1NjkxIDEwMDY0NA0KPiA+PiAtLS0gYS9ody92aXJ0aW8vdHJhY2UtZXZlbnRz
DQo+ID4+ICsrKyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMNCj4gPj4gQEAgLTczLDMgKzczLDQg
QEAgdmlydGlvX2lvbW11X2dldF9kb21haW4odWludDMyX3QgZG9tYWluX2lkKSAiQWxsb2MNCj4g
Pj4gZG9tYWluPSVkIg0KPiA+PiAgdmlydGlvX2lvbW11X3B1dF9kb21haW4odWludDMyX3QgZG9t
YWluX2lkKSAiRnJlZSBkb21haW49JWQiDQo+ID4+ICB2aXJ0aW9faW9tbXVfdHJhbnNsYXRlX291
dCh1aW50NjRfdCB2aXJ0X2FkZHIsIHVpbnQ2NF90IHBoeXNfYWRkciwNCj4gPj4gdWludDMyX3Qg
c2lkKSAiMHglIlBSSXg2NCIgLT4gMHglIlBSSXg2NCAiIGZvciBzaWQ9JWQiDQo+ID4+ICB2aXJ0
aW9faW9tbXVfcmVwb3J0X2ZhdWx0KHVpbnQ4X3QgcmVhc29uLCB1aW50MzJfdCBmbGFncywgdWlu
dDMyX3QNCj4gPj4gZW5kcG9pbnQsIHVpbnQ2NF90IGFkZHIpICJGQVVMVCByZWFzb249JWQgZmxh
Z3M9JWQgZW5kcG9pbnQ9JWQNCj4gPj4gYWRkcmVzcyA9MHglIlBSSXg2NA0KPiA+PiArdmlydGlv
X2lvbW11X2ZpbGxfcmVzdl9wcm9wZXJ0eSh1aW50MzJfdCBkZXZpZCwgdWludDhfdCBzdWJ0eXBl
LA0KPiA+PiArdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVuZCkgImRldj0gJWQsIHR5cGU9JWQg
c3RhcnQ9MHglIlBSSXg2NCINCj4gPj4gK2VuZD0weCUiUFJJeDY0DQo+ID4+IC0tDQo+ID4+IDIu
MjAuMQ0KPiA+DQo+ID4NCg0K

