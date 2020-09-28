Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463B3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6A021D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MysiK5I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6A021D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsVT-0002ib-3V
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOq-00040I-W6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:02 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46903)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOn-0005el-8W
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601296617; x=1632832617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nAeZH9Y+mQLnnu3AZ0LQCat5fitYHY1YIfKimPmku6o=;
 b=MysiK5I2QAV43AOQ2obRgbWDhvpSubEKdsIxnEyfrtcwOCzh83l/qmhG
 7R4Hy+uHGHE6pWqZI4wRpyrdN21feJblL67jPmwxlvU4wY0cs3LXuHQno
 TyoouYXwPR2Zf6HrHM/h6GlBDmjfeKHCxYdG2p4BEJuJK46VZuU2w1CcX c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Sep 2020 05:36:52 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 28 Sep 2020 05:36:51 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 9C4EF1253; Mon, 28 Sep 2020 07:36:51 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v4 05/29] Hexagon (disas) disassembler
Date: Mon, 28 Sep 2020 07:36:24 -0500
Message-Id: <1601296608-29390-6-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601296608-29390-1-git-send-email-tsimpson@quicinc.com>
References: <1601296608-29390-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 08:36:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIGhleGFnb24gdG8gZGlzYXMvbWVzb24uYnVpbGQKQWRkIGRpc2FzL2hleGFnb24uYwpBZGQg
aGV4YWdvbiB0byBpbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaAoKU2lnbmVkLW9mZi1ieTogVGF5bG9y
IFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIGluY2x1ZGUvZGlzYXMvZGlzLWFz
bS5oIHwgIDEgKwogZGlzYXMvaGV4YWdvbi5jICAgICAgICAgfCA2MiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBkaXNhcy9tZXNvbi5idWlsZCAgICAg
ICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRpc2FzL2hleGFnb24uYwoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZGlzYXMvZGlzLWFz
bS5oIGIvaW5jbHVkZS9kaXNhcy9kaXMtYXNtLmgKaW5kZXggOTg1NmJmNy4uMTRmZjJiZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9kaXNhcy9kaXMtYXNtLmgKKysrIGIvaW5jbHVkZS9kaXNhcy9kaXMt
YXNtLmgKQEAgLTQ2MCw2ICs0NjAsNyBAQCBpbnQgcHJpbnRfaW5zbl94dGVuc2EgICAgICAgICAg
IChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7CiBpbnQgcHJpbnRfaW5zbl9yaXNjdjMyICAg
ICAgICAgIChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7CiBpbnQgcHJpbnRfaW5zbl9yaXNj
djY0ICAgICAgICAgIChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7CiBpbnQgcHJpbnRfaW5z
bl9yeChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvICopOworaW50IHByaW50X2luc25faGV4YWdv
bihiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvICopOwogCiAjaWYgMAogLyogRmV0Y2ggdGhlIGRp
c2Fzc2VtYmxlciBmb3IgYSBnaXZlbiBCRkQsIGlmIHRoYXQgc3VwcG9ydCBpcyBhdmFpbGFibGUu
ICAqLwpkaWZmIC0tZ2l0IGEvZGlzYXMvaGV4YWdvbi5jIGIvZGlzYXMvaGV4YWdvbi5jCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjZlZTg2NTMKLS0tIC9kZXYvbnVsbAorKysg
Yi9kaXNhcy9oZXhhZ29uLmMKQEAgLTAsMCArMSw2MiBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykg
MjAxOS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVz
ZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJl
ZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBv
cgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMg
cHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVs
LAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVk
IHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZv
ciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHBy
b2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLwor
CisvKgorICogUUVNVSBIZXhhZ29uIERpc2Fzc2VtYmxlcgorICovCisKKyNpbmNsdWRlICJxZW11
L29zZGVwLmgiCisjaW5jbHVkZSAiZGlzYXMvZGlzLWFzbS5oIgorI2luY2x1ZGUgInRhcmdldC9o
ZXhhZ29uL2NwdV9iaXRzLmgiCisKKy8qCisgKiBXZSB3aWxsIGRpc2Fzc2VtYmxlIGEgcGFja2V0
IHdpdGggdXAgdG8gNCBpbnN0cnVjdGlvbnMsIHNvIHdlIG5lZWQKKyAqIGEgaGVmdHkgc2l6ZSBi
dWZmZXIuCisgKi8KKyNkZWZpbmUgUEFDS0VUX0JVRkZFUl9MRU4gICAgICAgICAgICAgICAgICAg
MTAyOAorCitpbnQgcHJpbnRfaW5zbl9oZXhhZ29uKGJmZF92bWEgbWVtYWRkciwgc3RydWN0IGRp
c2Fzc2VtYmxlX2luZm8gKmluZm8pCit7CisgICAgdWludDMyX3Qgd29yZHNbUEFDS0VUX1dPUkRT
X01BWF07CisgICAgaW50IGxlbiwgc2xlbjsKKyAgICBjaGFyIGJ1ZltQQUNLRVRfQlVGRkVSX0xF
Tl07CisgICAgaW50IHN0YXR1czsKKyAgICBpbnQgaTsKKworICAgIGZvciAoaSA9IDA7IGkgPCBQ
QUNLRVRfV09SRFNfTUFYOyBpKyspIHsKKyAgICAgICAgc3RhdHVzID0gKCppbmZvLT5yZWFkX21l
bW9yeV9mdW5jKShtZW1hZGRyICsgaSAqIHNpemVvZih1aW50MzJfdCksCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGJmZF9ieXRlICopJndvcmRzW2ldLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1aW50MzJfdCks
IGluZm8pOworICAgICAgICBpZiAoc3RhdHVzKSB7CisgICAgICAgICAgICBpZiAoaSA+IDApIHsK
KyAgICAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAgICgqaW5m
by0+bWVtb3J5X2Vycm9yX2Z1bmMpKHN0YXR1cywgbWVtYWRkciwgaW5mbyk7CisgICAgICAgICAg
ICByZXR1cm4gc3RhdHVzOworICAgICAgICB9CisgICAgfQorCisgICAgbGVuID0gZGlzYXNzZW1i
bGVfaGV4YWdvbih3b3JkcywgaSwgYnVmLCBQQUNLRVRfQlVGRkVSX0xFTik7CisgICAgc2xlbiA9
IHN0cmxlbihidWYpOworICAgIGlmIChidWZbc2xlbiAtIDFdID09ICdcbicpIHsKKyAgICAgICAg
YnVmW3NsZW4gLSAxXSA9ICdcMCc7CisgICAgfQorICAgICgqaW5mby0+ZnByaW50Zl9mdW5jKShp
bmZvLT5zdHJlYW0sICIlcyIsIGJ1Zik7CisKKyAgICByZXR1cm4gbGVuOworfQorCmRpZmYgLS1n
aXQgYS9kaXNhcy9tZXNvbi5idWlsZCBiL2Rpc2FzL21lc29uLmJ1aWxkCmluZGV4IGJkZTgyODAu
LjQ0NjhkMTAgMTAwNjQ0Ci0tLSBhL2Rpc2FzL21lc29uLmJ1aWxkCisrKyBiL2Rpc2FzL21lc29u
LmJ1aWxkCkBAIC03LDYgKzcsNyBAQCBjb21tb25fc3MuYWRkX2FsbCh3aGVuOiAnQ09ORklHX0FS
TV9BNjRfRElTJywgaWZfdHJ1ZTogbGlidml4bF9zcykKIGNvbW1vbl9zcy5hZGQod2hlbjogJ0NP
TkZJR19BUk1fRElTJywgaWZfdHJ1ZTogZmlsZXMoJ2FybS5jJykpCiBjb21tb25fc3MuYWRkKHdo
ZW46ICdDT05GSUdfQ1JJU19ESVMnLCBpZl90cnVlOiBmaWxlcygnY3Jpcy5jJykpCiBjb21tb25f
c3MuYWRkKHdoZW46ICdDT05GSUdfSFBQQV9ESVMnLCBpZl90cnVlOiBmaWxlcygnaHBwYS5jJykp
Citjb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfSEVYQUdPTl9ESVMnLCBpZl90cnVlOiBmaWxl
cygnaGV4YWdvbi5jJykpCiBjb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfSTM4Nl9ESVMnLCBp
Zl90cnVlOiBmaWxlcygnaTM4Ni5jJykpCiBjb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfTE0z
Ml9ESVMnLCBpZl90cnVlOiBmaWxlcygnbG0zMi5jJykpCiBjb21tb25fc3MuYWRkKHdoZW46ICdD
T05GSUdfTTY4S19ESVMnLCBpZl90cnVlOiBmaWxlcygnbTY4ay5jJykpCi0tIAoyLjcuNAoK

