Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48322C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E19420679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DESLNI4n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="SAsna4QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E19420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5E7-0004lO-8F
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5D5-00043x-6z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:08 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54740)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5D2-0003LB-CV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485924; x=1630021924;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YDOvNXtjpi+IlzZKXxbwEobxlKU7MoR7jgjeidpHg50=;
 b=DESLNI4n8xOAks+navqUpYGR3P718E3d0egSB4rD8yj4NWjTpgQhzImP
 Cngcv3xntcNf+7irSVG7I1JxSHTi6JvYW22zsI2D8gBqF9GWUC/ijchUr
 EsfmGpwI2efxpUT3LZq3AaDxzwqYIEVgECT+5x5DfdE5BDmJe/DRYAIKR 4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Aug 2020 16:52:00 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:51:59 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:51:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:51:59 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:51:58 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:51:58 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 04/34] Hexagon (target/hexagon) scalar core
 definition
Thread-Topic: [RFC PATCH v3 04/34] Hexagon (target/hexagon) scalar core
 definition
Thread-Index: AQHWdXddxlIHEo97/0ar/BthZny+aqlKcLKAgABkbxA=
Date: Wed, 26 Aug 2020 23:51:58 +0000
Message-ID: <BYAPR02MB4886C178FAE038F23D4FC0B4DE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-5-git-send-email-tsimpson@quicinc.com>
 <929004a5-f633-376a-d8d2-6ad8e0368e13@linaro.org>
In-Reply-To: <929004a5-f633-376a-d8d2-6ad8e0368e13@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7d2951e-faf5-4a76-df9f-08d84a1b0516
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB49524E28BFCEB6E24D53AFABDE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cDP5ibNOslfmFC7XXOsVgDcC92sF/1k7k1W+LadPdoG4P796GKHm7pmTREaRZgZIdCxZRTIT1ufhln9ViYNDwUEKk7NL/CC+6K5osEUoRVDhQiAWcdAay4oetE91MFDhdvhrji1gDh2n94UHQzdlNU2Wbm9NeSJh8mhGWMand9AHqR7Mc4jJCy0kPOEWLtr5xcVmON7wbxXTAIf0fwHz9s4nyk8gqNIT7wonNuvVdF/g5qkwIawcztdwtzF8sYytIGnRDyKtnk1SP2SKmoyXVbSqCSduiyvKK1a5ct18Q/QlZO54zSv54W3k+ZyZz9HzzlPdaqrhsfzBWUH904tcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AU5Jxtl6GJg9Gxr5HjLOpoJ2Zex8c1tPYX0fgasquLTFlO+WzHpm4+JnYorOh5sPCzylGcZTMFz94SLwZStY6fcUTyy1HtPe2TnIzfeGrtNwtk0GStGmQOUtdfm0u0F6Ap0IkESpU5dHlzVupaqNWfRyutBNkMJse7m/GZGVS7lt8oXGqsUVkkMf1kIjv88XKrkiKf7NNBtiKaBE4riHpTwf9BjkGevV/9SWRtt1g4iGtHEEWaOCOAkYnLOeXEVv3mU3VMK79MS0rKSwHUeWrqsamQKEQ6sGaRJAfgy594lU5qTlqsGap5wTbkzeYkZIcVqAugQGUuPuG2R5YB452Ada5venxUCVI6VbsMyPghVvnAa3nhuqv09uDSk2AD91Tp+U6Q2uFJOiB2aE7CM4DFcqSIavRzNvyisGvPuJUf440A2OTtn5TrT6W8imUBVWTOGZzyLwsxscDzKbkIR6MgyJIuVbtqbp+FSNpZzYMc40X7C9MQ8GXYv2f4gll1GIJsCAdUCDmFFX3PCeTz9Gm74rW9hdIbYUkFtPxl5mnjZv0CgJu/3u0JSPJZ5PORlaBjksbRMhZf6CVi1tsMvUO1C1953pJPk1D5E7Le/X+5QT1zxjEQRrbAgbEby2ZeJVDJ/ALU/O9oYx+rTpTNGLwg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbu1XU2k0onjAjbX4/dTgyTbJD0MQYLt+WpTqyGLQW7F2A0hmX3aleKecjG7vXBkWe4wQfNM5QG+YAFbReiLqIpeV1iORCy+/K73R4BckuL7K21igkmaHtHYHVJNMrNO26uh6eENzYh97WHPp6W5TdCBNO78ODOVnfnwe2Ho9RS6U+Rg3FuLDmbGGdjqUD0Wv0EZc8RLngQIGl48f0KHK/nr9EVVEEzIyFVtAYvCskhQ5xGm+E2IDF6JdFi+DE5OJDTrAhN1sPbo73B1WBSIagvz4K4SMySgAMiXAxomA3+UNxPAWxgdSVHavI4duA+JqwqAIEldoppf3porw2aGiw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crLOmbuzX2I2CzfrjLZkTe1gY8Y7IcoDazgX8uwDNXQ=;
 b=frQdkTvjN70s66a+li0Tg82L4LbT6cUP5VSLyAPXaQJdU0ILlaCbHquatQWhXJlidOsaMQUKDBDACatFTZyPv9eAkJPDvLfwTnNSgVKIBnbsXAZ6AyHFD3O50edGfvyhHxThZmz59XUihJ1ZP8Hoe0yyvJL91QZHavzW2VZctms+XKtubCiK+5G+7mSvXW3QYwp60/ETvaH6jRb5I7Np8mPTebjLiJ4moNDnUncRsfcpVsI45lJj8ke+ORpulxy9wlv9tRSQGpWNdGFKoyNEdCS0u9l0P0rP7ZpMoNEZ1Dvcze7e/wD+lgst31iVUJUjojBSnHUT7iUmpM4aZl9Huw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crLOmbuzX2I2CzfrjLZkTe1gY8Y7IcoDazgX8uwDNXQ=;
 b=SAsna4QWWcClm8/Ow4Cmaas2sXea3Df/sZ5KXQc5yQ0oRKIXxJTDVXo6Tvf7gfhUWYAN6ERZXgXyz1RX6kONzziTFvIJel54HvsE/TTmJY05JotksErwV64zEg6HKayQm7T98XbinA66MHp/s0mJvDyFiL1SN3P1y4WAeNqWOnA=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: a7d2951e-faf5-4a76-df9f-08d84a1b0516
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:51:58.1053 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: sDw+M+KH0oV2qpuV6474VIcXzzgrR62qMPT+lTMRbkzVoNEKzoG6+jTlCaU2EFODURgq0/UV2+2FuhXgzSGhog==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:00
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

VGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssIFJpY2hhcmQhIQ0KDQoNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjYsIDIwMjAgNzozNiBB
TQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPjsgcWVtdS1kZXZl
bEBub25nbnUub3JnDQo+IENjOiBwaGlsbWRAcmVkaGF0LmNvbTsgbGF1cmVudEB2aXZpZXIuZXU7
IHJpa3Uudm9pcGlvQGlraS5maTsNCj4gYWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tOyBhbGVA
cmV2Lm5nDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDA0LzM0XSBIZXhhZ29uICh0YXJn
ZXQvaGV4YWdvbikgc2NhbGFyIGNvcmUNCj4gZGVmaW5pdGlvbg0KPg0KPiBPbiA4LzE4LzIwIDg6
NTAgQU0sIFRheWxvciBTaW1wc29uIHdyb3RlOg0KPiA+ICsjaW5jbHVkZSA8ZmVudi5oPg0KPg0K
PiBUaGlzIHNob3VsZCBub3QgYmUgaW4gY3B1LmguICBXaGF0J3MgdXA/DQoNCldlJ3JlIG5vdCB1
c2luZyBxZW11IHNvZnRmbG9hdCAoaXQncyBvbiB0aGUgVE9ETyBsaXN0KSwgc28gdGhlcmUncyBh
IGZlbnZfdCBmaWVsZCBpbiBDUFVIZXhhZ29uU3RhdGUuDQoNCj4gPiArI2RlZmluZSBUQVJHRVRf
UEFHRV9CSVRTIDE2ICAgICAvKiA2NEsgcGFnZXMgKi8NCj4gPiArI2RlZmluZSBUQVJHRVRfTE9O
R19CSVRTIDMyDQo+DQo+IEJlbG9uZ3MgaW4gY3B1LXBhcmFtLmgNCg0KT0sNCg0KPiA+ICsjaWZk
ZWYgQ09ORklHX1VTRVJfT05MWQ0KPiA+ICsjZGVmaW5lIFRPVEFMX1BFUl9USFJFQURfUkVHUyA2
NA0KPiA+ICsjZWxzZQ0KPiAuLi4NCj4gPiArICAgIHRhcmdldF91bG9uZyBncHJbVE9UQUxfUEVS
X1RIUkVBRF9SRUdTXTsNCj4NCj4gRG8gSSBub3QgdW5kZXJzdGFuZCBoZXhhZ29uIGVub3VnaCB0
byBrbm93IHdoeSB0aGUgbnVtYmVyIG9mIGdlbmVyYWwNCj4gcmVnaXN0ZXJzDQo+IHdvdWxkIHZh
cnkgd2l0aCBzeXN0ZW0gbW9kZT8gIFdoeSBpcyB0aGUgZGVmaW5lIGNvbmRpdGlvbmFsIG9uIHVz
ZXItb25seT8NCg0KWWVzLCB0aGVyZSBhcmUgc29tZSByZWdpc3RlcnMgdGhhdCBhcmUgb25seSBh
dmFpbGFibGUgaW4gc3lzdGVtIG1vZGUuICBTaW5jZSB0aGlzIHNlcmllcyBpcyBvbmx5IGZvciBs
aW51eC11c2VyIG1vZGUsIEknbGwgcmVtb3ZlIHRoZSBpZmRlZiBmb3Igbm93Lg0KDQpXZSdyZSB3
b3JraW5nIG9uIHN5c3RlbSBtb2RlLiAgV2hlbiB0aGF0IHNlcmllcyBpcyByZWFkeSwgd2UgY2Fu
IHB1dCB0aGUgaWZkZWYgYmFjayBpbi4gIEF0IHRoYXQgdGltZSwgeW91J2xsIGFsc28gc2VlIHRo
ZSBleHRyYSByZWdpc3RlcnMgaW4gaGV4X3JlZ3MuaC4NCg0KPiBOby4gIFRoZXJlIGFyZSBwbGVu
dHkgb2YgYmFkIGV4YW1wbGVzIG9mIHRoaXMgaW4gcWVtdSwgbGV0J3Mgbm90IGFkZCBhbm90aGVy
Lg0KPg0KPiBGaXJzdCwgdGhlIGxvY2sgZG9lc24ndCBkbyB3aGF0IHlvdSB0aGluay4NCj4gU2Vj
b25kLCBzdGRlcnIgaXMgbmV2ZXIgcmlnaHQuDQo+IFRoaXJkLCBqdXN0IGFib3V0IGFueSB0aW1l
IHlvdSB3YW50IHRoaXMsIHRoZXJlJ3MgYSB0cmFjZXBvaW50IHRoYXQgeW91IGNvdWxkDQo+IGFk
ZCB0aGF0IHdvdWxkIGJlIGJldHRlciwgY29ycmVjdCwgYW5kIHRvZ2dsZWFibGUgZnJvbSB0aGUg
Y29tbWFuZC1saW5lLg0KDQpPSw0KDQo+IEkgdW5kZXJzdGFuZCB5b3VyIGRlc2lyZSBmb3IgdGhp
cyBzb3J0IG9mIGNvbXBhcmlzb24uICBXaGF0IEkgZG9uJ3QNCj4gdW5kZXJzdGFuZA0KPiBpcyB0
aGUgbWV0aG9kLiAgU3VyZWx5IGl0IHdvdWxkIGJlIHByZWZlcmFibGUgdG8gYWN0dWFsbHkgY2hh
bmdlIHRoZSBzdGFjaw0KPiBsb2NhdGlvbiBpbiBxZW11LCByYXRoZXIgdGhhbiBjb25zdGFudGx5
IGFkanVzdCBmb3IgaXQuDQo+DQo+IEFkZCBhIHBlci10YXJnZXQgaG9vayB0byBsaW51eC11c2Vy
L2hleGFnb24vdGFyZ2V0X2VsZi5oIHRoYXQgY29udHJvbHMgdGhlDQo+IGFsbG9jYXRpb24gb2Yg
dGhlIHN0YWNrIGluIGVsZmxvYWQuYywgc2V0dXBfYXJnX3BhZ2VzKCkuDQoNCk9LLCB3aWxsIGxv
b2sgaW50byB0aGlzLiAgVGhhbmtzIGZvciB0aGUgYWR2aWNlLCBJIHdhc24ndCBhd2FyZSB0aGlz
IHdhcyBwb3NzaWJsZS4NCg0KPg0KPiA+ICtzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BVSGV4
YWdvblN0YXRlICplbnYsIEZJTEUgKmYpDQo+ID4gK3sNCj4gPiArICAgIHN0YXRpYyB0YXJnZXRf
dWxvbmcgbGFzdF9wYzsNCj4gPiArICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4g
KyAgICAgKiBXaGVuIGNvbXBhcmluZyB3aXRoIExMREIsIGl0IGRvZXNuJ3Qgc3RlcCB0aHJvdWdo
IHNpbmdsZS1jeWNsZQ0KPiA+ICsgICAgICogaGFyZHdhcmUgbG9vcHMgdGhlIHNhbWUgd2F5LiAg
U28sIHdlIGp1c3Qgc2tpcCB0aGVtIGhlcmUNCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKGVu
di0+Z3ByW0hFWF9SRUdfUENdID09IGxhc3RfcGMpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+
ID4gKyAgICB9DQo+DQo+IE11bHRpLXRocmVhZGVkIGRhdGEgcmFjZS4gIE1pZ2h0IGFzIHdlbGwg
bW92ZSBsYXN0X3BjIHRvIGVudi0+ZHVtcF9sYXN0X3BjDQo+IG9yDQo+IHNvbWV0aGluZy4NCj4N
Cj4gQnV0IEknZCBhbHNvIHN1Z2dlc3QgdGhhdCBhbGwgb2YgdGhpcyBsbGRiIGNvbXBhdGliaWxp
dHkgc3R1ZmYgYmUgb3B0aW9uYWwsDQo+IHN3aXRjaGFibGUgZnJvbSB0aGUgY29tbWFuZC1saW5l
IHdpdGggYSBjcHUgcHJvcGVydHkuICBCZWNhdXNlIHRoZXJlIGFyZQ0KPiBnb2luZw0KPiB0byBi
ZSByZWFsIGNhc2VzIHdoZXJlICpub3QqIHNpbmdsZS1zdGVwcGluZyB3aWxsIHJlc3VsdCBpbiBk
dW1wcyBmcm9tIHRoZQ0KPiBzYW1lDQo+IFBDLCBhbmQgeW91J3ZlIGp1c3Qgc3F1YXNoZWQgYWxs
IG9mIHRob3NlLg0KPg0KPiBDYWxsIHRoZSBwcm9wZXJ0eSB4LWxsZGItY29tcGF0LCBvciBzb21l
dGhpbmcsIGFuZCBkZWZhdWx0IGl0IHRvIG9mZi4gIFlvdSB0aGVuDQo+IHR1cm4gaXQgb24gd2l0
aCAiLWNwdSB2NjcseC1sbGRiLWNvbXBhdD1vbiIuDQoNCk9LDQoNCg==

