Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87375C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510BD24672
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E55zXvFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510BD24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iwX-0005Sz-Cq
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ike-0002pC-DF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikb-0005Xj-1U
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ika-0005Uc-Kx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908272; x=1614444272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nmaNHOXJLS0IoFi9w9IXnOwHbfpZW/oqSktNaMagkXc=;
 b=E55zXvFpISm6Q19DvPnW+btORFq+ihzMhhn6OKm60voaXVeVqCQRtDYP
 uj+WPVvBYSVonK/GM+H9WBD/kfSpTGXN59KX6ido4va18yoZz7EoOK2fv
 OygofH/uSqrv+R7fwmntIWDq7OFRu8BYKsojsoNFIDYYtvwMN0wn/VzKo 0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:29 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:28 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 6B6F1115A; Fri, 28 Feb 2020 10:44:28 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 15/67] Hexagon instruction printing
Date: Fri, 28 Feb 2020 10:43:11 -0600
Message-Id: <1582908244-304-16-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Taylor Simpson <tsimpson@quicinc.com>, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5oIHwgMjYgKysrKysrKysrKysrKwogdGFyZ2V0L2hl
eGFnb24vcHJpbnRpbnNuLmMgfCA5MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXQvaGV4YWdvbi9wcmludGluc24uYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3ByaW50aW5zbi5oIGIvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmgKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uMjY0YjYzYwotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3ByaW50aW5zbi5oCkBAIC0wLDAgKzEsMjYgQEAKKy8qCisgKiAgQ29weXJpZ2h0KGMp
IDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJl
c2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlz
IHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1
bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGll
ZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBw
cm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8K
KworI2lmbmRlZiBIRVhBR09OX1BSSU5USU5TTl9ICisjZGVmaW5lIEhFWEFHT05fUFJJTlRJTlNO
X0gKKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJpbnNuLmgiCisKK2V4dGVy
biB2b2lkIHNucHJpbnRfYV9wa3QoY2hhciAqYnVmLCBpbnQgbiwgcGFja2V0X3QgKnBrdCk7CisK
KyNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMgYi90YXJnZXQv
aGV4YWdvbi9wcmludGluc24uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5m
NTkzODNlCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMKQEAg
LTAsMCArMSw5MSBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDIwIFF1YWxjb21tIElu
bm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
OyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlv
bikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRl
ZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFO
WSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVS
Q0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRo
ZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgor
ICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxo
dHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIgorI2luY2x1ZGUgIm9wY29kZXMuaCIKKyNpbmNsdWRlICJwcmludGluc24uaCIKKyNpbmNs
dWRlICJpbnNuLmgiCisjaW5jbHVkZSAibWFjcm9zLmgiCisjaW5jbHVkZSAiaW50ZXJuYWwuaCIK
Kworc3RhdGljIGNvbnN0IGNoYXIgKnNyZWcyc3RyKHVuc2lnbmVkIGludCByZWcpCit7CisgICAg
aWYgKHJlZyA8IFRPVEFMX1BFUl9USFJFQURfUkVHUykgeworICAgICAgICByZXR1cm4gaGV4YWdv
bl9yZWduYW1lc1tyZWddOworICAgIH0gZWxzZSB7CisgICAgICAgIHJldHVybiAiPz8/IjsKKyAg
ICB9Cit9CisKK3N0YXRpYyBjb25zdCBjaGFyICpjcmVnMnN0cih1bnNpZ25lZCBpbnQgcmVnKQor
eworICAgIHJldHVybiBzcmVnMnN0cihyZWcgKyBOVU1fR0VOX1JFR1MpOworfQorCitzdGF0aWMg
dm9pZCBzbnByaW50aW5zbihjaGFyICpidWYsIGludCBuLCBpbnNuX3QgKiBpbnNuKQoreworICAg
IHN3aXRjaCAoaW5zbi0+b3Bjb2RlKSB7CisjZGVmaW5lIERFRl9WRUNYX1BSSU5USU5GTyhUQUcs
IEZNVCwgLi4uKSBERUZfUFJJTlRJTkZPKFRBRywgRk1ULCBfX1ZBX0FSR1NfXykKKyNkZWZpbmUg
REVGX1BSSU5USU5GTyhUQUcsIEZNVCwgLi4uKSBcCisgICAgY2FzZSBUQUc6IFwKKyAgICAgICAg
c25wcmludGYoYnVmLCBuLCBGTVQsIF9fVkFfQVJHU19fKTtcCisgICAgICAgIGJyZWFrOworI2lu
Y2x1ZGUgInByaW50aW5zbl9nZW5lcmF0ZWQuaCIKKyN1bmRlZiBERUZfVkVDWF9QUklOVElORk8K
KyN1bmRlZiBERUZfUFJJTlRJTkZPCisgICAgfQorfQorCit2b2lkIHNucHJpbnRfYV9wa3QoY2hh
ciAqYnVmLCBpbnQgbiwgcGFja2V0X3QgKiBwa3QpCit7CisgICAgY2hhciB0bXBidWZbMTI4XTsK
KyAgICBidWZbMF0gPSAnXDAnOworICAgIGludCBpLCBzbG90LCBvcGNvZGU7CisKKyAgICBpZiAo
cGt0ID09IE5VTEwpIHsKKyAgICAgICAgc25wcmludGYoYnVmLCBuLCAiPHByaW50cGt0OiBOVUxM
IHB0cj4iKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKworICAgIGlmIChwa3QtPm51bV9pbnNu
cyA+IDEpIHsKKyAgICAgICAgc3RybmNhdChidWYsICJcbntcbiIsIG4pOworICAgIH0KKyAgICBm
b3IgKGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAgICAgICBpZiAocGt0LT5p
bnNuW2ldLnBhcnQxKSB7CisgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgfQorICAgICAg
ICBzbnByaW50aW5zbih0bXBidWYsIDEyNywgJihwa3QtPmluc25baV0pKTsKKyAgICAgICAgc3Ry
bmNhdChidWYsICJcdCIsIG4pOworICAgICAgICBzdHJuY2F0KGJ1ZiwgdG1wYnVmLCBuKTsKKyAg
ICAgICAgaWYgKEdFVF9BVFRSSUIocGt0LT5pbnNuW2ldLm9wY29kZSwgQV9TVUJJTlNOKSkgewor
ICAgICAgICAgICAgc3RybmNhdChidWYsICIgLy9zdWJpbnNuIiwgbik7CisgICAgICAgIH0KKyAg
ICAgICAgaWYgKHBrdC0+aW5zbltpXS5leHRlbnNpb25fdmFsaWQpIHsKKyAgICAgICAgICAgIHN0
cm5jYXQoYnVmLCAiIC8vY29uc3RhbnQgZXh0ZW5kZWQiLCBuKTsKKyAgICAgICAgfQorICAgICAg
ICBzbG90ID0gcGt0LT5pbnNuW2ldLnNsb3Q7CisgICAgICAgIG9wY29kZSA9IHBrdC0+aW5zbltp
XS5vcGNvZGU7CisgICAgICAgIHNucHJpbnRmKHRtcGJ1ZiwgMTI3LCAiIC8vc2xvdD0lZDp0YWc9
JXMiLCBzbG90LCBvcGNvZGVfbmFtZXNbb3Bjb2RlXSk7CisgICAgICAgIHN0cm5jYXQoYnVmLCB0
bXBidWYsIG4pOworCisgICAgICAgIHN0cm5jYXQoYnVmLCAiXG4iLCBuKTsKKyAgICB9CisgICAg
aWYgKHBrdC0+bnVtX2luc25zID4gMSkgeworICAgICAgICBzdHJuY2F0KGJ1ZiwgIn1cbiIsIG4p
OworICAgIH0KK30KKwotLSAKMi43LjQKCg==

