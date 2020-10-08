Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF66C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFB922203
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ADRbeSiV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="sN4QiV7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFB922203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQczi-0001bm-O8
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQcw5-0007fD-VN
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:54:50 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38962)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQcw2-0001Ca-So
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1602190486; x=1633726486;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G9AAc2BKdoyTlwMuXXWHGMnfsPf5ytHqWrsPHbfCAO0=;
 b=ADRbeSiV4GstNzrrwDAD8Q568t7JoF2pIVdbgVe3w7SbfE4seYbvJUYQ
 obQRZqD+8IxlYW9cZjJ/55JpNND+lYOCoL8r54NYYyzKC79sGicT0jZAZ
 i3b/D3Zit76F0YzQqKYQaANcdwtwAKsKoXdX25o7UFQGNDb3sR5WIFj95 g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Oct 2020 13:54:44 -0700
X-QCInternal: smtphost
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 08 Oct 2020 13:54:44 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 13:54:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Oct 2020 13:54:43 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6194.namprd02.prod.outlook.com (2603:10b6:a03:1b3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 8 Oct
 2020 20:54:42 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3455.025; Thu, 8 Oct 2020
 20:54:42 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Topic: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Index: AQHWdXdf6p/vkS3v9UGs80VPN3oP2KlOWTUAgD+1nUCAADfPgIAAExFwgAAXOYCAAAhvQA==
Date: Thu, 8 Oct 2020 20:54:42 +0000
Message-ID: <BYAPR02MB4886A2E28C56A059B9F54942DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
 <BYAPR02MB488658CFC0440D56F13F68D0DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <7f0ae43c-97a0-3337-eac7-938a2f244d3d@linaro.org>
In-Reply-To: <7f0ae43c-97a0-3337-eac7-938a2f244d3d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0232dd78-6eb4-43f9-c24e-08d86bcc619d
x-ms-traffictypediagnostic: BY5PR02MB6194:
x-microsoft-antispam-prvs: <BY5PR02MB6194DF34BB68F6BA40F882F9DE0B0@BY5PR02MB6194.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZqq5jNLlN5u+Ef3noa7/9wkqv9wz62+hlKaXUCu3BJ5zX+kMqw8HeMLdwSSfzAnR8ASPli4zgiYtFMJdqGiMdDzz4ojKi9W9CDOIeyPLis+jTx4z3Q87m1PiucQ0Dm/eUzyceMt3YIo0bRzD6DyK/7DY+hs0uE70xfKwxwd8HVEgI1wcf4VLafuK03PGWjsybCr5g53R8Wn6apTBCvgN4qw2k9whuG0G2g1wvp02oS5ByRkti8/h6xDTcI/s+n5yKhYnWRAiFu2lMSxI5cJQph03OXYeOpFfq1C71WKkb9oBbPMttCAALJvw28eJrfeV0bVUSghRrQ2NI8pphurvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(76116006)(9686003)(83380400001)(33656002)(64756008)(66946007)(66476007)(66446008)(66556008)(52536014)(8676002)(86362001)(4326008)(5660300002)(8936002)(71200400001)(478600001)(55016002)(7696005)(2906002)(110136005)(26005)(186003)(6506007)(53546011)(316002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xrNmtMSsSar7/k66jYNjlfys1lFdxisRqA0qwceD8UmjPQ4LuK0RiKSgebIGsolIY9YTHpPp5uV5MU5ae6O/JtpILUFRgg23zZ9BnPfNu+RL2E0DOcwN+8G7YKY6Ffb2O2rMc1i641yLWTymU4pMtT5+FQzVGM88TWEE5me3C7OsO/F92mtD0VHGQsauS9xymPQP2zz9va7aWYXH4HZtMO+A1PVEz1XtFErZv9QSyULLz2MjmDDcO/dGnqmCAO0Wn754pzfIU8TRLHB5fBDePfI1AjxpK/ah79XiDz5iqfkENj17Y78Khw9xcTibu2ExKuV6K4pwDW3d8ZJ8Lawrv3YAp9e0MA1IpR5oXtDiPWab44dKxgl1zkiZvZmG1oULX81JciSmKOtWpgd1PGSKBuhaOL5VLoqK23IBwXbReZ7lAQAif0JuoPx+GrX2S2AlbJLk8eTcMHRSdnE0oL8I5WWaLkFJ1Uyn4W3MFm+KkY+Py2TWcJGwuZVPuwQ9WncyB2V+UiVwJ//A++w6TU14UqsqjEo7OfVECIv7X/gNq8UDiHn7vXruEJbOb7iQrGNdZAN0usCEeOeuJHySzVKiLb+2Qa3GkZzLnqCv7Suie2Y2AdDEdEDBTVo3NLF+Urizt/xSeYE7FUOjNMSkx4OYyg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BydTOS7IUibvnMGhnMJPDgc1kC9uNPudpf6Z8uvq7QDb8j2AIQN5fMAnfMlTWqD/BEMi+a1K7Fn+jNrsFNPLiclsjkp5fugQtOgDI5ynTtUHpp0w2m1nuBtULyzC0DsTY3nqTAcnl9JqrJkuwq7QIScIspSMcX1tKz6QbhAcTV44Nu1Vz9w0XEg1SSNhT6Ez7PwFIQpEsTS6Z19tIzopQ7Jr7INaoDDIhHNo8vJFnd/eThbkufOE0idUpgjo+k9/z3hr2ak/clmJhO1PNx79hza63UOauXumm87FMcvjEcTIZFBgJZbiiv8SpKiosdYO91pmcoWY+ZY7K6KQLB76HA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyj8evasujHjHzgDd/Oy6hghIXerXm24ZcHZTF7AUrQ=;
 b=YL/e5mWOr1QiI29WkAVkV+R6SgbTm1Z4Kp9lZx2j2kXm9eC/fj19G6FGOfjqOIE7avibxK9ZU6vSfNzhcLqtmDoHmgGmlznsrEtdmFirrujm0AgZWrLdtXBvbweqqkcrkQLeYLY5JOH009k+V22Kzrgf2byGBrtY/PNxd2Gpi2LswpyGGULUUg4FeZpOerH8zZkPtxO46qfNazhuCufyJcZZPl78tEsedoNw+YC2sR06Z6Hk8tprkUqp0GFkrIhD7KXQVQv11ID/nvfMXZ8RJ/z3FIP7+5i0OlY2/KBqpJHgXnlNXvlTAUX1ABQ4v/RWrK2rRK7QtAmsdEccI0lI7Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyj8evasujHjHzgDd/Oy6hghIXerXm24ZcHZTF7AUrQ=;
 b=sN4QiV7rOwh0gETRmlDHVRk3oAqHhN+NwNHn5UUB6dxCB+Zn2h3SCwuylq7blxqxFE8r01puAoG9jTi3tqFqIEW7OF1/EDQ5cdffFNMi0nF4yUG4KH9d7BCd1yOx5MvIqXuBCaXr23dMuAZrLKO6rkIV1mxi0VjgjIul7e4JouM=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 0232dd78-6eb4-43f9-c24e-08d86bcc619d
x-ms-exchange-crosstenant-originalarrivaltime: 08 Oct 2020 20:54:42.6945 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: fpVrHuwi/32u7LKCl42y9Cp2xRm6/exDSdUZyYQ7t1vuhxrFtRLeSoxj0qZL4NBGF2RSrdZaxlQvqW2SgQ0lNA==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6194
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 16:54:45
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDgsIDIwMjAgMjowMiBQTQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNp
bmMuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwaGlsbWRAcmVkaGF0LmNvbTsg
bGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlvQGlraS5maTsNCj4gYWxla3NhbmRhci5tLm1h
aWxAZ21haWwuY29tOyBhbGVAcmV2Lm5nDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDI2
LzM0XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgbWFjcm9zDQo+IHJlZmVyZW5jZWQgaW4gaW5z
dHJ1Y3Rpb24gc2VtYW50aWNzDQo+DQo+IE9uIDEwLzgvMjAgMTo1MSBQTSwgVGF5bG9yIFNpbXBz
b24gd3JvdGU6DQo+ID4+IEhvdyBjYW4gaXQgaGF2ZSBkb25lIHdpdGhvdXQgZG9pbmcgdGhlIG1l
cmdpbmcgYnkgaGFuZC4gIFdoaWNoIHRoaXMNCj4gb3BlcmF0aW9uIG9yZGVyaW5nIGlzIGludGVu
ZGVkIHRvIG1ha2UgdW5uZWNlc3NhcnkuDQo+ID4+DQo+ID4+IEkgdGhpbmsgeW91J3JlIG1pc3Np
bmcgdGhlIHBvaW50Lg0KPiA+DQo+ID4gU29ycnkgSSB3YXNuJ3QgY2xlYXIuICBXZSBoYXZlIGRv
bmUgdGhlIGxvYWQgZnJvbSBtZW1vcnkgYXMgaXQgd2FzIGF0IHRoZQ0KPiBiZWdpbm5pbmcgb2Yg
dGhlIHBhY2tldC4gIFRoZSByZXN1bHQgb2YgdGhlIHN0b3JlIGlzIGluIG1lbV9sb2dfc3RvcmVz
IGluDQo+IENQVUhleGFnb25TdGF0ZS4gIFRoaXMgY29kZSB1cGRhdGVzIHRoZSBieXRlcyB0aGF0
IHdlcmUgbG9hZGVkIHdpdGggYW55DQo+IG92ZXJsYXBwaW5nIGJ5dGVzIGZyb20gdGhlIHN0b3Jl
IHRoYXQgaGFzbid0IGJlZW4gY29tbWl0dGVkIHlldC4NCj4NCj4gUmlnaHQsIHNvIHlvdSAqYXJl
KiBtaXNzaW5nIHRoZSBwb2ludC4NCj4NCj4gVGhlIHBvaW50IGlzIHRvICpub3QqIGRvIHRoZSBs
b2FkIGVhcmxpZXIsIGJ1dCBvbmx5IHByb2JlIHRoZSBtZW1vcnkgZm9yDQo+IHJlYWRhYmlsaXR5
IHNvIHRoYXQgYW55IGV4Y2VwdGlvbiBpcyByZWNvZ25pemVkIGJlZm9yZSB0aGUgc3RvcmUgY29t
bWl0cy4NCj4NCj4gVGhlbiwgYWZ0ZXIgdGhlIHN0b3JlLCBhY3R1YWxseSBwZXJmb3JtIHRoZSBs
b2FkLiAgVGh1cyBhbnkgb3ZlcmxhcHBpbmcgYnl0ZXMNCj4gZ2V0IHRoZSB2YWx1ZXMgdGhhdCB0
aGV5IHNob3VsZC4NCg0KVGhhdCdzIHdoYXQgSSBjb2RlZCBvcmlnaW5hbGx5LCBidXQgYWZ0ZXIg
c2xlZXBpbmcgb24gaXQgZGVjaWRlZCBpdCBjb3VsZCBsZWFkIHRvIHByb2JsZW1zLiAgU2VlIGJl
bG93Li4uDQoNCj4gVm9pbGEsIG5vIGJ5LWhhbmQgbWVyZ2luZy4NCj4NCj4gPiAgICAgNjdmODog
ICAgICAgYzAgNDAgMjEgMWYgICAgIDFmMjE0MGMwIHsgICAgICB2MC51aCA9IHZzYXQodjAudXcs
djEudXcpDQo+ID4gICAgIDY3ZmM6ICAgICAgIDAwIDQ1IDAyIGExICAgICBhMTAyNDUwMCAgICAg
ICAgbWVtYihyMisjMCkgPSByNQ0KPiA+ICAgICA2ODAwOiAgICAgICAwMiBjMCAwNCA5MSAgICAg
OTEwNGMwMDIgICAgICAgIHIyID0gbWVtYihyNCsjMCkgfQ0KPiA+DQo+ID4gVGhlIHZzYXQgaW5z
dHJ1Y3Rpb24gcmVxdWlyZXMgYSB2ZWN0b3IgY29udGV4dC4gIElmIHRoZSB0aHJlYWQgZG9lc24n
dCBoYXZlIGENCj4gdmVjdG9yIGNvbnRleHQsIGFuIGV4Y2VwdGlvbiB3aWxsIGJlIHJhaXNlZC4g
IFRoZSBPUyBjYW4gcHJvdmlkZSBhIGNvbnRleHQgYW5kDQo+IHJlcGxheSB0aGUgcGFja2V0Lg0K
Pg0KPiBTdXJlLg0KPg0KPiBJcyB0aGVyZSBhbnkgcGVyLXBhY2tldCBleGNlcHRpb24gcHJpb3Jp
dHkgdGhhdCB3b3VsZCByZXF1aXJlIGEgZmF1bHQgZnJvbSB0aGUNCj4gc3RvcmUgdG8gYmUgcHJv
dmlkZWQgaW4gcHJlZmVyZW5jZSB0byB0aGUgZmF1bHQgZm9yIHRoZSB2ZWN0b3IgY29udGV4dD8N
Cg0KSSBkb24ndCB0aGluayB0aGVyZSdzIGEgcHJpb3JpdHkgZm9yIHRoZSBleGNlcHRpb25zLiAg
SW4gdGhpcyBleGFtcGxlLCBhbnkgb2YgdGhlIDMgaW5zdHJ1Y3Rpb25zIGNvdWxkIGdlbmVyYXRl
IGFuIGV4Y2VwdGlvbi4gIFRoZSB0aGluZyBJJ20gd29ycmllZCBhYm91dCBpc24ndCB0aGF0IHRo
ZSBzdG9yZSBjb3VsZCBnZW5lcmF0ZSBhbiBleGNlcHRpb24uICBUaGUgcHJvYmxlbSBpcyBsZXR0
aW5nIHRoZSBzdG9yZSBjaGFuZ2UgdGhlIG1hY2hpbmUgc3RhdGUgYmVmb3JlIHdlJ3JlIHN1cmUg
bm9uZSBvZiB0aGUgaW5zdHJ1Y3Rpb25zIHdpbGwgcmFpc2UgYW4gZXhjZXB0aW9uLiAgTWF5YmUg
SSdtIHdvcnJ5aW5nIGFib3V0IHNvbWV0aGluZyB0aGF0IHdvdWxkIG5ldmVyIHJlc3VsdCBpbiBk
aWZmZXJlbnQgYmVoYXZpb3IgLSBpZiB0aGUgcGFja2V0IGdldHMgcmVwbGF5ZWQsIHdlJ2xsIGp1
c3Qgc3RvcmUgdGhlIHNhbWUgdmFsdWUgYWdhaW4uDQoNCkknbGwgcmVhY2ggb3V0IHRvIHRoZSBh
cmNoaXRlY3RzIGFuZCBhc2sgaWYgdGhlcmUgaXMgYSBjYXNlIHdoZXJlIGRvaW5nIHRoZSBzdG9y
ZSBmaXJzdCBjb3VsZCBiZSBhIHByb2JsZW0gLSBhbmQgYWxzbyBhYm91dCB0aGUgcHJpb3JpdHkg
b2YgZXhjZXB0aW9ucy4NCg0KDQo+IEFueXdheSwgSSdtIHN1Z2dlc3Rpbmcgb3JkZXJpbmcgdGhl
IG9wZXJhdGlvbnMgd2l0aGluIHRoZSBwYWNrZXQgdG8gYmUgb25lDQo+IHRoYXQncyBtb3N0IGNv
bnZlbmllbnQgZm9yIHVzLg0KDQpUaGlzIG1heSBvciBtYXkgbm90IGJlIHBvc3NpYmxlLiAgV2Ug
YWxyZWFkeSBoYXZlIHRvIHJlb3JkZXIgdG8gcHV0IC5uZXcgY29uc3VtZXJzIGFmdGVyIHRoZSBw
cm9kdWNlcnMsIGFuZCB3ZSBoYXZlIHRvIGtlZXAgdGhlIGNoYW5nZS1vZi1mbG93IGluc3RydWN0
aW9ucyBpbiB0aGUgb3JpZ2luYWwgb3JkZXIuICBTbywgSSdtIHJlbHVjdGFudCB0byBnbyBkb3du
IHRoaXMgcGF0aCB3b3JyeWluZyB0aGF0IHRoZXJlIHdpbGwgYmUgYSBsb25nIHRhaWwgb2YgY29y
bmVyIGNhc2UgYnVncyB0byBlbmdpbmVlciBvdXQuDQoNCg0KDQo=

