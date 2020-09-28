Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59499C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF7D21531
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U+gimMzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF7D21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsT9-0000in-K6
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOq-0003zw-B2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:00 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46899)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOn-0005eW-8S
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601296617; x=1632832617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sqv8Md0TpUjb/AK2DrAatslhVb+W9RhEvE/mY8AJWjE=;
 b=U+gimMzgskqAXVhShIMXVOCOqzeQ6F4pRxXyHi6JeGIdyP31Vn+zxpcg
 1r60AqxoVabQpO3wwVY/s1ezYwhs7y1N61YTSkPt9gZbNELcydjrrTtxi
 nV5Vl5tc7mSFeSTsZ+juFCK+UZJzwpivtwjEWONPaMMaTR3i7FgFQPO27 c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Sep 2020 05:36:52 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 28 Sep 2020 05:36:52 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id EABDE127B; Mon, 28 Sep 2020 07:36:51 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v4 08/29] Hexagon (target/hexagon) GDB Stub
Date: Mon, 28 Sep 2020 07:36:27 -0500
Message-Id: <1601296608-29390-9-git-send-email-tsimpson@quicinc.com>
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

R0RCIHJlZ2lzdGVyIHJlYWQgYW5kIHdyaXRlIHJvdXRpbmVzCgpTaWduZWQtb2ZmLWJ5OiBUYXls
b3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaW50
ZXJuYWwuaCB8ICAzICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICB8ICAyICsrCiB0YXJn
ZXQvaGV4YWdvbi9nZGJzdHViLmMgIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2dkYnN0dWIuYwoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCmluZGV4
IDMyN2JhZDkuLjk2MTMxOGEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgK
KysrIGIvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaApAQCAtMjksNiArMjksOSBAQAogICAgICAg
ICB9IFwKICAgICB9IHdoaWxlICgwKQogCitleHRlcm4gaW50IGhleGFnb25fZ2RiX3JlYWRfcmVn
aXN0ZXIoQ1BVU3RhdGUgKmNwdSwgR0J5dGVBcnJheSAqYnVmLCBpbnQgcmVnKTsKK2V4dGVybiBp
bnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNwdSwgdWludDhfdCAqYnVm
LCBpbnQgcmVnKTsKKwogZXh0ZXJuIHZvaWQgaGV4YWdvbl9kZWJ1ZyhDUFVIZXhhZ29uU3RhdGUg
KmVudik7CiAKIGV4dGVybiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9yZWduYW1lc1tUT1RB
TF9QRVJfVEhSRUFEX1JFR1NdOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1ZTBkYTNmLi4zMmFhOTgyIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMjgwLDYg
KzI4MCw4IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3Mg
KmMsIHZvaWQgKmRhdGEpCiAgICAgY2MtPmR1bXBfc3RhdGUgPSBoZXhhZ29uX2R1bXBfc3RhdGU7
CiAgICAgY2MtPnNldF9wYyA9IGhleGFnb25fY3B1X3NldF9wYzsKICAgICBjYy0+c3luY2hyb25p
emVfZnJvbV90YiA9IGhleGFnb25fY3B1X3N5bmNocm9uaXplX2Zyb21fdGI7CisgICAgY2MtPmdk
Yl9yZWFkX3JlZ2lzdGVyID0gaGV4YWdvbl9nZGJfcmVhZF9yZWdpc3RlcjsKKyAgICBjYy0+Z2Ri
X3dyaXRlX3JlZ2lzdGVyID0gaGV4YWdvbl9nZGJfd3JpdGVfcmVnaXN0ZXI7CiAgICAgY2MtPmdk
Yl9udW1fY29yZV9yZWdzID0gVE9UQUxfUEVSX1RIUkVBRF9SRUdTOwogICAgIGNjLT5nZGJfc3Rv
cF9iZWZvcmVfd2F0Y2hwb2ludCA9IHRydWU7CiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gaGV4
YWdvbl9jcHVfZGlzYXNfc2V0X2luZm87CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZGJz
dHViLmMgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uZThjMTBiMgotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2dk
YnN0dWIuYwpAQCAtMCwwICsxLDQ3IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjAg
UXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAq
CisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRl
IGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJl
IEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0
IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlz
IGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0
IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkg
b2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBP
U0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNpbmNsdWRl
ICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAicWVtdS1jb21tb24uaCIKKyNpbmNsdWRlICJleGVj
L2dkYnN0dWIuaCIKKyNpbmNsdWRlICJjcHUuaCIKKyNpbmNsdWRlICJpbnRlcm5hbC5oIgorCitp
bnQgaGV4YWdvbl9nZGJfcmVhZF9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1l
bV9idWYsIGludCBuKQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKGNzKTsK
KyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9ICZjcHUtPmVudjsKKworICAgIGlmIChuIDwgVE9U
QUxfUEVSX1RIUkVBRF9SRUdTKSB7CisgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZ2wobWVtX2J1
ZiwgZW52LT5ncHJbbl0pOworICAgIH0KKworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9
CisKK2ludCBoZXhhZ29uX2dkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3Qg
Km1lbV9idWYsIGludCBuKQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKGNz
KTsKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9ICZjcHUtPmVudjsKKworICAgIGlmIChuIDwg
VE9UQUxfUEVSX1RIUkVBRF9SRUdTKSB7CisgICAgICAgIGVudi0+Z3ByW25dID0gbGR0dWxfcCht
ZW1fYnVmKTsKKyAgICAgICAgcmV0dXJuIHNpemVvZih0YXJnZXRfdWxvbmcpOworICAgIH0KKwor
ICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9Ci0tIAoyLjcuNAoK

