Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C5FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE1C2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="sDvRk1bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE1C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83vy-0003Kx-Qv
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tE-0006Sr-2K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:08 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55167)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83t7-0005sR-BC
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765861; x=1629301861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1sZWvPe4HVPYky0v9M2SBr2hH+kG9q1iAflUAapNOhA=;
 b=sDvRk1bswHpCkz1mt/BEjVNzMKNtuOFtyJ/7/gAUXhwIYaAh7RgeuLlT
 0mhu61S0myAGkt/1SsWWnGt8lgAJ9u8o2AryLAi/pZEd2fzLPfUuX6uF1
 6UA8K+g/ngc6+NWUCiSZ5IsVw0BoZEfft7Sh3iUJMSznfoI3tSy3gKjI1 0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id A3F1F1B13; Tue, 18 Aug 2020 10:50:56 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 15/34] Hexagon (target/hexagon) instruction printing
Date: Tue, 18 Aug 2020 10:50:28 -0500
Message-Id: <1597765847-16637-16-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 11:48:34
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

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5oIHwgMjYgKysrKysrKysrKysrKwogdGFyZ2V0L2hl
eGFnb24vcHJpbnRpbnNuLmMgfCA5NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyMCBpbnNlcnRpb25zKCspCiBjcmVhdGUg
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
aGV4YWdvbi9wcmludGluc24uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5i
NmNmZmQ2Ci0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMKQEAg
LTAsMCArMSw5NCBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDIwIFF1YWxjb21tIElu
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
dWRlICJpbnNuLmgiCisjaW5jbHVkZSAicmVnX2ZpZWxkcy5oIgorI2luY2x1ZGUgImludGVybmFs
LmgiCisKKyNkZWZpbmUgUkVHTk8oTlVNKSAoaW5zbi0+cmVnbm9bTlVNXSkKKyNkZWZpbmUgSU1N
Tk8oTlVNKSAoaW5zbi0+aW1tZWRbTlVNXSkKKworc3RhdGljIGNvbnN0IGNoYXIgKnNyZWcyc3Ry
KHVuc2lnbmVkIGludCByZWcpCit7CisgICAgaWYgKHJlZyA8IFRPVEFMX1BFUl9USFJFQURfUkVH
UykgeworICAgICAgICByZXR1cm4gaGV4YWdvbl9yZWduYW1lc1tyZWddOworICAgIH0gZWxzZSB7
CisgICAgICAgIHJldHVybiAiPz8/IjsKKyAgICB9Cit9CisKK3N0YXRpYyBjb25zdCBjaGFyICpj
cmVnMnN0cih1bnNpZ25lZCBpbnQgcmVnKQoreworICAgIHJldHVybiBzcmVnMnN0cihyZWcgKyBO
VU1fR0VOX1JFR1MpOworfQorCitzdGF0aWMgdm9pZCBzbnByaW50aW5zbihjaGFyICpidWYsIGlu
dCBuLCBpbnNuX3QgKiBpbnNuKQoreworICAgIHN3aXRjaCAoaW5zbi0+b3Bjb2RlKSB7CisjZGVm
aW5lIERFRl9WRUNYX1BSSU5USU5GTyhUQUcsIEZNVCwgLi4uKSBERUZfUFJJTlRJTkZPKFRBRywg
Rk1ULCBfX1ZBX0FSR1NfXykKKyNkZWZpbmUgREVGX1BSSU5USU5GTyhUQUcsIEZNVCwgLi4uKSBc
CisgICAgY2FzZSBUQUc6IFwKKyAgICAgICAgc25wcmludGYoYnVmLCBuLCBGTVQsIF9fVkFfQVJH
U19fKTtcCisgICAgICAgIGJyZWFrOworI2luY2x1ZGUgInByaW50aW5zbl9nZW5lcmF0ZWQuaCIK
KyN1bmRlZiBERUZfVkVDWF9QUklOVElORk8KKyN1bmRlZiBERUZfUFJJTlRJTkZPCisgICAgfQor
fQorCit2b2lkIHNucHJpbnRfYV9wa3QoY2hhciAqYnVmLCBpbnQgbiwgcGFja2V0X3QgKiBwa3Qp
Cit7CisgICAgY2hhciB0bXBidWZbMTI4XTsKKyAgICBidWZbMF0gPSAnXDAnOworICAgIGludCBp
LCBzbG90LCBvcGNvZGU7CisKKyAgICBpZiAocGt0ID09IE5VTEwpIHsKKyAgICAgICAgc25wcmlu
dGYoYnVmLCBuLCAiPHByaW50cGt0OiBOVUxMIHB0cj4iKTsKKyAgICAgICAgcmV0dXJuOworICAg
IH0KKworICAgIGlmIChwa3QtPm51bV9pbnNucyA+IDEpIHsKKyAgICAgICAgc3RybmNhdChidWYs
ICJcbntcbiIsIG4pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7
IGkrKykgeworICAgICAgICBpZiAocGt0LT5pbnNuW2ldLnBhcnQxKSB7CisgICAgICAgICAgICBj
b250aW51ZTsKKyAgICAgICAgfQorICAgICAgICBzbnByaW50aW5zbih0bXBidWYsIDEyNywgJihw
a3QtPmluc25baV0pKTsKKyAgICAgICAgc3RybmNhdChidWYsICJcdCIsIG4pOworICAgICAgICBz
dHJuY2F0KGJ1ZiwgdG1wYnVmLCBuKTsKKyAgICAgICAgaWYgKEdFVF9BVFRSSUIocGt0LT5pbnNu
W2ldLm9wY29kZSwgQV9TVUJJTlNOKSkgeworICAgICAgICAgICAgc3RybmNhdChidWYsICIgLy9z
dWJpbnNuIiwgbik7CisgICAgICAgIH0KKyAgICAgICAgaWYgKHBrdC0+aW5zbltpXS5leHRlbnNp
b25fdmFsaWQpIHsKKyAgICAgICAgICAgIHN0cm5jYXQoYnVmLCAiIC8vY29uc3RhbnQgZXh0ZW5k
ZWQiLCBuKTsKKyAgICAgICAgfQorICAgICAgICBzbG90ID0gcGt0LT5pbnNuW2ldLnNsb3Q7Cisg
ICAgICAgIG9wY29kZSA9IHBrdC0+aW5zbltpXS5vcGNvZGU7CisgICAgICAgIHNucHJpbnRmKHRt
cGJ1ZiwgMTI3LCAiIC8vc2xvdD0lZDp0YWc9JXMiLCBzbG90LCBvcGNvZGVfbmFtZXNbb3Bjb2Rl
XSk7CisgICAgICAgIHN0cm5jYXQoYnVmLCB0bXBidWYsIG4pOworCisgICAgICAgIHN0cm5jYXQo
YnVmLCAiXG4iLCBuKTsKKyAgICB9CisgICAgaWYgKHBrdC0+bnVtX2luc25zID4gMSkgeworICAg
ICAgICBzdHJuY2F0KGJ1ZiwgIn1cbiIsIG4pOworICAgIH0KK30KKwotLSAKMi43LjQKCg==

