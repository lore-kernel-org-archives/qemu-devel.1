Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EA5C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C29820733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="u2FYeSN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C29820733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JlO-0000G6-P5
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbu-0000yd-RU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbr-00054C-NS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:06 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbr-0004uP-EM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381663; x=1612917663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rFpDTN41TAWs+0TnNRe2g260zl8j8HDVS51hI+iCRm8=;
 b=u2FYeSN03VrNrxagbB9lrDjv9xWV+qEfBV6SmR9yOLwQzc7YyayySDnx
 4dtNwMVjXIMSp3PHehlEffaq4ddyWa5jQ0UOcvrqgcrguplj2DjJwZvdJ
 HHWD58556bC7GVabFQSloDQydyM1nJsko139s1g+ZH9LwUoaeQ0xB1Y+B g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:40:59 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:59 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 311D71B42; Mon, 10 Feb 2020 18:40:59 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 18/66] Hexagon instruction class definitions
Date: Mon, 10 Feb 2020 18:39:56 -0600
Message-Id: <1581381644-13678-19-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

ICAgIEltcG9ydGVkIGZyb20gdGhlIEhleGFnb24gYXJjaGl0ZWN0dXJlIGxpYnJhcnkKClNpZ25l
ZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9pY2xhc3MuZGVmIHwgNTIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvaWNsYXNzLmRlZgoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2ljbGFzcy5kZWYgYi90YXJnZXQvaGV4YWdv
bi9pbXBvcnRlZC9pY2xhc3MuZGVmCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjRiZDRiOTcKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9pY2xh
c3MuZGVmCkBAIC0wLDAgKzEsNTIgQEAKKy8qCisgKiAgQ29weXJpZ2h0IChjKSAyMDE5IFF1YWxj
b21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICog
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3Vy
IG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0
cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRI
T1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisg
KiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAg
U2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
CisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwg
c2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLworCisvKiBERUZfKihUWVBF
LFNMT1RTLFVOSVRTKSAqLworREVGX1BQX0lDTEFTUzMyKEVYVEVOREVSLDAxMjMsTERTVHxTVU5J
VHxNVU5JVCkgLyogMCAqLworREVGX1BQX0lDTEFTUzMyKENKLDAxMjMsQ1RSTEZMT1cpIC8qIDEg
Ki8KK0RFRl9QUF9JQ0xBU1MzMihOQ0osMDEsTERTVHxDVFJMRkxPVykgLyogMiAqLworREVGX1BQ
X0lDTEFTUzMyKFY0TERTVCwwMSxMRFNUKSAvKiAzICovCitERUZfUFBfSUNMQVNTMzIoVjJMRFNU
LDAxLExEU1QpIC8qIDQgKi8KK0RFRl9QUF9JQ0xBU1MzMihKLDAxMjMsQ1RSTEZMT1cpICAvKiA1
ICovCitERUZfUFBfSUNMQVNTMzIoQ1IsMyxTVU5JVCkgICAgIC8qIDYgKi8KK0RFRl9QUF9JQ0xB
U1MzMihBTFUzMl8yb3AsMDEyMyxMRFNUfFNVTklUfE1VTklUKSAvKiA3ICovCitERUZfUFBfSUNM
QVNTMzIoU18yb3AsMjMsU1VOSVR8TVVOSVQpICAgICAgICAgICAgICAgLyogOCAqLworREVGX1BQ
X0lDTEFTUzMyKExELDAxLExEU1QpICAgICAgICAgICAgICAgICAgICAvKiA5ICovCitERUZfUFBf
SUNMQVNTMzIoU1QsMDEsTERTVCkgICAgICAgICAgICAgICAgICAgICAgICAvKiAxMCAqLworREVG
X1BQX0lDTEFTUzMyKEFMVTMyX0FEREksMDEyMyxMRFNUfFNVTklUfE1VTklUKSAvKiAxMSAqLwor
REVGX1BQX0lDTEFTUzMyKFNfM29wLDIzLFNVTklUfE1VTklUKSAgICAgICAgICAgICAgIC8qIDEy
ICovCitERUZfUFBfSUNMQVNTMzIoQUxVNjQsMjMsU1VOSVR8TVVOSVQpICAgICAgICAgICAgIC8q
IDEzICovCitERUZfUFBfSUNMQVNTMzIoTSwyMyxTVU5JVHxNVU5JVCkgICAgICAgICAgICAgICAg
IC8qIDE0ICovCitERUZfUFBfSUNMQVNTMzIoQUxVMzJfM29wLDAxMjMsTERTVHxTVU5JVHxNVU5J
VCkgLyogMTUgKi8KKworREVGX0VFX0lDTEFTUzMyKEVFMCwwMSxJTlZBTElEKSAvKiAwICovCitE
RUZfRUVfSUNMQVNTMzIoRUUxLDAxLElOVkFMSUQpIC8qIDEgKi8KK0RFRl9FRV9JQ0xBU1MzMihF
RTIsMDEsSU5WQUxJRCkgLyogMiAqLworREVGX0VFX0lDTEFTUzMyKEVFMywwMSxJTlZBTElEKSAv
KiAzICovCitERUZfRUVfSUNMQVNTMzIoRUU0LDAxLElOVkFMSUQpIC8qIDQgKi8KK0RFRl9FRV9J
Q0xBU1MzMihFRTUsMDEsSU5WQUxJRCkgLyogNSAqLworREVGX0VFX0lDTEFTUzMyKEVFNiwwMSxJ
TlZBTElEKSAvKiA2ICovCitERUZfRUVfSUNMQVNTMzIoRUU3LDAxLElOVkFMSUQpIC8qIDcgKi8K
K0RFRl9FRV9JQ0xBU1MzMihFRTgsMDEsSU5WQUxJRCkgLyogOCAqLworREVGX0VFX0lDTEFTUzMy
KEVFOSwwMSxJTlZBTElEKSAvKiA5ICovCitERUZfRUVfSUNMQVNTMzIoRUVBLDAxLElOVkFMSUQp
IC8qIDEwICovCitERUZfRUVfSUNMQVNTMzIoRUVCLDAxLElOVkFMSUQpIC8qIDExICovCitERUZf
RUVfSUNMQVNTMzIoRUVDLDAxLElOVkFMSUQpIC8qIDEyICovCitERUZfRUVfSUNMQVNTMzIoRUVE
LDAxLElOVkFMSUQpIC8qIDEzICovCitERUZfRUVfSUNMQVNTMzIoRUVFLDAxLElOVkFMSUQpIC8q
IDE0ICovCitERUZfRUVfSUNMQVNTMzIoRUVGLDAxLElOVkFMSUQpIC8qIDE1ICovCisKLS0gCjIu
Ny40Cgo=

