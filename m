Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22736C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E183F206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI99JH0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E183F206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWMF-0006Zn-1U
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUWK2-0002e8-1s
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUWJu-00060W-NY
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUWJu-00060I-5w
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588342032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbG/ivlaYfH0BCJK951opl/KBNJa3i2O840z7dUnfdo=;
 b=gI99JH0nJaddgsNG2Z1w9OyrBB+nif1grv/RGV1cyui8czAfjUMf/LQEm+g5YQ0a6PNwIj
 OFia/KlX0KW5M9VYwNEl/CZzj4OCM2GlTk59rZwpyZi8Kd4xCOR7X8QTGx4vzb2/B+bdPy
 fna2NxKZnT5MrN8kYIMWUv+HNDiiLIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-1OitSWMcMraLIyp0Aczm1Q-1; Fri, 01 May 2020 10:07:10 -0400
X-MC-Unique: 1OitSWMcMraLIyp0Aczm1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23C31899527
 for <qemu-devel@nongnu.org>; Fri,  1 May 2020 14:07:09 +0000 (UTC)
Received: from localhost (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD865EDF1;
 Fri,  1 May 2020 14:07:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/2] virtiofsd: add --rlimit-nofile=NUM option
Date: Fri,  1 May 2020 15:06:43 +0100
Message-Id: <20200501140644.220940-2-stefanha@redhat.com>
In-Reply-To: <20200501140644.220940-1-stefanha@redhat.com>
References: <20200501140644.220940-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:09:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFrZSBpdCBwb3NzaWJsZSB0byBzcGVjaWZ5IHRoZSBSTElNSVRfTk9GSUxFIG9uIHRoZSBjb21t
YW5kLWxpbmUuClVzZXJzIHJ1bm5pbmcgbXVsdGlwbGUgdmlydGlvZnNkIHByb2Nlc3NlcyBzaG91
bGQgYWxsb2NhdGUgYSBjZXJ0YWluCm51bWJlciB0byBlYWNoIHByb2Nlc3Mgc28gdGhhdCB0aGUg
c3lzdGVtLXdpZGUgbGltaXQgY2FuIG5ldmVyIGJlCmV4aGF1c3RlZC4KCldoZW4gdGhpcyBvcHRp
b24gaXMgc2V0IHRvIDAgdGhlIHJsaW1pdCBpcyBsZWZ0IGF0IGl0cyBjdXJyZW50IHZhbHVlLgpU
aGlzIGlzIHVzZWZ1bCB3aGVuIGEgbWFuYWdlbWVudCB0b29sIHdhbnRzIHRvIGNvbmZpZ3VyZSB0
aGUgcmxpbWl0Cml0c2VsZi4KClRoZSBkZWZhdWx0IGJlaGF2aW9yIHJlbWFpbnMgdW5jaGFuZ2Vk
OiB0cnkgdG8gc2V0IHRoZSBsaW1pdCB0bwoxLDAwMCwwMDAgZmlsZSBkZXNjcmlwdG9ycyBpZiB0
aGUgY3VycmVudCBybGltaXQgaXMgbG93ZXIuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9j
emkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBEci4gRGF2aWQgQWxhbiBHaWxi
ZXJ0IDxkZ2lsYmVydEByZWRoYXQuY29tPgotLS0KIHRvb2xzL3ZpcnRpb2ZzZC9mdXNlX2xvd2xl
dmVsLmggIHwgIDEgKwogdG9vbHMvdmlydGlvZnNkL2hlbHBlci5jICAgICAgICAgfCAyMyArKysr
KysrKysrKysrKysrKysrKysrKwogdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgfCAy
MiArKysrKysrKy0tLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMo
KyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX2xv
d2xldmVsLmggYi90b29scy92aXJ0aW9mc2QvZnVzZV9sb3dsZXZlbC5oCmluZGV4IDhmNmQ3MDVi
NWMuLjU2MmZkNTI0MWUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX2xvd2xldmVs
LmgKKysrIGIvdG9vbHMvdmlydGlvZnNkL2Z1c2VfbG93bGV2ZWwuaApAQCAtMTc3Nyw2ICsxNzc3
LDcgQEAgc3RydWN0IGZ1c2VfY21kbGluZV9vcHRzIHsKICAgICBpbnQgc3lzbG9nOwogICAgIGlu
dCBsb2dfbGV2ZWw7CiAgICAgdW5zaWduZWQgaW50IG1heF9pZGxlX3RocmVhZHM7CisgICAgdW5z
aWduZWQgbG9uZyBybGltaXRfbm9maWxlOwogfTsKIAogLyoqCmRpZmYgLS1naXQgYS90b29scy92
aXJ0aW9mc2QvaGVscGVyLmMgYi90b29scy92aXJ0aW9mc2QvaGVscGVyLmMKaW5kZXggODE5YzJi
YzEzYy4uZGM1OWYzOGFmMCAxMDA2NDQKLS0tIGEvdG9vbHMvdmlydGlvZnNkL2hlbHBlci5jCisr
KyBiL3Rvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIuYwpAQCAtMjMsNiArMjMsOCBAQAogI2luY2x1ZGUg
PHN0ZGxpYi5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPHN5cy9wYXJhbS5oPgor
I2luY2x1ZGUgPHN5cy90aW1lLmg+CisjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+CiAjaW5jbHVk
ZSA8dW5pc3RkLmg+CiAKICNkZWZpbmUgRlVTRV9IRUxQRVJfT1BUKHQsIHApICAgICAgICAgICAg
ICAgICAgICAgICBcCkBAIC01Myw2ICs1NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZnVzZV9v
cHQgZnVzZV9oZWxwZXJfb3B0c1tdID0gewogICAgIEZVU0VfSEVMUEVSX09QVCgic3VidHlwZT0i
LCBub2RlZmF1bHRfc3VidHlwZSksCiAgICAgRlVTRV9PUFRfS0VZKCJzdWJ0eXBlPSIsIEZVU0Vf
T1BUX0tFWV9LRUVQKSwKICAgICBGVVNFX0hFTFBFUl9PUFQoIm1heF9pZGxlX3RocmVhZHM9JXUi
LCBtYXhfaWRsZV90aHJlYWRzKSwKKyAgICBGVVNFX0hFTFBFUl9PUFQoIi0tcmxpbWl0LW5vZmls
ZT0lbHUiLCBybGltaXRfbm9maWxlKSwKICAgICBGVVNFX0hFTFBFUl9PUFQoIi0tc3lzbG9nIiwg
c3lzbG9nKSwKICAgICBGVVNFX0hFTFBFUl9PUFRfVkFMVUUoImxvZ19sZXZlbD1kZWJ1ZyIsIGxv
Z19sZXZlbCwgRlVTRV9MT0dfREVCVUcpLAogICAgIEZVU0VfSEVMUEVSX09QVF9WQUxVRSgibG9n
X2xldmVsPWluZm8iLCBsb2dfbGV2ZWwsIEZVU0VfTE9HX0lORk8pLApAQCAtMTcxLDYgKzE3NCw5
IEBAIHZvaWQgZnVzZV9jbWRsaW5lX2hlbHAodm9pZCkKICAgICAgICAgICAgIiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZWZhdWx0OiBub193cml0ZWJhY2tcbiIKICAgICAgICAgICAg
IiAgICAtbyB4YXR0cnxub194YXR0ciAgICAgICAgICBlbmFibGUvZGlzYWJsZSB4YXR0clxuIgog
ICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQ6IG5vX3hh
dHRyXG4iCisgICAgICAgICAgICIgICAgLS1ybGltaXQtbm9maWxlPTxudW0+ICAgICAgc2V0IG1h
eGltdW0gbnVtYmVyIG9mIGZpbGUgZGVzY3JpcHRvcnNcbiIKKyAgICAgICAgICAgIiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoMCBsZWF2ZXMgcmxpbWl0IHVuY2hhbmdlZClcbiIKKyAg
ICAgICAgICAgIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWZhdWx0OiAxLDAwMCww
MDAgaWYgdGhlIGN1cnJlbnQgcmxpbWl0IGlzIGxvd2VyXG4iCiAgICAgICAgICAgICk7CiB9CiAK
QEAgLTE5MSwxMSArMTk3LDI4IEBAIHN0YXRpYyBpbnQgZnVzZV9oZWxwZXJfb3B0X3Byb2Modm9p
ZCAqZGF0YSwgY29uc3QgY2hhciAqYXJnLCBpbnQga2V5LAogICAgIH0KIH0KIAorc3RhdGljIHVu
c2lnbmVkIGxvbmcgZ2V0X2RlZmF1bHRfcmxpbWl0X25vZmlsZSh2b2lkKQoreworICAgIHJsaW1f
dCBtYXhfZmRzID0gMTAwMDAwMDsgLyogb3VyIGRlZmF1bHQgUkxJTUlUX05PRklMRSB0YXJnZXQg
Ki8KKyAgICBzdHJ1Y3QgcmxpbWl0IHJsaW07CisKKyAgICBpZiAoZ2V0cmxpbWl0KFJMSU1JVF9O
T0ZJTEUsICZybGltKSA8IDApIHsKKyAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLCAiZ2V0
cmxpbWl0KFJMSU1JVF9OT0ZJTEUpOiAlbVxuIik7CisgICAgICAgIGV4aXQoMSk7CisgICAgfQor
CisgICAgaWYgKHJsaW0ucmxpbV9jdXIgPj0gbWF4X2ZkcykgeworICAgICAgICByZXR1cm4gMDsg
Lyogd2UgaGF2ZSBtb3JlIGZkcyBhdmFpbGFibGUgdGhhbiByZXF1aXJlZCEgKi8KKyAgICB9Cisg
ICAgcmV0dXJuIG1heF9mZHM7Cit9CisKIGludCBmdXNlX3BhcnNlX2NtZGxpbmUoc3RydWN0IGZ1
c2VfYXJncyAqYXJncywgc3RydWN0IGZ1c2VfY21kbGluZV9vcHRzICpvcHRzKQogewogICAgIG1l
bXNldChvcHRzLCAwLCBzaXplb2Yoc3RydWN0IGZ1c2VfY21kbGluZV9vcHRzKSk7CiAKICAgICBv
cHRzLT5tYXhfaWRsZV90aHJlYWRzID0gMTA7CisgICAgb3B0cy0+cmxpbWl0X25vZmlsZSA9IGdl
dF9kZWZhdWx0X3JsaW1pdF9ub2ZpbGUoKTsKICAgICBvcHRzLT5mb3JlZ3JvdW5kID0gMTsKIAog
ICAgIGlmIChmdXNlX29wdF9wYXJzZShhcmdzLCBvcHRzLCBmdXNlX2hlbHBlcl9vcHRzLCBmdXNl
X2hlbHBlcl9vcHRfcHJvYykgPT0KZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhy
b3VnaF9sbC5jIGIvdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMKaW5kZXggNGMzNWM5
NWIyNS4uZjdiOWMxZDIwYyAxMDA2NDQKLS0tIGEvdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdo
X2xsLmMKKysrIGIvdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMKQEAgLTI3MDcsMjQg
KzI3MDcsMTggQEAgc3RhdGljIHZvaWQgc2V0dXBfc2FuZGJveChzdHJ1Y3QgbG9fZGF0YSAqbG8s
IHN0cnVjdCBmdXNlX3Nlc3Npb24gKnNlLAogICAgIHNldHVwX3NlY2NvbXAoZW5hYmxlX3N5c2xv
Zyk7CiB9CiAKLS8qIFJhaXNlIHRoZSBtYXhpbXVtIG51bWJlciBvZiBvcGVuIGZpbGUgZGVzY3Jp
cHRvcnMgKi8KLXN0YXRpYyB2b2lkIHNldHVwX25vZmlsZV9ybGltaXQodm9pZCkKKy8qIFNldCB0
aGUgbWF4aW11bSBudW1iZXIgb2Ygb3BlbiBmaWxlIGRlc2NyaXB0b3JzICovCitzdGF0aWMgdm9p
ZCBzZXR1cF9ub2ZpbGVfcmxpbWl0KHVuc2lnbmVkIGxvbmcgcmxpbWl0X25vZmlsZSkKIHsKLSAg
ICBjb25zdCBybGltX3QgbWF4X2ZkcyA9IDEwMDAwMDA7Ci0gICAgc3RydWN0IHJsaW1pdCBybGlt
OworICAgIHN0cnVjdCBybGltaXQgcmxpbSA9IHsKKyAgICAgICAgLnJsaW1fY3VyID0gcmxpbWl0
X25vZmlsZSwKKyAgICAgICAgLnJsaW1fbWF4ID0gcmxpbWl0X25vZmlsZSwKKyAgICB9OwogCi0g
ICAgaWYgKGdldHJsaW1pdChSTElNSVRfTk9GSUxFLCAmcmxpbSkgPCAwKSB7Ci0gICAgICAgIGZ1
c2VfbG9nKEZVU0VfTE9HX0VSUiwgImdldHJsaW1pdChSTElNSVRfTk9GSUxFKTogJW1cbiIpOwot
ICAgICAgICBleGl0KDEpOwotICAgIH0KLQotICAgIGlmIChybGltLnJsaW1fY3VyID49IG1heF9m
ZHMpIHsKKyAgICBpZiAocmxpbWl0X25vZmlsZSA9PSAwKSB7CiAgICAgICAgIHJldHVybjsgLyog
bm90aGluZyB0byBkbyAqLwogICAgIH0KIAotICAgIHJsaW0ucmxpbV9jdXIgPSBtYXhfZmRzOwot
ICAgIHJsaW0ucmxpbV9tYXggPSBtYXhfZmRzOwotCiAgICAgaWYgKHNldHJsaW1pdChSTElNSVRf
Tk9GSUxFLCAmcmxpbSkgPCAwKSB7CiAgICAgICAgIC8qIElnbm9yZSBTRUxpbnV4IGRlbmlhbHMg
Ki8KICAgICAgICAgaWYgKGVycm5vID09IEVQRVJNKSB7CkBAIC0yOTc3LDcgKzI5NzEsNyBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCiAgICAgZnVzZV9kYWVtb25pemUob3B0
cy5mb3JlZ3JvdW5kKTsKIAotICAgIHNldHVwX25vZmlsZV9ybGltaXQoKTsKKyAgICBzZXR1cF9u
b2ZpbGVfcmxpbWl0KG9wdHMucmxpbWl0X25vZmlsZSk7CiAKICAgICAvKiBNdXN0IGJlIGJlZm9y
ZSBzYW5kYm94IHNpbmNlIGl0IHdhbnRzIC9wcm9jICovCiAgICAgc2V0dXBfY2FwbmcoKTsKLS0g
CjIuMjUuMwoK


