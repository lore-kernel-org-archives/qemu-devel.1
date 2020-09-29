Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD96320848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lzbySQ7r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="hZK6Ayno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD96320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNNwh-0005QX-Qc
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNNvO-0004Ta-Tn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:16:45 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19170)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNNvM-00012w-42
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601417800; x=1632953800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6dA9VICzXadm6tp6ctBnVd6Af/Zeha/DhOLloUG5g9A=;
 b=lzbySQ7rzD2tqmpjnDno5LuKz7tTeqIQ3ozO+vH3CG+pSFQXu9+qMZx/
 ZQfeBvFl0wF8L8Sk1m4quX9GbRUuUqPY91dblXlSj9C/SE3t41PFoEMHy
 8mI75qUw81S7Z3m5Bf2Dnxp4tZwKRnmz/tEN1VQOO7mtlLzdmAhAhECi8 E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Sep 2020 15:16:38 -0700
X-QCInternal: smtphost
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 Sep 2020 15:16:37 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 15:16:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 29 Sep 2020 15:16:37 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4950.namprd02.prod.outlook.com (2603:10b6:a03:47::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Tue, 29 Sep
 2020 22:16:35 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 22:16:35 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Eric Blake <eblake@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 00/29] Hexagon patch series
Thread-Topic: [RFC PATCH v4 00/29] Hexagon patch series
Thread-Index: AQHWlbze9UuGeVhliU69LxBcqNXciKl/iuoAgAA551CAABQkAIAAJ9TQgAAixICAAAy14A==
Date: Tue, 29 Sep 2020 22:16:35 +0000
Message-ID: <BYAPR02MB4886923187C8C44D9893DD29DE320@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
 <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
 <BYAPR02MB4886C114AAC9DDEF70300D23DE320@BYAPR02MB4886.namprd02.prod.outlook.com>
 <c63a9b09-bffb-ad16-c38c-1a2b55d4ff4f@redhat.com>
In-Reply-To: <c63a9b09-bffb-ad16-c38c-1a2b55d4ff4f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83e5c12e-b86b-490b-aea1-08d864c5542f
x-ms-traffictypediagnostic: BYAPR02MB4950:
x-microsoft-antispam-prvs: <BYAPR02MB4950DDF9CDB19109FC4EBED0DE320@BYAPR02MB4950.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWwpLGWIFUpPIIjnnuDx1dmZxwXUAFyeIHbPsU/aBhg3WMz/Xc7xDTY+ndbsqPmgqJPR5kkzp9uQzXOJ3qMQVJ+LwywX2qLclscRaXV7UYYds2G9e9W7QOMoQhDGJE9VSoLTFm5JGezRXLKTo3Kszn1VfCSgogPCT5bG7RgkNWfY4D//+NcQE3cT+mhQdFNmApFcuTxgfMVQgyR0/9+Bj5y42cEq2jOLR6sbQi5ZNbQ7tbpMzE4FQx/wSdl3oTYj+dv+lo1nXRO2h+Ltwar7/Xu6Z11yOwqzt+KtsJvGOd2v5emXwoKG3wPPBvl0Ep0MqGLSByvlqsDaqD52Wl8qMJhiI+OhT8uzaOkncDAMKVM3qAgvrVVhvChjeLUVdo45
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(26005)(478600001)(316002)(110136005)(54906003)(186003)(4326008)(83380400001)(55016002)(9686003)(66476007)(66556008)(66446008)(64756008)(71200400001)(5660300002)(52536014)(86362001)(66946007)(2906002)(8936002)(53546011)(6506007)(33656002)(8676002)(7696005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 57/7LpLOlu4MGyVKcswehjEY4r/bw2zyB61Oxpysd0d0ixhxgJRt6Z4YjyWYSyGkZHAxg6zzhXl5jrkvCIS7rbTzZvIGj7CGZfa1bCuLKu8cDtlGoy2YwV4cEWi1OUHaimv+i09kWzZ7L/uDeaX116BDnPB/2S4TP0rXgVFbLjkMCxGbUUygoFy9+8khxY7rBvyIdXanf9fSHhxCxb98pHlJQokKUM14r1pljMOI9j8XjVIK8FLIg74Zi9aSotx1K2v+THigbXXO7bj94Vodq8I4D26ItcIkfbnTGqhKKXguAXenCqwGe96fzl2Vt+bRphssftnXeWM08EjqPQOdib4nkDDlzTl26Mc5KEkXbA6oqwb+hOtdBsygfUl2kbazEb7gNmI49vleFP7fXyjlDC9ecBOZVBQWSQfoY0IfpxtaUl56iSoOG0Y0q0iB0KkLdZ48gjZUTJiIs9Z/LAuITXY5bpm4i9hHOecwPK/PtF4X4ScJ12dFC6BPdfh+tu8niO5L41h+bj7/KT2qnPTSLZ5brTJvsc47jOMFVl2SMX70cIdxAwYxQgx8u2+fkLGQcBJfpyujH4fJVeUtUXHzxHI7BCQ3siNHdcHcQcwoLYtsLns0Qzp5EAe1udTX/hZAc31kLZHbnA5zIYTbpT/2OA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nET2LCdzvHzEy5g4nZ8s5eO84DXSuDaFdRSK93GcFzpcTVRGKwWr+bbty2POEjeUwVI1Rm8kh+V61yP6Uixv8q5qHmnzeCheBJdRVVXEhjvwiLe6LWFMleIkoRVCjuf5KworS3bxHkzg65xhbdUTMxsgmbGcLWadlHg0StsJQv98Ydj5jTFGmAF/3QpOVrFZ66cTGy0InBcmWAGaCc3YA0aQZj0V9Hl7xyUuhNHx0YUIva+SNUFHwr1G54bcJn+kWpDy/JubLyLgaYzodZwNxwdzKr/We5lYpZZrsMy0Ynsac+u+m4aTxhfxOMYW5X8R43a+AyZQvdDpWw5QeuzlAg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEz4H1+V2pvkUTER4kTmMiyAGWFxzRuPg6owXudlz3Y=;
 b=NeWd17lqVYeTXSBh+XGUq2/Fw9lGkXjzWv8pBooqbsccR8Y5QtkVRRKqc5M+8GnQxvxqnJ8NNOvu43SpwLIOIdApmFO/uLgu7x43kGIhjFRjmuKuJzew30SoVoq0bMAxPhcnk7XHhNw3K/4dTpY+ecUTlHnZ6mHMHXVGYb69PYXMp6hPOEQu/yij2a7oV7Oz/Hf9KSiBKHlpd3FnlhIQyuWmKqRim/0AotBDZV2upeyKy82tRtvnzLBcOniqowOGs5NGb4f5vtcdtR8sHWzf9fZaNElNmy/OAU62sAsQIP/VtvF6pZOCiqOezkPpyd+9Fxfj+Jjme9Ryq5mLhF9FdA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEz4H1+V2pvkUTER4kTmMiyAGWFxzRuPg6owXudlz3Y=;
 b=hZK6AynoRZw4RNv63A92k5NsIO75MtCgZOuo+ZObFCgSrQbwNSVcAmqsTJ2BRSWXlo2vDi2w77y6lNbjoEs+fYPPm4yw9p+EnKyH66O1KvqqHbVGJ7t938+GcD0I4qApkzN6yL4ke+zBhJpY5ED1EMbrMUYPmKRhw+VW+KlsELE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 83e5c12e-b86b-490b-aea1-08d864c5542f
x-ms-exchange-crosstenant-originalarrivaltime: 29 Sep 2020 22:16:35.5801 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: EdY1VzKVZOVnTt+szxNCFYv4/QzFUrme3qG7PXWRPwPeY/nBe/paSC8PrgTR77hLR8oY1hpJ6t5RuoxfJTxwVQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4950
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 18:16:38
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJsYWtlIDxlYmxha2VA
cmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI5LCAyMDIwIDM6MjkgUE0N
Cj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpDQo+IDxmNGJ1Z0BhbXNhdC5vcmc+OyBxZW11LWRldmVsQG5vbmdudS5vcmcN
Cj4gQ2M6IGFsZUByZXYubmc7IHJpa3Uudm9pcGlvQGlraS5maTsgcmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZzsNCj4gbGF1cmVudEB2aXZpZXIuZXU7IGFsZWtzYW5kYXIubS5tYWlsQGdtYWls
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NCAwMC8yOV0gSGV4YWdvbiBwYXRjaCBz
ZXJpZXMNCj4NCj4gT24gOS8yOS8yMCAzOjExIFBNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4N
Cj4gPiBPdWNoISAgNC44IGlzIG9sZCBlbm91Z2ggdGhhdCBpdCBkb2Vzbid0IHN1cHBvcnQgQzEx
IF9HZW5lcmljIHdoaWNoIEkgYW0NCj4gdXNpbmcuICBUaGF0IG5lZWRzIGF0IGxlYXN0IEdDQyA0
LjkuDQo+ID4NCj4gPiBIZXJlIGFyZSBhIGNvdXBsZSBvZiBleGFtcGxlcy4gIEFzIHlvdSBjYW4g
c2VlLCBfR2VuZXJpYyBpcyB1c2VkIHRvDQo+IGRpc3BhdGNoIHRvIHNsaWdodGx5IGRpZmZlcmVu
dCBUQ0cgZ2VuZXJhdGlvbiBmdW5jdGlvbnMgZGVwZW5kaW5nIG9uIHRoZQ0KPiB0eXBlIG9mIHRo
ZSBvcGVyYW5kcy4gIEkgd2lsbCBzY3JhdGNoIG15IGhlYWQgYW5kIGZpZ3VyZSBvdXQgYSBkaWZm
ZXJlbnQgd2F5IHRvDQo+IGRvIHRoaXMuDQo+ID4NCj4gPiAjZGVmaW5lIE1FTV9TVE9SRTFfRlVO
QyhYKSBcDQo+ID4gICAgIF9HZW5lcmljKChYKSwgaW50IDogZ2VuX3N0b3JlMWksIFRDR3ZfaTMy
IDogZ2VuX3N0b3JlMSkNCj4gPiAjZGVmaW5lIE1FTV9TVE9SRTEoVkEsIERBVEEsIFNMT1QpIFwN
Cj4gPiAgICAgTUVNX1NUT1JFMV9GVU5DKERBVEEpKGNwdV9lbnYsIFZBLCBEQVRBLCBjdHgsIFNM
T1QpDQo+DQo+IFNlZSBpZiB5b3UgY2FuIHVzZSBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoKSBpbnN0
ZWFkLiAgTG9vayBhdA0KPiBpbmNsdWRlL29zZGVwL2F0b21pYy5oIHdoaWNoIGRlZmluZXMgdHlw
ZW9mX3N0cmlwX3F1YWwoKSB3aXRob3V0DQo+IF9HZW5lcmljLiAgbGludXgtdXNlci9xZW11Lmgg
X19wdXRfdXNlcl9lKCkgaXMgYWxzbyBhbiBleGFtcGxlIG9mIHdoYXQNCj4gYXBwZWFycyB0byBi
ZSBhIHBvb3ItbWFuJ3MgcmVwbGFjZW1lbnQgdG8gX0dlbmVyaWMuDQoNClRoYW5rcyEgIEl0J3Mg
YSBwcmV0dHkgc3RyYWlnaHRmb3J3YXJkIHRyYW5zbGF0aW9uIGZvciBteSB1c2UgY2FzZXMNCg0K
I2RlZmluZSBNRU1fU1RPUkUxX0ZVTkMoWCkgXA0KICAgIF9fYnVpbHRpbl9jaG9vc2VfZXhwcihf
X2J1aWx0aW5fdHlwZXNfY29tcGF0aWJsZV9wKHR5cGVvZihYKSwgaW50KSwgXA0KICAgICAgICBn
ZW5fc3RvcmUxaSwgXA0KICAgICAgICBnZW5fc3RvcmUxKQ0KI2RlZmluZSBNRU1fU1RPUkUxKFZB
LCBEQVRBLCBTTE9UKSBcDQogICAgTUVNX1NUT1JFMV9GVU5DKERBVEEpKGNwdV9lbnYsIFZBLCBE
QVRBLCBjdHgsIFNMT1QpDQoNCg0KVGF5bG9yDQo=

