Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9CDC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B23F2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTPeUDnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B23F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56SW-0000Ct-9X
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j56RJ-0006Ol-SO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j56RI-0001vC-DR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j56RI-0001v1-9P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582284347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JxLX3G2fQYdmYBZqXd/PlErIkcNdVDptn8OF0OsJVU=;
 b=TTPeUDnA0rD9xN8xJvLxfoHWq/P0XAqUUZ/9C26Mm9H6MHuOYIzGfZr4b2y0nc9w6PwIGz
 8S6Ju26BbYrHnWuSKawmc7c7u11VLJbLqQQV5gohTa9Yd9YjOY1dS5OmhlQTfpuqjyQwNR
 lQfokV9RX4V8WXLm+vQLFInJ/aHZbxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-TUt43Nq1O9uD7bHCO09fbQ-1; Fri, 21 Feb 2020 06:25:42 -0500
X-MC-Unique: TUt43Nq1O9uD7bHCO09fbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 153E6800D5B;
 Fri, 21 Feb 2020 11:25:41 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0AFF1001DC2;
 Fri, 21 Feb 2020 11:25:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] qemu-img: allow qemu-img measure --object without a
 filename
Date: Fri, 21 Feb 2020 11:25:21 +0000
Message-Id: <20200221112522.1497712-4-stefanha@redhat.com>
In-Reply-To: <20200221112522.1497712-1-stefanha@redhat.com>
References: <20200221112522.1497712-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW4gbW9zdCBxZW11LWltZyBzdWItY29tbWFuZHMgdGhlIC0tb2JqZWN0IG9wdGlvbiBvbmx5IG1h
a2VzIHNlbnNlIHdoZW4KdGhlcmUgaXMgYSBmaWxlbmFtZS4gIHFlbXUtaW1nIG1lYXN1cmUgaXMg
YW4gZXhjZXB0aW9uIGJlY2F1c2Ugb2JqZWN0cwptYXkgYmUgcmVmZXJlbmNlZCBmcm9tIHRoZSBp
bWFnZSBjcmVhdGlvbiBvcHRpb25zIGluc3RlYWQgb2YgYW4gZXhpc3RpbmcKaW1hZ2UgZmlsZS4g
IEFsbG93IC0tb2JqZWN0IHdpdGhvdXQgYSBmaWxlbmFtZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IE1heCBSZWl0eiA8
bXJlaXR6QHJlZGhhdC5jb20+Ci0tLQogcWVtdS1pbWcuYyAgICAgICAgICAgICAgICAgICAgICAg
fCA2ICsrLS0tLQogdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OCAgICAgICAgICAgfCAyICstCiB0ZXN0
cy9xZW11LWlvdGVzdHMvMTc4Lm91dC5xY293MiB8IDggKysrKy0tLS0KIHRlc3RzL3FlbXUtaW90
ZXN0cy8xNzgub3V0LnJhdyAgIHwgOCArKysrLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9xZW11LWltZy5jIGIvcWVt
dS1pbWcuYwppbmRleCAyYjQ1NjJiOWQ5Li4wY2VlN2JlZDhiIDEwMDY0NAotLS0gYS9xZW11LWlt
Zy5jCisrKyBiL3FlbXUtaW1nLmMKQEAgLTQ5MTIsMTAgKzQ5MTIsOCBAQCBzdGF0aWMgaW50IGlt
Z19tZWFzdXJlKGludCBhcmdjLCBjaGFyICoqYXJndikKICAgICAgICAgZmlsZW5hbWUgPSBhcmd2
W29wdGluZF07CiAgICAgfQogCi0gICAgaWYgKCFmaWxlbmFtZSAmJgotICAgICAgICAob2JqZWN0
X29wdHMgfHwgaW1hZ2Vfb3B0cyB8fCBmbXQgfHwgc25hcHNob3RfbmFtZSB8fCBzbl9vcHRzKSkg
ewotICAgICAgICBlcnJvcl9yZXBvcnQoIi0tb2JqZWN0LCAtLWltYWdlLW9wdHMsIC1mLCBhbmQg
LWwgIgotICAgICAgICAgICAgICAgICAgICAgInJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4i
KTsKKyAgICBpZiAoIWZpbGVuYW1lICYmIChpbWFnZV9vcHRzIHx8IGZtdCB8fCBzbmFwc2hvdF9u
YW1lIHx8IHNuX29wdHMpKSB7CisgICAgICAgIGVycm9yX3JlcG9ydCgiLS1pbWFnZS1vcHRzLCAt
ZiwgYW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4iKTsKICAgICAgICAgZ290byBv
dXQ7CiAgICAgfQogICAgIGlmIChmaWxlbmFtZSAmJiBpbWdfc2l6ZSAhPSBVSU5UNjRfTUFYKSB7
CmRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMTc4IGIvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzE3OAppbmRleCA1MWE3MGZlNjY5Li43Y2YwZTI3MTU0IDEwMDc1NQotLS0gYS90ZXN0cy9xZW11
LWlvdGVzdHMvMTc4CisrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNzgKQEAgLTUwLDcgKzUwLDcg
QEAgX21ha2VfdGVzdF9pbWcgMUcKICRRRU1VX0lNRyBtZWFzdXJlICMgbWlzc2luZyBhcmd1bWVu
dHMKICRRRU1VX0lNRyBtZWFzdXJlIC0tc2l6ZSAyRyAiJFRFU1RfSU1HIiAjIG9ubHkgb25lIGFs
bG93ZWQKICRRRU1VX0lNRyBtZWFzdXJlICIkVEVTVF9JTUciIGEgIyBvbmx5IG9uZSBmaWxlbmFt
ZSBhbGxvd2VkCi0kUUVNVV9JTUcgbWVhc3VyZSAtLW9iamVjdCBzZWNyZXQsaWQ9c2VjMCxkYXRh
PU1USXpORFUyLGZvcm1hdD1iYXNlNjQgIyBtaXNzaW5nIGZpbGVuYW1lCiskUUVNVV9JTUcgbWVh
c3VyZSAtLW9iamVjdCBzZWNyZXQsaWQ9c2VjMCxkYXRhPU1USXpORFUyLGZvcm1hdD1iYXNlNjQg
IyBzaXplIG9yIGZpbGVuYW1lIG5lZWRlZAogJFFFTVVfSU1HIG1lYXN1cmUgLS1pbWFnZS1vcHRz
ICMgbWlzc2luZyBmaWxlbmFtZQogJFFFTVVfSU1HIG1lYXN1cmUgLWYgcWNvdzIgIyBtaXNzaW5n
IGZpbGVuYW1lCiAkUUVNVV9JTUcgbWVhc3VyZSAtbCBzbmFwMSAjIG1pc3NpbmcgZmlsZW5hbWUK
ZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNzgub3V0LnFjb3cyIGIvdGVzdHMvcWVt
dS1pb3Rlc3RzLzE3OC5vdXQucWNvdzIKaW5kZXggOWU3ZDhjNDRkZi4uZjU5YmY0YjJmYiAxMDA2
NDQKLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OC5vdXQucWNvdzIKKysrIGIvdGVzdHMvcWVt
dS1pb3Rlc3RzLzE3OC5vdXQucWNvdzIKQEAgLTUsMTAgKzUsMTAgQEAgRm9ybWF0dGluZyAnVEVT
VF9ESVIvdC5JTUdGTVQnLCBmbXQ9SU1HRk1UIHNpemU9MTA3Mzc0MTgyNAogcWVtdS1pbWc6IEVp
dGhlciAtLXNpemUgTiBvciBvbmUgZmlsZW5hbWUgbXVzdCBiZSBzcGVjaWZpZWQuCiBxZW11LWlt
ZzogLS1zaXplIE4gY2Fubm90IGJlIHVzZWQgdG9nZXRoZXIgd2l0aCBhIGZpbGVuYW1lLgogcWVt
dS1pbWc6IEF0IG1vc3Qgb25lIGZpbGVuYW1lIGFyZ3VtZW50IGlzIGFsbG93ZWQuCi1xZW11LWlt
ZzogLS1vYmplY3QsIC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUg
YXJndW1lbnQuCi1xZW11LWltZzogLS1vYmplY3QsIC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCBy
ZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQuCi1xZW11LWltZzogLS1vYmplY3QsIC0taW1hZ2Ut
b3B0cywgLWYsIGFuZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQuCi1xZW11LWltZzog
LS1vYmplY3QsIC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUgYXJn
dW1lbnQuCitxZW11LWltZzogRWl0aGVyIC0tc2l6ZSBOIG9yIG9uZSBmaWxlbmFtZSBtdXN0IGJl
IHNwZWNpZmllZC4KK3FlbXUtaW1nOiAtLWltYWdlLW9wdHMsIC1mLCBhbmQgLWwgcmVxdWlyZSBh
IGZpbGVuYW1lIGFyZ3VtZW50LgorcWVtdS1pbWc6IC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCBy
ZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQuCitxZW11LWltZzogLS1pbWFnZS1vcHRzLCAtZiwg
YW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KIHFlbXUtaW1nOiBJbnZhbGlkIG9w
dGlvbiBsaXN0OiAsCiBxZW11LWltZzogSW52YWxpZCBwYXJhbWV0ZXIgJ3NuYXBzaG90LmZvbycK
IHFlbXUtaW1nOiBGYWlsZWQgaW4gcGFyc2luZyBzbmFwc2hvdCBwYXJhbSAnc25hcHNob3QuZm9v
JwpkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OC5vdXQucmF3IGIvdGVzdHMvcWVt
dS1pb3Rlc3RzLzE3OC5vdXQucmF3CmluZGV4IDY0NzgzNjU5MDUuLjQwNGNhOTA4ZDggMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNzgub3V0LnJhdworKysgYi90ZXN0cy9xZW11LWlv
dGVzdHMvMTc4Lm91dC5yYXcKQEAgLTUsMTAgKzUsMTAgQEAgRm9ybWF0dGluZyAnVEVTVF9ESVIv
dC5JTUdGTVQnLCBmbXQ9SU1HRk1UIHNpemU9MTA3Mzc0MTgyNAogcWVtdS1pbWc6IEVpdGhlciAt
LXNpemUgTiBvciBvbmUgZmlsZW5hbWUgbXVzdCBiZSBzcGVjaWZpZWQuCiBxZW11LWltZzogLS1z
aXplIE4gY2Fubm90IGJlIHVzZWQgdG9nZXRoZXIgd2l0aCBhIGZpbGVuYW1lLgogcWVtdS1pbWc6
IEF0IG1vc3Qgb25lIGZpbGVuYW1lIGFyZ3VtZW50IGlzIGFsbG93ZWQuCi1xZW11LWltZzogLS1v
YmplY3QsIC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1l
bnQuCi1xZW11LWltZzogLS1vYmplY3QsIC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCByZXF1aXJl
IGEgZmlsZW5hbWUgYXJndW1lbnQuCi1xZW11LWltZzogLS1vYmplY3QsIC0taW1hZ2Utb3B0cywg
LWYsIGFuZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQuCi1xZW11LWltZzogLS1vYmpl
Y3QsIC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQu
CitxZW11LWltZzogRWl0aGVyIC0tc2l6ZSBOIG9yIG9uZSBmaWxlbmFtZSBtdXN0IGJlIHNwZWNp
ZmllZC4KK3FlbXUtaW1nOiAtLWltYWdlLW9wdHMsIC1mLCBhbmQgLWwgcmVxdWlyZSBhIGZpbGVu
YW1lIGFyZ3VtZW50LgorcWVtdS1pbWc6IC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCByZXF1aXJl
IGEgZmlsZW5hbWUgYXJndW1lbnQuCitxZW11LWltZzogLS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1s
IHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KIHFlbXUtaW1nOiBJbnZhbGlkIG9wdGlvbiBs
aXN0OiAsCiBxZW11LWltZzogSW52YWxpZCBwYXJhbWV0ZXIgJ3NuYXBzaG90LmZvbycKIHFlbXUt
aW1nOiBGYWlsZWQgaW4gcGFyc2luZyBzbmFwc2hvdCBwYXJhbSAnc25hcHNob3QuZm9vJwotLSAK
Mi4yNC4xCgo=


