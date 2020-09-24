Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6142C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 02:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4FC21D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 02:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XjOSUu+u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="bOyLQx1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4FC21D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLH80-0003YY-DM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 22:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kLH7B-00030q-Au
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 22:36:09 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:65458)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kLH76-0005cW-UL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 22:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1600914964; x=1632450964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3XVXiRGAyyEssK0zs0SkFp33kMftDSv24Ai49Bwxgg0=;
 b=XjOSUu+uvgIFuoSyMiW9Meoq7VK8d64eK292Ha8EurTZ/+Wia/tuWZ3O
 Y6UErwL3J1muhqDKzyoPb4IabB61zPxdAsH2FJGrT2dFeGfQlGFFmLhC/
 AgtHwcIWR8r/CFgDWLdf+Dx3wRc7ICpE2PC/ykymsqnfBlhRCJ9YGh/L7 I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Sep 2020 19:36:02 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Sep 2020 19:36:01 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Sep 2020 19:36:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 23 Sep 2020 19:36:00 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6771.namprd02.prod.outlook.com (2603:10b6:a03:200::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 24 Sep
 2020 02:35:59 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3391.025; Thu, 24 Sep 2020
 02:35:59 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 34/34] Hexagon build infrastructure
Thread-Topic: [RFC PATCH v3 34/34] Hexagon build infrastructure
Thread-Index: AQHWdXdnf3xeB8RkxEmUJuAY0ZgZWKlOe4wAgCjLdYA=
Date: Thu, 24 Sep 2020 02:35:59 +0000
Message-ID: <BYAPR02MB48860076D3E65C99C4D7396EDE390@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-35-git-send-email-tsimpson@quicinc.com>
 <bf3c6520-b64c-f977-d20f-a1718455b44b@linaro.org>
In-Reply-To: <bf3c6520-b64c-f977-d20f-a1718455b44b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9fdc0ce-b068-438c-15f5-08d8603292ba
x-ms-traffictypediagnostic: BY5PR02MB6771:
x-microsoft-antispam-prvs: <BY5PR02MB677150A82D6C38AC40425C1FDE390@BY5PR02MB6771.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnB874aLK3PVtTGhFo93+PJ2cemeDJdFNcKFHGHFUwrZmqPjCRP34C1HNvhXUhmWnvavB6TQfEqLZI27GpmOCk96qKT6NN5aLDOdg7wQ31jsTjNRTbLA8uveZMY6Re55u3Lv5w6CqQQjKYFXixIIuODMhGG0qzjW6KuN3YSnY1HggE53FZGUgWzZAFxej79qyeGnQ6XoR5sSPJsf1QdFx6zKGQOYb5pOp+qS6m/EM1y4jAZfodg7pP4acg2D12BgzfEzx758w20Ka6EWJrZzwTZTAJNguYYDW5SYwjZwzsUI9J1nSjyu+/zt1GhE6tVmE+jpmOJI2ww5OEHMApaEUpBsN/EwHlYXJ/8f2+3PvrzhL4nvAjnmGS9imsUz1mRK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(366004)(376002)(396003)(39860400002)(66446008)(66946007)(8936002)(66476007)(7696005)(76116006)(53546011)(26005)(478600001)(6506007)(186003)(64756008)(5660300002)(8676002)(4744005)(86362001)(54906003)(66556008)(71200400001)(4326008)(9686003)(52536014)(316002)(55016002)(33656002)(2906002)(110136005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IK2GCJtLWW+b/ECrPM704VVkcOaaj//FsJa1RfFOII0ysHBJNHpd7AUZir8CL7pvXJZTEuVuOtYo0BVPPs5AHN9VjK7ImnrmpUKhM6oM8S0R4jjKBs7YvLKKwJ9FZQtkLeCtE8od7cvNYWtQXpe6Pvj5O6Z1IrmDkvf6rul+d9VMaVoTFCl7OqHpLb9yjDxzoLtlRs4CzslCsXui/N1HzGjbitrQ0f/AYgvS8ofpBl4aZ+2Mbpu6ALGOuHbhwPSaDVCLFmuglxbG58zHttDkUzZ5guTuvBNIliT6QQ5iE5kUX4AzVUzbFy6VMd2EPYZFtL8K8bFXO78uDV7zl8dixXeQL5m3NtjG9DBJ1afFRU5Otc9NnGGMq7ABD4/NzSkbajUrxByNkpCzYex7lQICmtscmXKDXjgahDI+UhVexzXLHUolQF2xFyDjm5UULkIJCl8LSg7vdWYc5IrJH24M7ugzyBBNBskaHfoZlKBYio9aQrh1yyrSg3cVOkTH0heJMZiJmnKUbRx+lLnfru9ZQHzXuc7pqo2NRAjkLo53wqVEM6eY0ZYH04u7rguVWI4uZZh7R8toAPZe7gOpjnHlt+rIfzOIo2FRw7L11vbjPiDzUyPk/fdHI5WRcXb1TJUsv5kE3pbn0/LeV8irDta0Ew==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koMLANjelMcrt2x2aEttwTRvrAGW37EB5UcSAJ3lyGZeI8eh6ITi5c28OEB7/k+ySWF2upQr7brLMAaJkFlSVuyhm8ZKHUBUdA9tKRe8cqaox5ZnFWlNmz1xLB/P0X1t4i1xv27dcp3nYo+WWBcs4Ld3YzUmlSveX6K8TylObSW5LuswEaT/lTuh/WiBOGpC0Y6hHceUSpItCW8H76G5ThP8t/u6X16DlAVCx3qdJlCAswQbVaxIlpDo8sBTURGfVB541CDEZ50qZgIepPrSzXx+RxSnxfXxWvNL9Z+9BSdoxsN9cVzmGb2yGJ9J8Va/lQeKitkCuInq1zf3fcClyQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pArx0D3wd0WHK9NeQ71layA1ks/Hb0OB0BCB7Djd94U=;
 b=G4jWMJXTdFtRd9SGKKvnI2SQNFg1+zxt3tI+yepPNtSw1uumCJA8NqYb/cfg84GKG5TnL7A4Ic5Cdur+1BoNgfaaU8G2iguCrPk/trKpyFd5sk25cJNtzCMkwDTxSb62MAT+DXnilJ+8WkmBm8+cYB1onP24PpKeXLzDQXhqifGDgdVCjVD4YEKrXv8Up3PiuPWZJwggUGjCbpIK9vIrVegAbOjoI1CRsoaaeUhEADfRlG0DL2he6gRCBbRtvvnk0bJ2npI//LKSbKhNXMgRy16I6cp2Qsgspq6okzGlVs7fG9R9cY5S/kYkI+bs5e0SPmWQfSJXectaRuHRzAs/Wg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pArx0D3wd0WHK9NeQ71layA1ks/Hb0OB0BCB7Djd94U=;
 b=bOyLQx1bnSPUp++3VCidWtEfEVWpcCR9dNHHhFr+MB2x6gZR2hasegbCn1Ko7o7CP6zfNFtJekc7KgMXwY2v3xxWDeHUgaZXFuoj0qK5Uw9VIp4qTmOkUeUoy1z5SL5ite2N+LuY8HhY8nisS8L9XK/gsSqrEvb+i5Gf296Jd6A=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f9fdc0ce-b068-438c-15f5-08d8603292ba
x-ms-exchange-crosstenant-originalarrivaltime: 24 Sep 2020 02:35:59.6436 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 4Dkw7KM2KULccgylsSU9oZKZ5gocwj+GMdQussA2xiLhUOalsR0ni93OrGi0hRsejGe/DUACRIFlWZFNgGIWyQ==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6771
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 22:36:02
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDI4LCAyMDIwIDk6MjAgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzNC8z
NF0gSGV4YWdvbiBidWlsZCBpbmZyYXN0cnVjdHVyZQ0KPg0KPiBUaGlzIHdpbGwgaGF2ZSB0byBi
ZSB1cGRhdGVkIGZvciB0aGUgbWVzb24gY29udmVyc2lvbi4NCj4NCj4gSSBkb24ndCB1bmRlcnN0
YW5kIGl0IGFsbCBteXNlbGYsIGFuZCBhbGwgb2YgdGhvc2UgZ2VuZXJhdGVkIGZpbGVzIHdpbGwg
bmVlZA0KPiBzcGVjaWFsIGF0dGVudGlvbi4NCj4NCg0KSSd2ZSBtYWRlIHRoZSBjaGFuZ2VzIGZv
ciBtZXNvbiwgaW5jbHVkaW5nIGNvbnZlcnRpbmcgdGFyZ2V0L2hleGFnb24vTWFrZWZpbGUub2Jq
cyB0byB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCwgYW5kIEkgY2FuIGJ1aWxkIHFlbXUtaGV4
YWdvbiB3aXRoDQogICAgbWtkaXIgYnVpbGQNCiAgICBjZCBidWlsZA0KICAgIGNvbmZpZ3VyZSAt
LXRhcmdldC1saXN0PWhleGFnb24tbGludXgtdXNlcg0KICAgIG1ha2UNCg0KSG93ZXZlciwgd2hl
biBJIHJ1biAibWFrZSBjaGVjay10Y2ciLCBub3RoaW5nIGFjdHVhbGx5IGhhcHBlbnMuDQogICAg
ICBCVUlMRCAgIFRDRyB0ZXN0cyBmb3IgaGV4YWdvbi1saW51eC11c2VyDQogICAgR2VuZXJhdGlu
ZyBxZW11LXZlcnNpb24uaCB3aXRoIGEgbWVzb25fZXhlLnB5IGN1c3RvbSBjb21tYW5kDQogICAg
ICBSVU4gICAgIFRDRyB0ZXN0cyBmb3IgaGV4YWdvbi1saW51eC11c2VyDQoNCldoYXQgYW0gSSBt
aXNzaW5nPyAgSGFzIHNvbWUgb3RoZXIgY29tbWFuZCByZXBsYWNlZCAibWFrZSBjaGVjay10Y2ci
Pw0KDQpUaGFua3MsDQpUYXlsb3INCg0KDQo=

