Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39228C47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A8C206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="hqdpgfRD";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="h9y1Ri2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A8C206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLN1-0002te-2i
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=440173b5a9=bbhushan2@marvell.com>)
 id 1jYLKe-0006qQ-DT; Mon, 11 May 2020 23:11:48 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34328
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=440173b5a9=bbhushan2@marvell.com>)
 id 1jYLKc-0001SN-AF; Mon, 11 May 2020 23:11:47 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04C3Bh27003168; Mon, 11 May 2020 20:11:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1AH0CBRMg6m1iVa39qLk7cOcRoywe263lCboL18FT30=;
 b=hqdpgfRDA1CBz4YC+qyMuvSJUfRTDuortGYat8WP99xXxKFvan3vD9xP55yQohpCqPSo
 XEtXuuPwnVCZyfF4aRXgxl7zDJEO0vuF7NQSj3KaMQw89DgqyuPbaGJeFra9J6td6Zxd
 j2jXTVnJAogLEaIOoevMYWCWyHG1/UOsEwBbTzu4Y54ZdbpYRvjB7AO/wDGL7KnWIJmi
 0qbfW9m2lufKNZa6RcY3+lI85Q8BgLHoY7uqr84FcZxhqw2NKJPUXTy+xVdHs5LXaerm
 0q8ZS5I1iAz5fv/eCIjTuDySWpdJ2wBd4aFXEW2BbNFSCG4hlLhPxRwSykxSluSa6yTd bA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0a-0016f401.pphosted.com with ESMTP id 30wsvqhu6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2020 20:11:43 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 May
 2020 20:11:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 11 May 2020 20:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNo3hhp73TYuqC3dsJQyD4SqPV5eklUwc768ncwKWHIGMeDmMJO9ZmBcRC2N8pwL+y84fgDX7AcflQB1HMS8KQ1BfRBVYWHe2oDD370MjOqU7MvaMbovGsMwXnpdP2WVOIpHSeZT+7JYSlZ1K9jRAoNanu/pPqXCZVF7aTlb+Xp4HbGfBiEQOEVBIRAtp/PbIIGZeYhLWI2qISwJjskbgqVOs1jP8NIqee0KGI6CaipqPAZHbwLx7tfQ6Bd/3GZA7YY0jPeCUViATHxfpvTI62QvwVh4crlIZNxUQsVlSCKdEKlfj1S64SC2Imkoah6csvMLhsqGQD9caphpjLMGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AH0CBRMg6m1iVa39qLk7cOcRoywe263lCboL18FT30=;
 b=hJHICcFCiWr3UN2dSFCPDS30lGEnNlt5Ce9METVZKg4rlRRZ26dcciNmFnwqfHMg8nKF/oVSMoNTBmU8Q85T+ympPrLffHqy/7avYd9BgTLi9rdvpIqEEbRB7fkqIBeqLef7ksSxJvFOyIEhUhGNyYfBPy1F/CXb4CLDkAqPaTWQmgefvxcXsYeWvIdifLKmwNmuZwH9vWF24eepxXYKBUy8JFlqqyWYzI1TKY/M7MKp/VbVmpNEC9s4/xp1nTnxLg9biVzXhrnBcT/lncZVbioW17cV3jn+exncHILYvPuZFEUY0wYnE/6rHeqGORKRr9bC7L7rEhDZq247chILHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AH0CBRMg6m1iVa39qLk7cOcRoywe263lCboL18FT30=;
 b=h9y1Ri2ltBA0ePj1EXU5Hs2/Xlwi2iKLOSCXdGl8SW9oj6o0QtYwWLA0ItAqSUDZ32X33pOvjBfr7rBmZ1LsxjBJeJl6/Oc14hvLum99vv/CpaDGiooyid3REcAbrXsFgwa48MJ3Aoj68I6qkzaDKuY9XdfNIRuDa1WnVp9z6d0=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2031.namprd18.prod.outlook.com
 (2603:10b6:301:65::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 03:11:40 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:11:40 +0000
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
Thread-Index: AQHWJV6G7q81t6809kGgvGezOKtQUqiicegggAAFugCAAB0QEIAAAqYAgAEw++CAAAIzAIAAAHFQ
Date: Tue, 12 May 2020 03:11:40 +0000
Message-ID: <MWHPR1801MB1966913400061911BA0D25ACE3BE0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200508173057.32215-1-eric.auger@redhat.com>
 <20200508173057.32215-3-eric.auger@redhat.com>
 <MWHPR1801MB19669FBFAD49AD36460B0756E3A10@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <ba80143c-e053-5323-70a0-72a1dcc04376@redhat.com>
 <CY4PR1801MB1959F371C327FDBEE4EE7B64E3A10@CY4PR1801MB1959.namprd18.prod.outlook.com>
 <8e3d767e-f22e-41d3-885a-dbda866d0310@redhat.com>
 <MWHPR1801MB1966D8AFE2F6B81CE7EB7335E3BE0@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <bd265bb5-0488-bae3-4aa7-a65a5e4f6002@redhat.com>
In-Reply-To: <bd265bb5-0488-bae3-4aa7-a65a5e4f6002@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [171.61.68.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c901328-fb25-4b7c-7e26-08d7f6223108
x-ms-traffictypediagnostic: MWHPR1801MB2031:
x-microsoft-antispam-prvs: <MWHPR1801MB2031E03EC96E0B13DCCD69C4E3BE0@MWHPR1801MB2031.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:88;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+tEj+S7C9zZwr89pHJHofhix5qXdPoteNFhjO6jO9rggT7zeW3shrmJECh+hYnWYRFY6yRVEzLWVtiCeu7YSFCpE/2sALIPppW3jrynJ7ElliqCe91Cvib0WaK3+lz2sUb/VO9LHjKek8ipR809f/rlZeZsSOUNT1Je8pe3lgRzf5+AcgC4sdhHoQtFvLzjsxgPahNrtRkLVBZOD4UOzOi8uIbv3bXIQqEts4XoMMxFfbsPdXhqLtEw9RBJurIgZ0FHGFQlveqFzLmjWoyapfXVx6IPPWii60eRl3xBc6lqZpeA0ALo/NIr9yU33vPw7p0zKz8TyFr5e/zSzM1T5xJNUVJho826+qgQaInemqX0nlaMu1aCCb3SI7rJAgPBVhj2HnCazIgR5CBvUpiyx7+jQTpqxTWiy9ORZ7g7C9/4MWFajReh5D3z9SEUj0n2sWqXXj1c8rLTQ5lrKpkyh8SecxUd6qHN55+29PikBRyEzefSGjZMNdmrZrrqFhzMDxvi6Nxq9FB4iIu/NRht9WQaH9YBAprd1hla949WKMA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1801MB1966.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(33430700001)(71200400001)(66476007)(66556008)(478600001)(33656002)(66946007)(66446008)(110136005)(316002)(2906002)(64756008)(33440700001)(52536014)(5660300002)(186003)(8676002)(76116006)(9686003)(26005)(7416002)(53546011)(55016002)(8936002)(30864003)(7696005)(6506007)(86362001)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BMnve7+FZ3C2quIUbS3F+f67evetwaZFkVVTaEo2GJxBfoCSdwNvBjIvbs/SwLoWVVWhhGB6GosrLjwS4j3/nPyhMXMbTnmTmDLNFBizgQ/rqeXI+tiLG0PeZNOV/mkOQ0EM3R/XYknDtQETdliq5k9+jMLqF5RZwyc6q/apM6AEaLwCO6t8kA89pYbgYOVXP3XpnuLdbF2W5NuhyoyQ3KPC8lPSr+WU8AAiQPaD0iPZ0q9ez8V6qDQ+sPF01P25tRWwE41HEm3zsmrI5UZOfwqUad6vHG18kvIUf4etka2yqq/sloi5hCcJzoFBnr01++BRWrY6+av5LWLXtKMVZYFKVBfi3I7GDdoTa6FmsYDn8eQVgc9SItM3So/BSqkt0lH35eszDHEVKQvudM71g+EoYqoX5ho5SCKE5l5k8SWoU08qTH2r5Wmfce3GlbTadANJLJiJdWvyMUYHlPLsLUERnZ3+PLPPDIrYcKqEkXY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c901328-fb25-4b7c-7e26-08d7f6223108
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 03:11:40.6826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WasBZi0jKDhW3AuPodeIIo1eG4EeTAIKTMMsllfR9Gt7rf4J04QwVminPKCH8tHDRqUI2jUvhws5J1/S9JCaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2031
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-11_11:2020-05-11,
 2020-05-11 signatures=0
Received-SPF: pass client-ip=67.231.148.174;
 envelope-from=prvs=440173b5a9=bbhushan2@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:03:35
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
cmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxMiwgMjAy
MCA4OjM5IEFNDQo+IFRvOiBCaGFyYXQgQmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29tPjsg
ZXJpYy5hdWdlci5wcm9AZ21haWwuY29tOw0KPiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
YXJtQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4gbXN0QHJlZGhhdC5j
b207IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgcGV0ZXJ4QHJlZGhhdC5jb207DQo+IGFybWJy
dUByZWRoYXQuY29tOyBwYm9uemluaUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBb
UEFUQ0ggdjIgMi81XSB2aXJ0aW8taW9tbXU6IEltcGxlbWVudCBSRVNWX01FTSBwcm9iZQ0KPiBy
ZXF1ZXN0DQo+IA0KPiBIaSBCaGFyYXQsDQo+IE9uIDUvMTIvMjAgNTowMyBBTSwgQmhhcmF0IEJo
dXNoYW4gd3JvdGU6DQo+ID4gSGkgRXJpYywNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+PiBGcm9tOiBBdWdlciBFcmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+
ID4+IFNlbnQ6IE1vbmRheSwgTWF5IDExLCAyMDIwIDI6MTkgUE0NCj4gPj4gVG86IEJoYXJhdCBC
aHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+OyBlcmljLmF1Z2VyLnByb0BnbWFpbC5jb207
DQo+ID4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiA+PiBtc3RAcmVkaGF0LmNvbTsgamVhbi1waGlsaXBwZUBs
aW5hcm8ub3JnOyBwZXRlcnhAcmVkaGF0LmNvbTsNCj4gPj4gYXJtYnJ1QHJlZGhhdC5jb207IHBi
b256aW5pQHJlZGhhdC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtFWFRdIFtQQVRDSCB2MiAyLzVd
IHZpcnRpby1pb21tdTogSW1wbGVtZW50IFJFU1ZfTUVNDQo+ID4+IHByb2JlIHJlcXVlc3QNCj4g
Pj4NCj4gPj4gSGkgQmhhcmF0LA0KPiA+Pg0KPiA+PiBPbiA1LzExLzIwIDEwOjQyIEFNLCBCaGFy
YXQgQmh1c2hhbiB3cm90ZToNCj4gPj4+IEhpIEVyaWMsDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQXVnZXIgRXJpYyA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPg0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgTWF5IDExLCAyMDIwIDEyOjI2IFBNDQo+
ID4+Pj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+Ow0KPiA+Pj4+
IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiA+Pj4+
IHFlbXUtYXJtQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgbXN0QHJlZGhh
dC5jb207DQo+ID4+Pj4gamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBwZXRlcnhAcmVkaGF0LmNv
bTsgYXJtYnJ1QHJlZGhhdC5jb207DQo+ID4+Pj4gcGJvbnppbmlAcmVkaGF0LmNvbQ0KPiA+Pj4+
IFN1YmplY3Q6IFJlOiBbRVhUXSBbUEFUQ0ggdjIgMi81XSB2aXJ0aW8taW9tbXU6IEltcGxlbWVu
dCBSRVNWX01FTQ0KPiA+Pj4+IHByb2JlIHJlcXVlc3QNCj4gPj4+Pg0KPiA+Pj4+IEhpIEJoYXJh
dCwNCj4gPj4+PiBPbiA1LzExLzIwIDg6MzggQU0sIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+
Pj4+PiBIaSBFcmljLA0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4+Pj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4g
Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgTWF5IDgsIDIwMjAgMTE6MDEgUE0NCj4gPj4+Pj4+IFRvOiBl
cmljLmF1Z2VyLnByb0BnbWFpbC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4gPj4+Pj4+
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gPj4+Pj4+IHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZzsgbXN0QHJlZGhhdC5jb207IGplYW4tDQo+ID4+Pj4+PiBw
aGlsaXBwZUBsaW5hcm8ub3JnOyBCaGFyYXQgQmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29t
PjsNCj4gPj4+Pj4+IHBldGVyeEByZWRoYXQuY29tOyBhcm1icnVAcmVkaGF0LmNvbTsgcGJvbnpp
bmlAcmVkaGF0LmNvbQ0KPiA+Pj4+Pj4gU3ViamVjdDogW0VYVF0gW1BBVENIIHYyIDIvNV0gdmly
dGlvLWlvbW11OiBJbXBsZW1lbnQgUkVTVl9NRU0NCj4gPj4+Pj4+IHByb2JlIHJlcXVlc3QNCj4g
Pj4+Pj4+DQo+ID4+Pj4+PiBFeHRlcm5hbCBFbWFpbA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4+Pj4+PiAtLQ0KPiA+Pj4+Pj4gLS0NCj4gPj4+Pj4+IC0gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSBQUk9CRSByZXF1ZXN0LiBBdCB0aGUgbW9tZW50LCBvbmx5DQo+ID4+Pj4+PiBU
SEUgUkVTVl9NRU0gcHJvcGVydHkgaXMgaGFuZGxlZC4gVGhlIGZpcnN0IGdvYWwgaXMgdG8gcmVw
b3J0DQo+ID4+Pj4+PiBpb21tdSB3aWRlIHJlc2VydmVkIHJlZ2lvbnMgc3VjaCBhcyB0aGUgTVNJ
IHJlZ2lvbnMgc2V0IGJ5IHRoZQ0KPiA+Pj4+Pj4gbWFjaGluZSBjb2RlLiBPbg0KPiA+Pj4+Pj4g
eDg2IHRoaXMgd2lsbCBiZSB0aGUgSU9BUElDIE1TSSByZWdpb24sDQo+ID4+Pj4+PiBbMHhGRUUw
MDAwMCAtIDB4RkVFRkZGRkZdLCBvbiBBUk0gdGhpcyBtYXkgYmUgdGhlIElUUyBkb29yYmVsbC4N
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBJbiB0aGUgZnV0dXJlIHdlIG1heSBpbnRyb2R1Y2UgcGVyIGRl
dmljZSByZXNlcnZlZCByZWdpb25zLg0KPiA+Pj4+Pj4gVGhpcyB3aWxsIGJlIHVzZWZ1bCB3aGVu
IHByb3RlY3RpbmcgaG9zdCBhc3NpZ25lZCBkZXZpY2VzIHdoaWNoDQo+ID4+Pj4+PiBtYXkgZXhw
b3NlIHRoZWlyIG93biByZXNlcnZlZCByZWdpb25zDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IHYxIC0+IHYyOg0KPiA+Pj4+Pj4gLSBtb3Zl
IHRoZSB1bmxvY2sgYmFjayB0byB0aGUgc2FtZSBwbGFjZQ0KPiA+Pj4+Pj4gLSByZW1vdmUgdGhl
IHB1c2ggbGFiZWwgYW5kIGZhY3Rvcml6ZSB0aGUgY29kZSBhZnRlciB0aGUgb3V0DQo+ID4+Pj4+
PiBsYWJlbA0KPiA+Pj4+Pj4gLSBmaXggYSBidW5jaCBvZiBjcHVfdG9fbGVYIGFjY29yZGluZyB0
byB0aGUgbGF0ZXN0IHNwZWMgcmV2aXNpb24NCj4gPj4+Pj4+IC0gZG8gbm90IHJlbW92ZSBzaXpl
b2YobGFzdCkgZnJvbSBmcmVlIHNwYWNlDQo+ID4+Pj4+PiAtIGNoZWNrIHRoZSBlcCBleGlzdHMN
Cj4gPj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4gIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5o
IHwgIDIgKw0KPiA+Pj4+Pj4gIGh3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyAgICAgICAgIHwgOTQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+Pj4+ICBody92aXJ0aW8vdHJh
Y2UtZXZlbnRzICAgICAgICAgICB8ICAxICsNCj4gPj4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDkz
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oDQo+ID4+Pj4+PiBiL2luY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oDQo+ID4+Pj4+PiBpbmRleCBlNjUzMDA0ZDdjLi40
OWViMTA1Y2Q4IDEwMDY0NA0KPiA+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlv
LWlvbW11LmgNCj4gPj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5o
DQo+ID4+Pj4+PiBAQCAtNTMsNiArNTMsOCBAQCB0eXBlZGVmIHN0cnVjdCBWaXJ0SU9JT01NVSB7
DQo+ID4+Pj4+PiAgICAgIEdIYXNoVGFibGUgKmFzX2J5X2J1c3B0cjsNCj4gPj4+Pj4+ICAgICAg
SU9NTVVQY2lCdXMgKmlvbW11X3BjaWJ1c19ieV9idXNfbnVtW1BDSV9CVVNfTUFYXTsNCj4gPj4+
Pj4+ICAgICAgUENJQnVzICpwcmltYXJ5X2J1czsNCj4gPj4+Pj4+ICsgICAgUmVzZXJ2ZWRSZWdp
b24gKnJlc2VydmVkX3JlZ2lvbnM7DQo+ID4+Pj4+PiArICAgIHVpbnQzMl90IG5iX3Jlc2VydmVk
X3JlZ2lvbnM7DQo+ID4+Pj4+PiAgICAgIEdUcmVlICpkb21haW5zOw0KPiA+Pj4+Pj4gICAgICBR
ZW11TXV0ZXggbXV0ZXg7DQo+ID4+Pj4+PiAgICAgIEdUcmVlICplbmRwb2ludHM7DQo+ID4+Pj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jIGIvaHcvdmlydGlvL3ZpcnRp
by1pb21tdS5jDQo+ID4+Pj4+PiBpbmRleA0KPiA+Pj4+Pj4gMjJiYTg4NDhjMi4uMzVkNzcyZTAy
MSAxMDA2NDQNCj4gPj4+Pj4+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPiA+Pj4+
Pj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+ID4+Pj4+PiBAQCAtMzgsNiArMzgs
NyBAQA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAvKiBNYXggc2l6ZSAqLw0KPiA+Pj4+Pj4gICNkZWZp
bmUgVklPTU1VX0RFRkFVTFRfUVVFVUVfU0laRSAyNTYNCj4gPj4+Pj4+ICsjZGVmaW5lIFZJT01N
VV9QUk9CRV9TSVpFIDUxMg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICB0eXBlZGVmIHN0cnVjdCBWaXJ0
SU9JT01NVURvbWFpbiB7DQo+ID4+Pj4+PiAgICAgIHVpbnQzMl90IGlkOw0KPiA+Pj4+Pj4gQEAg
LTM3OCw2ICszNzksNjUgQEAgc3RhdGljIGludCB2aXJ0aW9faW9tbXVfdW5tYXAoVmlydElPSU9N
TVUgKnMsDQo+ID4+Pj4+PiAgICAgIHJldHVybiByZXQ7DQo+ID4+Pj4+PiAgfQ0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+ICtzdGF0aWMgc3NpemVfdCB2aXJ0aW9faW9tbXVfZmlsbF9yZXN2X21lbV9wcm9w
KFZpcnRJT0lPTU1VICpzLA0KPiA+Pj4+Pj4gK3VpbnQzMl90DQo+ID4+IGVwLA0KPiA+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAq
YnVmLA0KPiA+Pj4+Pj4gK3NpemVfdA0KPiA+Pj4+Pj4gK2ZyZWUpIHsNCj4gPj4+Pj4+ICsgICAg
c3RydWN0IHZpcnRpb19pb21tdV9wcm9iZV9yZXN2X21lbSBwcm9wID0ge307DQo+ID4+Pj4+PiAr
ICAgIHNpemVfdCBzaXplID0gc2l6ZW9mKHByb3ApLCBsZW5ndGggPSBzaXplIC0gc2l6ZW9mKHBy
b3AuaGVhZCksIHRvdGFsOw0KPiA+Pj4+Pj4gKyAgICBpbnQgaTsNCj4gPj4+Pj4+ICsNCj4gPj4+
Pj4+ICsgICAgdG90YWwgPSBzaXplICogcy0+bmJfcmVzZXJ2ZWRfcmVnaW9uczsNCj4gPj4+Pj4+
ICsNCj4gPj4+Pj4+ICsgICAgaWYgKHRvdGFsID4gZnJlZSkgew0KPiA+Pj4+Pj4gKyAgICAgICAg
cmV0dXJuIC1FTk9TUEM7DQo+ID4+Pj4+PiArICAgIH0NCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICsg
ICAgZm9yIChpID0gMDsgaSA8IHMtPm5iX3Jlc2VydmVkX3JlZ2lvbnM7IGkrKykgew0KPiA+Pj4+
Pj4gKyAgICAgICAgcHJvcC5oZWFkLnR5cGUgPQ0KPiBjcHVfdG9fbGUxNihWSVJUSU9fSU9NTVVf
UFJPQkVfVF9SRVNWX01FTSk7DQo+ID4+Pj4+PiArICAgICAgICBwcm9wLmhlYWQubGVuZ3RoID0g
Y3B1X3RvX2xlMTYobGVuZ3RoKTsNCj4gPj4+Pj4+ICsgICAgICAgIHByb3Auc3VidHlwZSA9IHMt
PnJlc2VydmVkX3JlZ2lvbnNbaV0udHlwZTsNCj4gPj4+Pj4+ICsgICAgICAgIHByb3Auc3RhcnQg
PSBjcHVfdG9fbGU2NChzLT5yZXNlcnZlZF9yZWdpb25zW2ldLmxvdyk7DQo+ID4+Pj4+PiArICAg
ICAgICBwcm9wLmVuZCA9IGNwdV90b19sZTY0KHMtPnJlc2VydmVkX3JlZ2lvbnNbaV0uaGlnaCk7
DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArICAgICAgICBtZW1jcHkoYnVmLCAmcHJvcCwgc2l6ZSk7
DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArICAgICAgICB0cmFjZV92aXJ0aW9faW9tbXVfZmlsbF9y
ZXN2X3Byb3BlcnR5KGVwLCBwcm9wLnN1YnR5cGUsDQo+ID4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb3Auc3RhcnQsIHByb3AuZW5kKTsNCj4g
Pj4+Pj4+ICsgICAgICAgIGJ1ZiArPSBzaXplOw0KPiA+Pj4+Pj4gKyAgICB9DQo+ID4+Pj4+PiAr
ICAgIHJldHVybiB0b3RhbDsNCj4gPj4+Pj4+ICt9DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArLyoq
DQo+ID4+Pj4+PiArICogdmlydGlvX2lvbW11X3Byb2JlIC0gRmlsbCB0aGUgcHJvYmUgcmVxdWVz
dCBidWZmZXIgd2l0aA0KPiA+Pj4+Pj4gKyAqIHRoZSBwcm9wZXJ0aWVzIHRoZSBkZXZpY2UgaXMg
YWJsZSB0byByZXR1cm4gYW5kIGFkZCBhIE5PTkUNCj4gPj4+Pj4+ICsgKiBwcm9wZXJ0eSBhdCB0
aGUgZW5kLg0KPiA+Pj4+Pj4gKyAqLw0KPiA+Pj4+Pj4gK3N0YXRpYyBpbnQgdmlydGlvX2lvbW11
X3Byb2JlKFZpcnRJT0lPTU1VICpzLA0KPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB2aXJ0aW9faW9tbXVfcmVxX3Byb2JlICpyZXEsDQo+ID4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqYnVmKSB7DQo+ID4+Pj4+PiArICAg
IHVpbnQzMl90IGVwX2lkID0gbGUzMl90b19jcHUocmVxLT5lbmRwb2ludCk7DQo+ID4+Pj4+PiAr
ICAgIHNpemVfdCBmcmVlID0gVklPTU1VX1BST0JFX1NJWkU7DQo+ID4+Pj4+PiArICAgIHNzaXpl
X3QgY291bnQ7DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArICAgIGlmICghdmlydGlvX2lvbW11X21y
KHMsIGVwX2lkKSkgew0KPiA+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIFZJUlRJT19JT01NVV9TX05P
RU5UOw0KPiA+Pj4+Pj4gKyAgICB9DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArICAgIGNvdW50ID0g
dmlydGlvX2lvbW11X2ZpbGxfcmVzdl9tZW1fcHJvcChzLCBlcF9pZCwgYnVmLCBmcmVlKTsNCj4g
Pj4+Pj4+ICsgICAgaWYgKGNvdW50IDwgMCkgew0KPiA+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIFZJ
UlRJT19JT01NVV9TX0lOVkFMOw0KPiA+Pj4+Pj4gKyAgICB9DQo+ID4+Pj4+PiArICAgIGJ1ZiAr
PSBjb3VudDsNCj4gPj4+Pj4+ICsgICAgZnJlZSAtPSBjb3VudDsNCj4gPj4+Pj4+ICsNCj4gPj4+
Pj4+ICsgICAgLyogRmlsbCB0aGUgcmVzdCB3aXRoIHplcm9lcyAqLw0KPiA+Pj4+Pj4gKyAgICBt
ZW1zZXQoYnVmLCAwLCBmcmVlKTsNCj4gPj4+Pj4NCj4gPj4+Pj4gTm8gbmVlZCB0byBmaWxsIHdp
dGggemVybyBoZXJlIGFzICJidWYiIGlzIHNldCB0byB6ZXJvIG9uIGFsbG9jYXRpb24sIG5vPw0K
PiA+Pj4+DQo+ID4+Pj4gWW91J3JlIHJpZ2h0LiBJIHdpbGwgcmVtb3ZlIHRoaXMgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCj4gPj4+Pg0KPiA+Pj4+IFRoYW5rcw0KPiA+Pj4+DQo+ID4+Pj4gRXJpYw0K
PiA+Pj4+Pg0KPiA+Pj4+PiBUaGFua3MNCj4gPj4+Pj4gLUJoYXJhdA0KPiA+Pj4+Pg0KPiA+Pj4+
Pj4gKw0KPiA+Pj4+Pj4gKyAgICByZXR1cm4gVklSVElPX0lPTU1VX1NfT0s7DQo+ID4+Pj4+PiAr
fQ0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4gIHN0YXRpYyBpbnQgdmlydGlvX2lvbW11X2lvdl90b19y
ZXEoc3RydWN0IGlvdmVjICppb3YsDQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBpbnQgaW92X2NudCwNCj4gPj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKnJlcSwgc2l6ZV90IHJlcV9zeikgQEANCj4gPj4+
Pj4+IC00MDcsMTUgKzQ2NywyNyBAQA0KPiA+Pj4+Pj4gdmlydGlvX2lvbW11X2hhbmRsZV9yZXEo
ZGV0YWNoKQ0KPiA+Pj4+Pj4gIHZpcnRpb19pb21tdV9oYW5kbGVfcmVxKG1hcCkNCj4gPj4+Pj4+
ICB2aXJ0aW9faW9tbXVfaGFuZGxlX3JlcSh1bm1hcCkNCj4gPj4+Pj4+DQo+ID4+Pj4+PiArc3Rh
dGljIGludCB2aXJ0aW9faW9tbXVfaGFuZGxlX3Byb2JlKFZpcnRJT0lPTU1VICpzLA0KPiA+Pj4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW92ZWMgKmlv
diwNCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgaW50IGlvdl9jbnQsDQo+ID4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ4X3QgKmJ1Zikgew0KPiA+Pj4+Pj4gKyAgICBzdHJ1Y3QgdmlydGlvX2lvbW11
X3JlcV9wcm9iZSByZXE7DQo+ID4+Pj4+PiArICAgIGludCByZXQgPSB2aXJ0aW9faW9tbXVfaW92
X3RvX3JlcShpb3YsIGlvdl9jbnQsICZyZXEsDQo+ID4+Pj4+PiArc2l6ZW9mKHJlcSkpOw0KPiA+
Pj4+Pj4gKw0KPiA+Pj4+Pj4gKyAgICByZXR1cm4gcmV0ID8gcmV0IDogdmlydGlvX2lvbW11X3By
b2JlKHMsICZyZXEsIGJ1Zik7IH0NCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICBzdGF0aWMgdm9pZCB2
aXJ0aW9faW9tbXVfaGFuZGxlX2NvbW1hbmQoVmlydElPRGV2aWNlICp2ZGV2LA0KPiA+Pj4+Pj4g
VmlydFF1ZXVlDQo+ID4+Pj4gKnZxKSAgew0KPiA+Pj4+Pj4gICAgICBWaXJ0SU9JT01NVSAqcyA9
IFZJUlRJT19JT01NVSh2ZGV2KTsNCj4gPj4+Pj4+ICAgICAgc3RydWN0IHZpcnRpb19pb21tdV9y
ZXFfaGVhZCBoZWFkOw0KPiA+Pj4+Pj4gICAgICBzdHJ1Y3QgdmlydGlvX2lvbW11X3JlcV90YWls
IHRhaWwgPSB7fTsNCj4gPj4+Pj4+ICsgICAgc2l6ZV90IG91dHB1dF9zaXplID0gc2l6ZW9mKHRh
aWwpLCBzejsNCj4gPj4+Pj4+ICAgICAgVmlydFF1ZXVlRWxlbWVudCAqZWxlbTsNCj4gPj4+Pj4+
ICAgICAgdW5zaWduZWQgaW50IGlvdl9jbnQ7DQo+ID4+Pj4+PiAgICAgIHN0cnVjdCBpb3ZlYyAq
aW92Ow0KPiA+Pj4+Pj4gLSAgICBzaXplX3Qgc3o7DQo+ID4+Pj4+PiArICAgIHZvaWQgKmJ1ZiA9
IE5VTEw7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICBmb3IgKDs7KSB7DQo+ID4+Pj4+PiAgICAg
ICAgICBlbGVtID0gdmlydHF1ZXVlX3BvcCh2cSwgc2l6ZW9mKFZpcnRRdWV1ZUVsZW1lbnQpKTsg
QEANCj4gPj4+Pj4+IC00NTIsNiArNTI0LDE3IEBAIHN0YXRpYyB2b2lkDQo+ID4+Pj4+PiB2aXJ0
aW9faW9tbXVfaGFuZGxlX2NvbW1hbmQoVmlydElPRGV2aWNlDQo+ID4+Pj4gKnZkZXYsIFZpcnRR
dWV1ZSAqdnEpDQo+ID4+Pj4+PiAgICAgICAgICBjYXNlIFZJUlRJT19JT01NVV9UX1VOTUFQOg0K
PiA+Pj4+Pj4gICAgICAgICAgICAgIHRhaWwuc3RhdHVzID0gdmlydGlvX2lvbW11X2hhbmRsZV91
bm1hcChzLCBpb3YsIGlvdl9jbnQpOw0KPiA+Pj4+Pj4gICAgICAgICAgICAgIGJyZWFrOw0KPiA+
Pj4+Pj4gKyAgICAgICAgY2FzZSBWSVJUSU9fSU9NTVVfVF9QUk9CRToNCj4gPj4+DQo+ID4+PiBB
cyBwZXIgc3BlYw0KPiA+Pj4gICAiDQo+ID4+PiAgICBJZiB0aGUgZGV2aWNlIGRvZXMgbm90IG9m
ZmVyIHRoZSBWSVJUSU9fSU9NTVVfRl9QUk9CRSBmZWF0dXJlLA0KPiA+Pj4gYW5kIGlmIHRoZQ0K
PiA+PiBkcml2ZXIgc2VuZHMgYSBWSVJUSU9fLQ0KPiA+Pj4gICAgSU9NTVVfVF9QUk9CRSByZXF1
ZXN0LCB0aGVuIHRoZSBkZXZpY2UgU0hPVUxEIE5PVCB3cml0ZSB0aGUNCj4gPj4+IGJ1ZmZlciBh
bmQNCj4gPj4gU0hPVUxEIHNldCB0aGUgdXNlZA0KPiA+Pj4gICAgbGVuZ3RoIHRvIHplcm8uDQo+
ID4+PiAgICINCj4gPj4+IFNvIHdlIHNob3VsZCBjaGVjayBpZiBkZXZpY2Ugc3VwcG9ydHMgIlZJ
UlRJT19JT01NVV9GX1BST0JFIiBiZWZvcmUNCj4gPj4gcHJvY2VlZD8NCj4gPj4gQnV0IGFyZSB0
aGUgZGV2aWNlIGFuZCBmcm9tIHRoYXQgcGF0Y2ggb253YXJkcyB3ZSBkbyBzdXBwb3J0IHRoZQ0K
PiA+PiBWSVJUSU9fSU9NTVVfRl9QUk9CRSBmZWF0dXJlLCByaWdodD8NCj4gPg0KPiA+IFllcyBJ
IGFncmVlLCBkbyB5b3UgdGhpbmsgaWYgZm9yIGRlYnVnZ2luZyBvbmUgd2FudHMgdG8gdHJ5IG91
dCB3aXRob3V0IHRoaXMNCj4gZmVhdHVyZSB0aGVuIGhlIHNob3VsZCBqdXN0IGRpc2FibGUgVklS
VElPX0lPTU1VX0ZfUFJPQkUuDQo+IA0KPiBZb3UgbWVhbiBmb3IgZGVidWdnaW5nIHRoZSBkcml2
ZXI/IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcHVycG9zZSBvZiB0aGlzIGRldmljZS4NCg0K
WWVzIGZvciBkZWJ1Z2dpbmcgcHVycG9zZSBvbmx5Lg0KDQpUaGFua3MNCi1CaGFyYXQNCg0KPiAN
Cj4gVGhhbmtzDQo+IA0KPiBFcmljDQo+ID4NCj4gPiBUaGFua3MNCj4gPiAtQmhhcmF0DQo+ID4N
Cj4gPj4NCj4gPj4gVGhhbmtzDQo+ID4+DQo+ID4+IEVyaWMNCj4gPj4+DQo+ID4+PiBUaGFua3MN
Cj4gPj4+IC1CaGFyYXQNCj4gPj4+DQo+ID4+Pj4+PiArICAgICAgICB7DQo+ID4+Pj4+PiArICAg
ICAgICAgICAgc3RydWN0IHZpcnRpb19pb21tdV9yZXFfdGFpbCAqcHRhaWw7DQo+ID4+Pj4+PiAr
DQo+ID4+Pj4+PiArICAgICAgICAgICAgb3V0cHV0X3NpemUgPSBzLT5jb25maWcucHJvYmVfc2l6
ZSArIHNpemVvZih0YWlsKTsNCj4gPj4+Pj4+ICsgICAgICAgICAgICBidWYgPSBnX21hbGxvYzAo
b3V0cHV0X3NpemUpOw0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4gKyAgICAgICAgICAgIHB0YWlsID0g
KHN0cnVjdCB2aXJ0aW9faW9tbXVfcmVxX3RhaWwgKikNCj4gPj4+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAoYnVmICsgcy0+Y29uZmlnLnByb2JlX3NpemUpOw0KPiA+Pj4+Pj4gKyAgICAg
ICAgICAgIHB0YWlsLT5zdGF0dXMgPSB2aXJ0aW9faW9tbXVfaGFuZGxlX3Byb2JlKHMsIGlvdiwg
aW92X2NudCwgYnVmKTsNCj4gPj4+Pj4+ICsgICAgICAgIH0NCj4gPj4+Pj4+ICAgICAgICAgIGRl
ZmF1bHQ6DQo+ID4+Pj4+PiAgICAgICAgICAgICAgdGFpbC5zdGF0dXMgPSBWSVJUSU9fSU9NTVVf
U19VTlNVUFA7DQo+ID4+Pj4+PiAgICAgICAgICB9DQo+ID4+Pj4+PiBAQCAtNDU5LDEyICs1NDIs
MTMgQEAgc3RhdGljIHZvaWQNCj4gPj4+Pj4+IHZpcnRpb19pb21tdV9oYW5kbGVfY29tbWFuZChW
aXJ0SU9EZXZpY2UgKnZkZXYsIFZpcnRRdWV1ZSAqdnEpDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gIG91
dDoNCj4gPj4+Pj4+ICAgICAgICAgIHN6ID0gaW92X2Zyb21fYnVmKGVsZW0tPmluX3NnLCBlbGVt
LT5pbl9udW0sIDAsDQo+ID4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAmdGFpbCwg
c2l6ZW9mKHRhaWwpKTsNCj4gPj4+Pj4+IC0gICAgICAgIGFzc2VydChzeiA9PSBzaXplb2YodGFp
bCkpOw0KPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmID8gYnVmIDogJnRh
aWwsIG91dHB1dF9zaXplKTsNCj4gPj4+Pj4+ICsgICAgICAgIGFzc2VydChzeiA9PSBvdXRwdXRf
c2l6ZSk7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gLSAgICAgICAgdmlydHF1ZXVlX3B1c2godnEsIGVs
ZW0sIHNpemVvZih0YWlsKSk7DQo+ID4+Pj4+PiArICAgICAgICB2aXJ0cXVldWVfcHVzaCh2cSwg
ZWxlbSwgc3opOw0KPiA+Pj4+Pj4gICAgICAgICAgdmlydGlvX25vdGlmeSh2ZGV2LCB2cSk7DQo+
ID4+Pj4+PiAgICAgICAgICBnX2ZyZWUoZWxlbSk7DQo+ID4+Pj4+PiArICAgICAgICBnX2ZyZWUo
YnVmKTsNCj4gPj4+Pj4+ICAgICAgfQ0KPiA+Pj4+Pj4gIH0NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBA
QCAtNjY3LDYgKzc1MSw3IEBAIHN0YXRpYyB2b2lkDQo+ID4+Pj4+PiB2aXJ0aW9faW9tbXVfZGV2
aWNlX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+Pj4+Pj4gICAg
ICBzLT5jb25maWcucGFnZV9zaXplX21hc2sgPSBUQVJHRVRfUEFHRV9NQVNLOw0KPiA+Pj4+Pj4g
ICAgICBzLT5jb25maWcuaW5wdXRfcmFuZ2UuZW5kID0gLTFVTDsNCj4gPj4+Pj4+ICAgICAgcy0+
Y29uZmlnLmRvbWFpbl9yYW5nZS5lbmQgPSAzMjsNCj4gPj4+Pj4+ICsgICAgcy0+Y29uZmlnLnBy
b2JlX3NpemUgPSBWSU9NTVVfUFJPQkVfU0laRTsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAgICAgIHZp
cnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMsIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYKTsN
Cj4gPj4+Pj4+ICAgICAgdmlydGlvX2FkZF9mZWF0dXJlKCZzLT5mZWF0dXJlcywNCj4gPj4+Pj4+
IFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQyk7IEBAIC02NzYsNg0KPiA+Pj4+Pj4gKzc2MSw3
IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19pb21tdV9kZXZpY2VfcmVhbGl6ZShEZXZpY2VTdGF0ZQ0K
PiA+Pj4+Pj4gKypkZXYsIEVycm9yDQo+ID4+Pj4+PiAqKmVycnApDQo+ID4+Pj4+PiAgICAgIHZp
cnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMsIFZJUlRJT19JT01NVV9GX01BUF9VTk1BUCk7
DQo+ID4+Pj4+PiAgICAgIHZpcnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMsIFZJUlRJT19J
T01NVV9GX0JZUEFTUyk7DQo+ID4+Pj4+PiAgICAgIHZpcnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVh
dHVyZXMsIFZJUlRJT19JT01NVV9GX01NSU8pOw0KPiA+Pj4+Pj4gKyAgICB2aXJ0aW9fYWRkX2Zl
YXR1cmUoJnMtPmZlYXR1cmVzLCBWSVJUSU9fSU9NTVVfRl9QUk9CRSk7DQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gICAgICBxZW11X211dGV4X2luaXQoJnMtPm11dGV4KTsNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cyBiL2h3L3ZpcnRpby90cmFjZS1l
dmVudHMNCj4gPj4+Pj4+IGluZGV4DQo+ID4+Pj4+PiBlODM1MDBiZWU5Li41NTUwNDc1NjkxIDEw
MDY0NA0KPiA+Pj4+Pj4gLS0tIGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cw0KPiA+Pj4+Pj4gKysr
IGIvaHcvdmlydGlvL3RyYWNlLWV2ZW50cw0KPiA+Pj4+Pj4gQEAgLTczLDMgKzczLDQgQEAgdmly
dGlvX2lvbW11X2dldF9kb21haW4odWludDMyX3QgZG9tYWluX2lkKQ0KPiA+Pj4+Pj4gIkFsbG9j
IGRvbWFpbj0lZCINCj4gPj4+Pj4+ICB2aXJ0aW9faW9tbXVfcHV0X2RvbWFpbih1aW50MzJfdCBk
b21haW5faWQpICJGcmVlIGRvbWFpbj0lZCINCj4gPj4+Pj4+ICB2aXJ0aW9faW9tbXVfdHJhbnNs
YXRlX291dCh1aW50NjRfdCB2aXJ0X2FkZHIsIHVpbnQ2NF90DQo+ID4+Pj4+PiBwaHlzX2FkZHIs
IHVpbnQzMl90IHNpZCkgIjB4JSJQUkl4NjQiIC0+IDB4JSJQUkl4NjQgIiBmb3Igc2lkPSVkIg0K
PiA+Pj4+Pj4gIHZpcnRpb19pb21tdV9yZXBvcnRfZmF1bHQodWludDhfdCByZWFzb24sIHVpbnQz
Ml90IGZsYWdzLA0KPiA+Pj4+Pj4gdWludDMyX3QgZW5kcG9pbnQsIHVpbnQ2NF90IGFkZHIpICJG
QVVMVCByZWFzb249JWQgZmxhZ3M9JWQNCj4gPj4+Pj4+IGVuZHBvaW50PSVkIGFkZHJlc3MgPTB4
JSJQUkl4NjQNCj4gPj4+Pj4+ICt2aXJ0aW9faW9tbXVfZmlsbF9yZXN2X3Byb3BlcnR5KHVpbnQz
Ml90IGRldmlkLCB1aW50OF90IHN1YnR5cGUsDQo+ID4+Pj4+PiArdWludDY0X3Qgc3RhcnQsIHVp
bnQ2NF90IGVuZCkgImRldj0gJWQsIHR5cGU9JWQgc3RhcnQ9MHglIlBSSXg2NCINCj4gPj4+Pj4+
ICtlbmQ9MHglIlBSSXg2NA0KPiA+Pj4+Pj4gLS0NCj4gPj4+Pj4+IDIuMjAuMQ0KPiA+Pj4+Pg0K
PiA+Pj4+Pg0KPiA+Pj4NCj4gPg0KDQo=

