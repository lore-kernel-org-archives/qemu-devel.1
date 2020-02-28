Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3BBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1DD2467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mfW4oYB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1DD2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ixy-0007sa-Dy
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ike-0002pB-EU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikb-0005Yb-Tl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ikb-0005U6-BS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908273; x=1614444273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xiLXgllqTqa4Dg32wC1/ZDzc5/wh/SzgW76sGR5PjCI=;
 b=mfW4oYB7lH7PCLLEZJDh58Cioj6F66XoK3ULd+fZ4ZKNr0JET40NtpYE
 k5vjQre6ZUro4a9WoV6ifdErtPamG5wtgYLZvfYa5n4bAf2Kphs1WeUJb
 tSLheElNr4wF45fcMv+DQXULBPE0V0fHtR6U5JJuSAOJ9jiNpLB/U+K6m M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 28 Feb 2020 08:44:29 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 9D124115A; Fri, 28 Feb 2020 10:44:29 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 21/67] Hexagon generator phase 1 - C preprocessor for
 semantics
Date: Fri, 28 Feb 2020 10:43:17 -0600
Message-Id: <1582908244-304-22-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

UnVuIHRoZSBDIHByZXByb2Nlc3NvciBhY3Jvc3MgdGhlIGluc3RydWN0aW9uIGRlZmluaXRpb24g
ZmlsZXMgYW5kIG1hY3JvIGRlZmluaXRvaW4gZmlsZSB0byBleHBhbmQgbWFjcm9zIGFuZCBwcmVw
YXJlIHRoZSBzZW1hbnRpY3NfZ2VuZXJhdGVkLnB5aW5jIGZpbGUuICBUaGUKcmVzdWx0aW5nIGZp
bGUgY29udGFpbnMgb25lIGVudHJ5IHdpdGggdGhlIHNlbWFudGljcyBmb3IgZWFjaCBpbnN0cnVj
dGlvbiBhbmQKb25lIGxpbmUgd2l0aCB0aGUgaW5zdHJ1Y3Rpb24gYXR0cmlidXRlcyBhc3NvY2lh
dGVkIHdpdGggZWFjaCBtYWNyby4KClRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNv
bkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fc2VtYW50aWNzLmMgfCA5MiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA5MiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vZ2Vu
X3NlbWFudGljcy5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3NlbWFudGljcy5j
IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3NlbWFudGljcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAuLjY1ZDA0ZmEKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9n
ZW5fc2VtYW50aWNzLmMKQEAgLTAsMCArMSw5MiBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAx
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
ICAgICAgICByZXR1cm4gLTE7CisgICAgfQorICAgIG91dGZpbGUgPSBmb3Blbihhcmd2WzFdLCAi
dyIpOworICAgIGlmIChvdXRmaWxlID09IE5VTEwpIHsKKyAgICAgICAgZnByaW50ZihzdGRlcnIs
ICJDYW5ub3Qgb3BlbiAlcyBmb3Igd3JpdGluZ1xuIiwgYXJndlsxXSk7CisgICAgICAgIHJldHVy
biAtMTsKKyAgICB9CisKKy8qCisgKiBQcm9jZXNzIHRoZSBpbnN0cnVjdGlvbiBkZWZpbml0aW9u
cworICogICAgIFNjYWxhciBjb3JlIGluc3RydWN0aW9ucyBoYXZlIHRoZSBmb2xsb3dpbmcgZm9y
bQorICogICAgICAgICBRNklOU04oQTJfYWRkLCJSZDMyPWFkZChSczMyLFJ0MzIpIixBVFRSSUJT
KCksCisgKiAgICAgICAgICJBZGQgMzItYml0IHJlZ2lzdGVycyIsCisgKiAgICAgICAgIHsgUmRW
PVJzVitSdFY7fSkKKyAqICAgICBIVlggaW5zdHJ1Y3Rpb25zIGhhdmUgdGhlIGZvbGxvd2luZyBm
b3JtCisgKiAgICAgICAgIEVYVElOU04oVjZfdmluc2VydHdyLCAiVngzMi53PXZpbnNlcnQoUnQz
MikiLAorICogICAgICAgICBBVFRSSUJTKEFfRVhURU5TSU9OLEFfQ1ZJLEFfQ1ZJX1ZYLEFfQ1ZJ
X0xBVEUsQV9OT1RFX01QWV9SRVNPVVJDRSksCisgKiAgICAgICAgICJJbnNlcnQgV29yZCBTY2Fs
YXIgaW50byBWZWN0b3IiLAorICogICAgICAgICBWeFYudXdbMF0gPSBSdFY7KQorICovCisjZGVm
aW5lIFE2SU5TTihUQUcsIEJFSCwgQVRUUklCUywgREVTQ1IsIFNFTSkgXAorICAgIGRvIHsgXAor
ICAgICAgICBmcHJpbnRmKG91dGZpbGUsICJTRU1BTlRJQ1MoXCIlc1wiLCVzLFwiXCJcIiVzXCJc
IlwiKVxuIiwgXAorICAgICAgICAgICAgICAgICNUQUcsIFNUUklOR0laRShCRUgpLCBTVFJJTkdJ
WkUoU0VNKSk7IFwKKyAgICAgICAgZnByaW50ZihvdXRmaWxlLCAiQVRUUklCVVRFUyhcIiVzXCIs
XCIlc1wiKVxuIiwgXAorICAgICAgICAgICAgICAgICNUQUcsIFNUUklOR0laRShBVFRSSUJTKSk7
IFwKKyAgICB9IHdoaWxlICgwKTsKKyNkZWZpbmUgRVhUSU5TTihUQUcsIEJFSCwgQVRUUklCUywg
REVTQ1IsIFNFTSkgXAorICAgIGRvIHsgXAorICAgICAgICBmcHJpbnRmKG91dGZpbGUsICJFWFRf
U0VNQU5USUNTKFwiJXNcIixcIiVzXCIsJXMsXCJcIlwiJXNcIlwiXCIpXG4iLCBcCisgICAgICAg
ICAgICAgICAgRVhUU1RSLCAjVEFHLCBTVFJJTkdJWkUoQkVIKSwgU1RSSU5HSVpFKFNFTSkpOyBc
CisgICAgICAgIGZwcmludGYob3V0ZmlsZSwgIkFUVFJJQlVURVMoXCIlc1wiLFwiJXNcIilcbiIs
IFwKKyAgICAgICAgICAgICAgICAjVEFHLCBTVFJJTkdJWkUoQVRUUklCUykpOyBcCisgICAgfSB3
aGlsZSAoMCk7CisjaW5jbHVkZSAiaW1wb3J0ZWQvYWxsaWRlZnMuZGVmIgorI3VuZGVmIFE2SU5T
TgorI3VuZGVmIEVYVElOU04KKworLyoKKyAqIFByb2Nlc3MgdGhlIG1hY3JvIGRlZmluaXRpb25z
CisgKiAgICAgTWFjcm9zIGRlZmluaXRpb25zIGhhdmUgdGhlIGZvbGxvd2luZyBmb3JtCisgKiAg
ICAgICAgIERFRl9NQUNSTygKKyAqICAgICAgICAgICAgIGZMU0JORVcwLCwKKyAqICAgICAgICAg
ICAgICJQMC5uZXdbMF0iLAorICogICAgICAgICAgICAgIkxlYXN0IHNpZ25pZmljYW50IGJpdCBv
ZiBuZXcgUDAiLAorICogICAgICAgICAgICAgcHJlZGxvZ19yZWFkKHRocmVhZCwwKSwKKyAqICAg
ICAgICAgICAgIChBX0RPVE5FVyxBX0lNUExJQ0lUX1JFQURTX1AwKQorICogICAgICAgICApCisg
KiBUaGUgaW1wb3J0YW50IHBhcnQgaGVyZSBpcyB0aGUgYXR0cmlidXRlcy4gIFdoZW5ldmVyIGFu
IGluc3RydWN0aW9uCisgKiBpbnZva2VzIGEgbWFjcm8sIHdlIGFkZCB0aGUgbWFjcm8ncyBhdHRy
aWJ1dGVzIHRvIHRoZSBpbnN0cnVjdGlvbi4KKyAqLworI2RlZmluZSBERUZfTUFDUk8oTU5BTUUs
IFBBUkFNUywgU0RFU0MsIExERVNDLCBCRUgsIEFUVFJTKSBcCisgICAgZnByaW50ZihvdXRmaWxl
LCAiTUFDUk9BVFRSSUIoXCIlc1wiLFwiXCJcIiVzXCJcIlwiLFwiJXNcIilcbiIsIFwKKyAgICAg
ICAgICAgICNNTkFNRSwgU1RSSU5HSVpFKEJFSCksIFNUUklOR0laRShBVFRSUykpOworI2luY2x1
ZGUgImltcG9ydGVkL21hY3Jvcy5kZWYiCisjdW5kZWYgREVGX01BQ1JPCisKKyAgICBmY2xvc2Uo
b3V0ZmlsZSk7CisgICAgcmV0dXJuIDA7Cit9Ci0tIAoyLjcuNAoK

