Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23338C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC172073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H+zomxQo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="FY7OPRVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC172073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCtY0-0006g4-W0
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCtXK-0006G3-O1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:48:31 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2460)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCtXH-0001OY-LE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598917705; x=1630453705;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=av6N+tnp2pZ3ybnt0fgW6ep8bVfPS4iuuP4n3/ja2nU=;
 b=H+zomxQopMiuK/AviKIYgclZkFQL7E3UCAMy3Ukomjq0S3ZuXdEJvXW4
 jEKqndWYsJUvbLAmwFxu2gypQ1Ps32VWtVjEpU+/wYQqHxC7GVdm/LCYl
 CuVvoluLMy4Vw31ZkCWI/Ehz1lrZiT9Z9wDQ+fgf0ex2s9aDGIOUtwvtV Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 31 Aug 2020 16:48:24 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 31 Aug 2020 16:48:25 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 16:48:25 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 16:48:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 16:48:04 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 23:48:03 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 23:48:03 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 00/34] Hexagon patch series
Thread-Topic: [RFC PATCH v3 00/34] Hexagon patch series
Thread-Index: AQHWdXdhC+P+V2qxTkGo6bPF07deGKlOfaQAgAKxJrCAADIWgIABHOOAgABGLwCAACkFEA==
Date: Mon, 31 Aug 2020 23:48:03 +0000
Message-ID: <BYAPR02MB4886F0AC75E90D83F4DAE335DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
 <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <78e5b8be-e7f4-a1b9-2810-e0855da23f00@linaro.org>
 <BYAPR02MB488699D87ED9C3ADBCF155BADE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <97b529f8-6dff-8cd1-bed2-5ce450fe4b64@linaro.org>
In-Reply-To: <97b529f8-6dff-8cd1-bed2-5ce450fe4b64@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9845ad4d-2e4d-4643-f8d3-08d84e084d07
x-ms-traffictypediagnostic: BY5PR02MB6753:
x-microsoft-antispam-prvs: <BY5PR02MB6753E0935271F53A34C9C395DE510@BY5PR02MB6753.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJ8sJ94pkiRMoeGUN0nNwJ9213ksaZkhd0yF9se27CgXOI/08KA4a1hJepn4dIc4j71W4PFs6FJQclSD8qsTotepVQwk9SInuwO0ZQUc3bDSxLT8iN9Zv/qd9UbQQxuW7cB/pD5tcHvih9eRgqAiZjA0Qon6nAMnWBQaRSGFPM8t5oOiNgcTz2nyJ2KSo+BehMZh7dP5O9bsTuYgc0e9iB1a3eqAKWzKtW9u9H+OFQTVJmxvVrpeYxmuzR3MCyNFHrI5gQLmwD9zIBFL+K5DHfomJfrNoL+Ca8r7D9VLRp2/8/CCMdaELVeyQnm5F8XQB+Cf2cpjWlKue0rrCKXjTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(136003)(376002)(396003)(39860400002)(7696005)(4326008)(66556008)(2906002)(478600001)(71200400001)(8936002)(186003)(33656002)(64756008)(86362001)(66446008)(66476007)(66946007)(76116006)(9686003)(316002)(53546011)(5660300002)(52536014)(26005)(6506007)(83380400001)(55016002)(110136005)(54906003)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GTwYBxxyqrSzJhjSVQvXk36iyAEcFGMN3ObmnpnvFxOZASbQMWFpV/uKo4oFkcLKTtvpxe/IlvBSm7CtES7TYfdcVMLPImGfiscNmnCfAqX8liZxuD5mgWdF2BIQtnyUkp39z4b7xVsqcB27PtiRDUGLA+k64jvbQGrAoASMTXVsEd1HSqiDgSPA40cAfi/8CN8yLxujl9bgMolJS9+gMusjZPs3kK79B0WPzkCgMuhWZPMPjAWaeKwjyqwc4noxv3SgoA9Xdt4LDFT/qv6s6lVof5iYhM3aysr/RcTnaIdwasTNpy5SUq7zbzGn29VHNL5Hrt5sCfION02RR+S3FpX+z2QWgERUVOG0akSjnbMEjgkVqfPNatzGKTrt39DWZ8916U9I3awLEyIcRZZ5koxMuusybr5TN0w51AY2L9icKD+vpSeEMz3uSpoAgQ3Ondq6X+3F81Te7CuvWM2+h6Mab/PfTY3SHyVtLHMLPbEk4Y7Ii8JbgAuR0GzfIg6NhquLJnm1m/KoaD/kXKgKPgTxxRSClhnCMeTcTijlpBYWg6ov78kfyObjj7DFzadjtOv2SFoTgDRLTJXewSHgn9TE/TaPToDy+X+0lMYJrTYQpiXW8kLNgQqjhIBaeNM6hjur9A8F8JF/JsvlRkcfWw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg1S7LfdRluwAnvNVRcPIswHMjMuRa+yxXEtpJwKF2hQTKte2CpL65jBnMuebwEeETem/0BcbWFZzxVqm//mg2BPqZHVOp8Ct0bJklN75v6QDMDoFvs2EwQ5h2j7no4BJh3yKHxDhnpRfs3mKW1pqDBkVEYTpUXQBCjHp3I6FM8L2HHv51+93cI8WJGw0ra3avMYPg0F885C9ESSR3JXxD+CGM4KZ8ooNQrjeehjsj9m+Plp2MVB5v02JyDg8PsRzoGKS9BXiEygMNmlc7trXXNIUC/lVz2SQM45k3oZsSEYG0QsxpeS+R+Dx0ua+ZGCK7p+jE9b/9Z8X4KwnxqZzg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULPSC+Ib5CI2MGZbHXBeW+D4Q7Q0LGoUuekYkOqitaw=;
 b=cLHaYoRo9x+inCtc/QcunC+ZZac0t8hyEFcGwm2x+EpB16430ClxxMHuu/2OpZLB7t3fKbLtlO0Jr/ocIi3n9yMz8H1JQy5PrqphNq3xw7pszwTvx+oUOjcgTVLimuBwalqJSVNIy7kAb0VdV60DWzfx+a4A2+8HU9GINcQJLr59MRbj6ybYwpMvcHI8vFDAGJ+Ru8ZAfT+TSKpmBUvc5OawZxXxGkBTHCTtn1t/DxJ8icKrSpz7qhgDBhYao0NuFtdLjR6hfH6ihzEMZ34p/pCzPQd//NiB7SF+ekf4VI7t3O2tttznAaU+wluFwUjTM5xRrN+eGiEr1cbivLUoKw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULPSC+Ib5CI2MGZbHXBeW+D4Q7Q0LGoUuekYkOqitaw=;
 b=FY7OPRVE3234sIJ8yIF8mqaJVBB9+VFrq/bJA1GzW+TWFAcsWDO5s4viZwwKOwP5/y6ds3WEihxmWRWrINDUjiyMKG1EfbIsp5HI8YFraOl+apMUVZJZo3SEt2nzjYWDAmA+gMTOzfPH9O+784iaY5rYUTgkvvOpfqaCiUpIDpw=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 9845ad4d-2e4d-4643-f8d3-08d84e084d07
x-ms-exchange-crosstenant-originalarrivaltime: 31 Aug 2020 23:48:03.0399 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: U8uQBMZ4puaYDslm1fuAFe+QR5lAG3r2eTtfZh3f8ipvXd1oo5+8B/VOyvQTtl/MSqG3wmHoHa+MmM3qGgcDJg==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6753
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 19:48:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgSGVuZGVyc29u
IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAz
MSwgMjAyMCAyOjQ0IFBNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5j
b20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBoaWxtZEByZWRoYXQuY29tOyBsYXVy
ZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiBhbGVrc2FuZGFyLm0ubWFpbEBn
bWFpbC5jb207IGFsZUByZXYubmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDAvMzRd
IEhleGFnb24gcGF0Y2ggc2VyaWVzDQo+DQo+IE9uIDgvMzEvMjAgMTA6NTcgQU0sIFRheWxvciBT
aW1wc29uIHdyb3RlOg0KPiA+IE9LLCBoZXJlJ3MgdGhlIGxpc3Qgb2YgaXRlbXMuICBMZXQgbWUg
a25vdyBpZiBJIG1pc3NlZCBhbnl0aGluZy4gIEknbGwNCj4gPiBpbmRpY2F0ZSB3aGljaCBvbmVz
IGNhbiBiZSBkb25lIHF1aWNrbHkgYW5kIHdoaWNoIG9uZXMgd291bGQgdGFrZSBtb3JlDQo+IHRp
bWUuDQo+ID4gSSBhZGRlZCBhIGNvbHVtbiBmb3IgYmxvY2tlciBpZiB5b3Ugb3IgYW55b25lIGVs
c2UgaGFzIGlucHV0IG9uIHRoYXQuDQo+ID4NCj4gPiBQYXRjaEl0ZW1FZmZvcnRCbG9ja2VyDQo+
ID4gVXNlIHFlbXUgc29mdGZsb2F0Pz9ZZXMNCj4NCj4gSG1tLCB0aGlzIHRhYmxlIGRpZG4ndCBy
ZW5kZXIuICBCZWxvdywgeWVzL25vIGZvciBibG9ja2VyIGNvbHVtbi4NCg0KU29ycnkgYWJvdXQg
dGhhdCAtIG5vdCBzdXJlIHdoYXQgaGFwcGVuZWQuDQoNCkkgd2lsbCB3b3JrIGFsbCB0aG9zZSB5
b3UgbWFya2VkICJ5ZXMiIG9yICJubywgYnV0IHNob3VsZCBiZSBlYXN5Ii4NCg0KPiA+IDI1RXhw
YW5kIERFQ0wvUkVBRC9XUklURS9GUkVFIG1hY3JvcyBpbnRvIGdlbmVyYXRlZCBjb2Rlc21hbGwN
Cj4NCj4gWWVzLg0KPg0KPiBJbiB0aGUgZW5kIEkgdGhpbmsgc29tZSBvZiB0aGVzZSB3aWxsIGlu
IHRoZSBlbmQgd2FudCB0byBiZSBoZWxwZXIgZnVuY3Rpb25zLg0KPiBBcyBJIHdhcyB0aGlua2lu
ZyBob3cgdG8gYmVzdCB3cml0ZSBBMl9hZGQsIEkgd2FzIHRoaW5raW5nDQoNClNlZSBteSByZXNw
b25zZSB0byB0aGUgdGhyZWFkIG9uIHBhdGNoIDMwLzM0Lg0KDQpTaW5jZSB5b3UgbWVudGlvbiBB
Ml9wYWRkaXQsIGhlcmUncyB3aGF0IGl0IHdvdWxkIGxvb2sgbGlrZSBhc3N1bWluZyBpdCBpcyBv
dmVycmlkZGVuLg0KDQpzdGF0aWMgdm9pZCBnZW5lcmF0ZV9BMl9wYWRkdChDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgsIGluc25fdCAqaW5zbiwgcGFja2V0X3QgKnBrdCkN
CnsNCi8qIEEyX3BhZGRpdCAqLw0KaW50IFB1TiA9IGluc24tPnJlZ25vWzBdOw0KVENHdiBQdVYg
PSBoZXhfcHJlZFtQdU5dOw0KSW50IFJkTiA9IGluc24tPnJlZ25vWzFdOw0KVENHdiBSZFYgPSB0
Y2dfdGVtcF9sb2NhbF9uZXcoKTsNCmlmICghaXNfcHJlbG9hZGVkKGN0eCwgUmROKSkgew0KICAg
IHRjZ19nZW5fbW92X3RsKGhleF9uZXdfdmFsdWVbUmROXSwgaGV4X2dwcltSZE5dKTsNCn0NCmlu
dCBSc04gPSBpbnNuLT5yZWdub1syXTsNClRDR3YgUnNWID0gaGV4X2dwcltSc05dOw0KaW50IHNp
ViA9IGluc24tPmltbWVkWzBdOw0KDQpmR0VOX1RDR19BMl9wYWRkaXQoe2lmKGZMU0JPTEQoUHVW
KSl7ZklNTUVYVChzaVYpOyBSZFY9UnNWK3NpVjt9IGVsc2Uge0NBTkNFTDt9fSk7DQoNCmdlbl9s
b2dfcmVnX3dyaXRlKFJkTiwgUmRWLCBpbnNuLT5zbG90LCAxKTsgICAvKiBPbmx5IGRvZXMgdGhl
IHdyaXRlIGlmIHdlIGhhdmVuJ3QgY2FuY2VsbGVkICovDQpjdHhfbG9nX3JlZ193cml0ZShjdHgs
IFJkTik7DQoNCnRjZ190ZW1wX2ZyZWUoUmRWKTsNCi8qIEEyX3BhZGRpdCAqLw0KfQ0KDQpIZXJl
J3Mgd2hhdCB0aGUgb3ZlcnJpZGUgbG9va3MgbGlrZSAodGhlcmUgYXJlIGEgYnVuY2ggb2YgdGhl
c2UsIHNvIHdlIGhhdmUgYSBoZWxwZXIgbWFjcm8gd2hpY2ggY291bGQgYWxzbyBiZSBhIGZ1bmN0
aW9uKQ0KLyogUHJlZGljYXRlZCBhZGQgaW5zdHJ1Y3Rpb25zICovDQojZGVmaW5lIEdFTl9UQ0df
cGFkZChQUkVELCBBREQpIFwNCiAgICBkbyB7IFwNCiAgICAgICAgVENHdiBMU0IgPSB0Y2dfdGVt
cF9uZXcoKTsgXA0KICAgICAgICBUQ0d2IG1hc2sgPSB0Y2dfdGVtcF9uZXcoKTsgXA0KICAgICAg
ICBUQ0d2IHplcm8gPSB0Y2dfY29uc3RfdGwoMCk7IFwNCiAgICAgICAgUFJFRDsgXA0KICAgICAg
ICBBREQ7IFwNCiAgICAgICAgdGNnX2dlbl9tb3ZpX3RsKG1hc2ssIDEgPDwgaW5zbi0+c2xvdCk7
IFwNCiAgICAgICAgdGNnX2dlbl9vcl90bChtYXNrLCBoZXhfc2xvdF9jYW5jZWxsZWQsIG1hc2sp
OyBcDQogICAgICAgIHRjZ19nZW5fbW92Y29uZF90bChUQ0dfQ09ORF9ORSwgaGV4X3Nsb3RfY2Fu
Y2VsbGVkLCBMU0IsIHplcm8sIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaGV4X3Nsb3RfY2FuY2VsbGVkLCBtYXNrKTsgXA0KICAgICAgICB0Y2dfdGVt
cF9mcmVlKExTQik7IFwNCiAgICAgICAgdGNnX3RlbXBfZnJlZShtYXNrKTsgXA0KICAgICAgICB0
Y2dfdGVtcF9mcmVlKHplcm8pOyBcDQogICAgfSB3aGlsZSAoMCkNCg0KI2RlZmluZSBmR0VOX1RD
R19BMl9wYWRkaXQoU0hPUlRDT0RFKSBcDQogICAgR0VOX1RDR19wYWRkKGZMU0JPTEQoUHVWKSwg
dGNnX2dlbl9hZGRpX3RsKFJkViwgUnNWLCBzaVYpKQ0K

