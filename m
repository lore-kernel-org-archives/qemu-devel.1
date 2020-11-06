Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F90DC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CF820729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CF820729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1karAo-0005Bv-Sk
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 21:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kar9o-0004M5-1O; Thu, 05 Nov 2020 21:07:16 -0500
Received: from smtp.h3c.com ([60.191.123.50]:57779 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kar9j-0005Ot-4n; Thu, 05 Nov 2020 21:07:15 -0500
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
 by h3cspam02-ex.h3c.com with ESMTPS id 0A626gFB091915
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Nov 2020 10:06:42 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 6 Nov 2020 10:06:43 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.2106.002; Fri, 6 Nov 2020 10:06:43 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [PATCH] block: Fix integer promotion error in bdrv_getlength()
Thread-Topic: [PATCH] block: Fix integer promotion error in bdrv_getlength()
Thread-Index: AdazNZvDJjXIINNtSs2+W7uMUYNirf//qsCAgABPKYD//qjFsA==
Date: Fri, 6 Nov 2020 02:06:43 +0000
Message-ID: <3d5116f925024e47854ab25a77a85da4@h3c.com>
References: <c0d398ea9d7141bcbb9b3746f97852b4@h3c.com>
 <bb1cfa18-badd-75af-587e-bd476544ddd2@redhat.com>
 <703e17a1-544f-4e5e-a431-6e20d4a04974@redhat.com>
In-Reply-To: <703e17a1-544f-4e5e-a431-6e20d4a04974@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.131]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0A626gFB091915
Received-SPF: pass client-ip=60.191.123.50; envelope-from=tu.guoyi@h3c.com;
 helo=h3cspam02-ex.h3c.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 21:07:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTA3LTAzIGF0IDEwOjEzIC0wNTAwLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBP
biAxMS81LzIwIDI6MzEgQU0sIE1heCBSZWl0eiB3cm90ZToNCj4gPiBPbiAwNS4xMS4yMCAwNjo0
MCwgVHVndW95aSB3cm90ZToNCj4gPj4gQXMgQkRSVl9TRUNUT1JfU0laRSBpcyBvZiB0eXBlIHVp
bnQ2NF90LCB0aGUgZXhwcmVzc2lvbiB3aWxsDQo+ID4+IGF1dG9tYXRpY2FsbHkgY29udmVydCB0
aGUgQHJldCB0byB1aW50NjRfdC4gV2hlbiBhbiBlcnJvciBjb2RlDQo+ID4+IHJldHVybmVkIGZy
b20gYmRydl9uYl9zZWN0b3JzKCksIHRoZSBwcm9tb3RlZCBAcmV0IHdpbGwgYmUgYSB2ZXJ5DQo+
ID4+IGxhcmdlIG51bWJlciwgYXMgYSByZXN1bHQgdGhlIC1FRkJJRyB3aWxsIGJlIHJldHVybmVk
IHdoaWNoIGlzIG5vdCB0aGUNCj4gPj4gcmVhbCBlcnJvciBjb2RlLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBHdW95aSBUdSA8dHUuZ3VveWlAaDNjLmNvbT4NCj4gPj4gLS0tDQo+ID4+IMKg
IGJsb2NrLmMgfCAyICstDQo+ID4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gVGhhbmtzLCBhcHBsaWVkIHRvIG15IGJsb2NrIGJyYW5j
aDoNCj4gPg0KPiA+IGh0dHBzOi8vZ2l0LnhhbmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRz
L2JyYW5jaC9ibG9jaw0KPiA+DQo+IA0KPiBJIGFjdHVhbGx5IHByZWZlcnJlZCB0aGUgdjEgc29s
dXRpb24sIHJhdGhlciB0aGFuIHRoaXMgdjIsIGFzIGl0IGF2b2lkZWQNCj4gYSBjYXN0Lg0KDQpU
aGVyZSBhcmUgc2V2ZXJhbCB0eXBlIHByb21vdGlvbiBidWdzKGNvbW1pdHMgJzU3MDU0MmVjJykg
Zm91bmQgcmVjZW50bHksIA0Kc28gaSB0aGluayBleHBsaWNpdGx5IGNhc3RpbmcgdGhlIGludGVn
ZXIgdHlwZSBjYW4gZ2l2ZSBhIGhpbnQgdGhhdCB0aGVyZQ0KaXMgYSBwb3RlbnRpYWwgdHlwZSBw
cm9tb3Rpb24gaWYgeW91IGRvbid0IGRvIHRoYXQuDQogDQpBY3R1YWxseSB5b3VyIHNvbHV0aW9u
IGxvb2sgbXVjaCBzaW1wbGUgYW5kIGNsZWFyLCBhbmQgaXQncyBvayBmb3IgbWUNCg0KLS0NCkJl
c3QgcmVnYXJkcywNCkd1b3lpDQo=

