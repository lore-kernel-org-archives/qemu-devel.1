Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7DC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD40B20733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fT/04AA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD40B20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jgb-0001aA-Mu
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbu-0000ye-Ri
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-00056Y-5t
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbr-0004rG-5O
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381663; x=1612917663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YKyXz9BJGWk0HFTvLbxOeHB6m1PFDX/vuoM82Z6Pb4k=;
 b=fT/04AA6v54Rmp1JQjUH54+6YRBbJVt5bMwlcvxY/YXo0fptV6qK1bhK
 p/D+FiE2/tY/h5w6hMPwMQOGER1c0DfNVmV3J3y2JLeHOz6VgE90AkfzN
 wENd0GNC3Vz6mkWyKpXKsvtsj7wP3tkdoJ18CTRJnpGz1wLIc7+brS0Be I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:40:59 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 5E9F31B5B; Mon, 10 Feb 2020 18:40:58 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/66] Hexagon instruction printing
Date: Mon, 10 Feb 2020 18:39:52 -0600
Message-Id: <1581381644-13678-15-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
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
IHRhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jIHwgOTMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmggfCAyNiAr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXQvaGV4YWdvbi9wcmludGluc24uaAoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3ByaW50aW5zbi5jIGIvdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uY2IxMDA0YgotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3ByaW50aW5zbi5jCkBAIC0wLDAgKzEsOTMgQEAKKy8qCisgKiAgQ29weXJpZ2h0IChj
KSAyMDE5IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2
ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgor
ICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAor
ICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dy
YW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLworCisj
aW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlICJxZW11L29z
ZGVwLmgiCisjaW5jbHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInByaW50aW5zbi5oIgorI2lu
Y2x1ZGUgImluc24uaCIKKyNpbmNsdWRlICJtYWNyb3MuaCIKKyNpbmNsdWRlICJpbnRlcm5hbC5o
IgorCitzdGF0aWMgY29uc3QgY2hhciAqc3JlZzJzdHIodW5zaWduZWQgaW50IHJlZykKK3sKKyAg
ICBpZiAocmVnIDwgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKSB7CisgICAgICAgIHJldHVybiBoZXhh
Z29uX3JlZ25hbWVzW3JlZ107CisgICAgfSBlbHNlIHsKKyAgICAgICAgcmV0dXJuICI/Pz8iOwor
ICAgIH0KK30KKworc3RhdGljIGNvbnN0IGNoYXIgKmNyZWcyc3RyKHVuc2lnbmVkIGludCByZWcp
Cit7CisgICAgcmV0dXJuIHNyZWcyc3RyKHJlZyArIE5VTV9HRU5fUkVHUyk7Cit9CisKK3N0YXRp
YyB2b2lkIHNucHJpbnRpbnNuKGNoYXIgKmJ1ZiwgaW50IG4sIGluc25fdCAqIGluc24pCit7Cisg
ICAgc3dpdGNoIChpbnNuLT5vcGNvZGUpIHsKKyNkZWZpbmUgREVGX1ZFQ1hfUFJJTlRJTkZPKFRB
RywgRk1ULCAuLi4pIERFRl9QUklOVElORk8oVEFHLCBGTVQsIF9fVkFfQVJHU19fKQorI2RlZmlu
ZSBERUZfUFJJTlRJTkZPKFRBRywgRk1ULCAuLi4pIFwKKyAgICBjYXNlIFRBRzogXAorICAgICAg
ICBzbnByaW50ZihidWYsIG4sIEZNVCwgX19WQV9BUkdTX18pO1wKKyAgICAgICAgYnJlYWs7Cisj
aW5jbHVkZSAicHJpbnRpbnNuX2dlbmVyYXRlZC5oIgorI3VuZGVmIERFRl9WRUNYX1BSSU5USU5G
TworI3VuZGVmIERFRl9QUklOVElORk8KKyAgICB9Cit9CisKK3ZvaWQgc25wcmludF9hX3BrdChj
aGFyICpidWYsIGludCBuLCBwYWNrZXRfdCAqIHBrdCkKK3sKKyAgICBjaGFyIHRtcGJ1ZlsxMjhd
OworICAgIGJ1ZlswXSA9ICdcMCc7CisgICAgaW50IGksIHNsb3QsIG9wY29kZTsKKworICAgIGlm
IChwa3QgPT0gTlVMTCkgeworICAgICAgICBzbnByaW50ZihidWYsIG4sICI8cHJpbnRwa3Q6IE5V
TEwgcHRyPiIpOworICAgICAgICByZXR1cm47CisgICAgfQorCisgICAgaWYgKHBrdC0+bnVtX2lu
c25zID4gMSkgeworICAgICAgICBzdHJuY2F0KGJ1ZiwgIlxue1xuIiwgbik7CisgICAgfQorICAg
IGZvciAoaSA9IDA7IGkgPCBwa3QtPm51bV9pbnNuczsgaSsrKSB7CisgICAgICAgIGlmIChwa3Qt
Pmluc25baV0ucGFydDEpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICB9CisgICAg
ICAgIHNucHJpbnRpbnNuKHRtcGJ1ZiwgMTI3LCAmKHBrdC0+aW5zbltpXSkpOworICAgICAgICBz
dHJuY2F0KGJ1ZiwgIlx0Iiwgbik7CisgICAgICAgIHN0cm5jYXQoYnVmLCB0bXBidWYsIG4pOwor
ICAgICAgICBpZiAoR0VUX0FUVFJJQihwa3QtPmluc25baV0ub3Bjb2RlLCBBX1NVQklOU04pKSB7
CisgICAgICAgICAgICBzdHJuY2F0KGJ1ZiwgIiAvL3N1Ymluc24iLCBuKTsKKyAgICAgICAgfQor
ICAgICAgICBpZiAocGt0LT5pbnNuW2ldLmV4dGVuc2lvbl92YWxpZCkgeworICAgICAgICAgICAg
c3RybmNhdChidWYsICIgLy9jb25zdGFudCBleHRlbmRlZCIsIG4pOworICAgICAgICB9CisgICAg
ICAgIHNsb3QgPSBwa3QtPmluc25baV0uc2xvdDsKKyAgICAgICAgb3Bjb2RlID0gcGt0LT5pbnNu
W2ldLm9wY29kZTsKKyAgICAgICAgc25wcmludGYodG1wYnVmLCAxMjcsICIgLy9zbG90PSVkOnRh
Zz0lcyIsIHNsb3QsIG9wY29kZV9uYW1lc1tvcGNvZGVdKTsKKyAgICAgICAgc3RybmNhdChidWYs
IHRtcGJ1Ziwgbik7CisKKyAgICAgICAgc3RybmNhdChidWYsICJcbiIsIG4pOworICAgIH0KKyAg
ICBpZiAocGt0LT5udW1faW5zbnMgPiAxKSB7CisgICAgICAgIHN0cm5jYXQoYnVmLCAifVxuIiwg
bik7CisgICAgfQorfQorCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9wcmludGluc24uaCBi
L3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAuLjY0YWY3NWMKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9wcmludGlu
c24uaApAQCAtMCwwICsxLDI2IEBACisvKgorICogIENvcHlyaWdodCAoYykgMjAxOSBRdWFsY29t
bSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBU
aGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBv
cHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9V
VCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICog
IE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNl
ZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgor
ICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNl
ZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworI2lmbmRlZiBQUklOVElO
U05fSAorI2RlZmluZSBQUklOVElOU05fSAorCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRl
ICJpbnNuLmgiCisKK2V4dGVybiB2b2lkIHNucHJpbnRfYV9wa3QoY2hhciAqYnVmLCBpbnQgbiwg
cGFja2V0X3QgKnBrdCk7CisKKyNlbmRpZgotLSAKMi43LjQKCg==

