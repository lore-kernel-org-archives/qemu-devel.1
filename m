Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B1D221FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B1D221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnOK-0001Ze-OZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnNO-000110-PE; Fri, 09 Oct 2020 04:03:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48706 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnNG-0001h2-5t; Fri, 09 Oct 2020 04:03:42 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id A2D31B61FD4BD2AFADA9;
 Fri,  9 Oct 2020 16:03:27 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 9 Oct 2020 16:03:27 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 9 Oct 2020 16:03:27 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Fri, 9 Oct 2020 16:03:27 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: RE: [PATCH] target/riscv: raise exception to HS-mode at
 get_physical_address
Thread-Topic: [PATCH] target/riscv: raise exception to HS-mode at
 get_physical_address
Thread-Index: AQHWefKN/OgGU8CPl0ibaJ0/byQAGql5myUAgAK0+QCABUGNAIANnmzA
Date: Fri, 9 Oct 2020 08:03:26 +0000
Message-ID: <dbdb1a99f4c14abda4c71ac314128a9e@huawei.com>
References: <20200824084158.1769-1-jiangyifei@huawei.com>
 <CAKmqyKOAAzhBqosJCFq9ww0T44EUZV1zqG+T1UPYAuebYbR1KQ@mail.gmail.com>
 <c1273b7d24f5488c845d81153e495b69@huawei.com>
 <CAKmqyKO4w9WhMwCOE0A7WrA+QOxmO7=hVuzmDYBu3sYHLQOppA@mail.gmail.com>
In-Reply-To: <CAKmqyKO4w9WhMwCOE0A7WrA+QOxmO7=hVuzmDYBu3sYHLQOppA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 04:03:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsaXN0YWlyIEZyYW5jaXMg
W21haWx0bzphbGlzdGFpcjIzQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MSwgMjAyMCA4OjAwIEFNDQo+IFRvOiBKaWFuZ3lpZmVpIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+
DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25n
bnUub3JnPjsgb3Blbg0KPiBsaXN0OlJJU0MtViA8cWVtdS1yaXNjdkBub25nbnUub3JnPjsgWmhh
bmdoYWlsaWFuZw0KPiA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgU2FnYXIgS2Fy
YW5kaWthcg0KPiA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgQmFzdGlhbiBLb3BwZWxtYW5u
DQo+IDxrYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGU+OyBaaGFuZ3hpYW9mZW5nIChGKQ0K
PiA8dmljdG9yLnpoYW5neGlhb2ZlbmdAaHVhd2VpLmNvbT47IEFsaXN0YWlyIEZyYW5jaXMNCj4g
PEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IHlpbnlpcGVuZyA8eWlueWlwZW5nMUBodWF3ZWku
Y29tPjsgUGFsbWVyDQo+IERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47IFd1YmluIChIKSA8
d3Uud3ViaW5AaHVhd2VpLmNvbT47DQo+IGRlbmdrYWkgKEEpIDxkZW5na2FpMUBodWF3ZWkuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0YXJnZXQvcmlzY3Y6IHJhaXNlIGV4Y2VwdGlvbiB0
byBIUy1tb2RlIGF0DQo+IGdldF9waHlzaWNhbF9hZGRyZXNzDQo+IA0KPiBPbiBTdW4sIFNlcCAy
NywgMjAyMCBhdCAxMjo1NCBBTSBKaWFuZ3lpZmVpIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+IHdy
b3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+IEZyb206IEFsaXN0YWlyIEZyYW5jaXMgW21haWx0bzphbGlzdGFpcjIzQGdtYWlsLmNvbV0N
Cj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjAgNjoyNCBBTQ0KPiA+ID4g
VG86IEppYW5neWlmZWkgPGppYW5neWlmZWlAaHVhd2VpLmNvbT4NCj4gPiA+IENjOiBxZW11LWRl
dmVsQG5vbmdudS5vcmcgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgb3Blbg0K
PiA+ID4gbGlzdDpSSVNDLVYgPHFlbXUtcmlzY3ZAbm9uZ251Lm9yZz47IFpoYW5naGFpbGlhbmcN
Cj4gPiA+IDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBTYWdhciBLYXJhbmRpa2Fy
DQo+ID4gPiA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgQmFzdGlhbiBLb3BwZWxtYW5uDQo+
ID4gPiA8a2Jhc3RpYW5AbWFpbC51bmktcGFkZXJib3JuLmRlPjsgWmhhbmd4aWFvZmVuZyAoRikN
Cj4gPiA+IDx2aWN0b3Iuemhhbmd4aWFvZmVuZ0BodWF3ZWkuY29tPjsgQWxpc3RhaXIgRnJhbmNp
cw0KPiA+ID4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IHlpbnlpcGVuZyA8eWlueWlwZW5n
MUBodWF3ZWkuY29tPjsNCj4gPiA+IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+
OyBXdWJpbiAoSCkNCj4gPiA+IDx3dS53dWJpbkBodWF3ZWkuY29tPjsgZGVuZ2thaSAoQSkgPGRl
bmdrYWkxQGh1YXdlaS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0YXJnZXQvcmlz
Y3Y6IHJhaXNlIGV4Y2VwdGlvbiB0byBIUy1tb2RlIGF0DQo+ID4gPiBnZXRfcGh5c2ljYWxfYWRk
cmVzcw0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgQXVnIDI0LCAyMDIwIGF0IDE6NDMgQU0gWWlmZWkg
SmlhbmcgPGppYW5neWlmZWlAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
IFZTLXN0YWdlIHRyYW5zbGF0aW9uIGF0IGdldF9waHlzaWNhbF9hZGRyZXNzIG5lZWRzIHRvIHRy
YW5zbGF0ZQ0KPiA+ID4gPiBwdGUgYWRkcmVzcyBieSBHLXN0YWdlIHRyYW5zbGF0aW9uLiBCdXQg
dGhlIEctc3RhZ2UgdHJhbnNsYXRpb24NCj4gPiA+ID4gZXJyb3IgY2FuIG5vdCBiZSBkaXN0aW5n
dWlzaGVkIGZyb20gVlMtc3RhZ2UgdHJhbnNsYXRpb24gZXJyb3IgaW4NCj4gPiA+ID4gcmlzY3Zf
Y3B1X3RsYl9maWxsLiBPbiBtaWdyYXRpb24sIGRlc3RpbmF0aW9uIG5lZWRzIHRvIHJlYnVpbGQN
Cj4gPiA+ID4gcHRlLCBhbmQgdGhpcyBHLXN0YWdlIHRyYW5zbGF0aW9uIGVycm9yIG11c3QgYmUg
aGFuZGxlZCBieQ0KPiA+ID4gPiBIUy1tb2RlLiBTbyBpbnRyb2R1Y2UgVFJBTlNMQVRFX1NUQUdF
Ml9GQUlMIHNvIHRoYXQNCj4gPiA+ID4gcmlzY3ZfY3B1X3RsYl9maWxsIGNvdWxkIGRpc3Rpbmd1
aXNoIGFuZCByYWlzZSBpdCB0byBIUy1tb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBZaWZlaSBKaWFuZyA8amlhbmd5aWZlaUBodWF3ZWkuY29tPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBZaXBlbmcgWWluIDx5aW55aXBlbmcxQGh1YXdlaS5jb20+DQo+ID4gPg0KPiA+ID4g
VGhhbmtzIGZvciB0aGUgcGF0Y2ghDQo+ID4gPg0KPiA+ID4gU29ycnkgZm9yIHRoZSBkZWxheSBo
ZXJlLg0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICB0YXJnZXQvcmlzY3YvY3B1LmggICAg
ICAgIHwgIDEgKw0KPiA+ID4gPiAgdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyB8IDEyICsrKysr
KysrKystLQ0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2Nw
dS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oIGluZGV4DQo+ID4gPiA+IGE4MDRhNWQwYmEuLjhiM2Iz
NjhkNmEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0KPiA+ID4gPiAr
KysgYi90YXJnZXQvcmlzY3YvY3B1LmgNCj4gPiA+ID4gQEAgLTg1LDYgKzg1LDcgQEAgZW51bSB7
DQo+ID4gPiA+ICAjZGVmaW5lIFRSQU5TTEFURV9GQUlMIDENCj4gPiA+ID4gICNkZWZpbmUgVFJB
TlNMQVRFX1NVQ0NFU1MgMA0KPiA+ID4gPiAgI2RlZmluZSBNTVVfVVNFUl9JRFggMw0KPiA+ID4g
PiArI2RlZmluZSBUUkFOU0xBVEVfR19TVEFHRV9GQUlMIDQNCj4gPiA+ID4NCj4gPiA+ID4gICNk
ZWZpbmUgTUFYX1JJU0NWX1BNUFMgKDE2KQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCj4g
PiA+ID4gaW5kZXggZmQxZDM3M2I2Zi4uMTYzNWIwOWM0MSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
dGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYw0KPiA+ID4gPiArKysgYi90YXJnZXQvcmlzY3YvY3B1
X2hlbHBlci5jDQo+ID4gPiA+IEBAIC00NDAsNyArNDQwLDEwIEBAIHJlc3RhcnQ6DQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW11X2lk
eCwNCj4gPiA+IGZhbHNlLA0KPiA+ID4gPiB0cnVlKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAg
ICAgICAgIGlmICh2YmFzZV9yZXQgIT0gVFJBTlNMQVRFX1NVQ0NFU1MpIHsNCj4gPiA+ID4gLSAg
ICAgICAgICAgICAgICByZXR1cm4gdmJhc2VfcmV0Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAg
IGVudi0+Z3Vlc3RfcGh5c19mYXVsdF9hZGRyID0gKGJhc2UgfA0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChhZGRyICYNCj4gPiA+ID4gKw0K
PiA+ID4gKFRBUkdFVF9QQUdFX1NJWkUgLQ0KPiA+ID4gPiArIDEpKSkgPj4gMjsNCj4gPiA+DQo+
ID4gPiBDYW4gd2Ugc2V0IGd1ZXN0X3BoeXNfZmF1bHRfYWRkciBpbiByaXNjdl9jcHVfdGxiX2Zp
bGwoKSBpbnN0ZWFkPw0KPiA+DQo+ID4gSGkgQWxpc3RhaXIsDQo+ID4NCj4gPiBJdCdzIG5vdCBl
YXN5IHRvIGRvIHRoYXQuIFRoZSBrZXkgaXMgdGhhdCB0aGUgd3JvbmcgYWRkcmVzcyh0aGUgYGJh
c2VgIHZhcmlhYmxlKQ0KPiBpcyBub3QgdmlzaWJsZSB0byByaXNjdl9jcHVfdGxiX2ZpbGwoKS4N
Cj4gPiBCZWNhdXNlIHRoZSB3cm9uZyBhZGRyZXNzIG1heSBiZSBmcm9tIGFueSBsZXZlbCBvZiBQ
VEUgd2hpY2ggY2FuJ3QgYmUNCj4gZWFzaWx5IG9idGFpbmVkIGJ5IHJpc2N2X2NwdV90bGJfZmls
bCgpLg0KPiA+IFRoZSBhbHRlcm5hdGl2ZSBpcyB0byBhZGQgYW4gb3V0IHBhcmFtZXRlciBpbiBn
ZXRfcGh5c2ljYWxfYWRkcmVzcygpLiBCdXQgaXQgaXMNCj4gbm90IGVpdGhlciBlbGVnYW50Lg0K
PiA+IFdoYXQgaXMgeW91ciBhZHZpY2U/DQo+IA0KPiBZb3UgYXJlIHJpZ2h0LiBHb29kIGNhbGwu
DQo+IA0KPiBJbiB3aGljaCBjYXNlIHRoaXMgbG9va3MgbGlrZSB0aGUgcmlnaHQgd2F5IHRvIGRv
IHRoaXMuIENhbiB5b3UgYWRkIGEgc21hbGwNCj4gY29tbWVudCBpbiByaXNjdl9jcHVfdGxiX2Zp
bGwoKSB0byBpbmRpY2F0ZSB0aGF0IGd1ZXN0X3BoeXNfZmF1bHRfYWRkciBoYXMNCj4gYWxyZWFk
eSBiZWVuIHNldCB3aGVuIGhhbmRsaW5nIHRoZSBlcnJvcj8NCj4gVGhlIFRMQiBmaWxsaW5nIGNv
ZGUgaXMgcHJldHR5IGNvbXBsZXggc28gdGhlIG1vcmUgZG9jdW1lbnRhdGlvbiB0aGUgYmV0dGVy
Lg0KPiANCj4gQWxpc3RhaXINCj4gDQoNCkkgaGF2ZSBhbHJlYWR5IHNlbnQgYSBuZXcgcGF0Y2gg
dG8gYWRkIG5lY2Vzc2FyeSBjb21tZW50LiBQbGVhc2UgcmV2aWV3IHRoZSBuZXcgcGF0Y2guDQoN
ClRoYW5rcywNCllpZmVpDQoNCj4gPg0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPiBZaWZlaQ0KPiA+
DQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICAgICAgIHJldHVybiBUUkFOU0xBVEVfR19TVEFH
RV9GQUlMOw0KPiA+ID4gPiAgICAgICAgICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAg
ICAgICAgcHRlX2FkZHIgPSB2YmFzZSArIGlkeCAqIHB0ZXNpemU7IEBAIC03MjgsMTIgKzczMSwx
Nw0KPiA+ID4gPiBAQCBib29sIHJpc2N2X2NwdV90bGJfZmlsbChDUFVTdGF0ZSAqY3MsIHZhZGRy
IGFkZHJlc3MsIGludCBzaXplLA0KPiA+ID4gPiAgICAgICAgICByZXQgPSBnZXRfcGh5c2ljYWxf
YWRkcmVzcyhlbnYsICZwYSwgJnByb3QsIGFkZHJlc3MsDQo+ID4gPiBhY2Nlc3NfdHlwZSwNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW11X2lkeCwgdHJ1ZSwg
dHJ1ZSk7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgIGlmIChyZXQgPT0gVFJBTlNMQVRFX0df
U1RBR0VfRkFJTCkgew0KPiA+ID4gPiArICAgICAgICAgICAgZmlyc3Rfc3RhZ2VfZXJyb3IgPSBm
YWxzZTsNCj4gPiA+ID4gKyAgICAgICAgICAgIGFjY2Vzc190eXBlID0gTU1VX0RBVEFfTE9BRDsN
Cj4gPiA+ID4gKyAgICAgICAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19NTVUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIiVzIDFz
dC1zdGFnZSBhZGRyZXNzPSUiIFZBRERSX1BSSXggIg0KPiA+ID4gcmV0ICVkIHBoeXNpY2FsICIN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICBUQVJHRVRfRk1UX3BseCAiIHByb3QgJWRc
biIsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGFkZHJlc3MsIHJl
dCwgcGEsIHByb3QpOw0KPiA+ID4gPg0KPiA+ID4gPiAtICAgICAgICBpZiAocmV0ICE9IFRSQU5T
TEFURV9GQUlMKSB7DQo+ID4gPiA+ICsgICAgICAgIGlmIChyZXQgIT0gVFJBTlNMQVRFX0ZBSUwg
JiYgcmV0ICE9DQo+ID4gPiA+ICsgVFJBTlNMQVRFX0dfU1RBR0VfRkFJTCkgew0KPiA+ID4NCj4g
PiA+IE90aGVyd2lzZSB0aGlzIHBhdGNoIGxvb2tzIGNvcnJlY3QuDQo+ID4gPg0KPiA+ID4gQWxp
c3RhaXINCj4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAvKiBTZWNvbmQgc3RhZ2UgbG9va3Vw
ICovDQo+ID4gPiA+ICAgICAgICAgICAgICBpbV9hZGRyZXNzID0gcGE7DQo+ID4gPiA+DQo+ID4g
PiA+IC0tDQo+ID4gPiA+IDIuMTkuMQ0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPg0K

