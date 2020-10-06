Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1588C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 04:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA65206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 04:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="udhYRohM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA65206F4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPeWx-0001pK-TX
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 00:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <precinct@mail.ustc.edu.cn>)
 id 1kPeVQ-0000uY-GI
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 00:23:16 -0400
Received: from email6.ustc.edu.cn ([2001:da8:d800::8]:54566 helo=ustc.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1kPeVN-0006Ca-4e
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 00:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID; bh=+m24CYoMnHmf+2fXa5lvJxYEdT4gLjubIbK8
 uvZBr+M=; b=udhYRohM/ZHfWkXZGJzJJ/1y/1V7lwwsDJeMYUF8V3Dta3CaE0sb
 yAVfm6pj8zWZ+KvZxaCNgEXwaezXpQuijva/FrDjXXCAFboUlIZtcbHu1yerz6Ij
 bZnrl0g9zr9xLIaReQqWGnhdea5Qsrk/jIcaeCBAOvnySBpEZlA1PPg=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 6 Oct
 2020 12:22:27 +0800 (GMT+08:00)
X-Originating-IP: [123.114.243.19]
Date: Tue, 6 Oct 2020 12:22:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: "Alexander Bulekov" <alxndr@bu.edu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, 
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Akkarit Sangpetch" <asangpet@andrew.cmu.edu>, 
 "Alex Barcelo" <abarcelo@ac.upc.edu>, 
 "Brian Wheeler" <bdwheele@indiana.edu>, 
 "Chen Wei-Ren" <chenwj@iis.sinica.edu.tw>, 
 "Christoffer Dall" <cdall@cs.columbia.edu>, 
 "Colin Lord" <cdlord2@illinois.edu>, "Dayeol Lee" <dayeol@berkeley.edu>, 
 "Fan Yang" <Fan_Yang@sjtu.edu.cn>, "Gabriel Somlo" <somlo@cmu.edu>, 
 "Guan Xuetao" <gxt@mprc.pku.edu.cn>, linzhecheng <linzc@zju.edu.cn>, 
 =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, 
 "Mike Nawrocki" <michael.nawrocki@gtri.gatech.edu>, 
 "Mike Ryan" <mikeryan@isi.edu>, 
 "Nickolai Zeldovich" <nickolai@csail.mit.edu>, 
 "Stephen Checkoway" <stephen.checkoway@oberlin.edu>, 
 "Viktor Prutyanov" <viktor.prutyanov@phystech.edu>, 
 "Vince Weaver" <vince@csl.cornell.edu>, 
 "Zhang Mengchi" <zhangmengchi@mprc.pku.edu.cn>, 
 "Alex Richardson" <Alexander.Richardson@cl.cam.ac.uk>, 
 "Bastian Koppelmann" <kbastian@mail.uni-paderborn.de>, 
 "Hesham Almatary" <Hesham.Almatary@cl.cam.ac.uk>, 
 "Timothy Edward Baldwin" <T.E.Baldwin99@members.leeds.ac.uk>, 
 "Pavel Pisa" <pisa@cmp.felk.cvut.cz>, 
 =?UTF-8?Q?C=C3=A9sar_Belley?= <cesar.belley@lse.epita.fr>, 
 "Amir Charif" <amir.charif@cea.fr>, 
 "Fabrice Desclaux" <fabrice.desclaux@cea.fr>
Subject: Re: Re: [RFC PATCH 2/2] contrib/gitdm: Add more academic domains
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2020 www.mailtech.cn ustc-xl
In-Reply-To: <20201006033501.2s3mhnlbxzvfovrc@mozz.bu.edu>
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-3-f4bug@amsat.org>
 <20201006033501.2s3mhnlbxzvfovrc@mozz.bu.edu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4d809d9d.91ec.174fc257507.Coremail.precinct@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygB3f7cD8XtfXjYFAA--.0W
X-CM-SenderInfo: 5suhuxxqfwqzxdloh3xvwfhvlgxou0/1tbiAQsRCVQhnxuCuAAHse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=2001:da8:d800::8;
 envelope-from=precinct@mail.ustc.edu.cn; helo=ustc.edu.cn
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: precinct@mail.ustc.edu.cn
From: precinct--- via <qemu-devel@nongnu.org>

QWNrZWQtYnk6IFhpbnl1IExpIDxwcmVjaW5jdEBtYWlsLnVzdGMuZWR1LmNuPgoK5ZyoMjAyMC0x
MC0wNiAxMTozNTowMSxBbGV4YW5kZXIgQnVsZWtvdjxhbHhuZHJAYnUuZWR1PuWGmemBk++8mgo+
IE9uIDIwMTAwNCAyMjQwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPiBUaGVy
ZSBpcyBhIG51bWJlciBvZiBjb250cmlidXRpb25zIGZyb20gdGhlc2UgYWNhZGVtaWMgZG9tYWlu
cy4NCj4gPiBBZGQgdGhlIGVudHJpZXMgdG8gdGhlIGdpdGRtICdhY2FkZW1pYycgZG9tYWluIG1h
cC4NCj4gPiANCj4gPiBDYzogQWtrYXJpdCBTYW5ncGV0Y2ggPGFzYW5ncGV0QGFuZHJldy5jbXUu
ZWR1Pg0KPiA+IENjOiBBbGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4NCj4gPiBDYzog
QWxleGFuZGVyIE9sZWluaWsgPGFseG5kckBidS5lZHU+DQo+ID4gQ2M6IEFsZXggQmFyY2VsbyA8
YWJhcmNlbG9AYWMudXBjLmVkdT4NCj4gPiBDYzogQnJpYW4gV2hlZWxlciA8YmR3aGVlbGVAaW5k
aWFuYS5lZHU+DQo+ID4gQ2M6IENoZW4gV2VpLVJlbiA8Y2hlbndqQGlpcy5zaW5pY2EuZWR1LnR3
Pg0KPiA+IENjOiBDaHJpc3RvZmZlciBEYWxsIDxjZGFsbEBjcy5jb2x1bWJpYS5lZHU+DQo+ID4g
Q2M6IENvbGluIExvcmQgPGNkbG9yZDJAaWxsaW5vaXMuZWR1Pg0KPiA+IENjOiBEYXllb2wgTGVl
IDxkYXllb2xAYmVya2VsZXkuZWR1Pg0KPiA+IENjOiBGYW4gWWFuZyA8RmFuX1lhbmdAc2p0dS5l
ZHUuY24+DQo+ID4gQ2M6IEdhYnJpZWwgU29tbG8gPHNvbWxvQGNtdS5lZHU+DQo+ID4gQ2M6IEd1
YW4gWHVldGFvIDxneHRAbXByYy5wa3UuZWR1LmNuPg0KPiA+IENjOiBsaW56aGVjaGVuZyA8bGlu
emNAemp1LmVkdS5jbj4NCj4gPiBDYzogTGx1w61zIFZpbGFub3ZhIDx2aWxhbm92YUBhYy51cGMu
ZWR1Pg0KPiA+IENjOiBNaWtlIE5hd3JvY2tpIDxtaWNoYWVsLm5hd3JvY2tpQGd0cmkuZ2F0ZWNo
LmVkdT4NCj4gPiBDYzogTWlrZSBSeWFuIDxtaWtlcnlhbkBpc2kuZWR1Pg0KPiA+IENjOiBOaWNr
b2xhaSBaZWxkb3ZpY2ggPG5pY2tvbGFpQGNzYWlsLm1pdC5lZHU+DQo+ID4gQ2M6IFN0ZXBoZW4g
Q2hlY2tvd2F5IDxzdGVwaGVuLmNoZWNrb3dheUBvYmVybGluLmVkdT4NCj4gPiBDYzogVmlrdG9y
IFBydXR5YW5vdiA8dmlrdG9yLnBydXR5YW5vdkBwaHlzdGVjaC5lZHU+DQo+ID4gQ2M6IFZpbmNl
IFdlYXZlciA8dmluY2VAY3NsLmNvcm5lbGwuZWR1Pg0KPiA+IENjOiBYaW55dSBMaSA8cHJlY2lu
Y3RAbWFpbC51c3RjLmVkdS5jbj4NCj4gPiBDYzogWmhhbmcgTWVuZ2NoaSA8emhhbmdtZW5nY2hp
QG1wcmMucGt1LmVkdS5jbj4NCj4gPiBDYzogQWxleCBSaWNoYXJkc29uIDxBbGV4YW5kZXIuUmlj
aGFyZHNvbkBjbC5jYW0uYWMudWs+DQo+ID4gQ2M6IEJhc3RpYW4gS29wcGVsbWFubiA8a2Jhc3Rp
YW5AbWFpbC51bmktcGFkZXJib3JuLmRlPg0KPiA+IENjOiBIZXNoYW0gQWxtYXRhcnkgPEhlc2hh
bS5BbG1hdGFyeUBjbC5jYW0uYWMudWs+DQo+ID4gQ2M6IFRpbW90aHkgRWR3YXJkIEJhbGR3aW4g
PFQuRS5CYWxkd2luOTlAbWVtYmVycy5sZWVkcy5hYy51az4NCj4gPiBDYzogUGF2ZWwgUGlzYSA8
cGlzYUBjbXAuZmVsay5jdnV0LmN6Pg0KPiA+IENjOiBDw6lzYXIgQmVsbGV5IDxjZXNhci5iZWxs
ZXlAbHNlLmVwaXRhLmZyPg0KPiA+IENjOiBBbWlyIENoYXJpZiA8YW1pci5jaGFyaWZAY2VhLmZy
Pg0KPiA+IENjOiBGYWJyaWNlIERlc2NsYXV4IDxmYWJyaWNlLmRlc2NsYXV4QGNlYS5mcj4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8ZjRidWdAYW1zYXQub3Jn
Pg0KPiANCj4gRm9yIGJvdGggQWxleGFuZGVyIHtCdWxla292LCBPbGVpbmlrfSA8YWx4bmRyQGJ1
LmVkdT4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVk
dT4NCj4gDQo+ID4gLS0tDQo+ID4gVG8gdGhlIGRldmVsb3BlcnMgQ2MnZWQ6IElmIHlvdSBhZ3Jl
ZSB3aXRoIHRoZSBlbnRyeSBvZiB5b3VyDQo+ID4gZG9tYWluLCBwbGVhc2UgcmVwbHkgd2l0aCBh
IFJldmlld2VkLWJ5L0Fja2VkLWJ5IHRhZy4gSWYgeW91DQo+ID4gZGlzYWdyZWUgb3IgZG9lc24n
dCBjYXJlLCBwbGVhc2UgZWl0aGVyIHJlcGx5IHdpdGggTmFjay1ieSBvcg0KPiA+IGlnbm9yZSB0
aGlzIHBhdGNoLg0KPiA+IEknbGwgcmVwb3N0IGluIDIgd2Vla3MgYXMgZm9ybWFsIHBhdGNoIChu
b3QgUkZDKSB3aXRoIG9ubHkgdGhlDQo+ID4gZW50cmllcyBhY2tlZCBieSB0aGVpciBhdXRob3Iu
DQo+ID4gT25lIFJldmlld2VkLWJ5L0Fjay1ieSBmcm9tIHNvbWVvbmUgZnJvbSBhIGRvbWFpbiBz
aG91bGQgYmUNCj4gPiBzdWZmaWNpZW50IHRvIGdldCB0aGUgZG9tYWluIGluY2x1ZGVkIGluIHRo
ZSBmaW5hbCBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgY29udHJpYi9naXRkbS9ncm91cC1tYXAtYWNh
ZGVtaWNzIHwgMTAgKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvZ2l0ZG0v
Z3JvdXAtbWFwLWFjYWRlbWljcyBiL2NvbnRyaWIvZ2l0ZG0vZ3JvdXAtbWFwLWFjYWRlbWljcw0K
PiA+IGluZGV4IGM3YjBkZDQ2YTMuLmZkNDJiYjgwNjkgMTAwNjQ0DQo+ID4gLS0tIGEvY29udHJp
Yi9naXRkbS9ncm91cC1tYXAtYWNhZGVtaWNzDQo+ID4gKysrIGIvY29udHJpYi9naXRkbS9ncm91
cC1tYXAtYWNhZGVtaWNzDQo+ID4gQEAgLTExLDkgKzExLDE3IEBAIGlzcHJhcy5ydQ0KPiA+ICBw
YXZlbC5kb3ZnYWx1a0BnbWFpbC5jb20NCj4gPiAgDQo+ID4gICMgQ29sdW1iaWEgVW5pdmVyc2l0
eQ0KPiA+IC1jcy5jb2x1bWJpYS5lZHUNCj4gPiAgY290YUBicmFhcC5vcmcNCj4gPiAgDQo+ID4g
IGppYXh1bi55YW5nQGZseWdvYXQuY29tDQo+ID4gIA0KPiA+ICBhcnRlbS5rLnBpc2FyZW5rb0Bn
bWFpbC5jb20NCj4gPiArDQo+ID4gK3VuaS1wYWRlcmJvcm4uZGUNCj4gPiArZWR1DQo+ID4gK2Fj
LnVrDQo+ID4gK2VkdS5jbg0KPiA+ICtlZHUudHcNCj4gPiArY21wLmZlbGsuY3Z1dC5jeg0KPiA+
ICtlcGl0YS5mcg0KPiA+ICtjZWEuZnINCj4gPiAtLSANCj4gPiAyLjI2LjINCj4gPiANCgo=

