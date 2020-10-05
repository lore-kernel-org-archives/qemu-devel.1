Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A23C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA5620663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5moGvju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA5620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSlD-0005eD-Mp
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeS-00057X-KS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeO-0008AL-HT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8JCARNNAwfpDJb/n4SC2jpFXhM1UsAo0LW+4Wi+p44=;
 b=d5moGvjuRvttQtcAjD5GvWappgt9iNg81myu6hp6lDewNf2zCwkHLMFGGwvddnyhOSBi6D
 nvxUsJX9Td/igzCMfuY5FGzx90z21+fKr/vWFMyxOjpx3bsLhE3SXk0FGj69bRb+45IdTv
 CegOzMD3QwbaNnIHh7g3UuP7tmcSKlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-pFYjbLVkNoS9DQUVXfINoQ-1; Mon, 05 Oct 2020 11:43:40 -0400
X-MC-Unique: pFYjbLVkNoS9DQUVXfINoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1AAC1019624;
 Mon,  5 Oct 2020 15:43:38 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90469610AF;
 Mon,  5 Oct 2020 15:43:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 03/17] block/nvme: Reduce I/O registers scope
Date: Mon,  5 Oct 2020 16:43:09 +0100
Message-Id: <20201005154323.31347-4-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKV2Ugb25s
eSBhY2Nlc3MgdGhlIEkvTyByZWdpc3RlciBpbiBudm1lX2luaXQoKS4KUmVtb3ZlIHRoZSByZWZl
cmVuY2UgaW4gQkRSVk5WTWVTdGF0ZSBhbmQgcmVkdWNlIGl0cyBzY29wZS4KClNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNzYWdlLUlkOiA8
MjAyMDA5MjIwODM4MjEuNTc4NTE5LTQtcGhpbG1kQHJlZGhhdC5jb20+Ci0tLQogYmxvY2svbnZt
ZS5jIHwgMjkgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
NiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9udm1l
LmMgYi9ibG9jay9udm1lLmMKaW5kZXggM2M4MzRkYThmZS4uZTUxN2M3NTM5ZiAxMDA2NDQKLS0t
IGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpAQCAtOTgsNyArOTgsNiBAQCBlbnVt
IHsKIHN0cnVjdCBCRFJWTlZNZVN0YXRlIHsKICAgICBBaW9Db250ZXh0ICphaW9fY29udGV4dDsK
ICAgICBRRU1VVkZJT1N0YXRlICp2ZmlvOwotICAgIE5WTWVSZWdzICpyZWdzOwogICAgIC8qIE1l
bW9yeSBtYXBwZWQgcmVnaXN0ZXJzICovCiAgICAgdm9sYXRpbGUgc3RydWN0IHsKICAgICAgICAg
dWludDMyX3Qgc3FfdGFpbDsKQEAgLTY5NSw2ICs2OTQsNyBAQCBzdGF0aWMgaW50IG52bWVfaW5p
dChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBpbnQgbmFtZXNwYWNl
LAogICAgIHVpbnQ2NF90IHRpbWVvdXRfbXM7CiAgICAgdWludDY0X3QgZGVhZGxpbmUsIG5vdzsK
ICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsKKyAgICBOVk1lUmVncyAqcmVnczsKIAogICAg
IHFlbXVfY29fbXV0ZXhfaW5pdCgmcy0+ZG1hX21hcF9sb2NrKTsKICAgICBxZW11X2NvX3F1ZXVl
X2luaXQoJnMtPmRtYV9mbHVzaF9xdWV1ZSk7CkBAIC03MTMsMTYgKzcxMywxNiBAQCBzdGF0aWMg
aW50IG52bWVfaW5pdChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBp
bnQgbmFtZXNwYWNlLAogICAgICAgICBnb3RvIG91dDsKICAgICB9CiAKLSAgICBzLT5yZWdzID0g
cWVtdV92ZmlvX3BjaV9tYXBfYmFyKHMtPnZmaW8sIDAsIDAsIHNpemVvZihOdm1lQmFyKSwKLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBST1RfUkVBRCB8IFBST1RfV1JJVEUs
IGVycnApOwotICAgIGlmICghcy0+cmVncykgeworICAgIHJlZ3MgPSBxZW11X3ZmaW9fcGNpX21h
cF9iYXIocy0+dmZpbywgMCwgMCwgc2l6ZW9mKE52bWVCYXIpLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgZXJycCk7CisgICAgaWYgKCFy
ZWdzKSB7CiAgICAgICAgIHJldCA9IC1FSU5WQUw7CiAgICAgICAgIGdvdG8gb3V0OwogICAgIH0K
ICAgICAvKiBQZXJmb3JtIGluaXRpYWxpemUgc2VxdWVuY2UgYXMgZGVzY3JpYmVkIGluIE5WTWUg
c3BlYyAiNy42LjEKICAgICAgKiBJbml0aWFsaXphdGlvbiIuICovCiAKLSAgICBjYXAgPSBsZTY0
X3RvX2NwdShzLT5yZWdzLT5jdHJsLmNhcCk7CisgICAgY2FwID0gbGU2NF90b19jcHUocmVncy0+
Y3RybC5jYXApOwogICAgIGlmICghKGNhcCAmICgxVUxMIDw8IDM3KSkpIHsKICAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLCAiRGV2aWNlIGRvZXNuJ3Qgc3VwcG9ydCBOVk1lIGNvbW1hbmQgc2V0Iik7
CiAgICAgICAgIHJldCA9IC1FSU5WQUw7CkBAIC03MzUsMTAgKzczNSwxMCBAQCBzdGF0aWMgaW50
IG52bWVfaW5pdChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBpbnQg
bmFtZXNwYWNlLAogICAgIHRpbWVvdXRfbXMgPSBNSU4oNTAwICogKChjYXAgPj4gMjQpICYgMHhG
RiksIDMwMDAwKTsKIAogICAgIC8qIFJlc2V0IGRldmljZSB0byBnZXQgYSBjbGVhbiBzdGF0ZS4g
Ki8KLSAgICBzLT5yZWdzLT5jdHJsLmNjID0gY3B1X3RvX2xlMzIobGUzMl90b19jcHUocy0+cmVn
cy0+Y3RybC5jYykgJiAweEZFKTsKKyAgICByZWdzLT5jdHJsLmNjID0gY3B1X3RvX2xlMzIobGUz
Ml90b19jcHUocmVncy0+Y3RybC5jYykgJiAweEZFKTsKICAgICAvKiBXYWl0IGZvciBDU1RTLlJE
WSA9IDAuICovCiAgICAgZGVhZGxpbmUgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JF
QUxUSU1FKSArIHRpbWVvdXRfbXMgKiBTQ0FMRV9NUzsKLSAgICB3aGlsZSAobGUzMl90b19jcHUo
cy0+cmVncy0+Y3RybC5jc3RzKSAmIDB4MSkgeworICAgIHdoaWxlIChsZTMyX3RvX2NwdShyZWdz
LT5jdHJsLmNzdHMpICYgMHgxKSB7CiAgICAgICAgIGlmIChxZW11X2Nsb2NrX2dldF9ucyhRRU1V
X0NMT0NLX1JFQUxUSU1FKSA+IGRlYWRsaW5lKSB7CiAgICAgICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJUaW1lb3V0IHdoaWxlIHdhaXRpbmcgZm9yIGRldmljZSB0byByZXNldCAoJSIKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUFJJZDY0ICIgbXMpIiwKQEAgLTc2NiwxOCArNzY2LDE4
IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBjb25zdCBjaGFy
ICpkZXZpY2UsIGludCBuYW1lc3BhY2UsCiAgICAgfQogICAgIHMtPm5yX3F1ZXVlcyA9IDE7CiAg
ICAgUUVNVV9CVUlMRF9CVUdfT04oTlZNRV9RVUVVRV9TSVpFICYgMHhGMDAwKTsKLSAgICBzLT5y
ZWdzLT5jdHJsLmFxYSA9IGNwdV90b19sZTMyKChOVk1FX1FVRVVFX1NJWkUgPDwgMTYpIHwgTlZN
RV9RVUVVRV9TSVpFKTsKLSAgICBzLT5yZWdzLT5jdHJsLmFzcSA9IGNwdV90b19sZTY0KHMtPnF1
ZXVlc1tJTkRFWF9BRE1JTl0tPnNxLmlvdmEpOwotICAgIHMtPnJlZ3MtPmN0cmwuYWNxID0gY3B1
X3RvX2xlNjQocy0+cXVldWVzW0lOREVYX0FETUlOXS0+Y3EuaW92YSk7CisgICAgcmVncy0+Y3Ry
bC5hcWEgPSBjcHVfdG9fbGUzMigoTlZNRV9RVUVVRV9TSVpFIDw8IDE2KSB8IE5WTUVfUVVFVUVf
U0laRSk7CisgICAgcmVncy0+Y3RybC5hc3EgPSBjcHVfdG9fbGU2NChzLT5xdWV1ZXNbSU5ERVhf
QURNSU5dLT5zcS5pb3ZhKTsKKyAgICByZWdzLT5jdHJsLmFjcSA9IGNwdV90b19sZTY0KHMtPnF1
ZXVlc1tJTkRFWF9BRE1JTl0tPmNxLmlvdmEpOwogCiAgICAgLyogQWZ0ZXIgc2V0dGluZyB1cCBh
bGwgY29udHJvbCByZWdpc3RlcnMgd2UgY2FuIGVuYWJsZSBkZXZpY2Ugbm93LiAqLwotICAgIHMt
PnJlZ3MtPmN0cmwuY2MgPSBjcHVfdG9fbGUzMigoY3R6MzIoTlZNRV9DUV9FTlRSWV9CWVRFUykg
PDwgMjApIHwKKyAgICByZWdzLT5jdHJsLmNjID0gY3B1X3RvX2xlMzIoKGN0ejMyKE5WTUVfQ1Ff
RU5UUllfQllURVMpIDw8IDIwKSB8CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoY3R6
MzIoTlZNRV9TUV9FTlRSWV9CWVRFUykgPDwgMTYpIHwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4MSk7CiAgICAgLyogV2FpdCBmb3IgQ1NUUy5SRFkgPSAxLiAqLwogICAgIG5vdyA9
IHFlbXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfUkVBTFRJTUUpOwogICAgIGRlYWRsaW5lID0g
bm93ICsgdGltZW91dF9tcyAqIDEwMDAwMDA7Ci0gICAgd2hpbGUgKCEobGUzMl90b19jcHUocy0+
cmVncy0+Y3RybC5jc3RzKSAmIDB4MSkpIHsKKyAgICB3aGlsZSAoIShsZTMyX3RvX2NwdShyZWdz
LT5jdHJsLmNzdHMpICYgMHgxKSkgewogICAgICAgICBpZiAocWVtdV9jbG9ja19nZXRfbnMoUUVN
VV9DTE9DS19SRUFMVElNRSkgPiBkZWFkbGluZSkgewogICAgICAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiVGltZW91dCB3aGlsZSB3YWl0aW5nIGZvciBkZXZpY2UgdG8gc3RhcnQgKCUiCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFBSSWQ2NCAiIG1zKSIsCkBAIC04MDgsNiArODA4LDEw
IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBjb25zdCBjaGFy
ICpkZXZpY2UsIGludCBuYW1lc3BhY2UsCiAgICAgICAgIHJldCA9IC1FSU87CiAgICAgfQogb3V0
OgorICAgIGlmIChyZWdzKSB7CisgICAgICAgIHFlbXVfdmZpb19wY2lfdW5tYXBfYmFyKHMtPnZm
aW8sIDAsICh2b2lkICopcmVncywgMCwgc2l6ZW9mKE52bWVCYXIpKTsKKyAgICB9CisKICAgICAv
KiBDbGVhbmluZyB1cCBpcyBkb25lIGluIG52bWVfZmlsZV9vcGVuKCkgdXBvbiBlcnJvci4gKi8K
ICAgICByZXR1cm4gcmV0OwogfQpAQCAtODgyLDcgKzg4Niw2IEBAIHN0YXRpYyB2b2lkIG52bWVf
Y2xvc2UoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpCiAgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgm
cy0+aXJxX25vdGlmaWVyW01TSVhfU0hBUkVEX0lSUV9JRFhdKTsKICAgICBxZW11X3ZmaW9fcGNp
X3VubWFwX2JhcihzLT52ZmlvLCAwLCAodm9pZCAqKXMtPmRvb3JiZWxscywKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplb2YoTnZtZUJhciksIE5WTUVfRE9PUkJFTExfU0laRSk7Ci0g
ICAgcWVtdV92ZmlvX3BjaV91bm1hcF9iYXIocy0+dmZpbywgMCwgKHZvaWQgKilzLT5yZWdzLCAw
LCBzaXplb2YoTnZtZUJhcikpOwogICAgIHFlbXVfdmZpb19jbG9zZShzLT52ZmlvKTsKIAogICAg
IGdfZnJlZShzLT5kZXZpY2UpOwotLSAKMi4yNi4yCgo=


