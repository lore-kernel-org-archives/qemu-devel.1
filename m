Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D1C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DB620769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG9dufzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DB620769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbD2-00076d-6O
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jMbC6-0005Oj-C1
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jMbC5-0006oP-EP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jMbC5-0006o6-AP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVF2oPLokgrMjXng0KIWWIEZOasxYMIOjCTJUOruRE0=;
 b=dG9dufzn2/HTNSXaVViBDH3MH7vxS6FDHI1UqxdJzEHb8VgniTpoWvLld4aPi6UXhnqnKK
 6DSfoGvU8Rvej9cort3ri805/1XnNOVwTlmG5jPwtCwDgevCmv3nfCYfIe2jy4hQ07laI5
 RIHmQJZJQ/SR34aT/UV62GD5ty4uW2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-VquynQwiM96o-gkPNuv33Q-1; Thu, 09 Apr 2020 13:42:23 -0400
X-MC-Unique: VquynQwiM96o-gkPNuv33Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81851084457;
 Thu,  9 Apr 2020 17:42:21 +0000 (UTC)
Received: from localhost (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4FD391;
 Thu,  9 Apr 2020 17:42:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 1/3] aio-posix: signal-proof fdmon-io_uring
Date: Thu,  9 Apr 2020 18:42:07 +0100
Message-Id: <20200409174209.321725-2-stefanha@redhat.com>
In-Reply-To: <20200409174209.321725-1-stefanha@redhat.com>
References: <20200409174209.321725-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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
U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZp
ZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdl
LWlkOiAyMDIwMDQwODA5MTEzOS4yNzM4NTEtMS1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL2Zk
bW9uLWlvX3VyaW5nLmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvZmRtb24taW9fdXJpbmcu
YyBiL3V0aWwvZmRtb24taW9fdXJpbmcuYwppbmRleCBiNGQ2MTA5ZjIwLi5kNWE4MGVkNmZiIDEw
MDY0NAotLS0gYS91dGlsL2ZkbW9uLWlvX3VyaW5nLmMKKysrIGIvdXRpbC9mZG1vbi1pb191cmlu
Zy5jCkBAIC04OCw3ICs4OCwxMCBAQCBzdGF0aWMgc3RydWN0IGlvX3VyaW5nX3NxZSAqZ2V0X3Nx
ZShBaW9Db250ZXh0ICpjdHgpCiAgICAgfQogCiAgICAgLyogTm8gZnJlZSBzcWVzIGxlZnQsIHN1
Ym1pdCBwZW5kaW5nIHNxZXMgZmlyc3QgKi8KLSAgICByZXQgPSBpb191cmluZ19zdWJtaXQocmlu
Zyk7CisgICAgZG8geworICAgICAgICByZXQgPSBpb191cmluZ19zdWJtaXQocmluZyk7CisgICAg
fSB3aGlsZSAocmV0ID09IC1FSU5UUik7CisKICAgICBhc3NlcnQocmV0ID4gMSk7CiAgICAgc3Fl
ID0gaW9fdXJpbmdfZ2V0X3NxZShyaW5nKTsKICAgICBhc3NlcnQoc3FlKTsKQEAgLTI4Miw3ICsy
ODUsMTAgQEAgc3RhdGljIGludCBmZG1vbl9pb191cmluZ193YWl0KEFpb0NvbnRleHQgKmN0eCwg
QWlvSGFuZGxlckxpc3QgKnJlYWR5X2xpc3QsCiAKICAgICBmaWxsX3NxX3JpbmcoY3R4KTsKIAot
ICAgIHJldCA9IGlvX3VyaW5nX3N1Ym1pdF9hbmRfd2FpdCgmY3R4LT5mZG1vbl9pb191cmluZywg
d2FpdF9ucik7CisgICAgZG8geworICAgICAgICByZXQgPSBpb191cmluZ19zdWJtaXRfYW5kX3dh
aXQoJmN0eC0+ZmRtb25faW9fdXJpbmcsIHdhaXRfbnIpOworICAgIH0gd2hpbGUgKHJldCA9PSAt
RUlOVFIpOworCiAgICAgYXNzZXJ0KHJldCA+PSAwKTsKIAogICAgIHJldHVybiBwcm9jZXNzX2Nx
X3JpbmcoY3R4LCByZWFkeV9saXN0KTsKLS0gCjIuMjUuMQoK


