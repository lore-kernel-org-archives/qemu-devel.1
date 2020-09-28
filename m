Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB4DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E23A208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="khh02l7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E23A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxCF-0004Vx-Bb
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMwxi-0002nN-BU
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:29:18 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51862)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMwxd-0007uu-VD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601314153; x=1632850153;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AeWNPnD8Ws4V82nyUVwdy/8dg209/+fEngliZUkYbZ4=;
 b=khh02l7bxK5JWXfL6O/EIfcU9uCV3a6kiGABCWdCKZI8EPIXhP61ebly
 kfIk0Vyv+oUFHUaT4T1JTD1Jve+sR7etnu9Fca04P9ZM+sXNnbtsH1osl
 yPg6mcbSqWseJo8Qqz4M0IHfGmIgbFLgJ/OTpWQj64RhSKBQouEZ4T0Ii A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Sep 2020 10:29:04 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 28 Sep 2020 10:29:02 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 9A2D7FE5; Mon, 28 Sep 2020 12:29:02 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 10/29] Hexagon (target/hexagon) instruction and packet
 types
Date: Mon, 28 Sep 2020 12:28:39 -0500
Message-Id: <1601314138-9930-11-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 13:29:03
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, tsimpson@quicinc.com, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGluc25fdCBhbmQgcGFja2V0X3QgYXJlIHRoZSBpbnRlcmZhY2UgYmV0d2VlbiBpbnN0cnVj
dGlvbiBkZWNvZGluZyBhbmQKVENHIGNvZGUgZ2VuZXJhdGlvbgoKU2lnbmVkLW9mZi1ieTogVGF5
bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
c24uaCB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXQvaGV4YWdvbi9pbnNuLmgKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnNu
LmggYi90YXJnZXQvaGV4YWdvbi9pbnNuLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMC4uMDg3Y2M2ZQotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2luc24uaApA
QCAtMCwwICsxLDc0IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjAgUXVhbGNvbW0g
SW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhp
cyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9v
ciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0
aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQg
QU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBN
RVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUg
dGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAq
CisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUg
PGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNpZm5kZWYgSEVYQUdPTl9J
TlNOX0gKKyNkZWZpbmUgSEVYQUdPTl9JTlNOX0gKKworI2luY2x1ZGUgImNwdS5oIgorCisjZGVm
aW5lIElOU1RSVUNUSU9OU19NQVggNyAgICAvKiAyIHBhaXJzICsgbG9vcGVuZCAqLworI2RlZmlu
ZSBSRUdfT1BFUkFORFNfTUFYIDUKKyNkZWZpbmUgSU1NRURTX01BWCAyCisKK3N0cnVjdCBJbnN0
cnVjdGlvbjsKK3N0cnVjdCBQYWNrZXQ7CitzdHJ1Y3QgRGlzYXNDb250ZXh0OworCit0eXBlZGVm
IHZvaWQgKCpzZW1hbnRpY19pbnNuX3QpKENQVUhleGFnb25TdGF0ZSAqZW52LAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgRGlzYXNDb250ZXh0ICpjdHgsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBJbnN0cnVjdGlvbiAqaW5zbiwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IFBhY2tldCAqcGt0KTsKKworc3RydWN0
IEluc3RydWN0aW9uIHsKKyAgICBzZW1hbnRpY19pbnNuX3QgZ2VuZXJhdGU7ICAgICAgICAgICAg
LyogcG9pbnRlciB0byBnZW5wdHIgcm91dGluZSAqLworICAgIHVpbnQ4X3QgcmVnbm9bUkVHX09Q
RVJBTkRTX01BWF07ICAgIC8qIHJlZyBvcGVyYW5kcyBpbmNsdWRpbmcgcHJlZGljYXRlcyAqLwor
ICAgIHVpbnQxNl90IG9wY29kZTsKKworICAgIHVpbnQzMl90IGljbGFzczo2OworICAgIHVpbnQz
Ml90IHNsb3Q6MzsKKyAgICB1aW50MzJfdCBwYXJ0MToxOyAgICAgICAgLyoKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICogY21wLWp1bXBzIGFyZSBzcGxpdCBpbnRvIHR3byBpbnNucy4K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogc2V0IGZvciB0aGUgY29tcGFyZSBhbmQg
Y2xlYXIgZm9yIHRoZSBqdW1wCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworICAg
IHVpbnQzMl90IGV4dGVuc2lvbl92YWxpZDoxOyAgIC8qIEhhcyBhIGNvbnN0YW50IGV4dGVuZGVy
IGF0dGFjaGVkICovCisgICAgdWludDMyX3Qgd2hpY2hfZXh0ZW5kZWQ6MTsgICAgLyogSWYgaGFz
IGFuIGV4dGVuZGVyLCB3aGljaCBpbW1lZGlhdGUgKi8KKyAgICB1aW50MzJfdCBpc19lbmRsb29w
OjE7ICAgLyogVGhpcyBpcyBhbiBlbmQgb2YgbG9vcCAqLworICAgIHVpbnQzMl90IG5ld192YWx1
ZV9wcm9kdWNlcl9zbG90OjQ7CisgICAgaW50MzJfdCBpbW1lZFtJTU1FRFNfTUFYXTsgICAgLyog
aW1tZWRpYXRlIGZpZWxkICovCit9OworCit0eXBlZGVmIHN0cnVjdCBJbnN0cnVjdGlvbiBpbnNu
X3Q7CisKK3N0cnVjdCBQYWNrZXQgeworICAgIHVpbnQxNl90IG51bV9pbnNuczsKKyAgICB1aW50
MTZfdCBlbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKKworICAgIC8qIFByZS1kZWNvZGVzIGFib3V0
IENPRiAqLworICAgIHVpbnQzMl90IHBrdF9oYXNfY29mOjE7ICAgICAgICAgIC8qIEhhcyBhbnkg
Y2hhbmdlLW9mLWZsb3cgKi8KKyAgICB1aW50MzJfdCBwa3RfaGFzX2VuZGxvb3A6MTsKKworICAg
IHVpbnQzMl90IHBrdF9oYXNfZGN6ZXJvYToxOworCisgICAgdWludDMyX3QgcGt0X2hhc19zdG9y
ZV9zMDoxOworICAgIHVpbnQzMl90IHBrdF9oYXNfc3RvcmVfczE6MTsKKworICAgIGluc25fdCBp
bnNuW0lOU1RSVUNUSU9OU19NQVhdOworfTsKKwordHlwZWRlZiBzdHJ1Y3QgUGFja2V0IHBhY2tl
dF90OworCisjZW5kaWYKLS0gCjIuNy40Cgo=

