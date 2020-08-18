Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E18C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66142076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bjYL3XwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66142076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84AR-0003b7-18
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tr-0007r1-DN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:47 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12941)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tm-0005sP-Nc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765902; x=1629301902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1h573ehNvUAlG4redxmStRE1byCEZHPk+7x5sMCmy5w=;
 b=bjYL3XwJMwcgH9nY85tNkxS5Dr/suNuxwgQ3uBHF7tA+FZVrY2KUDqnJ
 GryMlMtuyZ3yUfvhL525FXSn1WIZTrs4798h9jBpa9wH6zmq/KfQRFaJe
 FTPlsud7Exp5Y9sbjuRXtzMrOy8Yv2ZaPzsBY+5n4Syd9CNUYINck1Wyn M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Aug 2020 08:50:59 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 18 Aug 2020 08:50:58 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id A86978F7; Tue, 18 Aug 2020 10:50:58 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 29/34] Hexagon (target/hexagon) TCG generation
Date: Tue, 18 Aug 2020 10:50:42 -0500
Message-Id: <1597765847-16637-30-git-send-email-tsimpson@quicinc.com>
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

SW5jbHVkZSB0aGUgZ2VuZXJhdGVkIGZpbGVzIGFuZCBzZXQgdXAgdGhlIGRhdGEgc3RydWN0dXJl
cwoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5oIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKwog
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuaAogY3JlYXRlIG1vZGUg
MTAwNjQ0IHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmggYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuaApuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwLi5hM2EzZGIxCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmgKQEAgLTAsMCArMSwyNSBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAxOS0y
MDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQu
CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICog
IChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJvZ3Jh
bSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICog
IGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJh
bnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQ
VVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3Jl
IGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07
IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLworCisjaWZu
ZGVmIEhFWEFHT05fR0VOUFRSX0gKKyNkZWZpbmUgSEVYQUdPTl9HRU5QVFJfSAorCisjaW5jbHVk
ZSAiaW5zbi5oIgorCitleHRlcm4gc2VtYW50aWNfaW5zbl90IG9wY29kZV9nZW5wdHJbXTsKKwor
I2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhh
Z29uL2dlbnB0ci5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmE4NWZjMTQK
LS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMCwwICsxLDU1
IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjAgUXVhbGNvbW0gSW5ub3ZhdGlvbiBD
ZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAq
ICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFz
IHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0
ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJ
VFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNo
b3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cu
Z251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNkZWZpbmUgUUVNVV9HRU5FUkFURQorI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgorI2luY2x1ZGUgImNwdS5o
IgorI2luY2x1ZGUgImludGVybmFsLmgiCisjaW5jbHVkZSAidGNnL3RjZy1vcC5oIgorI2luY2x1
ZGUgImluc24uaCIKKyNpbmNsdWRlICJvcGNvZGVzLmgiCisjaW5jbHVkZSAidHJhbnNsYXRlLmgi
CisjaW5jbHVkZSAibWFjcm9zLmgiCisjaW5jbHVkZSAiZ2VucHRyX2hlbHBlcnMuaCIKKworI2Rl
ZmluZSBERUZfVENHX0ZVTkMoVEFHLCBHRU5GTikgXAorc3RhdGljIHZvaWQgZ2VuZXJhdGVfIyNU
QUcoQ1BVSGV4YWdvblN0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4LCBcCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnNuX3QgKmluc24sIHBhY2tldF90ICpwa3QpIFwKK3sgXAorICAg
IEdFTkZOIFwKK30KKyNpbmNsdWRlICJ0Y2dfZnVuY3NfZ2VuZXJhdGVkLmgiCisjdW5kZWYgREVG
X1RDR19GVU5DCisKKworLyogRmlsbCBpbiB0aGUgdGFibGUgd2l0aCBOVUxMcyBiZWNhdXNlIG5v
dCBhbGwgdGhlIG9wY29kZXMgaGF2ZSBERUZfUUVNVSAqLworc2VtYW50aWNfaW5zbl90IG9wY29k
ZV9nZW5wdHJbXSA9IHsKKyNkZWZpbmUgT1BDT0RFKFgpICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTlVMTAorI2luY2x1ZGUgIm9wY29kZXNfZGVmX2dlbmVyYXRlZC5oIgorICAgIE5VTEwK
KyN1bmRlZiBPUENPREUKK307CisKKy8qIFRoaXMgZnVuY3Rpb24gb3ZlcndyaXRlcyB0aGUgTlVM
TCBlbnRyaWVzIHdoZXJlIHdlIGhhdmUgYSBERUZfUUVNVSAqLwordm9pZCBpbml0X2dlbnB0cih2
b2lkKQoreworI2RlZmluZSBERUZfVENHX0ZVTkMoVEFHLCBHRU5GTikgXAorICAgIG9wY29kZV9n
ZW5wdHJbVEFHXSA9IGdlbmVyYXRlXyMjVEFHOworI2luY2x1ZGUgInRjZ19mdW5jc19nZW5lcmF0
ZWQuaCIKKyN1bmRlZiBERUZfVENHX0ZVTkMKK30KLS0gCjIuNy40Cgo=

