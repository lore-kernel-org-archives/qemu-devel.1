Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506F1C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E39120714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFKAPkmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E39120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Y1g-00018t-6j
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0f-0008CF-Hi
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0e-0005N4-C7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1Y0e-0005Mo-96
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581437016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vujQ+pL6hN4e4wRUA2XMROTkAAjLou+LqZRDRVdw254=;
 b=WFKAPkmpFxsZ3JxXXxltqL6XvqFQ2eOPnI9mNBzIH4zwo2vZUR2GvPrLzEZc47JjvhL9Kv
 PrHzQpxriuhyNfCeabsc7tz+XB25we/5pBuDGXLZcJekcTms3c4PBfUq0JvZdPnUD8zY92
 l2uvGauFAcN1KGLQ2jMGAdjE95MeTNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-AOTLPrEFMMiup2qrGBxmXg-1; Tue, 11 Feb 2020 11:03:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1831800D42;
 Tue, 11 Feb 2020 16:03:31 +0000 (UTC)
Received: from localhost (unknown [10.36.118.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64A521001B09;
 Tue, 11 Feb 2020 16:03:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] luks: implement .bdrv_measure()
Date: Tue, 11 Feb 2020 16:03:16 +0000
Message-Id: <20200211160318.453650-3-stefanha@redhat.com>
In-Reply-To: <20200211160318.453650-1-stefanha@redhat.com>
References: <20200211160318.453650-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: AOTLPrEFMMiup2qrGBxmXg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIHFlbXUtaW1nIG1lYXN1cmUgc3VwcG9ydCBpbiB0aGUgImx1a3MiIGJsb2NrIGRyaXZlci4K
ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0t
CiBibG9jay9jcnlwdG8uYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2Jsb2NrL2NyeXB0by5jIGIvYmxvY2svY3J5cHRvLmMKaW5kZXggMjQ4MjM4MzVjMS4u
NDUzMTE5ODc1ZSAxMDA2NDQKLS0tIGEvYmxvY2svY3J5cHRvLmMKKysrIGIvYmxvY2svY3J5cHRv
LmMKQEAgLTQ4NCw2ICs0ODQsNjcgQEAgc3RhdGljIGludDY0X3QgYmxvY2tfY3J5cHRvX2dldGxl
bmd0aChCbG9ja0RyaXZlclN0YXRlICpicykKIH0KIAogCitzdGF0aWMgQmxvY2tNZWFzdXJlSW5m
byAqYmxvY2tfY3J5cHRvX21lYXN1cmUoUWVtdU9wdHMgKm9wdHMsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqaW5fYnMsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KQoreworICAgIGdfYXV0b3B0cihRQ3J5cHRvQmxvY2tDcmVhdGVPcHRpb25zKSBjcmVhdGVfb3B0
cyA9IE5VTEw7CisgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7CisgICAgQmxvY2tNZWFzdXJl
SW5mbyAqaW5mbzsKKyAgICB1aW50NjRfdCBzaXplOworICAgIHNpemVfdCBsdWtzX3BheWxvYWRf
c2l6ZTsKKyAgICBRRGljdCAqY3J5cHRvb3B0czsKKworICAgIC8qCisgICAgICogUHJlYWxsb2Nh
dGlvbiBtb2RlIGRvZXNuJ3QgYWZmZWN0IHNpemUgcmVxdWlyZW1lbnRzIGJ1dCB3ZSBtdXN0IGNv
bnN1bWUKKyAgICAgKiB0aGUgb3B0aW9uLgorICAgICAqLworICAgIGdfZnJlZShxZW11X29wdF9n
ZXRfZGVsKG9wdHMsIEJMT0NLX09QVF9QUkVBTExPQykpOworCisgICAgc2l6ZSA9IHFlbXVfb3B0
X2dldF9zaXplX2RlbChvcHRzLCBCTE9DS19PUFRfU0laRSwgMCk7CisKKyAgICBpZiAoaW5fYnMp
IHsKKyAgICAgICAgaW50NjRfdCBzc2l6ZSA9IGJkcnZfZ2V0bGVuZ3RoKGluX2JzKTsKKworICAg
ICAgICBpZiAoc3NpemUgPCAwKSB7CisgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKCZsb2Nh
bF9lcnIsIC1zc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlVuYWJsZSB0byBn
ZXQgaW1hZ2UgdmlydHVhbF9zaXplIik7CisgICAgICAgICAgICBnb3RvIGVycjsKKyAgICAgICAg
fQorCisgICAgICAgIHNpemUgPSBzc2l6ZTsKKyAgICB9CisKKyAgICBjcnlwdG9vcHRzID0gcWVt
dV9vcHRzX3RvX3FkaWN0X2ZpbHRlcmVkKG9wdHMsIE5VTEwsCisgICAgICAgICAgICAmYmxvY2tf
Y3J5cHRvX2NyZWF0ZV9vcHRzX2x1a3MsIHRydWUpOworICAgIHFkaWN0X3B1dF9zdHIoY3J5cHRv
b3B0cywgImZvcm1hdCIsICJsdWtzIik7CisgICAgY3JlYXRlX29wdHMgPSBibG9ja19jcnlwdG9f
Y3JlYXRlX29wdHNfaW5pdChjcnlwdG9vcHRzLCBlcnJwKTsKKyAgICBxb2JqZWN0X3VucmVmKGNy
eXB0b29wdHMpOworICAgIGlmICghY3JlYXRlX29wdHMpIHsKKyAgICAgICAgZ290byBlcnI7Cisg
ICAgfQorCisgICAgaWYgKCFxY3J5cHRvX2Jsb2NrX2NhbGN1bGF0ZV9wYXlsb2FkX29mZnNldChj
cmVhdGVfb3B0cywgTlVMTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZsdWtzX3BheWxvYWRfc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZsb2NhbF9lcnIpKSB7CisgICAgICAgIGdvdG8gZXJyOwor
ICAgIH0KKworICAgIC8qCisgICAgICogVW5hbGxvY2F0ZWQgYmxvY2tzIGFyZSBzdGlsbCBlbmNy
eXB0ZWQgc28gYWxsb2NhdGlvbiBzdGF0dXMgbWFrZXMgbm8KKyAgICAgKiBkaWZmZXJlbmNlIHRv
IHRoZSBmaWxlIHNpemUuCisgICAgICovCisgICAgaW5mbyA9IGdfbmV3KEJsb2NrTWVhc3VyZUlu
Zm8sIDEpOworICAgIGluZm8tPmZ1bGx5X2FsbG9jYXRlZCA9IGx1a3NfcGF5bG9hZF9zaXplICsg
c2l6ZTsKKyAgICBpbmZvLT5yZXF1aXJlZCA9IGx1a3NfcGF5bG9hZF9zaXplICsgc2l6ZTsKKyAg
ICByZXR1cm4gaW5mbzsKKworZXJyOgorICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9l
cnIpOworICAgIHJldHVybiBOVUxMOworfQorCisKIHN0YXRpYyBpbnQgYmxvY2tfY3J5cHRvX3By
b2JlX2x1a3MoY29uc3QgdWludDhfdCAqYnVmLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgYnVmX3NpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKmZpbGVuYW1lKSB7CkBAIC02NzAsNiArNzMxLDcgQEAgc3RhdGljIEJsb2Nr
RHJpdmVyIGJkcnZfY3J5cHRvX2x1a3MgPSB7CiAgICAgLmJkcnZfY29fcHJlYWR2ICAgICA9IGJs
b2NrX2NyeXB0b19jb19wcmVhZHYsCiAgICAgLmJkcnZfY29fcHdyaXRldiAgICA9IGJsb2NrX2Ny
eXB0b19jb19wd3JpdGV2LAogICAgIC5iZHJ2X2dldGxlbmd0aCAgICAgPSBibG9ja19jcnlwdG9f
Z2V0bGVuZ3RoLAorICAgIC5iZHJ2X21lYXN1cmUgICAgICAgPSBibG9ja19jcnlwdG9fbWVhc3Vy
ZSwKICAgICAuYmRydl9nZXRfaW5mbyAgICAgID0gYmxvY2tfY3J5cHRvX2dldF9pbmZvX2x1a3Ms
CiAgICAgLmJkcnZfZ2V0X3NwZWNpZmljX2luZm8gPSBibG9ja19jcnlwdG9fZ2V0X3NwZWNpZmlj
X2luZm9fbHVrcywKIAotLSAKMi4yNC4xCgo=


