Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA48C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE702080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D+pPwVCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE702080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83uE-0008BX-1B
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tB-0006ML-Bv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:05 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12941)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83t7-0005sP-Bu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765861; x=1629301861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bQRPWfsKM9qpLNg89vDVScDdwjLkWk2uKejns4QrTCk=;
 b=D+pPwVCxVU+te8wXJR4QbjQKbHJTbZHKBREYo3ruOhWMqGbrlezzNAAo
 nWPS3iAiTsvO13wenjp8SD47nUzAawyvbKDMOkeCe/Evb1HzcH2ukRsWX
 nkqDq/yBDPCPGk0NuLg+FeUwY8EzsIMu+GuOJBxZWwHeZDbpdQ08JOWec o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 18 Aug 2020 08:50:56 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 21B447BD; Tue, 18 Aug 2020 10:50:56 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 10/34] Hexagon (target/hexagon) instruction and packet
 types
Date: Tue, 18 Aug 2020 10:50:23 -0500
Message-Id: <1597765847-16637-11-git-send-email-tsimpson@quicinc.com>
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

VGhlIGluc25fdCBhbmQgcGFja2V0X3QgYXJlIHRoZSBpbnRlcmZhY2UgYmV0d2VlbiBpbnN0cnVj
dGlvbiBkZWNvZGluZyBhbmQKVENHIGNvZGUgZ2VuZXJhdGlvbgoKU2lnbmVkLW9mZi1ieTogVGF5
bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
c24uaCB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXQvaGV4YWdvbi9pbnNuLmgKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnNu
LmggYi90YXJnZXQvaGV4YWdvbi9pbnNuLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMC4uYWEyZDFkZAotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2luc24uaApA
QCAtMCwwICsxLDc1IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjAgUXVhbGNvbW0g
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
TlNOX0gKKyNkZWZpbmUgSEVYQUdPTl9JTlNOX0gKKworI2luY2x1ZGUgImNwdS5oIgorI2luY2x1
ZGUgImhleF9hcmNoX3R5cGVzLmgiCisKKyNkZWZpbmUgSU5TVFJVQ1RJT05TX01BWCA3ICAgIC8q
IDIgcGFpcnMgKyBsb29wZW5kICovCisjZGVmaW5lIFJFR19PUEVSQU5EU19NQVggNQorI2RlZmlu
ZSBJTU1FRFNfTUFYIDIKKworc3RydWN0IEluc3RydWN0aW9uOworc3RydWN0IFBhY2tldDsKK3N0
cnVjdCBEaXNhc0NvbnRleHQ7CisKK3R5cGVkZWYgdm9pZCAoKnNlbWFudGljX2luc25fdCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBEaXNhc0NvbnRleHQgKmN0eCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IEluc3RydWN0aW9uICppbnNuLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgUGFja2V0ICpwa3QpOworCitzdHJ1Y3QgSW5zdHJ1Y3Rpb24geworICAgIHNlbWFudGlj
X2luc25fdCBnZW5lcmF0ZTsgICAgICAgICAgICAvKiBwb2ludGVyIHRvIGdlbnB0ciByb3V0aW5l
ICovCisgICAgc2l6ZTF1X3QgcmVnbm9bUkVHX09QRVJBTkRTX01BWF07ICAgIC8qIHJlZyBvcGVy
YW5kcyBpbmNsdWRpbmcgcHJlZGljYXRlcyAqLworICAgIHNpemUydV90IG9wY29kZTsKKworICAg
IHNpemU0dV90IGljbGFzczo2OworICAgIHNpemU0dV90IHNsb3Q6MzsKKyAgICBzaXplNHVfdCBw
YXJ0MToxOyAgICAgICAgLyoKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogY21wLWp1
bXBzIGFyZSBzcGxpdCBpbnRvIHR3byBpbnNucy4KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICogc2V0IGZvciB0aGUgY29tcGFyZSBhbmQgY2xlYXIgZm9yIHRoZSBqdW1wCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqLworICAgIHNpemU0dV90IGV4dGVuc2lvbl92YWxpZDox
OyAgIC8qIEhhcyBhIGNvbnN0YW50IGV4dGVuZGVyIGF0dGFjaGVkICovCisgICAgc2l6ZTR1X3Qg
d2hpY2hfZXh0ZW5kZWQ6MTsgICAgLyogSWYgaGFzIGFuIGV4dGVuZGVyLCB3aGljaCBpbW1lZGlh
dGUgKi8KKyAgICBzaXplNHVfdCBpc19lbmRsb29wOjE7ICAgLyogVGhpcyBpcyBhbiBlbmQgb2Yg
bG9vcCAqLworICAgIHNpemU0dV90IG5ld192YWx1ZV9wcm9kdWNlcl9zbG90OjQ7CisgICAgc2l6
ZTRzX3QgaW1tZWRbSU1NRURTX01BWF07ICAgIC8qIGltbWVkaWF0ZSBmaWVsZCAqLworfTsKKwor
dHlwZWRlZiBzdHJ1Y3QgSW5zdHJ1Y3Rpb24gaW5zbl90OworCitzdHJ1Y3QgUGFja2V0IHsKKyAg
ICBzaXplMnVfdCBudW1faW5zbnM7CisgICAgc2l6ZTJ1X3QgZW5jb2RfcGt0X3NpemVfaW5fYnl0
ZXM7CisKKyAgICAvKiBQcmUtZGVjb2RlcyBhYm91dCBDT0YgKi8KKyAgICBzaXplOHVfdCBwa3Rf
aGFzX2NvZjoxOyAgICAgICAgICAvKiBIYXMgYW55IGNoYW5nZS1vZi1mbG93ICovCisgICAgc2l6
ZTh1X3QgcGt0X2hhc19lbmRsb29wOjE7CisKKyAgICBzaXplOHVfdCBwa3RfaGFzX2RjemVyb2E6
MTsKKworICAgIHNpemU4dV90IHBrdF9oYXNfc3RvcmVfczA6MTsKKyAgICBzaXplOHVfdCBwa3Rf
aGFzX3N0b3JlX3MxOjE7CisKKyAgICBpbnNuX3QgaW5zbltJTlNUUlVDVElPTlNfTUFYXTsKK307
CisKK3R5cGVkZWYgc3RydWN0IFBhY2tldCBwYWNrZXRfdDsKKworI2VuZGlmCi0tIAoyLjcuNAoK

