Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8417EC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F847208C4
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsceqPPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F847208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QiO-0004qt-FR
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QXO-0000YR-T8
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QXN-0000hQ-J4
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24384
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QXN-0000hA-EP
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKwszAKgEu8Yc6LL/yDg5zjRkIzdNtJlTPkjAP5lJYo=;
 b=OsceqPPQkB2wLLV3u07Z/uxVWIyk0YBagIml35knWdV7IDDO+dEWqsCp2EIMQ0I8kItVUc
 3XTm89ZMuVcx5izLqj/Hb/qaRpnDEy2rkY5UNNNfv2GpKitcWmIhvh0aZZe8DPm6eVnpHY
 dUuUJ3Na6GRlmil+KYNbuz2ZBBXZCvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-WVxOiSVbOryJEyr7CYecoQ-1; Sat, 22 Feb 2020 03:53:23 -0500
X-MC-Unique: WVxOiSVbOryJEyr7CYecoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C04800D50;
 Sat, 22 Feb 2020 08:53:21 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AEA35D9CD;
 Sat, 22 Feb 2020 08:53:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] libqtest: add a layer of abstraction to send/recv
Date: Sat, 22 Feb 2020 08:50:14 +0000
Message-Id: <20200222085030.1760640-16-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpUaGlzIG1ha2VzIGl0IHNp
bXBsZSB0byBzd2FwIHRoZSB0cmFuc3BvcnQgZnVuY3Rpb25zIGZvciBxdGVzdCBjb21tYW5kcwp0
byBhbmQgZnJvbSB0aGUgcXRlc3QgY2xpZW50LiBGb3IgZXhhbXBsZSwgbm93IGl0IGlzIHBvc3Np
YmxlIHRvCmRpcmVjdGx5IHBhc3MgcXRlc3QgY29tbWFuZHMgdG8gYSBzZXJ2ZXIgaGFuZGxlciB0
aGF0IGV4aXN0cyB3aXRoaW4gdGhlCnNhbWUgcHJvY2Vzcywgd2l0aG91dCB0aGUgc3RhbmRhcmQg
d2F5IG9mIHdyaXRpbmcgdG8gYSBmaWxlIGRlc2NyaXB0b3IuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IERhcnJlbiBLZW5ueSA8ZGFycmVu
Lmtlbm55QG9yYWNsZS5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMjIwMDQxMTE4LjIzMjY0LTctYWx4
bmRyQGJ1LmVkdQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvbGlicXRlc3QuYyB8IDQ4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbGlicXRlc3QuYyBi
L3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmMKaW5kZXggNzZjOWY4ZWFkZS4uZTUwNTZhMWQwZiAxMDA2
NDQKLS0tIGEvdGVzdHMvcXRlc3QvbGlicXRlc3QuYworKysgYi90ZXN0cy9xdGVzdC9saWJxdGVz
dC5jCkBAIC0zNSw2ICszNSwxNSBAQAogI2RlZmluZSBTT0NLRVRfVElNRU9VVCA1MAogI2RlZmlu
ZSBTT0NLRVRfTUFYX0ZEUyAxNgogCisKK3R5cGVkZWYgdm9pZCAoKlFUZXN0U2VuZEZuKShRVGVz
dFN0YXRlICpzLCBjb25zdCBjaGFyICpidWYpOwordHlwZWRlZiBHU3RyaW5nKiAoKlFUZXN0UmVj
dkZuKShRVGVzdFN0YXRlICopOworCit0eXBlZGVmIHN0cnVjdCBRVGVzdENsaWVudFRyYW5zcG9y
dE9wcyB7CisgICAgUVRlc3RTZW5kRm4gICAgIHNlbmQ7ICAgICAgLyogZm9yIHNlbmRpbmcgcXRl
c3QgY29tbWFuZHMgKi8KKyAgICBRVGVzdFJlY3ZGbiAgICAgcmVjdl9saW5lOyAvKiBmb3IgcmVj
ZWl2aW5nIHF0ZXN0IGNvbW1hbmQgcmVzcG9uc2VzICovCit9IFFUZXN0VHJhbnNwb3J0T3BzOwor
CiBzdHJ1Y3QgUVRlc3RTdGF0ZQogewogICAgIGludCBmZDsKQEAgLTQ1LDYgKzU0LDcgQEAgc3Ry
dWN0IFFUZXN0U3RhdGUKICAgICBib29sIGJpZ19lbmRpYW47CiAgICAgYm9vbCBpcnFfbGV2ZWxb
TUFYX0lSUV07CiAgICAgR1N0cmluZyAqcng7CisgICAgUVRlc3RUcmFuc3BvcnRPcHMgb3BzOwog
fTsKIAogc3RhdGljIEdIb29rTGlzdCBhYnJ0X2hvb2tzOwpAQCAtNTIsNiArNjIsMTQgQEAgc3Rh
dGljIHN0cnVjdCBzaWdhY3Rpb24gc2lnYWN0X29sZDsKIAogc3RhdGljIGludCBxdGVzdF9xdWVy
eV90YXJnZXRfZW5kaWFubmVzcyhRVGVzdFN0YXRlICpzKTsKIAorc3RhdGljIHZvaWQgcXRlc3Rf
Y2xpZW50X3NvY2tldF9zZW5kKFFUZXN0U3RhdGUqLCBjb25zdCBjaGFyICpidWYpOworc3RhdGlj
IHZvaWQgc29ja2V0X3NlbmQoaW50IGZkLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBzaXplKTsK
Kworc3RhdGljIEdTdHJpbmcgKnF0ZXN0X2NsaWVudF9zb2NrZXRfcmVjdl9saW5lKFFUZXN0U3Rh
dGUgKik7CisKK3N0YXRpYyB2b2lkIHF0ZXN0X2NsaWVudF9zZXRfdHhfaGFuZGxlcihRVGVzdFN0
YXRlICpzLCBRVGVzdFNlbmRGbiBzZW5kKTsKK3N0YXRpYyB2b2lkIHF0ZXN0X2NsaWVudF9zZXRf
cnhfaGFuZGxlcihRVGVzdFN0YXRlICpzLCBRVGVzdFJlY3ZGbiByZWN2KTsKKwogc3RhdGljIGlu
dCBpbml0X3NvY2tldChjb25zdCBjaGFyICpzb2NrZXRfcGF0aCkKIHsKICAgICBzdHJ1Y3Qgc29j
a2FkZHJfdW4gYWRkcjsKQEAgLTIzNCw2ICsyNTIsOSBAQCBRVGVzdFN0YXRlICpxdGVzdF9pbml0
X3dpdGhvdXRfcW1wX2hhbmRzaGFrZShjb25zdCBjaGFyICpleHRyYV9hcmdzKQogICAgIHNvY2sg
PSBpbml0X3NvY2tldChzb2NrZXRfcGF0aCk7CiAgICAgcW1wc29jayA9IGluaXRfc29ja2V0KHFt
cF9zb2NrZXRfcGF0aCk7CiAKKyAgICBxdGVzdF9jbGllbnRfc2V0X3J4X2hhbmRsZXIocywgcXRl
c3RfY2xpZW50X3NvY2tldF9yZWN2X2xpbmUpOworICAgIHF0ZXN0X2NsaWVudF9zZXRfdHhfaGFu
ZGxlcihzLCBxdGVzdF9jbGllbnRfc29ja2V0X3NlbmQpOworCiAgICAgcXRlc3RfYWRkX2FicnRf
aGFuZGxlcihraWxsX3FlbXVfaG9va19mdW5jLCBzKTsKIAogICAgIGNvbW1hbmQgPSBnX3N0cmR1
cF9wcmludGYoImV4ZWMgJXMgIgpAQCAtMzc5LDEzICs0MDAsOSBAQCBzdGF0aWMgdm9pZCBzb2Nr
ZXRfc2VuZChpbnQgZmQsIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpCiAgICAgfQogfQog
Ci1zdGF0aWMgdm9pZCBzb2NrZXRfc2VuZGYoaW50IGZkLCBjb25zdCBjaGFyICpmbXQsIHZhX2xp
c3QgYXApCitzdGF0aWMgdm9pZCBxdGVzdF9jbGllbnRfc29ja2V0X3NlbmQoUVRlc3RTdGF0ZSAq
cywgY29uc3QgY2hhciAqYnVmKQogewotICAgIGdjaGFyICpzdHIgPSBnX3N0cmR1cF92cHJpbnRm
KGZtdCwgYXApOwotICAgIHNpemVfdCBzaXplID0gc3RybGVuKHN0cik7Ci0KLSAgICBzb2NrZXRf
c2VuZChmZCwgc3RyLCBzaXplKTsKLSAgICBnX2ZyZWUoc3RyKTsKKyAgICBzb2NrZXRfc2VuZChz
LT5mZCwgYnVmLCBzdHJsZW4oYnVmKSk7CiB9CiAKIHN0YXRpYyB2b2lkIEdDQ19GTVRfQVRUUigy
LCAzKSBxdGVzdF9zZW5kZihRVGVzdFN0YXRlICpzLCBjb25zdCBjaGFyICpmbXQsIC4uLikKQEAg
LTM5Myw4ICs0MTAsMTEgQEAgc3RhdGljIHZvaWQgR0NDX0ZNVF9BVFRSKDIsIDMpIHF0ZXN0X3Nl
bmRmKFFUZXN0U3RhdGUgKnMsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKQogICAgIHZhX2xpc3QgYXA7
CiAKICAgICB2YV9zdGFydChhcCwgZm10KTsKLSAgICBzb2NrZXRfc2VuZGYocy0+ZmQsIGZtdCwg
YXApOworICAgIGdjaGFyICpzdHIgPSBnX3N0cmR1cF92cHJpbnRmKGZtdCwgYXApOwogICAgIHZh
X2VuZChhcCk7CisKKyAgICBzLT5vcHMuc2VuZChzLCBzdHIpOworICAgIGdfZnJlZShzdHIpOwog
fQogCiAvKiBTZW5kcyBhIG1lc3NhZ2UgYW5kIGZpbGUgZGVzY3JpcHRvcnMgdG8gdGhlIHNvY2tl
dC4KQEAgLTQzMSw3ICs0NTEsNyBAQCBzdGF0aWMgdm9pZCBzb2NrZXRfc2VuZF9mZHMoaW50IHNv
Y2tldF9mZCwgaW50ICpmZHMsIHNpemVfdCBmZHNfbnVtLAogICAgIGdfYXNzZXJ0X2NtcGludChy
ZXQsID4sIDApOwogfQogCi1zdGF0aWMgR1N0cmluZyAqcXRlc3RfcmVjdl9saW5lKFFUZXN0U3Rh
dGUgKnMpCitzdGF0aWMgR1N0cmluZyAqcXRlc3RfY2xpZW50X3NvY2tldF9yZWN2X2xpbmUoUVRl
c3RTdGF0ZSAqcykKIHsKICAgICBHU3RyaW5nICpsaW5lOwogICAgIHNpemVfdCBvZmZzZXQ7CkBA
IC00NjgsNyArNDg4LDcgQEAgc3RhdGljIGdjaGFyICoqcXRlc3RfcnNwKFFUZXN0U3RhdGUgKnMs
IGludCBleHBlY3RlZF9hcmdzKQogICAgIGludCBpOwogCiByZWRvOgotICAgIGxpbmUgPSBxdGVz
dF9yZWN2X2xpbmUocyk7CisgICAgbGluZSA9IHMtPm9wcy5yZWN2X2xpbmUocyk7CiAgICAgd29y
ZHMgPSBnX3N0cnNwbGl0KGxpbmUtPnN0ciwgIiAiLCAwKTsKICAgICBnX3N0cmluZ19mcmVlKGxp
bmUsIFRSVUUpOwogCkBAIC0xMzM3LDMgKzEzNTcsMTMgQEAgdm9pZCBxbXBfYXNzZXJ0X2Vycm9y
X2NsYXNzKFFEaWN0ICpyc3AsIGNvbnN0IGNoYXIgKmNsYXNzKQogCiAgICAgcW9iamVjdF91bnJl
Zihyc3ApOwogfQorCitzdGF0aWMgdm9pZCBxdGVzdF9jbGllbnRfc2V0X3R4X2hhbmRsZXIoUVRl
c3RTdGF0ZSAqcywKKyAgICAgICAgICAgICAgICAgICAgUVRlc3RTZW5kRm4gc2VuZCkKK3sKKyAg
ICBzLT5vcHMuc2VuZCA9IHNlbmQ7Cit9CitzdGF0aWMgdm9pZCBxdGVzdF9jbGllbnRfc2V0X3J4
X2hhbmRsZXIoUVRlc3RTdGF0ZSAqcywgUVRlc3RSZWN2Rm4gcmVjdikKK3sKKyAgICBzLT5vcHMu
cmVjdl9saW5lID0gcmVjdjsKK30KLS0gCjIuMjQuMQoK


