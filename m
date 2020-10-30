Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001472068E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="upQkqgZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001472068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIBZ-0007eh-Jx
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHyR-0003sU-BT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:08:55 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:54820)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHyL-0005RE-G0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604016529; x=1635552529;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OU3eiNWH0dvHEp0gcXayEbYHbKv2nxVLisPkhN0hwbo=;
 b=upQkqgZIXOtNYbCBStJRZ5+K47JUPICtZfe7nHMYrcDRTzBchJYwpvYe
 4a+cWH36aHuwc+CIUXQ7znWS51MvwgDqm6Tq1T5bUZBsARlz8eAgqaoZP
 RyAAyNyy0aLibWnRJR+ycjR+hzxnrvIib4Z5kfTCx2BsIRHAVHG2HsV5I c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Oct 2020 17:08:44 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 29 Oct 2020 17:08:44 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 5F6524119; Thu, 29 Oct 2020 19:08:43 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 05/33] Hexagon (disas) disassembler
Date: Thu, 29 Oct 2020 19:08:11 -0500
Message-Id: <1604016519-28065-6-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604016519-28065-1-git-send-email-tsimpson@quicinc.com>
References: <1604016519-28065-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 19:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: ale@rev.ng, bcain@quicinc.com, richard.henderson@linaro.org,
 at.org@qualcomm.com, laurent@vivier.eu, tsimpson@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIGhleGFnb24gdG8gZGlzYXMvbWVzb24uYnVpbGQKQWRkIGRpc2FzL2hleGFnb24uYwpBZGQg
aGV4YWdvbiB0byBpbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaAoKU2lnbmVkLW9mZi1ieTogVGF5bG9y
IFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIGluY2x1ZGUvZGlzYXMvZGlzLWFz
bS5oIHwgIDEgKwogZGlzYXMvaGV4YWdvbi5jICAgICAgICAgfCA2OCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBkaXNhcy9tZXNvbi5idWlsZCAgICAg
ICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRpc2FzL2hleGFnb24uYwoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZGlzYXMvZGlzLWFz
bS5oIGIvaW5jbHVkZS9kaXNhcy9kaXMtYXNtLmgKaW5kZXggMjE2NDc2Mi4uMWY1NGZjMCAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9kaXNhcy9kaXMtYXNtLmgKKysrIGIvaW5jbHVkZS9kaXNhcy9kaXMt
YXNtLmgKQEAgLTQ1OSw2ICs0NTksNyBAQCBpbnQgcHJpbnRfaW5zbl94dGVuc2EgICAgICAgICAg
IChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7CiBpbnQgcHJpbnRfaW5zbl9yaXNjdjMyICAg
ICAgICAgIChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7CiBpbnQgcHJpbnRfaW5zbl9yaXNj
djY0ICAgICAgICAgIChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7CiBpbnQgcHJpbnRfaW5z
bl9yeChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvICopOworaW50IHByaW50X2luc25faGV4YWdv
bihiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvICopOwogCiAjaWZkZWYgQ09ORklHX0NBUFNUT05F
CiBib29sIGNhcF9kaXNhc190YXJnZXQoZGlzYXNzZW1ibGVfaW5mbyAqaW5mbywgdWludDY0X3Qg
cGMsIHNpemVfdCBzaXplKTsKZGlmZiAtLWdpdCBhL2Rpc2FzL2hleGFnb24uYyBiL2Rpc2FzL2hl
eGFnb24uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi45NjhmMTFjCi0tLSAv
ZGV2L251bGwKKysrIGIvZGlzYXMvaGV4YWdvbi5jCkBAIC0wLDAgKzEsNjggQEAKKy8qCisgKiAg
Q29weXJpZ2h0KGMpIDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBB
bGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5
CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0
aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgor
ICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3
aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25n
IHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vu
c2VzLz4uCisgKi8KKworLyoKKyAqIFFFTVUgSGV4YWdvbiBEaXNhc3NlbWJsZXIKKyAqLworCisj
aW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImRpc2FzL2Rpcy1hc20uaCIKKyNpbmNs
dWRlICJ0YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oIgorCisvKgorICogV2Ugd2lsbCBkaXNhc3Nl
bWJsZSBhIHBhY2tldCB3aXRoIHVwIHRvIDQgaW5zdHJ1Y3Rpb25zLCBzbyB3ZSBuZWVkCisgKiBh
IGhlZnR5IHNpemUgYnVmZmVyLgorICovCisjZGVmaW5lIFBBQ0tFVF9CVUZGRVJfTEVOICAgICAg
ICAgICAgICAgICAgIDEwMjgKKworaW50IHByaW50X2luc25faGV4YWdvbihiZmRfdm1hIG1lbWFk
ZHIsIHN0cnVjdCBkaXNhc3NlbWJsZV9pbmZvICppbmZvKQoreworICAgIHVpbnQzMl90IHdvcmRz
W1BBQ0tFVF9XT1JEU19NQVhdOworICAgIGJvb2wgZm91bmRfZW5kID0gZmFsc2U7CisgICAgY2hh
ciBidWZbUEFDS0VUX0JVRkZFUl9MRU5dOworICAgIGludCBpOworCisgICAgZm9yIChpID0gMDsg
aSA8IFBBQ0tFVF9XT1JEU19NQVggJiYgIWZvdW5kX2VuZDsgaSsrKSB7CisgICAgICAgIGludCBz
dGF0dXMgPSAoKmluZm8tPnJlYWRfbWVtb3J5X2Z1bmMpKG1lbWFkZHIgKyBpICogc2l6ZW9mKHVp
bnQzMl90KSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KGJmZF9ieXRlICopJndvcmRzW2ldLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzaXplb2YodWludDMyX3QpLCBpbmZvKTsKKyAgICAgICAgaWYgKHN0YXR1
cykgeworICAgICAgICAgICAgaWYgKGkgPiAwKSB7CisgICAgICAgICAgICAgICAgYnJlYWs7Cisg
ICAgICAgICAgICB9CisgICAgICAgICAgICAoKmluZm8tPm1lbW9yeV9lcnJvcl9mdW5jKShzdGF0
dXMsIG1lbWFkZHIsIGluZm8pOworICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsKKyAgICAgICAg
fQorICAgICAgICBpZiAoaXNfcGFja2V0X2VuZCh3b3Jkc1tpXSkpIHsKKyAgICAgICAgICAgIGZv
dW5kX2VuZCA9IHRydWU7CisgICAgICAgIH0KKyAgICB9CisKKyAgICBpZiAoIWZvdW5kX2VuZCkg
eworICAgICAgICAoKmluZm8tPmZwcmludGZfZnVuYykoaW5mby0+c3RyZWFtLCAiPGludmFsaWQ+
Iik7CisgICAgICAgIHJldHVybiBQQUNLRVRfV09SRFNfTUFYICogNDsKKyAgICB9CisKKyAgICBp
bnQgbGVuID0gZGlzYXNzZW1ibGVfaGV4YWdvbih3b3JkcywgaSwgbWVtYWRkciwgYnVmLCBQQUNL
RVRfQlVGRkVSX0xFTik7CisgICAgaW50IHNsZW4gPSBzdHJsZW4oYnVmKTsKKyAgICBpZiAoYnVm
W3NsZW4gLSAxXSA9PSAnXG4nKSB7CisgICAgICAgIGJ1ZltzbGVuIC0gMV0gPSAnXDAnOworICAg
IH0KKyAgICAoKmluZm8tPmZwcmludGZfZnVuYykoaW5mby0+c3RyZWFtLCAiJXMiLCBidWYpOwor
CisgICAgcmV0dXJuIGxlbjsKK30KZGlmZiAtLWdpdCBhL2Rpc2FzL21lc29uLmJ1aWxkIGIvZGlz
YXMvbWVzb24uYnVpbGQKaW5kZXggMDlhODUyNy4uYmU4NzhjMCAxMDA2NDQKLS0tIGEvZGlzYXMv
bWVzb24uYnVpbGQKKysrIGIvZGlzYXMvbWVzb24uYnVpbGQKQEAgLTcsNiArNyw3IEBAIGNvbW1v
bl9zcy5hZGRfYWxsKHdoZW46ICdDT05GSUdfQVJNX0E2NF9ESVMnLCBpZl90cnVlOiBsaWJ2aXhs
X3NzKQogY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FSTV9ESVMnLCBpZl90cnVlOiBmaWxl
cygnYXJtLmMnKSkKIGNvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19DUklTX0RJUycsIGlmX3Ry
dWU6IGZpbGVzKCdjcmlzLmMnKSkKIGNvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19IUFBBX0RJ
UycsIGlmX3RydWU6IGZpbGVzKCdocHBhLmMnKSkKK2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJ
R19IRVhBR09OX0RJUycsIGlmX3RydWU6IGZpbGVzKCdoZXhhZ29uLmMnKSkKIGNvbW1vbl9zcy5h
ZGQod2hlbjogJ0NPTkZJR19JMzg2X0RJUycsIGlmX3RydWU6IGZpbGVzKCdpMzg2LmMnKSkKIGNv
bW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19MTTMyX0RJUycsIGlmX3RydWU6IGZpbGVzKCdsbTMy
LmMnKSkKIGNvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19NNjhLX0RJUycsIGlmX3RydWU6IGZp
bGVzKCdtNjhrLmMnKSkKLS0gCjIuNy40Cgo=

