Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E351C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CD820756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pGICy3kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CD820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYI7I-0003fs-Rr
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHoy-0008LG-UL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 19:59:08 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48752)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHor-0004LT-BZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 19:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604015941; x=1635551941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7B1ZsWx47eUOWaZRfzgF+716TlaMb2rTCKW48OKtRiE=;
 b=pGICy3kbALXvZ8G3QGxJIl2Hg72N7mrCoT2Rf00bAF7lzx6QEJtCklMN
 3XtJ7Aj7+oHS2SUjWdGxbiLvXCwIBj+Tl1MGWE2u4VY6XN9CQt4ZKJstP
 Vayb9D0+5jDugn7bFvVH7FBOdYW+DzrR3EOvz4uoWSzSJgjmD3UEVxrC3 s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Oct 2020 16:58:53 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 29 Oct 2020 16:58:53 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 702A2411C; Thu, 29 Oct 2020 18:58:53 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v5 11/33] Hexagon (target/hexagon) register fields
Date: Thu, 29 Oct 2020 18:58:28 -0500
Message-Id: <1604015931-23005-12-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604015931-23005-1-git-send-email-tsimpson@quicinc.com>
References: <1604015931-23005-1-git-send-email-tsimpson@quicinc.com>
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RGVjbGFyZSBiaXRmaWVsZHMgd2l0aGluIHJlZ2lzdGVycyBzdWNoIGFzIHVzZXIgc3RhdHVzIHJl
Z2lzdGVyIChVU1IpCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVp
Y2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oICAgICB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxk
c19kZWYuaCB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzLmMgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFy
Z2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9o
ZXhhZ29uL3JlZ19maWVsZHMuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVs
ZHMuaCBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHMuaApuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi40ZWM3ZDdjCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkcy5oCkBAIC0wLDAgKzEsMzYgQEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTkt
MjAyMCBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVk
LgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAq
ICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAq
ICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJy
YW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIg
UFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9y
ZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFt
OyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworI2lm
bmRlZiBIRVhBR09OX1JFR19GSUVMRFNfSAorI2RlZmluZSBIRVhBR09OX1JFR19GSUVMRFNfSAor
Cit0eXBlZGVmIHN0cnVjdCB7CisgICAgaW50IG9mZnNldDsKKyAgICBpbnQgd2lkdGg7Cit9IFJl
Z0ZpZWxkOworCitleHRlcm4gY29uc3QgUmVnRmllbGQgcmVnX2ZpZWxkX2luZm9bXTsKKworZW51
bSB7CisjZGVmaW5lIERFRl9SRUdfRklFTEQoVEFHLCBTVEFSVCwgV0lEVEgpIFwKKyAgICBUQUcs
CisjaW5jbHVkZSAicmVnX2ZpZWxkc19kZWYuaCIKKyAgICBOVU1fUkVHX0ZJRUxEUworI3VuZGVm
IERFRl9SRUdfRklFTEQKK307CisKKyNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaCBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmgKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMjdiMjIzMQotLS0gL2Rldi9udWxsCisrKyBi
L3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmgKQEAgLTAsMCArMSw0MSBAQAorLyoKKyAq
ICBDb3B5cmlnaHQoYykgMjAxOS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMu
IEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQg
YnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9m
IHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0
IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxv
bmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGlj
ZW5zZXMvPi4KKyAqLworCisvKgorICogRm9yIHJlZ2lzdGVycyB0aGF0IGhhdmUgaW5kaXZpZHVh
bCBmaWVsZHMsIGV4cGxhaW4gdGhlbSBoZXJlCisgKiAgIERFRl9SRUdfRklFTEQodGFnLAorICog
ICAgICAgICAgICAgICAgIGJpdCBzdGFydCBvZmZzZXQsCisgKiAgICAgICAgICAgICAgICAgd2lk
dGgKKyAqLworCisvKiBVU1IgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKFVTUl9PVkYsICAgICAg
ICAgICAgMCwgMSkKK0RFRl9SRUdfRklFTEQoVVNSX0ZQSU5WRiwgICAgICAgICAxLCAxKQorREVG
X1JFR19GSUVMRChVU1JfRlBEQlpGLCAgICAgICAgIDIsIDEpCitERUZfUkVHX0ZJRUxEKFVTUl9G
UE9WRkYsICAgICAgICAgMywgMSkKK0RFRl9SRUdfRklFTEQoVVNSX0ZQVU5GRiwgICAgICAgICA0
LCAxKQorREVGX1JFR19GSUVMRChVU1JfRlBJTlBGLCAgICAgICAgIDUsIDEpCisKK0RFRl9SRUdf
RklFTEQoVVNSX0xQQ0ZHLCAgICAgICAgICA4LCAyKQorCitERUZfUkVHX0ZJRUxEKFVTUl9GUFJO
RCwgICAgICAgICAyMiwgMikKKworREVGX1JFR19GSUVMRChVU1JfRlBJTlZFLCAgICAgICAgMjUs
IDEpCitERUZfUkVHX0ZJRUxEKFVTUl9GUERCWkUsICAgICAgICAyNiwgMSkKK0RFRl9SRUdfRklF
TEQoVVNSX0ZQT1ZGRSwgICAgICAgIDI3LCAxKQorREVGX1JFR19GSUVMRChVU1JfRlBVTkZFLCAg
ICAgICAgMjgsIDEpCitERUZfUkVHX0ZJRUxEKFVTUl9GUElOUEUsICAgICAgICAyOSwgMSkKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHMuYyBiL3RhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi42NTkwNWQ1Ci0t
LSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5jCkBAIC0wLDAgKzEs
MjcgQEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9u
IENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBs
YXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhl
IGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJ
TElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ug
c2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3
dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNp
bmNsdWRlICJyZWdfZmllbGRzLmgiCisKK2NvbnN0IFJlZ0ZpZWxkIHJlZ19maWVsZF9pbmZvW10g
PSB7CisjZGVmaW5lIERFRl9SRUdfRklFTEQoVEFHLCBTVEFSVCwgV0lEVEgpICAgIFwKKyAgICAg
IHsgU1RBUlQsIFdJRFRIIH0sCisjaW5jbHVkZSAicmVnX2ZpZWxkc19kZWYuaCIKKyAgICAgIHsg
MCwgMCB9CisjdW5kZWYgREVGX1JFR19GSUVMRAorfTsKLS0gCjIuNy40Cgo=

