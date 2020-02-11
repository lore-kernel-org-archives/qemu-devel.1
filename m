Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B87EC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2884B20733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oSoGXVJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884B20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JdO-00030E-3X
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbv-0000z4-LY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-0005Ae-Sh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:07 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbs-0004uE-GK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381664; x=1612917664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E2cZcd66H/moJ/trPIhUSsNRwRJiv0yQlFwX7d0AJOk=;
 b=oSoGXVJ0GA9Zl1JK+KTbPlxRaL8vBi1VfiM9iWcfh3Yh6JpS/lWmXIkk
 6aANpX86H1a28ogXg64undmZrx+7Yoio4Fh6AoQ0h32U0dnkSQR+n0pwO
 C8rE3a95vkaBKT6rJL6w4IG8zk7UXW0D9kPbuY1ATuxm6zm1el4//YarU M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:41:00 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:59 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 732CC1B53; Mon, 10 Feb 2020 18:40:59 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 20/66] Hexagon generator phase 1 - C preprocessor for
 semantics
Date: Mon, 10 Feb 2020 18:39:58 -0600
Message-Id: <1581381644-13678-21-git-send-email-tsimpson@quicinc.com>
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

UnVuIHRoZSBDIHByZXByb2Nlc3NvciBhY3Jvc3MgdGhlIGluc3RydWN0aW9uIGRlZmluaXRpb24g
ZmlsZXMgYW5kIG1hY3JvIGRlZmluaXRvaW4gZmlsZSB0byBleHBhbmQgbWFjcm9zIGFuZCBwcmVw
YXJlIHRoZSBzZW1hbnRpY3NfZ2VuZXJhdGVkLnB5aW5jIGZpbGUuICBUaGUKcmVzdWx0aW5nIGZp
bGUgY29udGFpbnMgb25lIGVudHJ5IHdpdGggdGhlIHNlbWFudGljcyBmb3IgZWFjaCBpbnN0cnVj
dGlvbiBhbmQKb25lIGxpbmUgd2l0aCB0aGUgaW5zdHJ1Y3Rpb24gYXR0cmlidXRlcyBhc3NvY2lh
dGVkIHdpdGggZWFjaCBtYWNyby4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2lt
cHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fc2VtYW50aWNzLmMgfCA5
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA5MiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24v
Z2VuX3NlbWFudGljcy5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3NlbWFudGlj
cy5jIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3NlbWFudGljcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAuLjIyMTFhZTYKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5fc2VtYW50aWNzLmMKQEAgLTAsMCArMSw5MiBAQAorLyoKKyAqICBDb3B5cmlnaHQgKGMp
IDIwMTkgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZl
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
bTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKy8q
CisgKiBUaGlzIHByb2dyYW0gZ2VuZXJhdGVzIHRoZSBzZW1hbnRpY3MgZmlsZSB0aGF0IGlzIHBy
b2Nlc3NlZCBieQorICogdGhlIGRvX3FlbXUucHkgc2NyaXB0LiAgV2UgdXNlIHRoZSBDIHByZXBv
cmNlc3NvciB0byBtYW5pcHVsYXRlIHRoZQorICogZmlsZXMgaW1wb3J0ZWQgZnJvbSB0aGUgSGV4
YWdvbiBhcmNoaXRlY3R1cmUgbGlicmFyeS4KKyAqLworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNk
ZWZpbmUgU1RSSU5HSVpFKFgpICNYCisKK2ludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
Cit7CisgICAgRklMRSAqb3V0ZmlsZTsKKworICAgIGlmIChhcmdjICE9IDIpIHsKKyAgICAgICAg
ZnByaW50ZihzdGRlcnIsICJVc2FnZTogZ2VuX3NlbWFudGljcyBvdXB0cHV0ZmlsZVxuIik7Cisg
ICAgICAgIHJldHVybiAtMTsKKyAgICB9CisgICAgb3V0ZmlsZSA9IGZvcGVuKGFyZ3ZbMV0sICJ3
Iik7CisgICAgaWYgKG91dGZpbGUgPT0gTlVMTCkgeworICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
IkNhbm5vdCBvcGVuICVzIGZvciB3cml0aW5nXG4iLCBhcmd2WzFdKTsKKyAgICAgICAgcmV0dXJu
IC0xOworICAgIH0KKworLyoKKyAqIFByb2Nlc3MgdGhlIGluc3RydWN0aW9uIGRlZmluaXRpb25z
CisgKiAgICAgU2NhbGFyIGNvcmUgaW5zdHJ1Y3Rpb25zIGhhdmUgdGhlIGZvbGxvd2luZyBmb3Jt
CisgKiAgICAgICAgIFE2SU5TTihBMl9hZGQsIlJkMzI9YWRkKFJzMzIsUnQzMikiLEFUVFJJQlMo
KSwKKyAqICAgICAgICAgIkFkZCAzMi1iaXQgcmVnaXN0ZXJzIiwKKyAqICAgICAgICAgeyBSZFY9
UnNWK1J0Vjt9KQorICogICAgIEhWWCBpbnN0cnVjdGlvbnMgaGF2ZSB0aGUgZm9sbG93aW5nIGZv
cm0KKyAqICAgICAgICAgRVhUSU5TTihWNl92aW5zZXJ0d3IsICJWeDMyLnc9dmluc2VydChSdDMy
KSIsCisgKiAgICAgICAgIEFUVFJJQlMoQV9FWFRFTlNJT04sQV9DVkksQV9DVklfVlgsQV9DVklf
TEFURSxBX05PVEVfTVBZX1JFU09VUkNFKSwKKyAqICAgICAgICAgIkluc2VydCBXb3JkIFNjYWxh
ciBpbnRvIFZlY3RvciIsCisgKiAgICAgICAgIFZ4Vi51d1swXSA9IFJ0VjspCisgKi8KKyNkZWZp
bmUgUTZJTlNOKFRBRywgQkVILCBBVFRSSUJTLCBERVNDUiwgU0VNKSBcCisgICAgZG8geyBcCisg
ICAgICAgIGZwcmludGYob3V0ZmlsZSwgIlNFTUFOVElDUyhcIiVzXCIsJXMsXCJcIlwiJXNcIlwi
XCIpXG4iLCBcCisgICAgICAgICAgICAgICAgI1RBRywgU1RSSU5HSVpFKEJFSCksIFNUUklOR0la
RShTRU0pKTsgXAorICAgICAgICBmcHJpbnRmKG91dGZpbGUsICJBVFRSSUJVVEVTKFwiJXNcIixc
IiVzXCIpXG4iLCBcCisgICAgICAgICAgICAgICAgI1RBRywgU1RSSU5HSVpFKEFUVFJJQlMpKTsg
XAorICAgIH0gd2hpbGUgKDApOworI2RlZmluZSBFWFRJTlNOKFRBRywgQkVILCBBVFRSSUJTLCBE
RVNDUiwgU0VNKSBcCisgICAgZG8geyBcCisgICAgICAgIGZwcmludGYob3V0ZmlsZSwgIkVYVF9T
RU1BTlRJQ1MoXCIlc1wiLFwiJXNcIiwlcyxcIlwiXCIlc1wiXCJcIilcbiIsIFwKKyAgICAgICAg
ICAgICAgICBFWFRTVFIsICNUQUcsIFNUUklOR0laRShCRUgpLCBTVFJJTkdJWkUoU0VNKSk7IFwK
KyAgICAgICAgZnByaW50ZihvdXRmaWxlLCAiQVRUUklCVVRFUyhcIiVzXCIsXCIlc1wiKVxuIiwg
XAorICAgICAgICAgICAgICAgICNUQUcsIFNUUklOR0laRShBVFRSSUJTKSk7IFwKKyAgICB9IHdo
aWxlICgwKTsKKyNpbmNsdWRlICJpbXBvcnRlZC9hbGxpZGVmcy5kZWYiCisjdW5kZWYgUTZJTlNO
CisjdW5kZWYgRVhUSU5TTgorCisvKgorICogUHJvY2VzcyB0aGUgbWFjcm8gZGVmaW5pdGlvbnMK
KyAqICAgICBNYWNyb3MgZGVmaW5pdGlvbnMgaGF2ZSB0aGUgZm9sbG93aW5nIGZvcm0KKyAqICAg
ICAgICAgREVGX01BQ1JPKAorICogICAgICAgICAgICAgZkxTQk5FVzAsLAorICogICAgICAgICAg
ICAgIlAwLm5ld1swXSIsCisgKiAgICAgICAgICAgICAiTGVhc3Qgc2lnbmlmaWNhbnQgYml0IG9m
IG5ldyBQMCIsCisgKiAgICAgICAgICAgICBwcmVkbG9nX3JlYWQodGhyZWFkLDApLAorICogICAg
ICAgICAgICAgKEFfRE9UTkVXLEFfSU1QTElDSVRfUkVBRFNfUDApCisgKiAgICAgICAgICkKKyAq
IFRoZSBpbXBvcnRhbnQgcGFydCBoZXJlIGlzIHRoZSBhdHRyaWJ1dGVzLiAgV2hlbmV2ZXIgYW4g
aW5zdHJ1Y3Rpb24KKyAqIGludm9rZXMgYSBtYWNybywgd2UgYWRkIHRoZSBtYWNybydzIGF0dHJp
YnV0ZXMgdG8gdGhlIGluc3RydWN0aW9uLgorICovCisjZGVmaW5lIERFRl9NQUNSTyhNTkFNRSwg
UEFSQU1TLCBTREVTQywgTERFU0MsIEJFSCwgQVRUUlMpIFwKKyAgICBmcHJpbnRmKG91dGZpbGUs
ICJNQUNST0FUVFJJQihcIiVzXCIsXCJcIlwiJXNcIlwiXCIsXCIlc1wiKVxuIiwgXAorICAgICAg
ICAgICAgI01OQU1FLCBTVFJJTkdJWkUoQkVIKSwgU1RSSU5HSVpFKEFUVFJTKSk7CisjaW5jbHVk
ZSAiaW1wb3J0ZWQvbWFjcm9zLmRlZiIKKyN1bmRlZiBERUZfTUFDUk8KKworICAgIGZjbG9zZShv
dXRmaWxlKTsKKyAgICByZXR1cm4gMDsKK30KLS0gCjIuNy40Cgo=

