Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F319C2070E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ku6OZitf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F319C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADv2-0005gU-7i
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jADtA-0003WG-Tn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jADt9-0000Vv-S5
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jADt9-0000NK-NE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbFZ+xRC4xCgdTu1Z5jmW+hbiR8L9+v/14TGSPWC2R0=;
 b=Ku6OZitfZGvLdWllOHLzt4dVfHf9XF7ECb8NHOSg5Z02mZqGO2IhS8JvGb+i8bO3cq+5zP
 y5gWVplsgSMabWzFqsus698u7YT/34L6DJZQZidNT4R8q8a2S/iCOCdpO4bJUta363PGgR
 RJbbUgh+1Mi1NRvxxkDYx4K+EuJwY1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-yZXa0ly6MwyB36M6wQn0oA-1; Fri, 06 Mar 2020 09:23:41 -0500
X-MC-Unique: yZXa0ly6MwyB36M6wQn0oA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3F4D1137841;
 Fri,  6 Mar 2020 14:23:39 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19AAF60C63;
 Fri,  6 Mar 2020 14:23:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] qtest: fix fuzzer-related 80-char limit violations
Date: Fri,  6 Mar 2020 14:23:17 +0000
Message-Id: <20200306142318.1435372-3-stefanha@redhat.com>
In-Reply-To: <20200306142318.1435372-1-stefanha@redhat.com>
References: <20200306142318.1435372-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2Ug
PGVibGFrZUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRGFycmVuIEtlbm55IDxkYXJyZW4ua2Vu
bnlAb3JhY2xlLmNvbT4KTWVzc2FnZS1pZDogMjAyMDAyMjcwMzE0MzkuMzEzODYtMy1hbHhuZHJA
YnUuZWR1ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiBxdGVzdC5jICAgICAgICAgICAgICAgICAgICAgfCAzICsrLQogdGVzdHMvcXRlc3Qv
ZnV6ei9xb3NfZnV6ei5jIHwgNSArKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcXRlc3QuYyBiL3F0ZXN0LmMKaW5kZXgg
MWFmNGUxYjA4ZC4uNTY3MmI3NWMzNSAxMDA2NDQKLS0tIGEvcXRlc3QuYworKysgYi9xdGVzdC5j
CkBAIC03OTQsNyArNzk0LDggQEAgdm9pZCBxdGVzdF9zZXJ2ZXJfaW5pdChjb25zdCBjaGFyICpx
dGVzdF9jaHJkZXYsIGNvbnN0IGNoYXIgKnF0ZXN0X2xvZywgRXJyb3IgKioKICAgICB9CiB9CiAK
LXZvaWQgcXRlc3Rfc2VydmVyX3NldF9zZW5kX2hhbmRsZXIodm9pZCAoKnNlbmQpKHZvaWQqLCBj
b25zdCBjaGFyKiksIHZvaWQgKm9wYXF1ZSkKK3ZvaWQgcXRlc3Rfc2VydmVyX3NldF9zZW5kX2hh
bmRsZXIodm9pZCAoKnNlbmQpKHZvaWQqLCBjb25zdCBjaGFyKiksCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSkKIHsKICAgICBxdGVzdF9zZXJ2ZXJfc2Vu
ZCA9IHNlbmQ7CiAgICAgcXRlc3Rfc2VydmVyX3NlbmRfb3BhcXVlID0gb3BhcXVlOwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvZnV6ei9xb3NfZnV6ei5jIGIvdGVzdHMvcXRlc3QvZnV6ei9xb3Nf
ZnV6ei5jCmluZGV4IGJiYjE3NDcwZmYuLjFhOTkyNzdkNjAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0
ZXN0L2Z1enovcW9zX2Z1enouYworKysgYi90ZXN0cy9xdGVzdC9mdXp6L3Fvc19mdXp6LmMKQEAg
LTEyMCw3ICsxMjAsMTAgQEAgc3RhdGljIHZvaWQgd2Fsa19wYXRoKFFPU0dyYXBoTm9kZSAqb3Jp
Z19wYXRoLCBpbnQgbGVuKQogICAgIFFPU0dyYXBoTm9kZSAqcGF0aDsKICAgICBRT1NHcmFwaEVk
Z2UgKmVkZ2U7CiAKLSAgICAvKiBldHlwZSBzZXQgdG8gUUVER0VfQ09OU1VNRURfQlkgc28gdGhh
dCBtYWNoaW5lIGNhbiBhZGQgdG8gdGhlIGNvbW1hbmQgbGluZSAqLworICAgIC8qCisgICAgICog
ZXR5cGUgc2V0IHRvIFFFREdFX0NPTlNVTUVEX0JZIHNvIHRoYXQgbWFjaGluZSBjYW4gYWRkIHRv
IHRoZSBjb21tYW5kCisgICAgICogbGluZQorICAgICAqLwogICAgIFFPU0VkZ2VUeXBlIGV0eXBl
ID0gUUVER0VfQ09OU1VNRURfQlk7CiAKICAgICAvKiB0d2ljZSBRT1NfUEFUSF9NQVhfRUxFTUVO
VF9TSVpFIHNpbmNlIGVhY2ggZWRnZSBjYW4gaGF2ZSBpdHMgYXJnICovCi0tIAoyLjI0LjEKCg==


