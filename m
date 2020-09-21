Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7458C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 05:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F43207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 05:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="c3M4xmds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F43207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKEVJ-0001jE-6o
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 01:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibinzhang@tencent.com>)
 id 1kKETu-000152-6P; Mon, 21 Sep 2020 01:35:18 -0400
Received: from mail4.tencent.com ([183.57.53.109]:45049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibinzhang@tencent.com>)
 id 1kKETg-0005Vi-Nn; Mon, 21 Sep 2020 01:35:07 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
 by mail4.tencent.com (Postfix) with ESMTP id A1AB472543;
 Mon, 21 Sep 2020 13:34:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1600666484;
 bh=G0jK20Mo8U5msXJ5ovoNI3Pb0ukRMbXXD54Gwzjwb7U=;
 h=From:To:CC:Subject:Date:References:In-Reply-To;
 b=c3M4xmdscOFiSROq2CRNbC0DfLRWc0x0n08cjR0of45GVuypSQMaeZDf6xahyo/yq
 dL0gnXhqyo7Ctb+EO/E977a4kF3vslvzGgNwq1vBKDo3zWVEcSX4jTGuJi5E/uXv6b
 K91XqHMgiRibM3f+Vht1SOWx/rpYlt900sdat3ls=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 21 Sep
 2020 13:34:44 +0800
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 21 Sep
 2020 13:34:44 +0800
Received: from EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930]) by
 EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930%2]) with mapi id
 15.01.2106.002; Mon, 21 Sep 2020 13:34:44 +0800
From: =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= <haibinzhang@tencent.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/arm/virt: use pflash image real size when mapping
Thread-Topic: [PATCH] hw/arm/virt: use pflash image real size when mapping
Thread-Index: AQHWj9jp3iU0W8yxW0mOeOdrWvTgGw==
Date: Mon, 21 Sep 2020 05:34:44 +0000
Message-ID: <811E645C-AE91-43F5-B849-3F79532E1023@tencent.com>
References: <790EEEF3-0799-4507-BF30-DA85440E766F@tencent.com>
 <52eb89e8-3602-2a2a-df9e-66130bce4070@redhat.com>
In-Reply-To: <52eb89e8-3602-2a2a-df9e-66130bce4070@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.113]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0D857B18E13534DBCD10977DE0A2FBA@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=183.57.53.109;
 envelope-from=haibinzhang@tencent.com; helo=mail4.tencent.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:34:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "xtay.haibin@gmail.com" <xtay.haibin@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Ard Biesheuvel <Ard.Biesheuvel@arm.com>, Leif Lindholm <leif@nuviainc.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmVzZW5kIHRoZSBtYWlsIHVzaW5nIHBsYWluIHRleHQgZm9ybWF0DQoNCj4gT24gU2VwIDE4LCAy
MDIwLCBhdCA5OjQxIFBNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+IHdyb3RlOg0KPiANCj4gQ2MnaW5nIGZpcm13YXJlIGV4cGVydHMuDQo+IA0KPiBPbiA5LzE4
LzIwIDI6MjYgUE0sIGhhaWJpbnpoYW5nKOWvrueKs+aNo+mPgj8gd3JvdGU6DQo+PiBEZWZhdWx0
IHNpemUgb2YgYXJtLXZpcnQgcGZsYXNoIGltYWdlIGlzIDY0TUIgd2hpY2gNCj4+IHdpbGwgY29z
dCBleHRyYSAxMjhNQig2NE1CeDIpIG1lbW9yeSBwZXIgcWVtdSBwcm9jZXNzDQo+PiBhbmQgMTIu
NUdCIGZvciAxMDAgcWVtdSBwcm9jZXNzZXMuIEhvc3QgbWVtb3J5IGlzDQo+PiBwcmVjaW91cyBh
bmQgaXQgaXMgdmFsdWFibGUgdG8gcmVkdWNlIHBmbGFzaCBpbWFnZSBzaXplLg0KPj4gRm9yIGNv
bXBhdGliaWxpdHkgYXJtLXZpcnQgdXNlcyByZWFsIHNpemUgd2hlbiBtYXBwaW5nLg0KPiANCj4g
Rmxhc2gjMCBpcyBhIGRldmljZSBiZWNhdXNlIGV2ZW50dWFsbHkgaXRzIG1vZGVsIHdpbGwgaGFu
ZGxlDQo+IHNlY3Rvci9ibG9jayBwcm90ZWN0aW9uLCBzbyBmaXJtd2FyZSBjYW4gZG8gQ2Fwc3Vs
ZVVwZGF0ZQ0KPiAodXBkYXRpbmcgaXRzZWxmKS4gTWVhbndoaWxlIHlvdSBjb3VsZCB0cmVhdCBm
bGFzaCMwIGFzIGEgcHVyZQ0KPiBST00gZGV2aWNlLi4uIEJ1dCB0aGlzIHdvdWxkbid0IGJlIHRo
ZSAnYXJtLXZpcnQnIG1hY2hpbmUgYW55bW9yZS4NCj4gDQoNCkJ1dCBGbGFzaCMwLyMxIGFyZSBj
b3JyZXNwb25kaW5nIHRvIHR3byByb20gTWVtb3J5UmVnaW9ucyByZWxhdGVkIHRvIG1lbW9yeSBj
b3N0Lg0KDQpFeGFtcGxlOg0KMS4gR2V0IFFFTVVfRUZJLmZkIGFuZCBRRU1VX1ZBUlMuZmQgZnJv
bSB0aWFub2NvcmUvZWRrMg0KDQoyLiBNYWtlIHBmbGFzaCBpbWFnZXMNCiAgZGQgaWY9L2Rldi96
ZXJvIGJzPTFNIGNvdW50PTY0IG9mPWZsYXNoMC5pbWcNCiAgZGQgaWY9L2Rldi96ZXJvIGJzPTFN
IGNvdW50PTY0IG9mPWZsYXNoMS5pbWcNCiAgZGQgaWY9UUVNVV9FRkkuZmQgYnM9MU0gb2Y9Zmxh
c2gwLmltZyBjb252PW5vdHJ1bmMNCiAgZGQgaWY9UUVNVV9WQVJTLmZkIGJzPTFNIG9mPWZsYXNo
MS5pbWcgY29udj1ub3RydW5jDQoNCjMuIFN0YXJ0IFZNDQogIHFlbXUtc3lzdGVtLWFhcmNoNjQg
LW1hY2hpbmUgdmlydCxhY2NlbD1rdm0sZ2ljLXZlcnNpb249MyBcDQogIC1kcml2ZSBmaWxlPWZs
YXNoMC5pbWcsaWY9cGZsYXNoLGZvcm1hdD1yYXcsdW5pdD0wLHJlYWRvbmx5PW9uIFwNCiAgLWRy
aXZlIGZpbGU9Zmxhc2gxLmltZyxpZj1wZmxhc2gsZm9ybWF0PXJhdyx1bml0PTEgXA0KICDigKYN
Cg0KSW4gdmlydCBtYWNoaW5lLCBWSVJUX0ZMQVNIIHNpemUgaXMgZml4ZWQgMTI4TUIgKGZpeGVk
IDY0TUIgZm9yIEZsYXNoMCwgZml4ZWQgNjRNQiBmb3IgRmxhc2gxKS4NCkZsYXNoMCBhbmQgRmxh
c2gxIGFyZSB0d28gQmxvY2sgQmFja2VuZCBkZXZpY2VzIGFuZCB3aWxsIGJlIGNvcGllZCBpbnRv
IHR3byBtZW1vcnkgc3RvcmFnZXMgYWxsb2NlZCANCmluIHZpcnRfZmxhc2hfbWFwLCBub3QgZmls
ZSBtYXBwaW5nLiBTaXplIG9mIG1lbW9yeSBzdG9yYWdlIGlzIGZpeGVkIDY0TUIuDQoNClNpbmNl
IHNpemUgY2hlY2tpbmcsIHZpcnQgbWFjaGluZSBjdXJyZW50bHkgZG9lc27igJl0IHN1cHBvcnQg
PDY0TUIgcGZsYXNoIGltYWdlcy4gU28sIGdldCByZWFsDQpzaXplIG9mIHBmbGFzaCBpbWFnZSBm
aXJzdCwgYW5kIHVzZSByZWFsIHNpemUgdG8gYWxsb2MgbWVtb3J5IHN0b3JhZ2UuDQoNCkkgYWx3
YXlzIHVzZSA4TUIgRmxhc2gwIGFuZCBGbGFzaDEsIHVzaW5nIGZvbGxvd2luZyBjb21tYW5kcw0K
ICBkZCBpZj0vZGV2L3plcm8gYnM9MU0gY291bnQ9OCBvZj1mbGFzaDAuaW1nDQogIGRkIGlmPS9k
ZXYvemVybyBicz0xTSBjb3VudD04IG9mPWZsYXNoMS5pbWcNCiAgZGQgaWY9UUVNVV9FRkkuZmQg
YnM9MU0gb2Y9Zmxhc2gwLmltZyBjb252PW5vdHJ1bmMNCiAgZGQgaWY9UUVNVV9WQVJTLmZkIGJz
PTFNIG9mPWZsYXNoMS5pbWcgY29udj1ub3RydW5jDQoNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTog
SGFpYmluIFpoYW5nIDxoYWliaW56aGFuZ0B0ZW5jZW50LmNvbT4NCj4+IC0tLQ0KPj4gaHcvYXJt
L3ZpcnQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvaHcv
YXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMNCj4+IGluZGV4IGFjZjliZmJlY2UuLjM1NDVlMTI4
NjUgMTAwNjQ0DQo+PiAtLS0gYS9ody9hcm0vdmlydC5jDQo+PiArKysgYi9ody9hcm0vdmlydC5j
DQo+PiBAQCAtNTAsNiArNTAsNyBAQA0KPj4gI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCINCj4+
ICNpbmNsdWRlICJzeXNlbXUvdHBtLmgiDQo+PiAjaW5jbHVkZSAic3lzZW11L2t2bS5oIg0KPj4g
KyNpbmNsdWRlICJzeXNlbXUvYmxvY2stYmFja2VuZC5oIg0KPj4gI2luY2x1ZGUgImh3L2xvYWRl
ci5oIg0KPj4gI2luY2x1ZGUgImV4ZWMvYWRkcmVzcy1zcGFjZXMuaCINCj4+ICNpbmNsdWRlICJx
ZW11L2JpdG9wcy5oIg0KPj4gQEAgLTEwMDEsMTAgKzEwMDIsMjcgQEAgc3RhdGljIHZvaWQgdmly
dF9mbGFzaF9tYXAoVmlydE1hY2hpbmVTdGF0ZSAqdm1zLA0KPj4gICAgICAqLw0KPj4gICAgIGh3
YWRkciBmbGFzaHNpemUgPSB2bXMtPm1lbW1hcFtWSVJUX0ZMQVNIXS5zaXplIC8gMjsNCj4+ICAg
ICBod2FkZHIgZmxhc2hiYXNlID0gdm1zLT5tZW1tYXBbVklSVF9GTEFTSF0uYmFzZTsNCj4+ICsg
ICAgaW50NjRfdCByZWFsc2l6ZTsNCj4+ICsgICAgQmxvY2tCYWNrZW5kICpibGs7DQo+PiANCj4+
IC0gICAgdmlydF9mbGFzaF9tYXAxKHZtcy0+Zmxhc2hbMF0sIGZsYXNoYmFzZSwgZmxhc2hzaXpl
LA0KPj4gKyAgICByZWFsc2l6ZSA9IGZsYXNoc2l6ZTsNCj4+ICsgICAgYmxrID0gcGZsYXNoX2Nm
aTAxX2dldF9ibGsodm1zLT5mbGFzaFswXSk7DQo+PiArICAgIGlmIChibGspIHsNCj4+ICsgICAg
ICAgIHJlYWxzaXplID0gYmxrX2dldGxlbmd0aChibGspOw0KPj4gKyAgICAgICAgcmVhbHNpemUg
PSByZWFsc2l6ZSA8IGZsYXNoc2l6ZSA/IHJlYWxzaXplIDogZmxhc2hzaXplOw0KPj4gKyAgICB9
DQo+IA0KPiBTdGVmYW4gcmVjZW50bHkgcG9zdGVkICJudmRpbW06IHJlYWQtb25seSBmaWxlIHN1
cHBvcnQiIHdoaWNoDQo+IG1pZ2h0IGJlIGEgYmV0dGVyIHdheSB0byBhY2hpZXZlIHdoYXQgeW91
IHdhbnQ6DQo+IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vcWVtdS1kZXZlbEBub25nbnUu
b3JnL21zZzc0MTEzNy5odG1sDQoNCkZsYXNoMCBpcyByZWFkLW9ubHkgYW5kIHNoYXJlZCBieSBh
bGwgVk1zLCBidXQgRmxhc2gxIGlzIG5vdCBhbmQgcHJpdmF0ZSBmb3IgZWFjaCBWTS4NCg0KQnR3
LiwgaG93IHRvIGNyZWF0ZSBhIG52ZGltbSBkZXZpY2UgbWFwcGluZyB0byBhZGRyZXNzIHJhbmdl
IDB+MTI4TUI/DQoNCj4gDQo+PiArDQo+PiArICAgIHZpcnRfZmxhc2hfbWFwMSh2bXMtPmZsYXNo
WzBdLCBmbGFzaGJhc2UsIHJlYWxzaXplLA0KPj4gICAgICAgICAgICAgICAgICAgICBzZWN1cmVf
c3lzbWVtKTsNCj4+IC0gICAgdmlydF9mbGFzaF9tYXAxKHZtcy0+Zmxhc2hbMV0sIGZsYXNoYmFz
ZSArIGZsYXNoc2l6ZSwgZmxhc2hzaXplLA0KPj4gKw0KPj4gKyAgICByZWFsc2l6ZSA9IGZsYXNo
c2l6ZTsNCj4+ICsgICAgYmxrID0gcGZsYXNoX2NmaTAxX2dldF9ibGsodm1zLT5mbGFzaFsxXSk7
DQo+PiArICAgIGlmIChibGspIHsNCj4+ICsgICAgICAgIHJlYWxzaXplID0gYmxrX2dldGxlbmd0
aChibGspOw0KPj4gKyAgICAgICAgcmVhbHNpemUgPSByZWFsc2l6ZSA8IGZsYXNoc2l6ZSA/IHJl
YWxzaXplIDogZmxhc2hzaXplOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHZpcnRfZmxhc2hf
bWFwMSh2bXMtPmZsYXNoWzFdLCBmbGFzaGJhc2UgKyBmbGFzaHNpemUsIHJlYWxzaXplLA0KPj4g
ICAgICAgICAgICAgICAgICAgICBzeXNtZW0pOw0KPj4gfQ0KPj4gDQo+PiAtLQ0KPj4gMi4yMy4w
DQoNCg==

