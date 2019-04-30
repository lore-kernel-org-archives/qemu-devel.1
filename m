Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CCFC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D3720644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VXzFQ++3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ejd42Y5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D3720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZ5t-0003cJ-MX
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:11:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ44-0002Sc-PH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ43-00077P-U1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ41-00076X-Af; Tue, 30 Apr 2019 16:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556654957; x=1588190957;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=t1F3oSyXeXmUcCQnM3yIqeG8yxJbnn+Grz5yfhWD3Dc=;
	b=VXzFQ++3zcZ6etb7//wxELhWJEHAnIDQQzD91VRTC9qqbowh0m43umcP
	SzvxxcfSzcOflHoS64CGG0So8EGG6N2t0VS2bfsOKjlhskh5auH+YdCnh
	spFcJ+8zDrjiSrhB0EkkEt7krXcuWhV/lL41O7caBKxUtT0Na3bjNlZIS
	YqNZq3ORdWhc5Zu0Fh9d9ccddC7Q4TYjs2SC0bUiysui29fRa1L176GBc
	y4zpQgv3nGgjxPFQUT/dH6C+OaNMRJt0ZNcz10F5DskgXVBeu9pk8TKOv
	XmhIxh0k7dIbHG74Fz10zJygVhRki6jc11oUxzXS2LqbZT4KgOue8nQZI A==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; d="scan'208";a="107206353"
Received: from mail-bn3nam01lp2057.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.57])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 04:09:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=t1F3oSyXeXmUcCQnM3yIqeG8yxJbnn+Grz5yfhWD3Dc=;
	b=ejd42Y5z63YOzDingheOkwCZ9j92hLCvhbqd044oOfHn15IuVCQ0mJGScKJS3vsbp+/vsVl8bDN7oDgDDyneucE9RquwUJFOd88gIAANajuVW6tKKOYul7Wj+JGgzz3oOkipKI/8FPhjX23Oi0sRLZW54eJoij0/V/hcmHB+QhQ=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 20:09:13 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:09:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build warning
Thread-Index: AQHU/5CUO2QL1YlLekGmTofqK2bLDg==
Date: Tue, 30 Apr 2019 20:09:13 +0000
Message-ID:
 <f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BY5PR13CA0009.namprd13.prod.outlook.com
	(2603:10b6:a03:180::22) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 613dc384-2da9-4176-5482-08d6cda7b71a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5672; 
x-ms-traffictypediagnostic: BYAPR04MB5672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB567244B7792630D3A5CB1D05903A0@BYAPR04MB5672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(4326008)(50226002)(71190400001)(71200400001)(7736002)(305945005)(316002)(14444005)(256004)(44832011)(186003)(36756003)(8936002)(6436002)(54906003)(2501003)(11346002)(102836004)(2906002)(26005)(6486002)(446003)(486006)(476003)(2616005)(5660300002)(8676002)(25786009)(6116002)(81156014)(81166006)(72206003)(3846002)(86362001)(66066001)(478600001)(73956011)(6512007)(66556008)(118296001)(66446008)(14454004)(66476007)(66946007)(64756008)(68736007)(53936002)(76176011)(97736004)(52116002)(2351001)(386003)(6506007)(5640700003)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5672;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AFKNN1oeiVDDxF4Ti3yYjNEdNTwFphD1GPn1tlbK/15ied6WPy5WIWgbcnMCzWuF03RXAQY04QDDtmBk9i7G8dy/RHKiaTCGZsWb51udVDWe6yyGmiOCNDKzzKYGyTrB6sCv5zd2JST7aFY3vDpbjCUtbceG0bcv6iEj17W6xNK4FLjsw5Y7ggAVxnSCDKIuI7oQyvTiVhRKnVRM9RbFWnH+kkJ5JzWGDLF4kOuPktGxyUOJCaPKCIuHiMPYyWRN11yxrcNmMlIVN3V9xYqXzUHdLkA9TP0iscEyj95e464nyaYgpBjSu9KDw4/mBAxp5fkv2RW70xPO69+zbjBohKTan4Qx/IH2CR9bHncbPNFKz0LGdL1NJ+yWc7NLPoL+BebCJkJsywRD4jnyreF3nVKevcKIjmEzDmpM+t819Zg=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <AFE9768B5F3E374CBD5CE5ABF90D21D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613dc384-2da9-4176-5482-08d6cda7b71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:09:13.7334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build warning
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430200913.51YMEZHkYjj2U1013L7b9dYjIA8eXZnkBVBNTKk2-bc@z>

Rml4IHRoaXMgd2FybmluZyB3aXRoIEdDQyA5IG9uIEZlZG9yYSAzMDoNCmh3L3VzYi9kZXYtbXRw
LmM6MTcxNTozNjogZXJyb3I6IHRha2luZyBhZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgb2Yg4oCY
c3RydWN0IDxhbm9ueW1vdXM+4oCZIG1heSByZXN1bHQgaW4gYW4gdW5hbGlnbmVkIHBvaW50ZXIg
dmFsdWUgWy1XZXJyb3I9YWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyXQ0KIDE3MTUgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGF0YXNldC0+ZmlsZW5hbWUpOw0KICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fl5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogaHcvdXNi
L2Rldi1tdHAuYyB8IDEzICsrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvdXNiL2Rldi1tdHAuYyBiL2h3L3VzYi9kZXYtbXRw
LmMNCmluZGV4IDk5NTQ4YjAxMmQuLjZkZTg1ZDk5ZTYgMTAwNjQ0DQotLS0gYS9ody91c2IvZGV2
LW10cC5jDQorKysgYi9ody91c2IvZGV2LW10cC5jDQpAQCAtMTcxMSw5ICsxNzExLDIyIEBAIHN0
YXRpYyB2b2lkIHVzYl9tdHBfd3JpdGVfbWV0YWRhdGEoTVRQU3RhdGUgKnMsIHVpbnQ2NF90IGRs
ZW4pDQogICAgIGFzc2VydCghcy0+d3JpdGVfcGVuZGluZyk7DQogICAgIGFzc2VydChwICE9IE5V
TEwpOw0KIA0KKy8qDQorICogV2UgYXJlIGFib3V0IHRvIGFjY2VzcyBhIHBhY2tlZCBzdHJ1Y3Qu
IFdlIGFyZSBjb25maWRlbnQgdGhhdCB0aGUgcG9pbnRlcg0KKyAqIGFkZHJlc3Mgd29uJ3QgYmUg
dW5hbGxpZ25lZCwgc28gd2UgaWdub3JlIEdDQyB3YXJuaW5ncy4NCisgKi8NCisjaWYgZGVmaW5l
ZChDT05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFKSAmJiBRRU1VX0dOVUNfUFJFUkVR
KDksIDApDQorI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwdXNoDQorI3ByYWdtYSBHQ0MgZGlhZ25v
c3RpYyBpZ25vcmVkICItV2FkZHJlc3Mtb2YtcGFja2VkLW1lbWJlciINCisjZW5kaWYNCisNCiAg
ICAgZmlsZW5hbWUgPSB1dGYxNl90b19zdHIoTUlOKGRhdGFzZXQtPmxlbmd0aCwgZmlsZW5hbWVf
Y2hhcnMpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhc2V0LT5maWxlbmFtZSk7
DQogDQorI2lmIGRlZmluZWQoQ09ORklHX1BSQUdNQV9ESUFHTk9TVElDX0FWQUlMQUJMRSkgJiYg
UUVNVV9HTlVDX1BSRVJFUSg5LCAwKQ0KKyNwcmFnbWEgR0NDIGRpYWdub3N0aWMgcG9wDQorI2Vu
ZGlmDQorDQogICAgIGlmIChzdHJjaHIoZmlsZW5hbWUsICcvJykpIHsNCiAgICAgICAgIHVzYl9t
dHBfcXVldWVfcmVzdWx0KHMsIFJFU19QQVJBTUVURVJfTk9UX1NVUFBPUlRFRCwgZC0+dHJhbnMs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwKTsNCi0tIA0KMi4yMS4w
DQoNCg==

