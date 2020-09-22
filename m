Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35157C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E805B23A32
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="ivYhmu4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E805B23A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKYz3-0001Rh-IQ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 23:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibinzhang@tencent.com>)
 id 1kKYyS-0000zh-AU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:28:13 -0400
Received: from mail4.tencent.com ([183.57.53.109]:60920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibinzhang@tencent.com>)
 id 1kKYyL-000532-Bv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:28:09 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
 by mail4.tencent.com (Postfix) with ESMTP id C6BF072578;
 Tue, 22 Sep 2020 11:27:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1600745274;
 bh=5qpVKvA2egJXwbKcD4TeoqIYuhE5xklLswijF2foncQ=;
 h=From:To:CC:Subject:Date;
 b=ivYhmu4Tx7C000J9uqW2TswCEvCCi13OblfP3IxLbajRhYv2HbTtvnqkPgwWf4SdD
 L7ty+ySlX57G/jdCayGHQ4zAOupFTZwKf/G2I1u/O2ss0Jr1fBCQQsYz3kGhfdFGUc
 SNnonGN0RgXfx0w6vo6reae8/C8gROWlU3nXXgZ0=
Received: from EX-SZ007.tencent.com (10.28.6.31) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 22 Sep
 2020 11:27:54 +0800
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ007.tencent.com
 (10.28.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 22 Sep
 2020 11:27:54 +0800
Received: from EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930]) by
 EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930%2]) with mapi id
 15.01.2106.002; Tue, 22 Sep 2020 11:27:54 +0800
From: =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH] vhost-user: save features of multiqueues if chardev is closed
Thread-Topic: [PATCH] vhost-user: save features of multiqueues if chardev is
 closed
Thread-Index: AQHWkJBbURiqOHG7gEeDe0rUGA5Yvw==
Date: Tue, 22 Sep 2020 03:27:54 +0000
Message-ID: <46CBC206-E0CA-4249-81CD-10F75DA30441@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.114]
Content-Type: text/plain; charset="gb2312"
Content-ID: <690BCF2A1B3C524FBC55E4FBA166007B@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=183.57.53.109;
 envelope-from=haibinzhang@tencent.com; helo=mail4.tencent.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 23:27:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "xtay.haibin@gmail.com" <xtay.haibin@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rm9yZS1jb21taXQoYzZiZWVmZDY3NCkgb25seSBzYXZlcyBmZWF0dXJlcyBvZiBxdWV1ZTAsDQp0
aGlzIG1ha2VzIHdyb25nIGZlYXR1cmVzIG9mIG90aGVyIHF1ZXVlcyBpbiBtdWx0aXF1ZXVlcw0K
c2l0dWF0aW9uLg0KRm9yIGV4YW1wbGVzOg0KICBxZW11LXN5c3RlbS1hYXJjaDY0IC4uLiBcDQog
IC1jaGFyZGV2IHNvY2tldCxpZD1jaGFybmV0MCxwYXRoPS92YXIvcnVuL3Zob3N0X3NvY2sgXA0K
ICAtbmV0ZGV2IHZob3N0LXVzZXIsY2hhcmRldj1jaGFybmV0MCxxdWV1ZXM9MixpZD1ob3N0bmV0
MCBcDQogIC4uLg0KVGhlcmUgYXJlIHR3byBxdWV1ZXMgaW4gbmljIGFzc29jYXRlZCB3aXRoIG9u
ZSBjaGFyZGV2Lg0KV2hlbiBjaGFyZGV2IGlzIHJlY29ubmVjdGVkLCBpdCBpcyBuZWNlc3Nhcnkg
dG8gc2F2ZSBhbmQNCnJlc3RvcmUgZmVhdHVyZXMgb2YgYWxsIHF1ZXVlcy4NCg0KU2lnbmVkLW9m
LWJ5OiBIYWliaW4gWmhhbmcgPGhhaWJpbnpoYW5nQHRlbmNlbnQuY29tPg0KLS0tDQogbmV0L3Zo
b3N0LXVzZXIuYyB8IDEwICsrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXVzZXIuYyBiL25l
dC92aG9zdC11c2VyLmMNCmluZGV4IDE3NTMyZGFhZjMuLmZmYmQ5NGQ5NDQgMTAwNjQ0DQotLS0g
YS9uZXQvdmhvc3QtdXNlci5jDQorKysgYi9uZXQvdmhvc3QtdXNlci5jDQpAQCAtMjI2LDcgKzIy
Niw3IEBAIHN0YXRpYyB2b2lkIGNocl9jbG9zZWRfYmgodm9pZCAqb3BhcXVlKQ0KICAgICBOZXRD
bGllbnRTdGF0ZSAqbmNzW01BWF9RVUVVRV9OVU1dOw0KICAgICBOZXRWaG9zdFVzZXJTdGF0ZSAq
czsNCiAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQotICAgIGludCBxdWV1ZXM7DQorICAgIGludCBx
dWV1ZXMsIGk7DQogDQogICAgIHF1ZXVlcyA9IHFlbXVfZmluZF9uZXRfY2xpZW50c19leGNlcHQo
bmFtZSwgbmNzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5F
VF9DTElFTlRfRFJJVkVSX05JQywNCkBAIC0yMzUsOCArMjM1LDEyIEBAIHN0YXRpYyB2b2lkIGNo
cl9jbG9zZWRfYmgodm9pZCAqb3BhcXVlKQ0KIA0KICAgICBzID0gRE9fVVBDQVNUKE5ldFZob3N0
VXNlclN0YXRlLCBuYywgbmNzWzBdKTsNCiANCi0gICAgaWYgKHMtPnZob3N0X25ldCkgew0KLSAg
ICAgICAgcy0+YWNrZWRfZmVhdHVyZXMgPSB2aG9zdF9uZXRfZ2V0X2Fja2VkX2ZlYXR1cmVzKHMt
PnZob3N0X25ldCk7DQorICAgIGZvciAoaSA9IHF1ZXVlcyAtMTsgaSA+PSAwOyBpLS0pIHsNCisg
ICAgICAgIHMgPSBET19VUENBU1QoTmV0Vmhvc3RVc2VyU3RhdGUsIG5jLCBuY3NbaV0pOw0KKw0K
KyAgICAgICAgaWYgKHMtPnZob3N0X25ldCkgew0KKyAgICAgICAgICAgIHMtPmFja2VkX2ZlYXR1
cmVzID0gdmhvc3RfbmV0X2dldF9hY2tlZF9mZWF0dXJlcyhzLT52aG9zdF9uZXQpOw0KKyAgICAg
ICAgfQ0KICAgICB9DQogDQogICAgIHFtcF9zZXRfbGluayhuYW1lLCBmYWxzZSwgJmVycik7DQot
LSANCjIuMjMuMA0KDQoNCg==

