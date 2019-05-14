Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D1C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33A3208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NTlyKGmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33A3208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWKy-0006kr-5C
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:15:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGp-0003NU-UX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGn-00022b-E5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:59 -0400
Received: from mail-ve1eur01on072b.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::72b]:39198
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGg-0001pj-PI; Tue, 14 May 2019 08:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=K/zUYUKsAM5aVkIisRlci6D62ji3clpG26Ilc5jZaBc=;
	b=NTlyKGmqLjxYIw28vS3mlBODY1Hryl/dWplgQVtRU9u7tl8N1aFHEtUIm7dUH++ZfuRIv//sdBAtuhI1JjJ7E0De4dH1kkaO/YnJD7S4n1EPbvtHgHCFCNAAMntD8wZZ2qm7UMCovQYuFi/cYE2hw8Bz1dIh99Te0bm7Z5KYVhc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4480.eurprd08.prod.outlook.com (20.179.27.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:40 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:40 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 0/9] discard blockstats
Thread-Index: AQHVCk4LHMttZCqeQUeaJK/Q2TMYQA==
Date: Tue, 14 May 2019 12:10:40 +0000
Message-ID: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0057.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5806d194-01c3-4e10-4ca4-08d6d8652e3f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4480; 
x-ms-traffictypediagnostic: VI1PR08MB4480:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <VI1PR08MB44800DB32A69E84326036C0EF8080@VI1PR08MB4480.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39850400004)(189003)(199004)(186003)(86362001)(6116002)(486006)(3846002)(66066001)(4326008)(256004)(52116002)(316002)(26005)(44832011)(36756003)(6512007)(966005)(6486002)(25786009)(6506007)(14444005)(478600001)(102836004)(6916009)(386003)(2351001)(54906003)(64756008)(66446008)(66556008)(5640700003)(7736002)(6306002)(14454004)(2616005)(2906002)(73956011)(53936002)(476003)(71190400001)(71200400001)(99286004)(107886003)(66946007)(66476007)(2501003)(305945005)(6436002)(8936002)(1076003)(81166006)(81156014)(8676002)(5660300002)(50226002)(68736007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4480;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G3E/3srAszU1FI5GTjgSDk7DxD3y+mlp/1AEmrh7zaK+lAPvEPvCPQPFEXG/ASD56QnU1u68J8OZd9wyGLClDPu4IJc6hXyPrz2aBT2veIO2rs9pYGkiV+HWWZP27v+IpZlyA32TYPzNtkD2Ju8IB3KAId2WdlV7VqkY/fCGjrjSPqP08xPlJVa528YTmnEFfuHmrGGP7mSRGs5Wtwo+e84ktkxHfBaHW5bPtJRAdasAXJzMZf1wgegdR/FllVswRlw1OdG4djr87QLCnJ1qMvIzj68o3mNOg/nqiejGnf9wM0vbgVNVOoDWSkm89bwb7BI9a4cDuRjO9OsKPwx29pDl1CMD6LdWPOGQWxkpAORtR16aUiHTlS5tRhQJ6Ma6L952WOrEkn9Y/fwi4U/su0CmtWY2uh26fVD+xIH6f8E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5806d194-01c3-4e10-4ca4-08d6d8652e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:40.2143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::72b
Subject: [Qemu-devel] [PATCH v7 0/9] discard blockstats
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

aGksDQoNCnlldCBhbm90aGVyIHRha2UgZm9yIHRoaXMgcGF0Y2ggc2VyaWVzOyBwbGVhc2Uga2lu
ZGx5IGNvbnNpZGVyIHRoZXNlIGZvciA0LjENCg0KSnVzdCBhIGZldyBjb3NtZXRpYyBjb21tZW50
cyB3ZXJlIHJlY2VpdmVkIGZvciB2NiBzbyB0aGlzIGlzIG1vc3RseQ0KYSByZWJhc2UrcGluZy4N
Cg0KbmV3IGluIHY3Og0KICAgIC0gZ2VuZXJhbCByZWJhc2UNCiAgICAtIHNpbmNlIGNsYXVzZXMg
LT4gNC4xDQogICAgLSBwYXRjaCA4OiBub3QgY29tcGxldGVseSB0cml2aWFsIHJlYmFzZTogcmF3
X2FjY291bnRfZGlzY2FyZCBtb3ZlZCB0bw0KICAgICAgY29tbW9uIHJhd19kb19wZGlzY2FyZCgp
DQogICAgLSBwYXRjaCA5OiBjb21tZW50IHdvcmRpbmcgZml4ZWQNCg0KdjY6IGh0dHA6Ly9saXN0
cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMTEvbXNnMDY2MzMuaHRt
bA0KdjU6IGh0dHA6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIw
MTgtMTAvbXNnMDY4MjguaHRtbA0KdjQ6IGh0dHA6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMTgtMDgvbXNnMDQzMDguaHRtbA0KdjM6IGh0dHA6Ly9saXN0cy5u
b25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMDYvbXNnMDM2ODguaHRtbA0K
DQotLS0tDQoNCnFtcCBxdWVyeS1ibG9ja3N0YXRzIHByb3ZpZGVzIHN0YXRzIGluZm8gZm9yIHdy
aXRlL3JlYWQvZmx1c2ggb3BzLg0KDQpQYXRjaGVzIDEtNyBpbXBsZW1lbnQgdGhlIHNpbWlsYXIg
Zm9yIGRpc2NhcmQgKHVubWFwKSBjb21tYW5kIGZvciBzY3NpDQphbmQgaWRlIGRpc2tzLg0KRGlz
Y2FyZCBzdGF0ICJ1bm1hcF9vcHMgLyB1bm1hcF9ieXRlcyIgaXMgc3VwcG9zZWQgdG8gYWNjb3Vu
dCB0aGUgb3BzIHRoYXQNCmhhdmUgY29tcGxldGVkIHdpdGhvdXQgYW4gZXJyb3IuDQoNCkhvd2V2
ZXIsIGRpc2NhcmQgb3BlcmF0aW9uIGlzIGFkdmlzb3J5LiBTcGVjaWZpY2FsbHksDQogLSBjb21t
b24gYmxvY2sgbGF5ZXIgaWdub3JlcyBFTk9UU1VQIGVycm9yIGNvZGUuDQogICBUaGF0IG1pZ2h0
IGJlIHJldHVybmVkIGlmIHRoZSBibG9jayBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBkaXNjYXJk
LA0KICAgb3IgZGlzY2FyZCBoYXMgYmVlbiBjb25maWd1cmVkIHRvIGJlIGlnbm9yZWQuDQogLSBm
b3JtYXQgZHJpdmVycyBzdWNoIGFzIHFjb3cyIG1heSBpZ25vcmUgZGlzY2FyZCBpZiB0aGV5IHdl
cmUgY29uZmlndXJlZA0KICAgdG8gaWdub3JlIHRoYXQsIG9yIGlmIHRoZSBjb3JyZXNwb25kaW5n
IGFyZWEgaXMgYWxyZWFkeSBtYXJrZWQgdW51c2VkDQogICAodW5hbGxvY2F0ZWQgLyB6ZXJvIGNs
dXN0ZXJzKS4NCg0KQW5kIHdoYXQgaXMgYWN0dWFsbHkgdXNlZnVsIGlzIHRoZSBudW1iZXIgb2Yg
Ynl0ZXMgYWN0dWFsbHkgZGlzY2FyZGVkDQpkb3duIG9uIHRoZSBob3N0IGZpbGVzeXN0ZW0uDQpU
byBhY2hpZXZlIHRoYXQsIGRyaXZlci1zcGVjaWZpYyBzdGF0aXN0aWNzIGhhcyBiZWVuIGFkZGVk
IHRvIGJsb2Nrc3RhdHMNCihwYXRjaCA5KS4NCldpdGggcGF0Y2ggOCwgZmlsZS1wb3NpeCBkcml2
ZXIgYWNjb3VudHMgZGlzY2FyZCBvcGVyYXRpb25zIG9uIGl0cyBsZXZlbCB0b28uDQoNCnF1ZXJ5
LWJsb2Nrc3RhdCByZXN1bHQ6DQoNCihub3RlIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gYmxvY2tk
ZXZpY2UgdW5tYXAgYW5kIGZpbGUgZGlzY2FyZCBzdGF0cy4gcWNvdzINCnNlbmRzIGZld2VyIG9w
cyBkb3duIHRvIHRoZSBmaWxlIGFzIHRoZSBjbHVzdGVycyBhcmUgYWN0dWFsbHkgdW5hbGxvY2F0
ZWQNCm9uIHFjb3cyIGxldmVsKQ0KDQogICAgew0KICAgICAgImRldmljZSI6ICJkcml2ZS1zY3Np
MC0wLTAtMCIsDQogICAgICAibm9kZS1uYW1lIjogIiNibG9jazE1OSIsDQogICAgICAic3RhdHMi
OiB7DQo+ICAgICAgICJpbnZhbGlkX3VubWFwX29wZXJhdGlvbnMiOiAwLA0KPiAgICAgICAiZmFp
bGVkX3VubWFwX29wZXJhdGlvbnMiOiAwLA0KICAgICAgICAid3JfaGlnaGVzdF9vZmZzZXQiOiAx
MzQxMTY4ODQ0OCwNCiAgICAgICAgInJkX3RvdGFsX3RpbWVfbnMiOiAyODU5NTY2MzE1LA0KICAg
ICAgICAicmRfYnl0ZXMiOiAxMDMxODIzMzYsDQogICAgICAgICJyZF9tZXJnZWQiOiAwLA0KICAg
ICAgICAiZmx1c2hfb3BlcmF0aW9ucyI6IDE5LA0KICAgICAgICAiaW52YWxpZF93cl9vcGVyYXRp
b25zIjogMCwNCiAgICAgICAgImZsdXNoX3RvdGFsX3RpbWVfbnMiOiAyMzExMTYwOCwNCiAgICAg
ICAgImZhaWxlZF9yZF9vcGVyYXRpb25zIjogMCwNCiAgICAgICAgImZhaWxlZF9mbHVzaF9vcGVy
YXRpb25zIjogMCwNCiAgICAgICAgImludmFsaWRfZmx1c2hfb3BlcmF0aW9ucyI6IDAsDQogICAg
ICAgICJ0aW1lZF9zdGF0cyI6IFsNCiAgICAgICAgICANCiAgICAgICAgXSwNCiAgICAgICAgIndy
X21lcmdlZCI6IDAsDQogICAgICAgICJ3cl9ieXRlcyI6IDE3MDI5MTIsDQo+ICAgICAgICJ1bm1h
cF9ieXRlcyI6IDExOTU0OTU0MjQwLA0KPiAgICAgICAidW5tYXBfb3BlcmF0aW9ucyI6IDg2NSwN
CiAgICAgICAgImlkbGVfdGltZV9ucyI6IDI2Njk1MDg2MjMsDQogICAgICAgICJhY2NvdW50X2lu
dmFsaWQiOiB0cnVlLA0KPiAgICAgICAidW5tYXBfdG90YWxfdGltZV9ucyI6IDE5Njk4MDAyLA0K
ICAgICAgICAid3Jfb3BlcmF0aW9ucyI6IDE0MywNCiAgICAgICAgImZhaWxlZF93cl9vcGVyYXRp
b25zIjogMCwNCiAgICAgICAgInJkX29wZXJhdGlvbnMiOiA0ODE2LA0KICAgICAgICAiYWNjb3Vu
dF9mYWlsZWQiOiB0cnVlLA0KPiAgICAgICAidW5tYXBfbWVyZ2VkIjogMCwNCiAgICAgICAgIndy
X3RvdGFsX3RpbWVfbnMiOiAxMjYyNjg2MTI0LA0KICAgICAgICAiaW52YWxpZF9yZF9vcGVyYXRp
b25zIjogMA0KICAgICAgfSwNCiAgICAgICJwYXJlbnQiOiB7DQo+ICAgICAgICJkcml2ZXItc3Bl
Y2lmaWMiOiB7DQo+ICAgICAgICAgImRpc2NhcmQtbmItZmFpbGVkIjogMCwNCj4gICAgICAgICAi
ZGlzY2FyZC1ieXRlcy1vayI6IDcyMDg5NiwNCj4gICAgICAgICAiZHJpdmVyIjogImZpbGUiLA0K
PiAgICAgICAgICJkaXNjYXJkLW5iLW9rIjogOA0KPiAgICAgICB9LA0KICAgICAgICAibm9kZS1u
YW1lIjogIiNibG9jazAwOSIsDQogICAgICAgICJzdGF0cyI6IHsNCiAgICAgICAgWy4uXQ0KICAg
ICAgICB9DQogICAgICB9DQogICAgfSwNCiAgICB7DQogICAgICAiZGV2aWNlIjogImZsb3BweTAi
LA0KDQpBbnRvbiBOZWZlZG92ICg5KToNCiAgcWFwaTogZ3JvdXAgQmxvY2tEZXZpY2VTdGF0cyBm
aWVsZHMNCiAgcWFwaTogYWRkIHVubWFwIHRvIEJsb2NrRGV2aWNlU3RhdHMNCiAgYmxvY2s6IGFk
ZCBlbXB0eSBhY2NvdW50IGNvb2tpZSB0eXBlDQogIGlkZTogYWNjb3VudCBVTk1BUCAoVFJJTSkg
b3BlcmF0aW9ucw0KICBzY3NpOiBzdG9yZSB1bm1hcCBvZmZzZXQgYW5kIG5iX3NlY3RvcnMgaW4g
cmVxdWVzdCBzdHJ1Y3QNCiAgc2NzaTogbW92ZSB1bm1hcCBlcnJvciBjaGVja2luZyB0byB0aGUg
Y29tcGxldGUgY2FsbGJhY2sNCiAgc2NzaTogYWNjb3VudCB1bm1hcCBvcGVyYXRpb25zDQogIGZp
bGUtcG9zaXg6IGFjY291bnQgZGlzY2FyZCBvcGVyYXRpb25zDQogIHFhcGk6IHF1ZXJ5LWJsb2Nr
c3RhdDogYWRkIGRyaXZlciBzcGVjaWZpYyBmaWxlLXBvc2l4IHN0YXRzDQoNCiBxYXBpL2Jsb2Nr
LWNvcmUuanNvbiAgICAgICB8IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tDQogaW5jbHVkZS9ibG9jay9hY2NvdW50aW5nLmggfCAgMiArDQogaW5jbHVkZS9ibG9jay9i
bG9jay5oICAgICAgfCAgMSArDQogaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCAgfCAgMSArDQog
YmxvY2suYyAgICAgICAgICAgICAgICAgICAgfCAgOSArKysrKw0KIGJsb2NrL2FjY291bnRpbmcu
YyAgICAgICAgIHwgIDYgKysrDQogYmxvY2svZmlsZS1wb3NpeC5jICAgICAgICAgfCA1NCArKysr
KysrKysrKysrKysrKysrKysrKystDQogYmxvY2svcWFwaS5jICAgICAgICAgICAgICAgfCAxMSAr
KysrKysNCiBody9pZGUvY29yZS5jICAgICAgICAgICAgICB8IDEyICsrKysrKw0KIGh3L3Njc2kv
c2NzaS1kaXNrLmMgICAgICAgIHwgMzIgKysrKysrKysrLS0tLS0tDQogdGVzdHMvcWVtdS1pb3Rl
c3RzLzIyNy5vdXQgfCAxOCArKysrKysrKysNCiAxMSBmaWxlcyBjaGFuZ2VkLCAyMDQgaW5zZXJ0
aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4xDQoNCg==

