Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE2FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 04:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2DB206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 04:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="NdU4uTBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2DB206F4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPeXx-0003AL-Rc
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 00:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <precinct@mail.ustc.edu.cn>)
 id 1kPeWl-0001tg-Ez
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 00:24:39 -0400
Received: from email6.ustc.edu.cn ([2001:da8:d800::8]:54987 helo=ustc.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1kPeWe-0006b1-1S
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 00:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID; bh=DMy2W1hZ8CJYoPN4oH4HJJnS/SNtbZwvft/j
 rx3DJF0=; b=NdU4uTBixNiKBFcJuI61+EbR++er31G1zvAxX1gqAPe6vxAxP6/1
 Vui+fdiSWolG/z6EU6Ds3wH7hdcE3ThUiiJv5MqFET7glu+xaTtEtScWyNRyEls7
 CsumuxZsQcm2LzH8JXZNEJT2UL6nRj9LOBGDyq+cB8yov5aT5a02vUY=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 6 Oct
 2020 12:23:47 +0800 (GMT+08:00)
X-Originating-IP: [123.114.243.19]
Date: Tue, 6 Oct 2020 12:23:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Akkarit Sangpetch" <asangpet@andrew.cmu.edu>, 
 "Alexander Bulekov" <alxndr@bu.edu>, 
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
Subject: Re: [RFC PATCH 2/2] contrib/gitdm: Add more academic domains
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2020 www.mailtech.cn ustc-xl
In-Reply-To: <20201004204010.2048608-3-f4bug@amsat.org>
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-3-f4bug@amsat.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <57169ed0.91f1.174fc26ad82.Coremail.precinct@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygCXn7dT8Xtf2zgFAA--.0W
X-CM-SenderInfo: 5suhuxxqfwqzxdloh3xvwfhvlgxou0/1tbiAQsRCVQhnxuCuAAOsX
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
MC0wNSAwNDo0MDoxMCxQaGlsaXBwZSBNYXRoaWV1LURhdWTDqTxmNGJ1Z0BhbXNhdC5vcmc+5YaZ
6YGT77yaCj4gVGhlcmUgaXMgYSBudW1iZXIgb2YgY29udHJpYnV0aW9ucyBmcm9tIHRoZXNlIGFj
YWRlbWljIGRvbWFpbnMuDQo+IEFkZCB0aGUgZW50cmllcyB0byB0aGUgZ2l0ZG0gJ2FjYWRlbWlj
JyBkb21haW4gbWFwLg0KPiANCj4gQ2M6IEFra2FyaXQgU2FuZ3BldGNoIDxhc2FuZ3BldEBhbmRy
ZXcuY211LmVkdT4NCj4gQ2M6IEFsZXhhbmRlciBCdWxla292IDxhbHhuZHJAYnUuZWR1Pg0KPiBD
YzogQWxleGFuZGVyIE9sZWluaWsgPGFseG5kckBidS5lZHU+DQo+IENjOiBBbGV4IEJhcmNlbG8g
PGFiYXJjZWxvQGFjLnVwYy5lZHU+DQo+IENjOiBCcmlhbiBXaGVlbGVyIDxiZHdoZWVsZUBpbmRp
YW5hLmVkdT4NCj4gQ2M6IENoZW4gV2VpLVJlbiA8Y2hlbndqQGlpcy5zaW5pY2EuZWR1LnR3Pg0K
PiBDYzogQ2hyaXN0b2ZmZXIgRGFsbCA8Y2RhbGxAY3MuY29sdW1iaWEuZWR1Pg0KPiBDYzogQ29s
aW4gTG9yZCA8Y2Rsb3JkMkBpbGxpbm9pcy5lZHU+DQo+IENjOiBEYXllb2wgTGVlIDxkYXllb2xA
YmVya2VsZXkuZWR1Pg0KPiBDYzogRmFuIFlhbmcgPEZhbl9ZYW5nQHNqdHUuZWR1LmNuPg0KPiBD
YzogR2FicmllbCBTb21sbyA8c29tbG9AY211LmVkdT4NCj4gQ2M6IEd1YW4gWHVldGFvIDxneHRA
bXByYy5wa3UuZWR1LmNuPg0KPiBDYzogbGluemhlY2hlbmcgPGxpbnpjQHpqdS5lZHUuY24+DQo+
IENjOiBMbHXDrXMgVmlsYW5vdmEgPHZpbGFub3ZhQGFjLnVwYy5lZHU+DQo+IENjOiBNaWtlIE5h
d3JvY2tpIDxtaWNoYWVsLm5hd3JvY2tpQGd0cmkuZ2F0ZWNoLmVkdT4NCj4gQ2M6IE1pa2UgUnlh
biA8bWlrZXJ5YW5AaXNpLmVkdT4NCj4gQ2M6IE5pY2tvbGFpIFplbGRvdmljaCA8bmlja29sYWlA
Y3NhaWwubWl0LmVkdT4NCj4gQ2M6IFN0ZXBoZW4gQ2hlY2tvd2F5IDxzdGVwaGVuLmNoZWNrb3dh
eUBvYmVybGluLmVkdT4NCj4gQ2M6IFZpa3RvciBQcnV0eWFub3YgPHZpa3Rvci5wcnV0eWFub3ZA
cGh5c3RlY2guZWR1Pg0KPiBDYzogVmluY2UgV2VhdmVyIDx2aW5jZUBjc2wuY29ybmVsbC5lZHU+
DQo+IENjOiBYaW55dSBMaSA8cHJlY2luY3RAbWFpbC51c3RjLmVkdS5jbj4NCj4gQ2M6IFpoYW5n
IE1lbmdjaGkgPHpoYW5nbWVuZ2NoaUBtcHJjLnBrdS5lZHUuY24+DQo+IENjOiBBbGV4IFJpY2hh
cmRzb24gPEFsZXhhbmRlci5SaWNoYXJkc29uQGNsLmNhbS5hYy51az4NCj4gQ2M6IEJhc3RpYW4g
S29wcGVsbWFubiA8a2Jhc3RpYW5AbWFpbC51bmktcGFkZXJib3JuLmRlPg0KPiBDYzogSGVzaGFt
IEFsbWF0YXJ5IDxIZXNoYW0uQWxtYXRhcnlAY2wuY2FtLmFjLnVrPg0KPiBDYzogVGltb3RoeSBF
ZHdhcmQgQmFsZHdpbiA8VC5FLkJhbGR3aW45OUBtZW1iZXJzLmxlZWRzLmFjLnVrPg0KPiBDYzog
UGF2ZWwgUGlzYSA8cGlzYUBjbXAuZmVsay5jdnV0LmN6Pg0KPiBDYzogQ8Opc2FyIEJlbGxleSA8
Y2VzYXIuYmVsbGV5QGxzZS5lcGl0YS5mcj4NCj4gQ2M6IEFtaXIgQ2hhcmlmIDxhbWlyLmNoYXJp
ZkBjZWEuZnI+DQo+IENjOiBGYWJyaWNlIERlc2NsYXV4IDxmYWJyaWNlLmRlc2NsYXV4QGNlYS5m
cj4NCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0
Lm9yZz4NCj4gLS0tDQo+IFRvIHRoZSBkZXZlbG9wZXJzIENjJ2VkOiBJZiB5b3UgYWdyZWUgd2l0
aCB0aGUgZW50cnkgb2YgeW91cg0KPiBkb21haW4sIHBsZWFzZSByZXBseSB3aXRoIGEgUmV2aWV3
ZWQtYnkvQWNrZWQtYnkgdGFnLiBJZiB5b3UNCj4gZGlzYWdyZWUgb3IgZG9lc24ndCBjYXJlLCBw
bGVhc2UgZWl0aGVyIHJlcGx5IHdpdGggTmFjay1ieSBvcg0KPiBpZ25vcmUgdGhpcyBwYXRjaC4N
Cj4gSSdsbCByZXBvc3QgaW4gMiB3ZWVrcyBhcyBmb3JtYWwgcGF0Y2ggKG5vdCBSRkMpIHdpdGgg
b25seSB0aGUNCj4gZW50cmllcyBhY2tlZCBieSB0aGVpciBhdXRob3IuDQo+IE9uZSBSZXZpZXdl
ZC1ieS9BY2stYnkgZnJvbSBzb21lb25lIGZyb20gYSBkb21haW4gc2hvdWxkIGJlDQo+IHN1ZmZp
Y2llbnQgdG8gZ2V0IHRoZSBkb21haW4gaW5jbHVkZWQgaW4gdGhlIGZpbmFsIHBhdGNoLg0KPiAt
LS0NCj4gIGNvbnRyaWIvZ2l0ZG0vZ3JvdXAtbWFwLWFjYWRlbWljcyB8IDEwICsrKysrKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9jb250cmliL2dpdGRtL2dyb3VwLW1hcC1hY2FkZW1pY3MgYi9jb250cmli
L2dpdGRtL2dyb3VwLW1hcC1hY2FkZW1pY3MNCj4gaW5kZXggYzdiMGRkNDZhMy4uZmQ0MmJiODA2
OSAxMDA2NDQNCj4gLS0tIGEvY29udHJpYi9naXRkbS9ncm91cC1tYXAtYWNhZGVtaWNzDQo+ICsr
KyBiL2NvbnRyaWIvZ2l0ZG0vZ3JvdXAtbWFwLWFjYWRlbWljcw0KPiBAQCAtMTEsOSArMTEsMTcg
QEAgaXNwcmFzLnJ1DQo+ICBwYXZlbC5kb3ZnYWx1a0BnbWFpbC5jb20NCj4gIA0KPiAgIyBDb2x1
bWJpYSBVbml2ZXJzaXR5DQo+IC1jcy5jb2x1bWJpYS5lZHUNCj4gIGNvdGFAYnJhYXAub3JnDQo+
ICANCj4gIGppYXh1bi55YW5nQGZseWdvYXQuY29tDQo+ICANCj4gIGFydGVtLmsucGlzYXJlbmtv
QGdtYWlsLmNvbQ0KPiArDQo+ICt1bmktcGFkZXJib3JuLmRlDQo+ICtlZHUNCj4gK2FjLnVrDQo+
ICtlZHUuY24NCj4gK2VkdS50dw0KPiArY21wLmZlbGsuY3Z1dC5jeg0KPiArZXBpdGEuZnINCj4g
K2NlYS5mcg0KPiAtLSANCj4gMi4yNi4yDQo+IA0KCg==

