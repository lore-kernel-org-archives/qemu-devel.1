Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C5C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C6D208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa4Q/Nav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C6D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0ge-0008IP-5X
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0fh-0006eq-Ob
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0fg-0000FL-JH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0fg-0000FB-GF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3Jtfg1TTB2Ah/JG3MKEAc1vIUmTSjTGAWT/B4X6ezQ=;
 b=Fa4Q/Navdq7WxyOFWvYv6wMoqzPEOuyvWKWuG/XBe0xRyXleRwJDP4XbgUxWrr6trt65oh
 Jb+pSEDP/U2pDOtQwD5OcikkwlICqrm9/70MxE7MIDlCCUpdnoEmm2R6xmtuE0HPWWHs/r
 wx0C2RHPK90M438GeryEEpB2Xg8AjSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-88HbSqWPNM-RqxCCeowwTQ-1; Wed, 11 Mar 2020 08:41:05 -0400
X-MC-Unique: 88HbSqWPNM-RqxCCeowwTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D7431084431;
 Wed, 11 Mar 2020 12:41:04 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 648C338E;
 Wed, 11 Mar 2020 12:41:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] aio-posix: completely stop polling when disabled
Date: Wed, 11 Mar 2020 12:40:39 +0000
Message-Id: <20200311124045.277969-4-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
References: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T25lIGl0ZXJhdGlvbiBvZiBwb2xsaW5nIGlzIGFsd2F5cyBwZXJmb3JtZWQgZXZlbiB3aGVuIHBv
bGxpbmcgaXMKZGlzYWJsZWQuICBUaGlzIGlzIGRvbmUgYmVjYXVzZToKMS4gVXNlcnNwYWNlIHBv
bGxpbmcgaXMgY2hlYXBlciB0aGFuIG1ha2luZyBhIHN5c2NhbGwuICBXZSBtaWdodCBnZXQKICAg
bHVja3kuCjIuIFdlIG11c3QgcG9sbCBvbmNlIG1vcmUgYWZ0ZXIgcG9sbGluZyBoYXMgc3RvcHBl
ZCBpbiBjYXNlIGFuIGV2ZW50CiAgIG9jY3VycmVkIHdoaWxlIHN0b3BwaW5nIHBvbGxpbmcuCgpI
b3dldmVyLCB0aGVyZSBhcmUgZG93bnNpZGVzOgoxLiBQb2xsaW5nIGJlY29tZXMgYSBib3R0bGVu
ZWNrIHdoZW4gdGhlIG51bWJlciBvZiBldmVudCBzb3VyY2VzIGlzIHZlcnkKICAgaGlnaC4gIEl0
J3MgbW9yZSBlZmZpY2llbnQgdG8gbW9uaXRvciBmZHMgaW4gdGhhdCBjYXNlLgoyLiBBIGhpZ2gt
ZnJlcXVlbmN5IHBvbGxpbmcgZXZlbnQgc291cmNlIGNhbiBzdGFydmUgbm9uLXBvbGxpbmcgZXZl
bnQKICAgc291cmNlcyBiZWNhdXNlIHBwb2xsKDIpL2Vwb2xsKDcpIGlzIG5ldmVyIGludm9rZWQu
CgpUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIGZvcmNlZCBwb2xsaW5nIGl0ZXJhdGlvbiBzbyB0aGF0
IHBvbGxfbnM9MCByZWFsbHkKbWVhbnMgbm8gcG9sbGluZy4KCklPUFMgaW5jcmVhc2VzIGZyb20g
MTBrIHRvIDYwayB3aGVuIHRoZSBndWVzdCBoYXMgMTAwCnZpcnRpby1ibGstcGNpLG51bS1xdWV1
ZXM9MzIgZGV2aWNlcyBhbmQgMSB2aXJ0aW8tYmxrLXBjaSxudW0tcXVldWVzPTEKZGV2aWNlIGJl
Y2F1c2UgdGhlIGxhcmdlIG51bWJlciBvZiBldmVudCBzb3VyY2VzIGJlaW5nIHBvbGxlZCBzbG93
cyBkb3duCnRoZSBldmVudCBsb29wLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAw
MzA1MTcwODA2LjEzMTMyNDUtMi1zdGVmYW5oYUByZWRoYXQuY29tCk1lc3NhZ2UtSWQ6IDwyMDIw
MDMwNTE3MDgwNi4xMzEzMjQ1LTItc3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL2Fpby1w
b3NpeC5jIHwgMjIgKysrKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9haW8tcG9zaXgu
YyBiL3V0aWwvYWlvLXBvc2l4LmMKaW5kZXggYjMzOWFhYjEyYy4uNjU5NjRhMjU5NyAxMDA2NDQK
LS0tIGEvdXRpbC9haW8tcG9zaXguYworKysgYi91dGlsL2Fpby1wb3NpeC5jCkBAIC0zNjEsMTIg
KzM2MSwxMyBAQCB2b2lkIGFpb19zZXRfZXZlbnRfbm90aWZpZXJfcG9sbChBaW9Db250ZXh0ICpj
dHgsCiAgICAgICAgICAgICAgICAgICAgIChJT0hhbmRsZXIgKilpb19wb2xsX2VuZCk7CiB9CiAK
LXN0YXRpYyB2b2lkIHBvbGxfc2V0X3N0YXJ0ZWQoQWlvQ29udGV4dCAqY3R4LCBib29sIHN0YXJ0
ZWQpCitzdGF0aWMgYm9vbCBwb2xsX3NldF9zdGFydGVkKEFpb0NvbnRleHQgKmN0eCwgYm9vbCBz
dGFydGVkKQogewogICAgIEFpb0hhbmRsZXIgKm5vZGU7CisgICAgYm9vbCBwcm9ncmVzcyA9IGZh
bHNlOwogCiAgICAgaWYgKHN0YXJ0ZWQgPT0gY3R4LT5wb2xsX3N0YXJ0ZWQpIHsKLSAgICAgICAg
cmV0dXJuOworICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQogCiAgICAgY3R4LT5wb2xsX3N0
YXJ0ZWQgPSBzdGFydGVkOwpAQCAtMzg4LDggKzM4OSwxNSBAQCBzdGF0aWMgdm9pZCBwb2xsX3Nl
dF9zdGFydGVkKEFpb0NvbnRleHQgKmN0eCwgYm9vbCBzdGFydGVkKQogICAgICAgICBpZiAoZm4p
IHsKICAgICAgICAgICAgIGZuKG5vZGUtPm9wYXF1ZSk7CiAgICAgICAgIH0KKworICAgICAgICAv
KiBQb2xsIG9uZSBsYXN0IHRpbWUgaW4gY2FzZSAtPmlvX3BvbGxfZW5kKCkgcmFjZWQgd2l0aCB0
aGUgZXZlbnQgKi8KKyAgICAgICAgaWYgKCFzdGFydGVkKSB7CisgICAgICAgICAgICBwcm9ncmVz
cyA9IG5vZGUtPmlvX3BvbGwobm9kZS0+b3BhcXVlKSB8fCBwcm9ncmVzczsKKyAgICAgICAgfQog
ICAgIH0KICAgICBxZW11X2xvY2tjbnRfZGVjKCZjdHgtPmxpc3RfbG9jayk7CisKKyAgICByZXR1
cm4gcHJvZ3Jlc3M7CiB9CiAKIApAQCAtNjcwLDEyICs2NzgsMTIgQEAgc3RhdGljIGJvb2wgdHJ5
X3BvbGxfbW9kZShBaW9Db250ZXh0ICpjdHgsIGludDY0X3QgKnRpbWVvdXQpCiAgICAgICAgIH0K
ICAgICB9CiAKLSAgICBwb2xsX3NldF9zdGFydGVkKGN0eCwgZmFsc2UpOworICAgIGlmIChwb2xs
X3NldF9zdGFydGVkKGN0eCwgZmFsc2UpKSB7CisgICAgICAgICp0aW1lb3V0ID0gMDsKKyAgICAg
ICAgcmV0dXJuIHRydWU7CisgICAgfQogCi0gICAgLyogRXZlbiBpZiB3ZSBkb24ndCBydW4gYnVz
eSBwb2xsaW5nLCB0cnkgcG9sbGluZyBvbmNlIGluIGNhc2UgaXQgY2FuIG1ha2UKLSAgICAgKiBw
cm9ncmVzcyBhbmQgdGhlIGNhbGxlciB3aWxsIGJlIGFibGUgdG8gYXZvaWQgcHBvbGwoMikvZXBv
bGxfd2FpdCgyKS4KLSAgICAgKi8KLSAgICByZXR1cm4gcnVuX3BvbGxfaGFuZGxlcnNfb25jZShj
dHgsIHRpbWVvdXQpOworICAgIHJldHVybiBmYWxzZTsKIH0KIAogYm9vbCBhaW9fcG9sbChBaW9D
b250ZXh0ICpjdHgsIGJvb2wgYmxvY2tpbmcpCi0tIAoyLjI0LjEKCg==


