Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A13C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ABC2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZ1f4Jxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ABC2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIHL-0005pB-Av
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHpE-0000O0-QU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 19:59:24 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:54880)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHpC-0004Kz-AZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 19:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604015962; x=1635551962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ea16rMLO9ENk2mX5wAHnY6ZStYfbopsALMRyKJlSI+A=;
 b=AZ1f4Jxtr8y5DOfogxCkR9Kl1Ym/a9XXs3aoV6AsMWTU5dAdQ9k/AAtZ
 984FQzJeHQ5gQTQ8V+cFiMX+etiA+vAXzcepdENCWJDvTQSPkxk/ecyj8
 ZK/Bea260twHSxa+qB7apkA1D8dbzoEAKkL7LeXG7rSjxgixuSr9h88Es I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Oct 2020 16:58:55 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 29 Oct 2020 16:58:54 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id B1F2E4115; Thu, 29 Oct 2020 18:58:54 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v5 19/33] Hexagon (target/hexagon) generator phase 1 - C
 preprocessor for semantics
Date: Thu, 29 Oct 2020 18:58:36 -0500
Message-Id: <1604015931-23005-20-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604015931-23005-1-git-send-email-tsimpson@quicinc.com>
References: <1604015931-23005-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

UnVuIHRoZSBDIHByZXByb2Nlc3NvciBhY3Jvc3MgdGhlIGluc3RydWN0aW9uIGRlZmluaXRpb24g
ZmlsZXMgYW5kIG1hY3JvCmRlZmluaXRpb24gZmlsZSB0byBleHBhbmQgbWFjcm9zIGFuZCBwcmVw
YXJlIHRoZSBzZW1hbnRpY3NfZ2VuZXJhdGVkLnB5aW5jCmZpbGUuICBUaGUgcmVzdWx0aW5nIGZp
bGUgY29udGFpbnMgb25lIGVudHJ5IHdpdGggdGhlIHNlbWFudGljcyBmb3IgZWFjaAppbnN0cnVj
dGlvbiBhbmQgb25lIGxpbmUgd2l0aCB0aGUgaW5zdHJ1Y3Rpb24gYXR0cmlidXRlcyBhc3NvY2lh
dGVkIHdpdGgKZWFjaCBtYWNyby4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2lt
cHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxm
NGJ1Z0BhbXNhdC5vcmcKLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fc2VtYW50aWNzLmMgfCA4OCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA4OCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vZ2Vu
X3NlbWFudGljcy5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3NlbWFudGljcy5j
IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3NlbWFudGljcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAuLjI1ZDhmNjMKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9n
ZW5fc2VtYW50aWNzLmMKQEAgLTAsMCArMSw4OCBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAx
OS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2
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
YW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLworCisv
KgorICogVGhpcyBwcm9ncmFtIGdlbmVyYXRlcyB0aGUgc2VtYW50aWNzIGZpbGUgdGhhdCBpcyBw
cm9jZXNzZWQgYnkKKyAqIHRoZSBkb19xZW11LnB5IHNjcmlwdC4gIFdlIHVzZSB0aGUgQyBwcmVw
b3JjZXNzb3IgdG8gbWFuaXB1bGF0ZSB0aGUKKyAqIGZpbGVzIGltcG9ydGVkIGZyb20gdGhlIEhl
eGFnb24gYXJjaGl0ZWN0dXJlIGxpYnJhcnkuCisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+Cisj
ZGVmaW5lIFNUUklOR0laRShYKSAjWAorCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQoreworICAgIEZJTEUgKm91dGZpbGU7CisKKyAgICBpZiAoYXJnYyAhPSAyKSB7CisgICAgICAg
IGZwcmludGYoc3RkZXJyLCAiVXNhZ2U6IGdlbl9zZW1hbnRpY3Mgb3VwdHB1dGZpbGVcbiIpOwor
ICAgICAgICByZXR1cm4gMTsKKyAgICB9CisgICAgb3V0ZmlsZSA9IGZvcGVuKGFyZ3ZbMV0sICJ3
Iik7CisgICAgaWYgKG91dGZpbGUgPT0gTlVMTCkgeworICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
IkNhbm5vdCBvcGVuICVzIGZvciB3cml0aW5nXG4iLCBhcmd2WzFdKTsKKyAgICAgICAgcmV0dXJu
IDE7CisgICAgfQorCisvKgorICogUHJvY2VzcyB0aGUgaW5zdHJ1Y3Rpb24gZGVmaW5pdGlvbnMK
KyAqICAgICBTY2FsYXIgY29yZSBpbnN0cnVjdGlvbnMgaGF2ZSB0aGUgZm9sbG93aW5nIGZvcm0K
KyAqICAgICAgICAgUTZJTlNOKEEyX2FkZCwiUmQzMj1hZGQoUnMzMixSdDMyKSIsQVRUUklCUygp
LAorICogICAgICAgICAiQWRkIDMyLWJpdCByZWdpc3RlcnMiLAorICogICAgICAgICB7IFJkVj1S
c1YrUnRWO30pCisgKi8KKyNkZWZpbmUgUTZJTlNOKFRBRywgQkVILCBBVFRSSUJTLCBERVNDUiwg
U0VNKSBcCisgICAgZG8geyBcCisgICAgICAgIGZwcmludGYob3V0ZmlsZSwgIlNFTUFOVElDUygg
XFxcbiIgXAorICAgICAgICAgICAgICAgICAgICAgICAgICIgICAgXCIlc1wiLCBcXFxuIiBcCisg
ICAgICAgICAgICAgICAgICAgICAgICAgIiAgICAlcywgXFxcbiIgXAorICAgICAgICAgICAgICAg
ICAgICAgICAgICIgICAgXCJcIlwiJXNcIlwiXCIgXFxcbiIgXAorICAgICAgICAgICAgICAgICAg
ICAgICAgICIpXG4iLCBcCisgICAgICAgICAgICAgICAgI1RBRywgU1RSSU5HSVpFKEJFSCksIFNU
UklOR0laRShTRU0pKTsgXAorICAgICAgICBmcHJpbnRmKG91dGZpbGUsICJBVFRSSUJVVEVTKCBc
XFxuIiBcCisgICAgICAgICAgICAgICAgICAgICAgICAgIiAgICBcIiVzXCIsIFxcXG4iIFwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAiICAgIFwiJXNcIiBcXFxuIiBcCisgICAgICAgICAgICAg
ICAgICAgICAgICAgIilcbiIsIFwKKyAgICAgICAgICAgICAgICAjVEFHLCBTVFJJTkdJWkUoQVRU
UklCUykpOyBcCisgICAgfSB3aGlsZSAoMCk7CisjaW5jbHVkZSAiaW1wb3J0ZWQvYWxsaWRlZnMu
ZGVmIgorI3VuZGVmIFE2SU5TTgorCisvKgorICogUHJvY2VzcyB0aGUgbWFjcm8gZGVmaW5pdGlv
bnMKKyAqICAgICBNYWNyb3MgZGVmaW5pdGlvbnMgaGF2ZSB0aGUgZm9sbG93aW5nIGZvcm0KKyAq
ICAgICAgICAgREVGX01BQ1JPKAorICogICAgICAgICAgICAgZkxTQk5FVzAsCisgKiAgICAgICAg
ICAgICBwcmVkbG9nX3JlYWQodGhyZWFkLDApLAorICogICAgICAgICAgICAgKCkKKyAqICAgICAg
ICAgKQorICogVGhlIGltcG9ydGFudCBwYXJ0IGhlcmUgaXMgdGhlIGF0dHJpYnV0ZXMuICBXaGVu
ZXZlciBhbiBpbnN0cnVjdGlvbgorICogaW52b2tlcyBhIG1hY3JvLCB3ZSBhZGQgdGhlIG1hY3Jv
J3MgYXR0cmlidXRlcyB0byB0aGUgaW5zdHJ1Y3Rpb24uCisgKi8KKyNkZWZpbmUgREVGX01BQ1JP
KE1OQU1FLCBCRUgsIEFUVFJTKSBcCisgICAgZnByaW50ZihvdXRmaWxlLCAiTUFDUk9BVFRSSUIo
IFxcXG4iIFwKKyAgICAgICAgICAgICAgICAgICAgICIgICAgXCIlc1wiLCBcXFxuIiBcCisgICAg
ICAgICAgICAgICAgICAgICAiICAgIFwiXCJcIiVzXCJcIlwiLCBcXFxuIiBcCisgICAgICAgICAg
ICAgICAgICAgICAiICAgIFwiJXNcIiBcXFxuIiBcCisgICAgICAgICAgICAgICAgICAgICAiKVxu
IiwgXAorICAgICAgICAgICAgI01OQU1FLCBTVFJJTkdJWkUoQkVIKSwgU1RSSU5HSVpFKEFUVFJT
KSk7CisjaW5jbHVkZSAiaW1wb3J0ZWQvbWFjcm9zLmRlZiIKKyN1bmRlZiBERUZfTUFDUk8KKwor
ICAgIGZjbG9zZShvdXRmaWxlKTsKKyAgICByZXR1cm4gMDsKK30KLS0gCjIuNy40Cgo=

