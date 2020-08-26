Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6638920679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h74GfvH8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Li5RS06R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6638920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5Gu-00013r-Fc
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DV-0004Kn-2B
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:33 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54782)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DS-0003MY-Il
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485950; x=1630021950;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oaeB/g19SuqW6dQaul95ySmWWQT9XsGH9MJ0z25eHjE=;
 b=h74GfvH8R+f8iqTMelSTjBgUnF2WyUMH2JNDrIG5PztFhlRlaek8oRSO
 7gtnXVv9zn5gSg7/Ubt+L4sAiMJE1wR3tHSkFBcnzx4F/89PufrI+PC3m
 /Efzw7xADql8uI8paVWgnAXT3MaVCPQ2SebqbAFtbU1b38FZNKTXOq75c w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Aug 2020 16:52:29 -0700
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:52:29 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:28 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:13 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:13 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 10/34] Hexagon (target/hexagon) instruction and
 packet types
Thread-Topic: [RFC PATCH v3 10/34] Hexagon (target/hexagon) instruction and
 packet types
Thread-Index: AQHWdXdeG6VSJBd4o0K1OB5wy5qzF6lKfZYAgABtBkA=
Date: Wed, 26 Aug 2020 23:52:12 +0000
Message-ID: <BYAPR02MB4886103238878540CD1374EADE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-11-git-send-email-tsimpson@quicinc.com>
 <182cb39f-7a49-22e4-141c-a3df790b56ab@linaro.org>
In-Reply-To: <182cb39f-7a49-22e4-141c-a3df790b56ab@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6350ad10-e103-43c4-ae41-08d84a1b0dfd
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB49523F456318314E516B7601DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +hW3rhJKyBp06wk3wjHh5bajWy9uwg4IQKkg5A1xTuY2zMBQA9kkFez1j/ZuTTkRW1biyh3GFF8c7JmmeBz0zdMPU8zS3D7WwHPgAkVvrxK5fkHrtr53Ymf1ZBjK2g774kN7dtfrExA+MyJesBJEaaugHBrh2PbK/Rr/xFPR4n9i/EpROHCVNVWLAQqYYgC89cvOd/c0XaMpiWasNuQRajLx6+FHVK5GIUAjHZAl6bvnYcXtZ4SOVjIP9Ij6hYf0xXpN7DGCZC8FqquG1RuXOF9OfFESOcLmxplOlX50qMjnWnDNzvPmvFLdNyGmgVZR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nCfkmA8YdK973GthlTXxItCZrGgXB+9qFaVEbqP1JVnDso3sK8Y3FtDZv2n1q2VkWwtQJvSCseY1ieqKpMNlE8U3OGQT4HGuJwH0mk4X5wVoxxFkfnxAmNaL1RnUREyWHJufMXop6y1Ownp+rZEEH3ap9MNMuy0XqRxPj3k5GHABxH61G3Cwc69jn4YzZ1WzdQEdb544CJkyU+5uwR2YYrQXFZfvWNCRiGH1vyRU/hdiOsZwJxVjVHFAdFvjDLYVdXxSKl4ivNJF/remAVMebHvKrmO/kEJ3r3kEazHca8ihHuY1rZ+K0ZTxhwaFdmevquwqo2zFzjVq+ez4E9nD5HrTlkb6M5xK64CNgHxdKQOFy7xSKQR7wKw7E5OhjNfwOFZPnDlPhfDQpV0j7S9JVgux9gnxOz9e7er29SDQIQLI3KhnjYI3Xp62/ZjDEIjvpuFZ70D1Ovhi0cKmnT88I6kpiwYhtmuzt5pQCQjQ6MUP+MAWf4iFj4wv12OXYIEb37+xY5Z9TSdxNPrO+Mq/Te9bM8AnQGoEOOLiBxw4BGMG4qHrcBjKuEWj7JL2/gBgaWun0hSGfPWqphYphpPCU6ih8382U/aoL5hhYxGc9l25PW2jBbSKsfvDzGY2dYO0/52xAENMai/dLqKOzrd94A==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3AiDbYPUso0qRNRhAzZKBkH3VBlMdt24n9RT0RWQGZv13LMWNjiBeysWanAxdPOZlX2/QMqBihDxNhHeRLAvM/fqUqzdMBHQUauTAK6S0sM5HVFIiMvpJeW6EosV0IVcIg0i11CbEe3PWJYwfaCckKc+LyorVrIij/EY6/ax0cChzMyt+EgoZrnISIOiGKNFB10IT/cHTWv3eTYonTd52e9cBW1YaZay0JYBO5qX3jLaUypsTw6H+L4qt4d6Ly3hNWuEdhYKwqvyzQdNK7tknwPUUKo8UKSR2Yi0fBgQTMSi6makhvNpnnsKYDcnb5nnsi1RBZBr6F3yowacwBJEA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlZxc1DvliGSxqmC8d8nRYfGeKpYzhoPzjWtDw6MocU=;
 b=nwtNJTvXRyy8Lc+DprP82FVYaTUp7MVWveYRVTnaWp8NoFWdH9YVE87ZFJI3zY+m80IlK0DF8pATxibS07/OcEylwylmd30Qyb1bQZn1lMBMPGx8f+/QzTcJBcTcVfnB28VRX5/Wo/0OGyyKQ61I5WlPdJJQW77Dhiqr7TwiDFyaczmL9sg67LvSLJyC7CDh0cnNznws+PZi9der81LMlWY40wa+5lhvw+Imo2WCDx1Tx6YwgsGYD5mui2jsDAJBoQikYGgAB+2aP89o+HFp1XpvnYbD23cdg+IAubYKQ2aRrehJGygngHZRXkfC4GpH7EESmiVKkgF1HeTfrIEDMg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlZxc1DvliGSxqmC8d8nRYfGeKpYzhoPzjWtDw6MocU=;
 b=Li5RS06RArkb5IiKdE6Ex3609F8oKKyXhN9i5FfkAlDJGSxJkdrboUJhHk8DmwgWorKh87ZrXtptfv4+6sasfkmwUeKubAuQYhzUSw9bXKXKBDGvkq6PC4sQlRok6VHOKEXUJWNbSYEgJCkjdzcqM57oIUI2ewWa9HSXTnvvyEM=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 6350ad10-e103-43c4-ae41-08d84a1b0dfd
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:13.0007 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Dg9Ysxy6sf6c+zX2TZX2zr8Kw5e4PXwumFiRdBmMAFDh/fPFVynBqzwyVADQ6dqee6S/r3dM5MiCjLQpADWwew==
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI2LCAyMDIwIDg6MjIgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogYWxlQHJldi5uZzsgcmlrdS52
b2lwaW9AaWtpLmZpOyBsYXVyZW50QHZpdmllci5ldTsgcGhpbG1kQHJlZGhhdC5jb207DQo+IGFs
ZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAx
MC8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIGluc3RydWN0aW9uIGFuZA0KPiBwYWNrZXQg
dHlwZXMNCj4NCj4gT24gOC8xOC8yMCA4OjUwIEFNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4g
PiArc3RydWN0IEluc3RydWN0aW9uIHsNCj4gPiArICAgIHNlbWFudGljX2luc25fdCBnZW5lcmF0
ZTsgICAgICAgICAgICAvKiBwb2ludGVyIHRvIGdlbnB0ciByb3V0aW5lICovDQo+ID4gKyAgICBz
aXplMXVfdCByZWdub1tSRUdfT1BFUkFORFNfTUFYXTsgICAgLyogcmVnIG9wZXJhbmRzIGluY2x1
ZGluZw0KPiBwcmVkaWNhdGVzICovDQo+ID4gKyAgICBzaXplMnVfdCBvcGNvZGU7DQo+ID4gKw0K
PiA+ICsgICAgc2l6ZTR1X3QgaWNsYXNzOjY7DQo+ID4gKyAgICBzaXplNHVfdCBzbG90OjM7DQo+
ID4gKyAgICBzaXplNHVfdCBwYXJ0MToxOyAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKiBjbXAtanVtcHMgYXJlIHNwbGl0IGludG8gdHdvIGluc25zLg0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHNldCBmb3IgdGhlIGNvbXBhcmUgYW5k
IGNsZWFyIGZvciB0aGUganVtcA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
Lw0KPiA+ICsgICAgc2l6ZTR1X3QgZXh0ZW5zaW9uX3ZhbGlkOjE7ICAgLyogSGFzIGEgY29uc3Rh
bnQgZXh0ZW5kZXIgYXR0YWNoZWQgKi8NCj4gPiArICAgIHNpemU0dV90IHdoaWNoX2V4dGVuZGVk
OjE7ICAgIC8qIElmIGhhcyBhbiBleHRlbmRlciwgd2hpY2ggaW1tZWRpYXRlDQo+ICovDQo+ID4g
KyAgICBzaXplNHVfdCBpc19lbmRsb29wOjE7ICAgLyogVGhpcyBpcyBhbiBlbmQgb2YgbG9vcCAq
Lw0KPiA+ICsgICAgc2l6ZTR1X3QgbmV3X3ZhbHVlX3Byb2R1Y2VyX3Nsb3Q6NDsNCj4gPiArICAg
IHNpemU0c190IGltbWVkW0lNTUVEU19NQVhdOyAgICAvKiBpbW1lZGlhdGUgZmllbGQgKi8NCj4g
PiArfTsNCj4NCj4gSXMgdGhpcyBhbiBpbXBvcnRlZCBmaWxlIG9yIG5vdD8NCj4NCj4gSWYgaXQg
aXMgbm90IGltcG9ydGVkLCBJJ2QgdmVyeSBtdWNoIHByZWZlciB0aGF0IHdlIHN0aWNrIHRvIHRo
ZSBzdGRpbnQuaCB0eXBlDQo+IG5hbWVzLg0KDQpBZ3JlZWQuICBNeSBnb2FsIGlzIHRvIHN0aWNr
IHdpdGggc3RkaW50LmggdHlwZXMgb3V0c2lkZSB0aGUgaW1wb3J0ZWQgZGlyZWN0b3J5LiAgSSds
bCBjaGFuZ2UgdGhpcy4NCg0K

