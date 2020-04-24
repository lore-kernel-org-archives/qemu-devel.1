Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDBC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36BE20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=acronis.com header.i=@acronis.com header.b="QDFMx2KI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36BE20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=acronis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyUc-0003gc-1D
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Anton.Nefedov@acronis.com>) id 1jRv49-0002R7-T7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <Anton.Nefedov@acronis.com>) id 1jRv48-000182-3q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:56:13 -0400
Received: from us-edge-1.acronis.com ([69.20.59.99]:59392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Anton.Nefedov@acronis.com>)
 id 1jRv47-0000sw-No; Fri, 24 Apr 2020 05:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=acronis.com
 ; s=exim;
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:
 In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2CrWiZAUloDv2NDT9u9FRA58dE2qm8RR73On86F7sJA=; b=QDFMx2KI1yn04cDzi9cGNJD3b3
 fKGqQaheHoXBfEB9BTn3ZzvITB3X0/6UhUSkT5qqDQFlKvHAWWjYVPv1j2Oo7IJ/fBiKjI5Zku4oA
 DHvawaBagbTVK5hfRgbeHJCjG9BwbnPo/Mb/4C9ai2pGwu0+FICZ61fFSNfFsl+TL5pE=;
Received: from [91.195.22.120] (helo=ru-ex-1.corp.acronis.com)
 by us-edge-1.acronis.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <Anton.Nefedov@acronis.com>)
 id 1jRv40-0002wp-Ee; Fri, 24 Apr 2020 05:56:04 -0400
Received: from ru-ex-2.corp.acronis.com (10.250.32.21) by
 ru-ex-1.corp.acronis.com (10.250.32.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Fri, 24 Apr 2020 12:55:59 +0300
Received: from ru-ex-2.corp.acronis.com ([fe80::758f:d572:7ba8:9f04]) by
 ru-ex-2.corp.acronis.com ([fe80::758f:d572:7ba8:9f04%4]) with mapi id
 15.01.1913.007; Fri, 24 Apr 2020 12:55:59 +0300
From: Anton Nefedov <Anton.Nefedov@acronis.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "Dima
 Stepanov" <dimastep@yandex-team.ru>, Anton Nefedov
 <anton.nefedov@virtuozzo.com>
Subject: Re: [RFC PATCH v1 2/7] char-socket: return -1 in case of disconnect
 during tcp_chr_write
Thread-Topic: [RFC PATCH v1 2/7] char-socket: return -1 in case of disconnect
 during tcp_chr_write
Thread-Index: AQHWGas4mcxAMJsxjkGjMFCPA3sgw6iH13oA
Date: Fri, 24 Apr 2020 09:55:59 +0000
Message-ID: <68888867-4f38-da63-1054-9dfdf1e77444@acronis.com>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <045f356cec6f07300819d28457a2bb8876d1c887.1587667007.git.dimastep@yandex-team.ru>
 <ca921f6f56104bcbb664424f97558ec3@HE1PR08MB2650.eurprd08.prod.outlook.com>
In-Reply-To: <ca921f6f56104bcbb664424f97558ec3@HE1PR08MB2650.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.166.139.159]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1CC69080DD9D34EB20050295EA43861@acronis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MessageID-Signature: 51e065b410addcefeede4a1fa7840b42e122e6a4
Received-SPF: pass client-ip=69.20.59.99;
 envelope-from=Anton.Nefedov@acronis.com; helo=us-edge-1.acronis.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 05:56:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 69.20.59.99
X-Mailman-Approved-At: Fri, 24 Apr 2020 09:34:51 -0400
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "open
 list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Gonglei <arei.gonglei@huawei.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Paolo
 Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBPbiBUaHUsIEFwciAyMywgMjAyMCBhdCA4OjQzIFBNIERpbWEgU3RlcGFub3YgPGRpbWFzdGVw
QHlhbmRleC10ZWFtLnJ1PiB3cm90ZToNCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdmhvc3RfdXNl
cl93cml0ZSBkb2Vzbid0IGdldCBhbiBlcnJvciBhZnRlcg0KPj4gZGlzY29ubmVjdCBhbmQgdHJ5
IHRvIGNhbGwgdmhvc3RfdXNlcl9yZWFkKCkuIFRoZSB0Y3BfY2hyX3dyaXRlKCkNCj4+IHJvdXRp
bmUgc2hvdWxkIHJldHVybiAtMSBpbiBjYXNlIG9mIGRpc2Nvbm5lY3QuIEluZGljYXRlIHRoZSBF
SU8gZXJyb3INCj4+IGlmIHRoaXMgcm91dGluZSBpcyBjYWxsZWQgaW4gdGhlIGRpc2Nvbm5lY3Rl
ZCBzdGF0ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEaW1hIFN0ZXBhbm92IDxkaW1hc3RlcEB5
YW5kZXgtdGVhbS5ydT4NCj4+IC0tLQ0KPj4gICBjaGFyZGV2L2NoYXItc29ja2V0LmMgfCA4ICsr
KysrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2NoYXJkZXYvY2hhci1zb2NrZXQuYyBiL2NoYXJkZXYv
Y2hhci1zb2NrZXQuYw0KPj4gaW5kZXggMTg1ZmUzOC4uYzEyOGNjYSAxMDA2NDQNCj4+IC0tLSBh
L2NoYXJkZXYvY2hhci1zb2NrZXQuYw0KPj4gKysrIGIvY2hhcmRldi9jaGFyLXNvY2tldC5jDQo+
PiBAQCAtMTc1LDE0ICsxNzUsMTYgQEAgc3RhdGljIGludCB0Y3BfY2hyX3dyaXRlKENoYXJkZXYg
KmNociwgY29uc3QgdWludDhfdCAqYnVmLCBpbnQgbGVuKQ0KPj4gICAgICAgICAgIGlmIChyZXQg
PCAwICYmIGVycm5vICE9IEVBR0FJTikgew0KPj4gICAgICAgICAgICAgICBpZiAodGNwX2Nocl9y
ZWFkX3BvbGwoY2hyKSA8PSAwKSB7DQo+PiAgICAgICAgICAgICAgICAgICB0Y3BfY2hyX2Rpc2Nv
bm5lY3RfbG9ja2VkKGNocik7DQo+PiAtICAgICAgICAgICAgICAgIHJldHVybiBsZW47DQo+PiAr
ICAgICAgICAgICAgICAgIC8qIFJldHVybiBhbiBlcnJvciBzaW5jZSB3ZSBtYWRlIGEgZGlzY29u
bmVjdC4gKi8NCj4+ICsgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IExvb2tzIG9r
LCBidXQgdGhpcyByZXR1cm4gd2FzIGludHJvZHVjZWQgaW4gY29tbWl0DQo+IGIwYTMzNWUzNTEx
MDNiZjkyZjNmOWQwYmQ1NzU5MzExYmU4MTU2YWMgKCJxZW11LWNoYXI6IHNvY2tldCBiYWNrZW5k
Og0KPiBkaXNjb25uZWN0IG9uIHdyaXRlIGVycm9yIikuIEl0IGRvZXNuJ3Qgc2F5IHdoeSBpdCBk
aWRuJ3QgcmV0dXJuIC0xDQo+IHRob3VnaC4gQW50b24sIGNvdWxkIHlvdSByZXZpZXc/IHRoYW5r
cw0KPiANCg0KaGVqLA0KDQpJIHRoaW5rIEkgaGFkIG5vIHNwZWNpYWwgaW50ZW50IGJ1dCB0byBy
ZXBlYXQgdGhlIGJlaGF2aW91ciBhcyBpbiB0aGUNCnNuaXBwZXQgYmVsb3csIHRoYXQgaXMgdG8g
cmV0dXJuIEBsZW4gd2hlbiB0aGUgc29ja2V0IGlzIGRpc2Nvbm5lY3RlZC4NCg0KU2VlbXMgdGhh
dCB0Y3BfY2hyX3dyaXRlKCkgd29ya2VkIHRoYXQgd2F5IHNpbmNlIHRoZSB2ZXJ5IGJlZ2lubmlu
Zw0KKGNvbW1pdCAwYmFiMDBmKS4NCg0KSXQgbG9va3Mgb2sgdG8gbWUgdG8gcmV0dXJuIGFuIGVy
cm9yIHRob3VnaC4gSWYgc29tZSBndWVzdCBkZXZpY2UgZG9lc250DQpleHBlY3QgdGhhdCBJIGd1
ZXNzIGl0IHNob3VsZCBpZ25vcmUgdGhlIGVycm9yIG9uIGl0cyBzaWRlLg0KDQo+PiAgICAgICAg
ICAgICAgIH0gLyogZWxzZSBsZXQgdGhlIHJlYWQgaGFuZGxlciBmaW5pc2ggaXQgcHJvcGVybHkg
Ki8NCj4+ICAgICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAgICAg
ICB9IGVsc2Ugew0KPj4gLSAgICAgICAgLyogWFhYOiBpbmRpY2F0ZSBhbiBlcnJvciA/ICovDQo+
PiAtICAgICAgICByZXR1cm4gbGVuOw0KPj4gKyAgICAgICAgLyogSW5kaWNhdGUgYW4gZXJyb3Iu
ICovDQo+PiArICAgICAgICBlcnJubyA9IEVJTzsNCj4+ICsgICAgICAgIHJldHVybiAtMTsNCj4+
ICAgICAgIH0NCj4+ICAgfQ0K

