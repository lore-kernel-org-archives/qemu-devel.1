Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63068C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CED420679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SatZJl6w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Z/NIHWJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CED420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5IU-0003qx-Fa
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DW-0004MJ-DY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:34 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54792)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DT-0003Mg-V8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485951; x=1630021951;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p21gN43xOp5oy75Ur1wvb0ovOLYP5K7OOl4lVrtfjCU=;
 b=SatZJl6wjAWy8QxqkGfCiT5G9jDJe23Ih6lpgq93m0Ob2O7PESAO8K8E
 6dKr5UD0Hg+a1PIZsf1rKqqsQ6HIUuqTgRLlRGA4bPltgBAvlrYJo78dA
 QrWxpHnPr0Mn2EBF9N191UBJp1tacFSn/FbIAyE+3XGU0n6qdFK5X+lMD 0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Aug 2020 16:52:30 -0700
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:52:30 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:29 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:24 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:24 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 14/34] Hexagon (target/hexagon) instruction/packet
 decode
Thread-Topic: [RFC PATCH v3 14/34] Hexagon (target/hexagon) instruction/packet
 decode
Thread-Index: AQHWdXdiehsqeVd/lU6J35ayRTWfQKlKigeAgACHPSA=
Date: Wed, 26 Aug 2020 23:52:24 +0000
Message-ID: <BYAPR02MB488651BF66F1984786D2A1CBDE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-15-git-send-email-tsimpson@quicinc.com>
 <c1334480-b2cd-0c85-e55c-a76244b295ed@linaro.org>
In-Reply-To: <c1334480-b2cd-0c85-e55c-a76244b295ed@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3b7bbac-96e6-494a-3409-08d84a1b14b4
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB4952E4F80751F852A8D31F0CDE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVjSOiuavcS30tkUbEbY6fKgo+2I8MPcSZa5e50slUupKJpXg6CWKsrWQqS21PO+S9bRkqPIkPnMFfYTbf8gNo+heCMVZ98V+jzX+djUb3z/vKtIqS/K5w7xZxXUdRM+TZz8EiT96sgXNkVZcWG93qwasNxXaTraMwo4ojkX0joBANqRoUVUGozeZUglBfqsJQ9BecCiKFJm53vREE/sj6wUdDY+GUrt0+w4sjRSQWmgSgscA/cJpUA/GKfLoijk2S11ExmiUBW88Q1ExKZy2xD6l6c/PRVY70CLduqIuIYGJdw3u9gUNrGP/MKNpXnwllDlgJ7OkErur+7lqNGFzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: pNQA6dXL6mTBwQRAZLsPkBFtPUirxvWKrsc+0iGtt8fpzHnGIvbG14knuigsc5E0boI6p528iJZR6RZadvADnfHTOGCy8fLFkgVYa/xAjRCP/LofP/3IqBVAMQ9A36ekzB7M7aLK6GIHYDKsvVu8oLrF69ZqIw7wSZdjFWhuw4n9jdN0B0SnlKC8Pq1yg+TkYQmFlHVX/jpNrGdGgiIndsgXUSZytHGOfOVsRT836pS1fYLiNaFWQ5jMZdOzfKUC44ZdB/nVhMZNhPopBan9aZkEj7kq6rXDu5M4iplZjrwO2OQYgfJRgQlr/11ssGPy5WdwmZIznseWOzER1TGhJOZMka5vaHUgpZ2meNTR4QhEf/gWK5ar5eZtCaT9tkRAe92Aj3S/ZLw7527Y7YYPau0JHMyLUr+zL183S5VNs/n3joNs+YW/jtQlkzjpn3+QYmxQAng96Jd1NIo+nijMLxzHmQsa8sDS2MPoqPKiUo3kWg0eIOrXGdrkR1qZTcXvr1U/pd1Hpw4dyr+9Be+uOD1pSocS/tFd/ASSM912UDTi5M/7XFcMPWuJhoupT8/+AGLOYsZv1VTlho7jJpEe0e8H4vSHbonvYUrtcoAbtmb1XYwuWmren7lXlTWxkdEBSslVj8wSyXmn22lW8RQjVw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2d4ptni0G/YonjnE6Roy84BCNbpJIGNlzJEt9xD6oelDFKqHabiOBgF9TiCzT9e0qkZpciUhIUbHPyrRCaNx5RlcDwUH6kMvGowz+i71TfIbzSYIzsN/zzYkZBH5076mBDMf+8CcYvnEgKXr8BmD+yW9ZLHxA1U6E6Hp5/TXVGhwOmwWlGtWueaWl1J7xp/d1y7/Hh0ugMpDGGVHzUrW0n4x9wcDozHdWbi+nv8mOcfosQbzIcRDTU/0DpD9jbJ5lSDRfoS43bpOpw+G7pG6b6yb/Nt5LMoAgG3OeN9elVzszbSzeArIK1PNJDJrXAduwraTsYfCOkFs/ppH2Nnvg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbum5s5JT66UM6a+pmMHYVPR73riTxsc/FeQLd2AqRI=;
 b=C5glTJYY/+MDJtqhwhMwss9Z2A+kow3Zt5/aPmFhESrtD4sBCyuhQALZFr9TvqWo7NpBwqm1WCvSfQB+oUrkfk/giNK9JYrRzzkg9wS/KIVUr1F+4UjI+b8WnOBVWewcJbZla89+VwCO3onyv7EqsgaEKMBYbKkiXfrFMj5eM7h6qXL3d5zs/qUiil9I481T0AEWFS6LORXQRcqoBLpapRIXKKVrkKZNVZ5dvXQwIXuE2a0axm3ngM+1DwCXhNPzzxhtB6vMAAawyzWwAK63RKd73+sVRNrXkQqA8MgcQfYF/qBaQXPJD88lnh72qDa/r0eEdxD+0HQkEiLKCuQiFQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbum5s5JT66UM6a+pmMHYVPR73riTxsc/FeQLd2AqRI=;
 b=Z/NIHWJVQULg8eEECsWNGTvJTHFQK1qKUsDBEc5cpFExE9SvCURuuCCKky1Ex2Zr1IvOIE1UUj0iPhzbKvu9Lz1ELZHr0h33yC9vXDwvRFkEwdjSJQ3gfXd12prQ8oNjiJkIZy1PFgDOlr3Uf32tt430Y2MjvV2d+hmT36Ybl5M=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: d3b7bbac-96e6-494a-3409-08d84a1b14b4
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:24.3262 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: AIpvhIQH5DUCpJHQb7YemFZEZNfdMR1FeO6jj2APE+jPnxrJejvITCDX7DvWb/ikuy3LVS2l0zLAI/W+uRMplQ==
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
dXN0IDI2LCAyMDIwIDk6MDcgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAx
NC8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pDQo+IGluc3RydWN0aW9uL3BhY2tldCBkZWNv
ZGUNCj4NCj4gT24gOC8xOC8yMCA4OjUwIEFNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4gPiAr
I2RlZmluZSBERUNPREVfTkVXX1RBQkxFKFRBRywgU0laRSwgV0hBVE5PVCkgXA0KPiA+ICsgICAg
c3RhdGljIHN0cnVjdCBfZGVjdHJlZV90YWJsZV9zdHJ1Y3QgZGVjdHJlZV90YWJsZV8jI1RBRzsN
Cj4NCj4gQWxsIG9mIHRoZXNlIGxpdHRsZSBzdHJ1Y3R1cmVzIHNob3VsZCBiZSBjb25zdC4NCj4N
Cj4gV2hpY2ggcHJvYmFibHkgcmVxdWlyZXMgdGhlc2UgbGlua3MgdG8gYmUgY29uc3QsIGFuZCBh
IGZldyB1c2VzIHdpdGhpbiB0aGUNCj4gZnVuY3Rpb25zIHRoYXQgdXNlIHRoZW0uDQo+DQo+IFRo
YXQgc2hvdWxkIG1vdmUgNzhLIHdvcnRoIG9mIHRhYmxlcyBpbnRvIC5kYXRhLnJlbC5ybywgd2hl
cmUgdGhleSBjYW4ndCBiZQ0KPiBtb2RpZmllZCBhZnRlciByZWxvY2F0aW9uLg0KDQpPSw0KDQo+
IEkgY2FuJ3QgaGVscCBidXQgdGhpbmtpbmcgdGhhdCBhbGwgb2YgdGhpcyBzdHJpbmcgbWFuaXB1
bGF0aW9uIGlzIG5vdCB0aGUgbW9zdA0KPiBpZGVhbCB3YXkgdG8gaW1wbGVtZW50IGEgZGVjb2Rl
ci4gIFN1cmVseSBhbGwgdGhpcyBjYW4gYmUgcHJlLXByb2Nlc3NlZCBpbnRvDQo+IGNvZGUsIG9y
IGZsYWdzLCBvciBhbiBlbnVtZXJhdGlvbiBvciBzb21ldGhpbmcuDQoNCkknbGwgaGF2ZSB0byB0
aGluayBhYm91dCB0aGlzIG9uZS4NCg0KPg0KPiBPaCwgYW5kIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCkgd2lsbCBuZXZlciByZXR1cm4uICBZb3UgZG9uJ3QgaGF2ZSB0byBrZWVwDQo+IHB1dHRpbmcg
cmV0dXJuIHN0YXRlbWVudHMgYWZ0ZXIgaXQuICBQbGVhc2UgcmVtb3ZlIGFsbCBvZiB0aG9zZSwg
ZXZlcnl3aGVyZS4NCg0KT0sNCg0KPiBJJ20gZ29pbmcgdG8gaWdub3JlIHRoZSByZXN0IG9mIHRo
ZSBkZWNvZGVyLCBhcyBpdCdzIHNvbWV3aGF0IGJld2lsZGVyaW5nLg0KPiBFdmVuIGluIHRoZSBm
aW5hbCBwYXRjaGVzLWFwcGxpZWQgZm9ybS4gIEl0IGNvdWxkIHJlYWxseSB1c2Ugc29tZSBtb3Jl
DQo+IGNvbW1lbnRhcnkuDQoNCk9LDQo=

