Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4515C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E15E2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="yImP2DRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E15E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83wF-0003oq-GU
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tI-0006du-Lh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:12 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12941)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tE-0005sP-Th
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765868; x=1629301868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tUWIh60VIBZ0LRuhNAwMPb0vZxGR3JoiB9ulRsp8naY=;
 b=yImP2DRWKS+9UDZdC0j3gkUr8rZKhQpRAlOzP+GiaWIJzD3DHDbf0vuG
 YKjzCRBfRSZjdp/bK5FiqjF0+p9npVeP6cZYlnOK2Bh/vgAN4cxf7Ke+c
 7CTZe/9vpxC3QmkYOhx5Obh68IJy7nyXoUsc5akleidL7mt22aQZSoUIJ s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 18 Aug 2020 08:50:56 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 6ADFD1A4A; Tue, 18 Aug 2020 10:50:56 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 13/34] Hexagon (target/hexagon) register map
Date: Tue, 18 Aug 2020 10:50:26 -0500
Message-Id: <1597765847-16637-14-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 11:50:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, tsimpson@quicinc.com, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q2VydGFpbiBvcGVyYW5kIHR5cGVzIHJlcHJlc2VudCBhIG5vbi1jb250aWd1b3VzIHNldCBvZiB2
YWx1ZXMuCkZvciBleGFtcGxlLCB0aGUgY29tcG91bmQgY29tcGFyZS1hbmQtanVtcCBpbnN0cnVj
dGlvbiBjYW4gb25seSBhY2Nlc3MKcmVnaXN0ZXJzIFIwLVI3IGFuZCBSMTYtMjMuClRoaXMgdGFi
bGUgcmVwcmVzZW50cyB0aGUgbWFwcGluZyBmcm9tIHRoZSBlbmNvZGluZyB0byB0aGUgYWN0dWFs
IHZhbHVlcy4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9yZWdtYXAuaCB8IDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL3JlZ21hcC5oCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vcmVnbWFwLmggYi90YXJnZXQvaGV4YWdvbi9yZWdtYXAuaApuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4yYmNjMGRlCi0tLSAvZGV2L251bGwKKysrIGIv
dGFyZ2V0L2hleGFnb24vcmVnbWFwLmgKQEAgLTAsMCArMSwzOCBAQAorLyoKKyAqICBDb3B5cmln
aHQoYykgMjAxOS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdo
dHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICog
IFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBh
IGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0
aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4K
KyAqLworCisvKgorICogIENlcnRhaW4gb3BlcmFuZCB0eXBlcyByZXByZXNlbnQgYSBub24tY29u
dGlndW91cyBzZXQgb2YgdmFsdWVzLgorICogIEZvciBleGFtcGxlLCB0aGUgY29tcG91bmQgY29t
cGFyZS1hbmQtanVtcCBpbnN0cnVjdGlvbiBjYW4gb25seSBhY2Nlc3MKKyAqICByZWdpc3RlcnMg
UjAtUjcgYW5kIFIxNi0yMy4KKyAqICBUaGlzIHRhYmxlIHJlcHJlc2VudHMgdGhlIG1hcHBpbmcg
ZnJvbSB0aGUgZW5jb2RpbmcgdG8gdGhlIGFjdHVhbCB2YWx1ZXMuCisgKi8KKworI2lmbmRlZiBI
RVhBR09OX1JFR01BUF9ICisjZGVmaW5lIEhFWEFHT05fUkVHTUFQX0gKKworICAgICAgICAvKiBO
YW1lICAgTnVtIFRhYmxlICovCitERUZfUkVHTUFQKFJfMTYsICAxNiwgMCwgMSwgMiwgMywgNCwg
NSwgNiwgNywgMTYsIDE3LCAxOCwgMTksIDIwLCAyMSwgMjIsIDIzKQorREVGX1JFR01BUChSX184
LCAgOCwgIDAsIDIsIDQsIDYsIDE2LCAxOCwgMjAsIDIyKQorREVGX1JFR01BUChSX180LCAgNCwg
IDAsIDIsIDQsIDYpCitERUZfUkVHTUFQKFJfNCwgICA0LCAgMCwgMSwgMiwgMykKK0RFRl9SRUdN
QVAoUl84UywgIDgsICAwLCAxLCAyLCAzLCAxNiwgMTcsIDE4LCAxOSkKK0RFRl9SRUdNQVAoUl84
LCAgIDgsICAwLCAxLCAyLCAzLCA0LCA1LCA2LCA3KQorREVGX1JFR01BUChWX184LCAgOCwgIDAs
IDQsIDgsIDEyLCAxNiwgMjAsIDI0LCAyOCkKK0RFRl9SRUdNQVAoVl9fMTYsIDE2LCAwLCAyLCA0
LCA2LCA4LCAxMCwgMTIsIDE0LCAxNiwgMTgsIDIwLCAyMiwgMjQsIDI2LCAyOCwgMzApCisKKyNl
bmRpZgotLSAKMi43LjQKCg==

