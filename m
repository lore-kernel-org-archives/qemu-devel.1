Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FEBC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C252071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q70kR3zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C252071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QgA-0000lR-DZ
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QYh-0003Md-9E
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QYg-0002Uu-8Z
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QYg-0002T1-4H
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCjuxJEFBatZ6J+737OYr/8ebBR5a4ikhIbtsJ2K5Is=;
 b=Q70kR3zkCGhcOAdNL6TWPI/JUyQ5xPBdLPIwxdQ2+fVAE188HaVvkMJ8+7HW6H/DJuZJfq
 7iwjiSbTzLJpuhUjx2U7lysdrWzsAOgXBtmfCrzgNNre1yb+srHXIzoSd4LL6isceNhbhn
 ugcwAzXF9EADpLOOJDJGgwEBVn9g3Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-CbCWf7DpO8yrMfQ87fInTg-1; Sat, 22 Feb 2020 03:54:40 -0500
X-MC-Unique: CbCWf7DpO8yrMfQ87fInTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FDB5800D50;
 Sat, 22 Feb 2020 08:54:39 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE65C8B742;
 Sat, 22 Feb 2020 08:54:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/31] exec: keep ram block across fork when using qtest
Date: Sat, 22 Feb 2020 08:50:21 +0000
Message-Id: <20200222085030.1760640-23-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpSYW0gYmxvY2tzIHdlcmUg
bWFya2VkIE1BRFZfRE9OVEZPUksgYnJlYWtpbmcgZnV6emluZy10ZXN0cyB3aGljaApleGVjdXRl
IGVhY2ggdGVzdC1pbnB1dCBpbiBhIGZvcmtlZCBwcm9jZXNzLgoKU2lnbmVkLW9mZi1ieTogQWxl
eGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9j
emkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJl
bi5rZW5ueUBvcmFjbGUuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDIyMDA0MTExOC4yMzI2NC0xNC1h
bHhuZHJAYnUuZWR1ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KLS0tCiBleGVjLmMgfCAxMiArKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2V4ZWMuYyBiL2V4
ZWMuYwppbmRleCA4ZTljYzNiNDdjLi5jOTMwMDQwZjgzIDEwMDY0NAotLS0gYS9leGVjLmMKKysr
IGIvZXhlYy5jCkBAIC0zNSw2ICszNSw3IEBACiAjaW5jbHVkZSAic3lzZW11L2t2bS5oIgogI2lu
Y2x1ZGUgInN5c2VtdS9zeXNlbXUuaCIKICNpbmNsdWRlICJzeXNlbXUvdGNnLmgiCisjaW5jbHVk
ZSAic3lzZW11L3F0ZXN0LmgiCiAjaW5jbHVkZSAicWVtdS90aW1lci5oIgogI2luY2x1ZGUgInFl
bXUvY29uZmlnLWZpbGUuaCIKICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIgpAQCAtMjMw
NSw4ICsyMzA2LDE1IEBAIHN0YXRpYyB2b2lkIHJhbV9ibG9ja19hZGQoUkFNQmxvY2sgKm5ld19i
bG9jaywgRXJyb3IgKiplcnJwLCBib29sIHNoYXJlZCkKICAgICBpZiAobmV3X2Jsb2NrLT5ob3N0
KSB7CiAgICAgICAgIHFlbXVfcmFtX3NldHVwX2R1bXAobmV3X2Jsb2NrLT5ob3N0LCBuZXdfYmxv
Y2stPm1heF9sZW5ndGgpOwogICAgICAgICBxZW11X21hZHZpc2UobmV3X2Jsb2NrLT5ob3N0LCBu
ZXdfYmxvY2stPm1heF9sZW5ndGgsIFFFTVVfTUFEVl9IVUdFUEFHRSk7Ci0gICAgICAgIC8qIE1B
RFZfRE9OVEZPUksgaXMgYWxzbyBuZWVkZWQgYnkgS1ZNIGluIGFic2VuY2Ugb2Ygc3luY2hyb25v
dXMgTU1VICovCi0gICAgICAgIHFlbXVfbWFkdmlzZShuZXdfYmxvY2stPmhvc3QsIG5ld19ibG9j
ay0+bWF4X2xlbmd0aCwgUUVNVV9NQURWX0RPTlRGT1JLKTsKKyAgICAgICAgLyoKKyAgICAgICAg
ICogTUFEVl9ET05URk9SSyBpcyBhbHNvIG5lZWRlZCBieSBLVk0gaW4gYWJzZW5jZSBvZiBzeW5j
aHJvbm91cyBNTVUKKyAgICAgICAgICogQ29uZmlndXJlIGl0IHVubGVzcyB0aGUgbWFjaGluZSBp
cyBhIHF0ZXN0IHNlcnZlciwgaW4gd2hpY2ggY2FzZQorICAgICAgICAgKiBLVk0gaXMgbm90IHVz
ZWQgYW5kIGl0IG1heSBiZSBmb3JrZWQgKGVnIGZvciBmdXp6aW5nIHB1cnBvc2VzKS4KKyAgICAg
ICAgICovCisgICAgICAgIGlmICghcXRlc3RfZW5hYmxlZCgpKSB7CisgICAgICAgICAgICBxZW11
X21hZHZpc2UobmV3X2Jsb2NrLT5ob3N0LCBuZXdfYmxvY2stPm1heF9sZW5ndGgsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgUUVNVV9NQURWX0RPTlRGT1JLKTsKKyAgICAgICAgfQogICAgICAg
ICByYW1fYmxvY2tfbm90aWZ5X2FkZChuZXdfYmxvY2stPmhvc3QsIG5ld19ibG9jay0+bWF4X2xl
bmd0aCk7CiAgICAgfQogfQotLSAKMi4yNC4xCgo=


