Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D2C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBDB2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzilrd6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBDB2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6lq-0008Bv-VB
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jM6kT-0006Rh-Kg
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jM6kR-0002TJ-DZ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:11:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jM6kR-0002Sp-A6
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586337110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+OnMlkR57OpXijgZ9SMDHND6/b9Z/s6xw8PDZc3TL68=;
 b=hzilrd6lg4KUZLkpUNqGuEEcjok0QZI9rdhi7LmT7kSPL0jEehMVkEBzpUTbyDwttJgH89
 zryT3+KWSxq2kriN3lHLQvnqIV/SHek5ziZp7WQvaEEAnq2bXaXMFDN0ttsYFpGDOXcbYy
 BtzgA1OBeQFC3FSZSGvnAxzSmjC0iRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-FHyhIlw8MGa3cs-6_gpo9g-1; Wed, 08 Apr 2020 05:11:49 -0400
X-MC-Unique: FHyhIlw8MGa3cs-6_gpo9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9ED18B9FC8;
 Wed,  8 Apr 2020 09:11:46 +0000 (UTC)
Received: from localhost (ovpn-114-249.ams2.redhat.com [10.36.114.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E4B68C08D;
 Wed,  8 Apr 2020 09:11:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] aio-posix: signal-proof fdmon-io_uring
Date: Wed,  8 Apr 2020 10:11:39 +0100
Message-Id: <20200408091139.273851-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGlvX3VyaW5nX2VudGVyKDIpIHN5c2NhbGwgcmV0dXJucyB3aXRoIGVycm5vPUVJTlRSIHdo
ZW4gaW50ZXJydXB0ZWQKYnkgYSBzaWduYWwuICBSZXRyeSB0aGUgc3lzY2FsbCBpbiB0aGlzIGNh
c2UuCgpJdCdzIGVzc2VudGlhbCB0byBkbyB0aGlzIGluIHRoZSBpb191cmluZ19zdWJtaXRfYW5k
X3dhaXQoKSBjYXNlLiAgTXkKaW50ZXJwcmV0YXRpb24gb2YgdGhlIExpbnV4IHY1LjUgaW9fdXJp
bmdfZW50ZXIoMikgY29kZSBpcyB0aGF0IGl0CnNob3VsZG4ndCBhZmZlY3QgdGhlIGlvX3VyaW5n
X3N1Ym1pdCgpIGNhc2UsIGJ1dCB0aGVyZSBpcyBubyBndWFyYW50ZWUKdGhpcyB3aWxsIGFsd2F5
cyBiZSB0aGUgY2FzZS4gIExldCdzIGNoZWNrIGZvciAtRUlOVFIgYXJvdW5kIGJvdGggQVBJcy4K
Ck5vdGUgdGhhdCB0aGUgbGlidXJpbmcgQVBJcyBoYXZlIC1lcnJubyByZXR1cm4gdmFsdWVzLgoK
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IHV0aWwvZmRtb24taW9fdXJpbmcuYyB8IDEwICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9mZG1vbi1p
b191cmluZy5jIGIvdXRpbC9mZG1vbi1pb191cmluZy5jCmluZGV4IGI0ZDYxMDlmMjAuLmQ1YTgw
ZWQ2ZmIgMTAwNjQ0Ci0tLSBhL3V0aWwvZmRtb24taW9fdXJpbmcuYworKysgYi91dGlsL2ZkbW9u
LWlvX3VyaW5nLmMKQEAgLTg4LDcgKzg4LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgaW9fdXJpbmdfc3Fl
ICpnZXRfc3FlKEFpb0NvbnRleHQgKmN0eCkKICAgICB9CiAKICAgICAvKiBObyBmcmVlIHNxZXMg
bGVmdCwgc3VibWl0IHBlbmRpbmcgc3FlcyBmaXJzdCAqLwotICAgIHJldCA9IGlvX3VyaW5nX3N1
Ym1pdChyaW5nKTsKKyAgICBkbyB7CisgICAgICAgIHJldCA9IGlvX3VyaW5nX3N1Ym1pdChyaW5n
KTsKKyAgICB9IHdoaWxlIChyZXQgPT0gLUVJTlRSKTsKKwogICAgIGFzc2VydChyZXQgPiAxKTsK
ICAgICBzcWUgPSBpb191cmluZ19nZXRfc3FlKHJpbmcpOwogICAgIGFzc2VydChzcWUpOwpAQCAt
MjgyLDcgKzI4NSwxMCBAQCBzdGF0aWMgaW50IGZkbW9uX2lvX3VyaW5nX3dhaXQoQWlvQ29udGV4
dCAqY3R4LCBBaW9IYW5kbGVyTGlzdCAqcmVhZHlfbGlzdCwKIAogICAgIGZpbGxfc3FfcmluZyhj
dHgpOwogCi0gICAgcmV0ID0gaW9fdXJpbmdfc3VibWl0X2FuZF93YWl0KCZjdHgtPmZkbW9uX2lv
X3VyaW5nLCB3YWl0X25yKTsKKyAgICBkbyB7CisgICAgICAgIHJldCA9IGlvX3VyaW5nX3N1Ym1p
dF9hbmRfd2FpdCgmY3R4LT5mZG1vbl9pb191cmluZywgd2FpdF9ucik7CisgICAgfSB3aGlsZSAo
cmV0ID09IC1FSU5UUik7CisKICAgICBhc3NlcnQocmV0ID49IDApOwogCiAgICAgcmV0dXJuIHBy
b2Nlc3NfY3FfcmluZyhjdHgsIHJlYWR5X2xpc3QpOwotLSAKMi4yNS4xCgo=


