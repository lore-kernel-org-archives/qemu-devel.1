Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78915C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A76F21531
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YNHDKgUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A76F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsQg-0005oI-Ux
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOv-000424-9W
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:05 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46905)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOn-0005es-90
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601296617; x=1632832617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FfAKiW+Y7y2GYUYEpj8f4aX5CuKrQ9AbTYi3jFlVKos=;
 b=YNHDKgUK4y4aF02fDdFN7ucLmdHHuQeDkYxxrJAnv/9/QY4/XohiumsT
 i/Sc99wKGfK4qpB2rXy6LQtS5LsSX/g3cvb5H5GbOAzychp4RGtdOVEXj
 pk9D0RtKTYAtJUXC3LTWoZsc9Q6c2+D2mLaiKFSOZoHVnivKHYsJJJbAb 0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Sep 2020 05:36:52 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 28 Sep 2020 05:36:52 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 3E5E4CE1; Mon, 28 Sep 2020 07:36:52 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v4 11/29] Hexagon (target/hexagon) register fields
Date: Mon, 28 Sep 2020 07:36:30 -0500
Message-Id: <1601296608-29390-12-git-send-email-tsimpson@quicinc.com>
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

RGVjbGFyZSBiaXRmaWVsZHMgd2l0aGluIHJlZ2lzdGVycyBzdWNoIGFzIHVzZXIgc3RhdHVzIHJl
Z2lzdGVyIChVU1IpCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVp
Y2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oICAgICB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxk
c19kZWYuaCB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzLmMgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQv
aGV4YWdvbi9yZWdfZmllbGRzLmMKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9yZWdfZmll
bGRzLmggYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMC4uNzA2YzNlOQotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29u
L3JlZ19maWVsZHMuaApAQCAtMCwwICsxLDM2IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5
LTIwMjAgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZl
ZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisg
KiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9n
cmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisg
KiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2Fy
cmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3Jh
bTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNp
Zm5kZWYgSEVYQUdPTl9SRUdfRklFTERTX0gKKyNkZWZpbmUgSEVYQUdPTl9SRUdfRklFTERTX0gK
KwordHlwZWRlZiBzdHJ1Y3QgeworICAgIGludCBvZmZzZXQ7CisgICAgaW50IHdpZHRoOworfSBy
ZWdfZmllbGRfdDsKKworZXh0ZXJuIGNvbnN0IHJlZ19maWVsZF90IHJlZ19maWVsZF9pbmZvW107
CisKK2VudW0geworI2RlZmluZSBERUZfUkVHX0ZJRUxEKFRBRywgU1RBUlQsIFdJRFRIKSBcCisg
ICAgVEFHLAorI2luY2x1ZGUgInJlZ19maWVsZHNfZGVmLmgiCisgICAgTlVNX1JFR19GSUVMRFMK
KyN1bmRlZiBERUZfUkVHX0ZJRUxECit9OworCisjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL3JlZ19maWVsZHNfZGVmLmggYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5o
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjI3YjIyMzEKLS0tIC9kZXYvbnVs
bAorKysgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oCkBAIC0wLDAgKzEsNDEgQEAK
Ky8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRl
ciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVi
bGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNp
b24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2
ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQor
ICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUu
b3JnL2xpY2Vuc2VzLz4uCisgKi8KKworLyoKKyAqIEZvciByZWdpc3RlcnMgdGhhdCBoYXZlIGlu
ZGl2aWR1YWwgZmllbGRzLCBleHBsYWluIHRoZW0gaGVyZQorICogICBERUZfUkVHX0ZJRUxEKHRh
ZywKKyAqICAgICAgICAgICAgICAgICBiaXQgc3RhcnQgb2Zmc2V0LAorICogICAgICAgICAgICAg
ICAgIHdpZHRoCisgKi8KKworLyogVVNSIGZpZWxkcyAqLworREVGX1JFR19GSUVMRChVU1JfT1ZG
LCAgICAgICAgICAgIDAsIDEpCitERUZfUkVHX0ZJRUxEKFVTUl9GUElOVkYsICAgICAgICAgMSwg
MSkKK0RFRl9SRUdfRklFTEQoVVNSX0ZQREJaRiwgICAgICAgICAyLCAxKQorREVGX1JFR19GSUVM
RChVU1JfRlBPVkZGLCAgICAgICAgIDMsIDEpCitERUZfUkVHX0ZJRUxEKFVTUl9GUFVORkYsICAg
ICAgICAgNCwgMSkKK0RFRl9SRUdfRklFTEQoVVNSX0ZQSU5QRiwgICAgICAgICA1LCAxKQorCitE
RUZfUkVHX0ZJRUxEKFVTUl9MUENGRywgICAgICAgICAgOCwgMikKKworREVGX1JFR19GSUVMRChV
U1JfRlBSTkQsICAgICAgICAgMjIsIDIpCisKK0RFRl9SRUdfRklFTEQoVVNSX0ZQSU5WRSwgICAg
ICAgIDI1LCAxKQorREVGX1JFR19GSUVMRChVU1JfRlBEQlpFLCAgICAgICAgMjYsIDEpCitERUZf
UkVHX0ZJRUxEKFVTUl9GUE9WRkUsICAgICAgICAyNywgMSkKK0RFRl9SRUdfRklFTEQoVVNSX0ZQ
VU5GRSwgICAgICAgIDI4LCAxKQorREVGX1JFR19GSUVMRChVU1JfRlBJTlBFLCAgICAgICAgMjks
IDEpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzLmMgYi90YXJnZXQvaGV4
YWdvbi9yZWdfZmllbGRzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uOGU2
YTE4OAotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHMuYwpAQCAt
MCwwICsxLDI4IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjAgUXVhbGNvbW0gSW5u
b3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247
IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
CisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisg
KiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0
dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNpbmNsdWRlICJxZW11L29zZGVw
LmgiCisjaW5jbHVkZSAicmVnX2ZpZWxkcy5oIgorCitjb25zdCByZWdfZmllbGRfdCByZWdfZmll
bGRfaW5mb1tdID0geworI2RlZmluZSBERUZfUkVHX0ZJRUxEKFRBRywgU1RBUlQsIFdJRFRIKSAg
ICBcCisgICAgICB7IFNUQVJULCBXSURUSCB9LAorI2luY2x1ZGUgInJlZ19maWVsZHNfZGVmLmgi
CisgICAgICB7IDAsIDAgfQorI3VuZGVmIERFRl9SRUdfRklFTEQKK307CisKLS0gCjIuNy40Cgo=

