Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A3C47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B280220643
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="x4B8Hmb5";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="HzNaAxRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280220643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLLE-0007U1-RV
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=440173b5a9=bbhushan2@marvell.com>)
 id 1jYLDE-0001dL-58; Mon, 11 May 2020 23:04:08 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27528
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=440173b5a9=bbhushan2@marvell.com>)
 id 1jYLDB-00088s-Fk; Mon, 11 May 2020 23:04:07 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04C319Rr019195; Mon, 11 May 2020 20:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=d7z5P9uSBlUKii4JQGF6GL2yL7Td+1OnDakNwn2AbZM=;
 b=x4B8Hmb5uXJBVUvSuyQ/VRQEVxt2oTWpQ/ymRvWmvIUfgv9kZ8Pu5TlpYxR6YW9PcWgS
 mXS0pU44dTtP/p+vC3H7k2NvOKdlAYVtKH5aAO+k0koRttTcCA54kjhr0N9lyFWgC/pE
 x2jRokjJtM68L8Yrzn+0xidq1W+rxoMFtmntfM8GL6blSQ550Xu7w0Afok1v/93htjOW
 QkrDlEm8FlxUXEDdgDFXacMiJ1+xQt4A4hQkN1ngkSVaIiEJ74ieCKViMUELnzMuK6UX
 RO1T2ukdce94GRREE9IX/bxDSrZcVv1/iVthznz8MdLEbGevc5rL1OngFrc70Ovdok0p 2A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 30wsvqhtd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2020 20:03:32 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 11 May 2020 20:03:31 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 11 May 2020 20:03:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 11 May 2020 20:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Olpv3fln9w0SwW5Q4gAPlvBACsk6QAVqh7MVQ3Rb/q5c5UxWHhQoVqCynhGT+ukiar62BGYDxQtDVqkFGlohlU6mfg/snvPl2AjAAo7amnLwpHEtOsxlZmWFWnCgqUNJzClOV3APszS9aGo19MWuWiWqA6bFyud8lI7ocS2E4ELNjGlZmmJ1U1lzfkLjcDes44vksVpiazzhC3DBp59gqx7BObainVqIYxai3liP2kybo8FKHyH42P3jCw/FRWrsxFc6GsS4FR9yPa0baU6k0XiF2wB9nlnnVPj6SVoUSdI3w/mPs72j8z4chkjUjx4xINDca11OJ1syuPQPtD6Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7z5P9uSBlUKii4JQGF6GL2yL7Td+1OnDakNwn2AbZM=;
 b=FuApjop1A4Ss7svTlFbtodtGrv+sYUlUDPEXJRZ9IDpwH2LkvlU488EIVYd76oCqCl6ULYneYeb/c6RxLGHusLiIlG8jQFj/kQliIdCM9Sw7ByfNiOLv4mt2h1pxHidr/tlsQ7rqk/LDkQQN74/xfy/szgiI5lTfmMo3xY+3d7GZGrLy+Ae8eO3Dmekj0M4MlFS+JQKZKOaxHJFJoE6fpJWaogbebPzicXG8HTMxwUz1/x0eq7J26ry/4LvsQMxeup5IxSW7l3ei8xKTjouJrGXhEIGQ2HLKvGNcoBpl2G7qit+sNBP8dRV10Innb6JoyhXfITshpMfOxQPrvswz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7z5P9uSBlUKii4JQGF6GL2yL7Td+1OnDakNwn2AbZM=;
 b=HzNaAxRl2qs2Z1IcS/9nyrDaMbxk7aaZy4wsZmnd8A0bEJ3/kjmWzYYWdvfB/Hu35Cb8Q4D/A5t8v42fNgWQpug7TZDZmg7yFb8iqNjtVnmz/2Nqty+RqqsbxwkzrDOYGktxxxHoDGoiLXSC3x6eZXBrNmvlGwTnr928l/lxYgU=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2031.namprd18.prod.outlook.com
 (2603:10b6:301:65::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 03:03:29 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::6028:eab:73:829d%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:03:29 +0000
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
Thread-Index: AQHWJV6G7q81t6809kGgvGezOKtQUqiicegggAAFugCAAB0QEIAAAqYAgAEw++A=
Date: Tue, 12 May 2020 03:03:29 +0000
Message-ID: <MWHPR1801MB1966D8AFE2F6B81CE7EB7335E3BE0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200508173057.32215-1-eric.auger@redhat.com>
 <20200508173057.32215-3-eric.auger@redhat.com>
 <MWHPR1801MB19669FBFAD49AD36460B0756E3A10@MWHPR1801MB1966.namprd18.prod.outlook.com>
 <ba80143c-e053-5323-70a0-72a1dcc04376@redhat.com>
 <CY4PR1801MB1959F371C327FDBEE4EE7B64E3A10@CY4PR1801MB1959.namprd18.prod.outlook.com>
 <8e3d767e-f22e-41d3-885a-dbda866d0310@redhat.com>
In-Reply-To: <8e3d767e-f22e-41d3-885a-dbda866d0310@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [171.61.68.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05d696c7-2a77-41a1-c371-08d7f6210c1e
x-ms-traffictypediagnostic: MWHPR1801MB2031:
x-microsoft-antispam-prvs: <MWHPR1801MB20313C02BE47502BE6606632E3BE0@MWHPR1801MB2031.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:95;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcz9TNPAkhGdRwKarEDKl4N2+Ht+RyvPL7o/RqsAZ8gRx0TqLfPHt9eR2SxTLTO2xNRDgb4ErEIWFBffeKPPdYsh6/StidLokmvtt46bBEP0h+NEvtcOpnppx77sC2SgEKKQbG6z7aE6zdgl33+lhd5yOBZUiSAc2R09/qg6YDWockbnSPBeZiNeQc9aiSL/5wN+oC36BaQS3ahYYfCoWRu90AkQpnzyKTYRaGSaQS5/Ht7BPAaaG9CMcecKd4aLT9gkfF7CrLz+04aNkSgqEQINLq7Hl+9q7H9owVBJ1Q9/9jDGKCwSfTVv3nKmY/buWE1Xo14xJW44PIWH2oHC8Z+LbToSlH4IaEignVsufxsLDMUPY8XhaPTqhj32c+0OnFEv2XcMXmI29adTWW9BeLno1nPBSkZMPwKO+awgFLc1auA748zMqHhg+Tiki4ta8NVlqYtP0BqgBvSzwfh/zt4ncnOVvrmJP/su4twJnLuLba0whhT8Zo3ai5WCmcur/dCIfGzxAomiO4vs7qMLfKj2d3M1jUMskPX26zA2NEk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1801MB1966.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(33430700001)(71200400001)(66476007)(66556008)(478600001)(33656002)(66946007)(66446008)(110136005)(316002)(2906002)(64756008)(33440700001)(52536014)(5660300002)(186003)(8676002)(76116006)(9686003)(26005)(7416002)(53546011)(55016002)(8936002)(30864003)(7696005)(6506007)(86362001)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fADtlst88dUgLUseKIU5miGkd7/2FKiwj1XHH+jon/I+7U+TincVyXgepvjIWUseFj8XzxeDa6DueKB6l0oyhJ3oI6CJmnYSP5HlIKWB6jimG1FLJ5w7AnAbzTCXJlVoXSabCJo82Qwv/XPOFSjGcmlda2FNgFyBikllEnwV0BPsqMAhllF/0fQtr+ywvXW0++PJ4sYlRJmw+0ZofX5i9pnQPR4jJQtkWtmVdsZFr4lX+eMCAFUxgFesPCjrfe8DtjXlYehhLnyvhYJd1GeQ5KH79CRl2/t/ALd718mFdSrSilM8cx8BpAVZxit6VFS/iHrcUN6O+ncPui69F8qB8dgUxm5l29Y+ZBoQTXSX/aA6TN6br1Mgdpk3zfR2uz7YZiY/wlYqDZb6xsfxgKkoiUNY0ChMC1vZri9yACTQjCtnZCnCiE2sgwK4o18bHjHs/TWP/lbWWmzkTsQ5dFlN0AUEcpkN1cwwACXoWHb7gHk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d696c7-2a77-41a1-c371-08d7f6210c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 03:03:29.2101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IkEUNcFYbe6Zvt6/tSIwoeU4gSda6AOdU3nTFAcqJJ8oPkSWJR60BWAlFd/cZUym1sZr+1L5EyXRfxKWU8+bA==
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
cmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDExLCAyMDIw
IDI6MTkgUE0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+OyBl
cmljLmF1Z2VyLnByb0BnbWFpbC5jb207DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1h
cm1Abm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiBtc3RAcmVkaGF0LmNv
bTsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBwZXRlcnhAcmVkaGF0LmNvbTsNCj4gYXJtYnJ1
QHJlZGhhdC5jb207IHBib256aW5pQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtFWFRdIFtQ
QVRDSCB2MiAyLzVdIHZpcnRpby1pb21tdTogSW1wbGVtZW50IFJFU1ZfTUVNIHByb2JlDQo+IHJl
cXVlc3QNCj4gDQo+IEhpIEJoYXJhdCwNCj4gDQo+IE9uIDUvMTEvMjAgMTA6NDIgQU0sIEJoYXJh
dCBCaHVzaGFuIHdyb3RlOg0KPiA+IEhpIEVyaWMsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQXVnZXIgRXJpYyA8ZXJpYy5hdWdlckByZWRoYXQuY29t
Pg0KPiA+PiBTZW50OiBNb25kYXksIE1heSAxMSwgMjAyMCAxMjoyNiBQTQ0KPiA+PiBUbzogQmhh
cmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT47IGVyaWMuYXVnZXIucHJvQGdtYWls
LmNvbTsNCj4gPj4gcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFybUBub25nbnUub3JnOyBw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7DQo+ID4+IG1zdEByZWRoYXQuY29tOyBqZWFuLXBoaWxp
cHBlQGxpbmFyby5vcmc7IHBldGVyeEByZWRoYXQuY29tOw0KPiA+PiBhcm1icnVAcmVkaGF0LmNv
bTsgcGJvbnppbmlAcmVkaGF0LmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW0VYVF0gW1BBVENIIHYy
IDIvNV0gdmlydGlvLWlvbW11OiBJbXBsZW1lbnQgUkVTVl9NRU0NCj4gPj4gcHJvYmUgcmVxdWVz
dA0KPiA+Pg0KPiA+PiBIaSBCaGFyYXQsDQo+ID4+IE9uIDUvMTEvMjAgODozOCBBTSwgQmhhcmF0
IEJodXNoYW4gd3JvdGU6DQo+ID4+PiBIaSBFcmljLA0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4gPj4+PiBTZW50OiBGcmlkYXksIE1heSA4LCAyMDIwIDExOjAxIFBNDQo+ID4+
Pj4gVG86IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0K
PiA+Pj4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gPj4+
PiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IG1zdEByZWRoYXQuY29tOyBqZWFuLQ0KPiA+Pj4+
IHBoaWxpcHBlQGxpbmFyby5vcmc7IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5j
b20+Ow0KPiA+Pj4+IHBldGVyeEByZWRoYXQuY29tOyBhcm1icnVAcmVkaGF0LmNvbTsgcGJvbnpp
bmlAcmVkaGF0LmNvbQ0KPiA+Pj4+IFN1YmplY3Q6IFtFWFRdIFtQQVRDSCB2MiAyLzVdIHZpcnRp
by1pb21tdTogSW1wbGVtZW50IFJFU1ZfTUVNDQo+ID4+Pj4gcHJvYmUgcmVxdWVzdA0KPiA+Pj4+
DQo+ID4+Pj4gRXh0ZXJuYWwgRW1haWwNCj4gPj4+Pg0KPiA+Pj4+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4+
PiAtLQ0KPiA+Pj4+IC0gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSBQUk9CRSByZXF1ZXN0LiBB
dCB0aGUgbW9tZW50LCBvbmx5IFRIRQ0KPiA+Pj4+IFJFU1ZfTUVNIHByb3BlcnR5IGlzIGhhbmRs
ZWQuIFRoZSBmaXJzdCBnb2FsIGlzIHRvIHJlcG9ydCBpb21tdQ0KPiA+Pj4+IHdpZGUgcmVzZXJ2
ZWQgcmVnaW9ucyBzdWNoIGFzIHRoZSBNU0kgcmVnaW9ucyBzZXQgYnkgdGhlIG1hY2hpbmUNCj4g
Pj4+PiBjb2RlLiBPbg0KPiA+Pj4+IHg4NiB0aGlzIHdpbGwgYmUgdGhlIElPQVBJQyBNU0kgcmVn
aW9uLA0KPiA+Pj4+IFsweEZFRTAwMDAwIC0gMHhGRUVGRkZGRl0sIG9uIEFSTSB0aGlzIG1heSBi
ZSB0aGUgSVRTIGRvb3JiZWxsLg0KPiA+Pj4+DQo+ID4+Pj4gSW4gdGhlIGZ1dHVyZSB3ZSBtYXkg
aW50cm9kdWNlIHBlciBkZXZpY2UgcmVzZXJ2ZWQgcmVnaW9ucy4NCj4gPj4+PiBUaGlzIHdpbGwg
YmUgdXNlZnVsIHdoZW4gcHJvdGVjdGluZyBob3N0IGFzc2lnbmVkIGRldmljZXMgd2hpY2ggbWF5
DQo+ID4+Pj4gZXhwb3NlIHRoZWlyIG93biByZXNlcnZlZCByZWdpb25zDQo+ID4+Pj4NCj4gPj4+
PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4+
Pj4NCj4gPj4+PiAtLS0NCj4gPj4+Pg0KPiA+Pj4+IHYxIC0+IHYyOg0KPiA+Pj4+IC0gbW92ZSB0
aGUgdW5sb2NrIGJhY2sgdG8gdGhlIHNhbWUgcGxhY2UNCj4gPj4+PiAtIHJlbW92ZSB0aGUgcHVz
aCBsYWJlbCBhbmQgZmFjdG9yaXplIHRoZSBjb2RlIGFmdGVyIHRoZSBvdXQgbGFiZWwNCj4gPj4+
PiAtIGZpeCBhIGJ1bmNoIG9mIGNwdV90b19sZVggYWNjb3JkaW5nIHRvIHRoZSBsYXRlc3Qgc3Bl
YyByZXZpc2lvbg0KPiA+Pj4+IC0gZG8gbm90IHJlbW92ZSBzaXplb2YobGFzdCkgZnJvbSBmcmVl
IHNwYWNlDQo+ID4+Pj4gLSBjaGVjayB0aGUgZXAgZXhpc3RzDQo+ID4+Pj4gLS0tDQo+ID4+Pj4g
IGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oIHwgIDIgKw0KPiA+Pj4+ICBody92aXJ0
aW8vdmlydGlvLWlvbW11LmMgICAgICAgICB8IDk0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4+Pj4gIGh3L3ZpcnRpby90cmFjZS1ldmVudHMgICAgICAgICAgIHwgIDEgKw0K
PiA+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWlv
bW11LmgNCj4gPj4+PiBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oDQo+ID4+Pj4g
aW5kZXggZTY1MzAwNGQ3Yy4uNDllYjEwNWNkOCAxMDA2NDQNCj4gPj4+PiAtLS0gYS9pbmNsdWRl
L2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuaA0KPiA+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlv
L3ZpcnRpby1pb21tdS5oDQo+ID4+Pj4gQEAgLTUzLDYgKzUzLDggQEAgdHlwZWRlZiBzdHJ1Y3Qg
VmlydElPSU9NTVUgew0KPiA+Pj4+ICAgICAgR0hhc2hUYWJsZSAqYXNfYnlfYnVzcHRyOw0KPiA+
Pj4+ICAgICAgSU9NTVVQY2lCdXMgKmlvbW11X3BjaWJ1c19ieV9idXNfbnVtW1BDSV9CVVNfTUFY
XTsNCj4gPj4+PiAgICAgIFBDSUJ1cyAqcHJpbWFyeV9idXM7DQo+ID4+Pj4gKyAgICBSZXNlcnZl
ZFJlZ2lvbiAqcmVzZXJ2ZWRfcmVnaW9uczsNCj4gPj4+PiArICAgIHVpbnQzMl90IG5iX3Jlc2Vy
dmVkX3JlZ2lvbnM7DQo+ID4+Pj4gICAgICBHVHJlZSAqZG9tYWluczsNCj4gPj4+PiAgICAgIFFl
bXVNdXRleCBtdXRleDsNCj4gPj4+PiAgICAgIEdUcmVlICplbmRwb2ludHM7DQo+ID4+Pj4gZGlm
ZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyBiL2h3L3ZpcnRpby92aXJ0aW8taW9t
bXUuYw0KPiA+Pj4+IGluZGV4DQo+ID4+Pj4gMjJiYTg4NDhjMi4uMzVkNzcyZTAyMSAxMDA2NDQN
Cj4gPj4+PiAtLS0gYS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4gPj4+PiArKysgYi9ody92
aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4gPj4+PiBAQCAtMzgsNiArMzgsNyBAQA0KPiA+Pj4+DQo+
ID4+Pj4gIC8qIE1heCBzaXplICovDQo+ID4+Pj4gICNkZWZpbmUgVklPTU1VX0RFRkFVTFRfUVVF
VUVfU0laRSAyNTYNCj4gPj4+PiArI2RlZmluZSBWSU9NTVVfUFJPQkVfU0laRSA1MTINCj4gPj4+
Pg0KPiA+Pj4+ICB0eXBlZGVmIHN0cnVjdCBWaXJ0SU9JT01NVURvbWFpbiB7DQo+ID4+Pj4gICAg
ICB1aW50MzJfdCBpZDsNCj4gPj4+PiBAQCAtMzc4LDYgKzM3OSw2NSBAQCBzdGF0aWMgaW50IHZp
cnRpb19pb21tdV91bm1hcChWaXJ0SU9JT01NVSAqcywNCj4gPj4+PiAgICAgIHJldHVybiByZXQ7
DQo+ID4+Pj4gIH0NCj4gPj4+Pg0KPiA+Pj4+ICtzdGF0aWMgc3NpemVfdCB2aXJ0aW9faW9tbXVf
ZmlsbF9yZXN2X21lbV9wcm9wKFZpcnRJT0lPTU1VICpzLCB1aW50MzJfdA0KPiBlcCwNCj4gPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90
ICpidWYsDQo+ID4+Pj4gK3NpemVfdA0KPiA+Pj4+ICtmcmVlKSB7DQo+ID4+Pj4gKyAgICBzdHJ1
Y3QgdmlydGlvX2lvbW11X3Byb2JlX3Jlc3ZfbWVtIHByb3AgPSB7fTsNCj4gPj4+PiArICAgIHNp
emVfdCBzaXplID0gc2l6ZW9mKHByb3ApLCBsZW5ndGggPSBzaXplIC0gc2l6ZW9mKHByb3AuaGVh
ZCksIHRvdGFsOw0KPiA+Pj4+ICsgICAgaW50IGk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgdG90
YWwgPSBzaXplICogcy0+bmJfcmVzZXJ2ZWRfcmVnaW9uczsNCj4gPj4+PiArDQo+ID4+Pj4gKyAg
ICBpZiAodG90YWwgPiBmcmVlKSB7DQo+ID4+Pj4gKyAgICAgICAgcmV0dXJuIC1FTk9TUEM7DQo+
ID4+Pj4gKyAgICB9DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgZm9yIChpID0gMDsgaSA8IHMtPm5i
X3Jlc2VydmVkX3JlZ2lvbnM7IGkrKykgew0KPiA+Pj4+ICsgICAgICAgIHByb3AuaGVhZC50eXBl
ID0gY3B1X3RvX2xlMTYoVklSVElPX0lPTU1VX1BST0JFX1RfUkVTVl9NRU0pOw0KPiA+Pj4+ICsg
ICAgICAgIHByb3AuaGVhZC5sZW5ndGggPSBjcHVfdG9fbGUxNihsZW5ndGgpOw0KPiA+Pj4+ICsg
ICAgICAgIHByb3Auc3VidHlwZSA9IHMtPnJlc2VydmVkX3JlZ2lvbnNbaV0udHlwZTsNCj4gPj4+
PiArICAgICAgICBwcm9wLnN0YXJ0ID0gY3B1X3RvX2xlNjQocy0+cmVzZXJ2ZWRfcmVnaW9uc1tp
XS5sb3cpOw0KPiA+Pj4+ICsgICAgICAgIHByb3AuZW5kID0gY3B1X3RvX2xlNjQocy0+cmVzZXJ2
ZWRfcmVnaW9uc1tpXS5oaWdoKTsNCj4gPj4+PiArDQo+ID4+Pj4gKyAgICAgICAgbWVtY3B5KGJ1
ZiwgJnByb3AsIHNpemUpOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgICAgICB0cmFjZV92aXJ0aW9f
aW9tbXVfZmlsbF9yZXN2X3Byb3BlcnR5KGVwLCBwcm9wLnN1YnR5cGUsDQo+ID4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcm9wLnN0YXJ0LCBwcm9w
LmVuZCk7DQo+ID4+Pj4gKyAgICAgICAgYnVmICs9IHNpemU7DQo+ID4+Pj4gKyAgICB9DQo+ID4+
Pj4gKyAgICByZXR1cm4gdG90YWw7DQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4gKy8qKg0K
PiA+Pj4+ICsgKiB2aXJ0aW9faW9tbXVfcHJvYmUgLSBGaWxsIHRoZSBwcm9iZSByZXF1ZXN0IGJ1
ZmZlciB3aXRoDQo+ID4+Pj4gKyAqIHRoZSBwcm9wZXJ0aWVzIHRoZSBkZXZpY2UgaXMgYWJsZSB0
byByZXR1cm4gYW5kIGFkZCBhIE5PTkUNCj4gPj4+PiArICogcHJvcGVydHkgYXQgdGhlIGVuZC4N
Cj4gPj4+PiArICovDQo+ID4+Pj4gK3N0YXRpYyBpbnQgdmlydGlvX2lvbW11X3Byb2JlKFZpcnRJ
T0lPTU1VICpzLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmlydGlvX2lvbW11X3JlcV9wcm9iZSAqcmVxLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50OF90ICpidWYpIHsNCj4gPj4+PiArICAgIHVpbnQzMl90IGVwX2lkID0g
bGUzMl90b19jcHUocmVxLT5lbmRwb2ludCk7DQo+ID4+Pj4gKyAgICBzaXplX3QgZnJlZSA9IFZJ
T01NVV9QUk9CRV9TSVpFOw0KPiA+Pj4+ICsgICAgc3NpemVfdCBjb3VudDsNCj4gPj4+PiArDQo+
ID4+Pj4gKyAgICBpZiAoIXZpcnRpb19pb21tdV9tcihzLCBlcF9pZCkpIHsNCj4gPj4+PiArICAg
ICAgICByZXR1cm4gVklSVElPX0lPTU1VX1NfTk9FTlQ7DQo+ID4+Pj4gKyAgICB9DQo+ID4+Pj4g
Kw0KPiA+Pj4+ICsgICAgY291bnQgPSB2aXJ0aW9faW9tbXVfZmlsbF9yZXN2X21lbV9wcm9wKHMs
IGVwX2lkLCBidWYsIGZyZWUpOw0KPiA+Pj4+ICsgICAgaWYgKGNvdW50IDwgMCkgew0KPiA+Pj4+
ICsgICAgICAgIHJldHVybiBWSVJUSU9fSU9NTVVfU19JTlZBTDsNCj4gPj4+PiArICAgIH0NCj4g
Pj4+PiArICAgIGJ1ZiArPSBjb3VudDsNCj4gPj4+PiArICAgIGZyZWUgLT0gY291bnQ7DQo+ID4+
Pj4gKw0KPiA+Pj4+ICsgICAgLyogRmlsbCB0aGUgcmVzdCB3aXRoIHplcm9lcyAqLw0KPiA+Pj4+
ICsgICAgbWVtc2V0KGJ1ZiwgMCwgZnJlZSk7DQo+ID4+Pg0KPiA+Pj4gTm8gbmVlZCB0byBmaWxs
IHdpdGggemVybyBoZXJlIGFzICJidWYiIGlzIHNldCB0byB6ZXJvIG9uIGFsbG9jYXRpb24sIG5v
Pw0KPiA+Pg0KPiA+PiBZb3UncmUgcmlnaHQuIEkgd2lsbCByZW1vdmUgdGhpcyBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KPiA+Pg0KPiA+PiBUaGFua3MNCj4gPj4NCj4gPj4gRXJpYw0KPiA+Pj4NCj4g
Pj4+IFRoYW5rcw0KPiA+Pj4gLUJoYXJhdA0KPiA+Pj4NCj4gPj4+PiArDQo+ID4+Pj4gKyAgICBy
ZXR1cm4gVklSVElPX0lPTU1VX1NfT0s7DQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4gIHN0
YXRpYyBpbnQgdmlydGlvX2lvbW11X2lvdl90b19yZXEoc3RydWN0IGlvdmVjICppb3YsDQo+ID4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGlvdl9j
bnQsDQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqcmVx
LCBzaXplX3QgcmVxX3N6KSBAQA0KPiA+Pj4+IC00MDcsMTUgKzQ2NywyNyBAQA0KPiA+Pj4+IHZp
cnRpb19pb21tdV9oYW5kbGVfcmVxKGRldGFjaCkNCj4gPj4+PiAgdmlydGlvX2lvbW11X2hhbmRs
ZV9yZXEobWFwKQ0KPiA+Pj4+ICB2aXJ0aW9faW9tbXVfaGFuZGxlX3JlcSh1bm1hcCkNCj4gPj4+
Pg0KPiA+Pj4+ICtzdGF0aWMgaW50IHZpcnRpb19pb21tdV9oYW5kbGVfcHJvYmUoVmlydElPSU9N
TVUgKnMsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgaW92ZWMgKmlvdiwNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVuc2lnbmVkIGludCBpb3ZfY250LA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDhfdCAqYnVmKSB7DQo+ID4+Pj4gKyAgICBzdHJ1Y3QgdmlydGlv
X2lvbW11X3JlcV9wcm9iZSByZXE7DQo+ID4+Pj4gKyAgICBpbnQgcmV0ID0gdmlydGlvX2lvbW11
X2lvdl90b19yZXEoaW92LCBpb3ZfY250LCAmcmVxLA0KPiA+Pj4+ICtzaXplb2YocmVxKSk7DQo+
ID4+Pj4gKw0KPiA+Pj4+ICsgICAgcmV0dXJuIHJldCA/IHJldCA6IHZpcnRpb19pb21tdV9wcm9i
ZShzLCAmcmVxLCBidWYpOyB9DQo+ID4+Pj4gKw0KPiA+Pj4+ICBzdGF0aWMgdm9pZCB2aXJ0aW9f
aW9tbXVfaGFuZGxlX2NvbW1hbmQoVmlydElPRGV2aWNlICp2ZGV2LA0KPiA+Pj4+IFZpcnRRdWV1
ZQ0KPiA+PiAqdnEpICB7DQo+ID4+Pj4gICAgICBWaXJ0SU9JT01NVSAqcyA9IFZJUlRJT19JT01N
VSh2ZGV2KTsNCj4gPj4+PiAgICAgIHN0cnVjdCB2aXJ0aW9faW9tbXVfcmVxX2hlYWQgaGVhZDsN
Cj4gPj4+PiAgICAgIHN0cnVjdCB2aXJ0aW9faW9tbXVfcmVxX3RhaWwgdGFpbCA9IHt9Ow0KPiA+
Pj4+ICsgICAgc2l6ZV90IG91dHB1dF9zaXplID0gc2l6ZW9mKHRhaWwpLCBzejsNCj4gPj4+PiAg
ICAgIFZpcnRRdWV1ZUVsZW1lbnQgKmVsZW07DQo+ID4+Pj4gICAgICB1bnNpZ25lZCBpbnQgaW92
X2NudDsNCj4gPj4+PiAgICAgIHN0cnVjdCBpb3ZlYyAqaW92Ow0KPiA+Pj4+IC0gICAgc2l6ZV90
IHN6Ow0KPiA+Pj4+ICsgICAgdm9pZCAqYnVmID0gTlVMTDsNCj4gPj4+Pg0KPiA+Pj4+ICAgICAg
Zm9yICg7Oykgew0KPiA+Pj4+ICAgICAgICAgIGVsZW0gPSB2aXJ0cXVldWVfcG9wKHZxLCBzaXpl
b2YoVmlydFF1ZXVlRWxlbWVudCkpOyBAQA0KPiA+Pj4+IC00NTIsNiArNTI0LDE3IEBAIHN0YXRp
YyB2b2lkDQo+ID4+Pj4gdmlydGlvX2lvbW11X2hhbmRsZV9jb21tYW5kKFZpcnRJT0RldmljZQ0K
PiA+PiAqdmRldiwgVmlydFF1ZXVlICp2cSkNCj4gPj4+PiAgICAgICAgICBjYXNlIFZJUlRJT19J
T01NVV9UX1VOTUFQOg0KPiA+Pj4+ICAgICAgICAgICAgICB0YWlsLnN0YXR1cyA9IHZpcnRpb19p
b21tdV9oYW5kbGVfdW5tYXAocywgaW92LCBpb3ZfY250KTsNCj4gPj4+PiAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4+Pj4gKyAgICAgICAgY2FzZSBWSVJUSU9fSU9NTVVfVF9QUk9CRToNCj4gPg0K
PiA+IEFzIHBlciBzcGVjDQo+ID4gICAiDQo+ID4gICAgSWYgdGhlIGRldmljZSBkb2VzIG5vdCBv
ZmZlciB0aGUgVklSVElPX0lPTU1VX0ZfUFJPQkUgZmVhdHVyZSwgYW5kIGlmIHRoZQ0KPiBkcml2
ZXIgc2VuZHMgYSBWSVJUSU9fLQ0KPiA+ICAgIElPTU1VX1RfUFJPQkUgcmVxdWVzdCwgdGhlbiB0
aGUgZGV2aWNlIFNIT1VMRCBOT1Qgd3JpdGUgdGhlIGJ1ZmZlciBhbmQNCj4gU0hPVUxEIHNldCB0
aGUgdXNlZA0KPiA+ICAgIGxlbmd0aCB0byB6ZXJvLg0KPiA+ICAgIg0KPiA+IFNvIHdlIHNob3Vs
ZCBjaGVjayBpZiBkZXZpY2Ugc3VwcG9ydHMgIlZJUlRJT19JT01NVV9GX1BST0JFIiBiZWZvcmUN
Cj4gcHJvY2VlZD8NCj4gQnV0IGFyZSB0aGUgZGV2aWNlIGFuZCBmcm9tIHRoYXQgcGF0Y2ggb253
YXJkcyB3ZSBkbyBzdXBwb3J0IHRoZQ0KPiBWSVJUSU9fSU9NTVVfRl9QUk9CRSBmZWF0dXJlLCBy
aWdodD8NCg0KWWVzIEkgYWdyZWUsIGRvIHlvdSB0aGluayBpZiBmb3IgZGVidWdnaW5nIG9uZSB3
YW50cyB0byB0cnkgb3V0IHdpdGhvdXQgdGhpcyBmZWF0dXJlIHRoZW4gaGUgc2hvdWxkIGp1c3Qg
ZGlzYWJsZSBWSVJUSU9fSU9NTVVfRl9QUk9CRS4NCg0KVGhhbmtzDQotQmhhcmF0DQoNCj4gDQo+
IFRoYW5rcw0KPiANCj4gRXJpYw0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gLUJoYXJhdA0KPiA+DQo+
ID4+Pj4gKyAgICAgICAgew0KPiA+Pj4+ICsgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2lvbW11
X3JlcV90YWlsICpwdGFpbDsNCj4gPj4+PiArDQo+ID4+Pj4gKyAgICAgICAgICAgIG91dHB1dF9z
aXplID0gcy0+Y29uZmlnLnByb2JlX3NpemUgKyBzaXplb2YodGFpbCk7DQo+ID4+Pj4gKyAgICAg
ICAgICAgIGJ1ZiA9IGdfbWFsbG9jMChvdXRwdXRfc2l6ZSk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsg
ICAgICAgICAgICBwdGFpbCA9IChzdHJ1Y3QgdmlydGlvX2lvbW11X3JlcV90YWlsICopDQo+ID4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgIChidWYgKyBzLT5jb25maWcucHJvYmVfc2l6ZSk7
DQo+ID4+Pj4gKyAgICAgICAgICAgIHB0YWlsLT5zdGF0dXMgPSB2aXJ0aW9faW9tbXVfaGFuZGxl
X3Byb2JlKHMsIGlvdiwgaW92X2NudCwgYnVmKTsNCj4gPj4+PiArICAgICAgICB9DQo+ID4+Pj4g
ICAgICAgICAgZGVmYXVsdDoNCj4gPj4+PiAgICAgICAgICAgICAgdGFpbC5zdGF0dXMgPSBWSVJU
SU9fSU9NTVVfU19VTlNVUFA7DQo+ID4+Pj4gICAgICAgICAgfQ0KPiA+Pj4+IEBAIC00NTksMTIg
KzU0MiwxMyBAQCBzdGF0aWMgdm9pZA0KPiA+Pj4+IHZpcnRpb19pb21tdV9oYW5kbGVfY29tbWFu
ZChWaXJ0SU9EZXZpY2UgKnZkZXYsIFZpcnRRdWV1ZSAqdnEpDQo+ID4+Pj4NCj4gPj4+PiAgb3V0
Og0KPiA+Pj4+ICAgICAgICAgIHN6ID0gaW92X2Zyb21fYnVmKGVsZW0tPmluX3NnLCBlbGVtLT5p
bl9udW0sIDAsDQo+ID4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgJnRhaWwsIHNpemVv
Zih0YWlsKSk7DQo+ID4+Pj4gLSAgICAgICAgYXNzZXJ0KHN6ID09IHNpemVvZih0YWlsKSk7DQo+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmID8gYnVmIDogJnRhaWwsIG91dHB1
dF9zaXplKTsNCj4gPj4+PiArICAgICAgICBhc3NlcnQoc3ogPT0gb3V0cHV0X3NpemUpOw0KPiA+
Pj4+DQo+ID4+Pj4gLSAgICAgICAgdmlydHF1ZXVlX3B1c2godnEsIGVsZW0sIHNpemVvZih0YWls
KSk7DQo+ID4+Pj4gKyAgICAgICAgdmlydHF1ZXVlX3B1c2godnEsIGVsZW0sIHN6KTsNCj4gPj4+
PiAgICAgICAgICB2aXJ0aW9fbm90aWZ5KHZkZXYsIHZxKTsNCj4gPj4+PiAgICAgICAgICBnX2Zy
ZWUoZWxlbSk7DQo+ID4+Pj4gKyAgICAgICAgZ19mcmVlKGJ1Zik7DQo+ID4+Pj4gICAgICB9DQo+
ID4+Pj4gIH0NCj4gPj4+Pg0KPiA+Pj4+IEBAIC02NjcsNiArNzUxLDcgQEAgc3RhdGljIHZvaWQN
Cj4gPj4+PiB2aXJ0aW9faW9tbXVfZGV2aWNlX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3IgKiplcnJwKQ0KPiA+Pj4+ICAgICAgcy0+Y29uZmlnLnBhZ2Vfc2l6ZV9tYXNrID0gVEFSR0VU
X1BBR0VfTUFTSzsNCj4gPj4+PiAgICAgIHMtPmNvbmZpZy5pbnB1dF9yYW5nZS5lbmQgPSAtMVVM
Ow0KPiA+Pj4+ICAgICAgcy0+Y29uZmlnLmRvbWFpbl9yYW5nZS5lbmQgPSAzMjsNCj4gPj4+PiAr
ICAgIHMtPmNvbmZpZy5wcm9iZV9zaXplID0gVklPTU1VX1BST0JFX1NJWkU7DQo+ID4+Pj4NCj4g
Pj4+PiAgICAgIHZpcnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMsIFZJUlRJT19SSU5HX0Zf
RVZFTlRfSURYKTsNCj4gPj4+PiAgICAgIHZpcnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMs
IFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQyk7DQo+ID4+Pj4gQEAgLTY3Niw2DQo+ID4+Pj4g
Kzc2MSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19pb21tdV9kZXZpY2VfcmVhbGl6ZShEZXZpY2VT
dGF0ZSAqZGV2LA0KPiA+Pj4+ICtFcnJvcg0KPiA+Pj4+ICoqZXJycCkNCj4gPj4+PiAgICAgIHZp
cnRpb19hZGRfZmVhdHVyZSgmcy0+ZmVhdHVyZXMsIFZJUlRJT19JT01NVV9GX01BUF9VTk1BUCk7
DQo+ID4+Pj4gICAgICB2aXJ0aW9fYWRkX2ZlYXR1cmUoJnMtPmZlYXR1cmVzLCBWSVJUSU9fSU9N
TVVfRl9CWVBBU1MpOw0KPiA+Pj4+ICAgICAgdmlydGlvX2FkZF9mZWF0dXJlKCZzLT5mZWF0dXJl
cywgVklSVElPX0lPTU1VX0ZfTU1JTyk7DQo+ID4+Pj4gKyAgICB2aXJ0aW9fYWRkX2ZlYXR1cmUo
JnMtPmZlYXR1cmVzLCBWSVJUSU9fSU9NTVVfRl9QUk9CRSk7DQo+ID4+Pj4NCj4gPj4+PiAgICAg
IHFlbXVfbXV0ZXhfaW5pdCgmcy0+bXV0ZXgpOw0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBh
L2h3L3ZpcnRpby90cmFjZS1ldmVudHMgYi9ody92aXJ0aW8vdHJhY2UtZXZlbnRzIGluZGV4DQo+
ID4+Pj4gZTgzNTAwYmVlOS4uNTU1MDQ3NTY5MSAxMDA2NDQNCj4gPj4+PiAtLS0gYS9ody92aXJ0
aW8vdHJhY2UtZXZlbnRzDQo+ID4+Pj4gKysrIGIvaHcvdmlydGlvL3RyYWNlLWV2ZW50cw0KPiA+
Pj4+IEBAIC03MywzICs3Myw0IEBAIHZpcnRpb19pb21tdV9nZXRfZG9tYWluKHVpbnQzMl90IGRv
bWFpbl9pZCkNCj4gPj4+PiAiQWxsb2MgZG9tYWluPSVkIg0KPiA+Pj4+ICB2aXJ0aW9faW9tbXVf
cHV0X2RvbWFpbih1aW50MzJfdCBkb21haW5faWQpICJGcmVlIGRvbWFpbj0lZCINCj4gPj4+PiAg
dmlydGlvX2lvbW11X3RyYW5zbGF0ZV9vdXQodWludDY0X3QgdmlydF9hZGRyLCB1aW50NjRfdCBw
aHlzX2FkZHIsDQo+ID4+Pj4gdWludDMyX3Qgc2lkKSAiMHglIlBSSXg2NCIgLT4gMHglIlBSSXg2
NCAiIGZvciBzaWQ9JWQiDQo+ID4+Pj4gIHZpcnRpb19pb21tdV9yZXBvcnRfZmF1bHQodWludDhf
dCByZWFzb24sIHVpbnQzMl90IGZsYWdzLCB1aW50MzJfdA0KPiA+Pj4+IGVuZHBvaW50LCB1aW50
NjRfdCBhZGRyKSAiRkFVTFQgcmVhc29uPSVkIGZsYWdzPSVkIGVuZHBvaW50PSVkDQo+ID4+Pj4g
YWRkcmVzcyA9MHglIlBSSXg2NA0KPiA+Pj4+ICt2aXJ0aW9faW9tbXVfZmlsbF9yZXN2X3Byb3Bl
cnR5KHVpbnQzMl90IGRldmlkLCB1aW50OF90IHN1YnR5cGUsDQo+ID4+Pj4gK3VpbnQ2NF90IHN0
YXJ0LCB1aW50NjRfdCBlbmQpICJkZXY9ICVkLCB0eXBlPSVkIHN0YXJ0PTB4JSJQUkl4NjQiDQo+
ID4+Pj4gK2VuZD0weCUiUFJJeDY0DQo+ID4+Pj4gLS0NCj4gPj4+PiAyLjIwLjENCj4gPj4+DQo+
ID4+Pg0KPiA+DQoNCg==

