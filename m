Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43DCC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35912073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9O+m0NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35912073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56SF-0007vX-Pg
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j56RC-00066l-Vl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j56RB-0001sh-Qm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j56RB-0001sQ-Mv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582284341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DOjkhYK9Ev6VFF4mYEv8pPngwL00LgAB6vpzU/9FSFM=;
 b=D9O+m0NO4hJWpLwJ8fdCV+yXoYiibPQGBa5G++TxNfY4Zi9mXGohTvSRl7qkuTqku3sLVr
 +6Vm9zKaDGLa9KZRkQafSwgvgmPVbhRmNBGyc4W85ROMyQUXHjvwTNjLV03LogpwZcq0I6
 y+kAZxPEC/SAYlEtVsUroxU/M5Kd20A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-yfjwDKyCNUy9G5svmQiNEQ-1; Fri, 21 Feb 2020 06:25:37 -0500
X-MC-Unique: yfjwDKyCNUy9G5svmQiNEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DFED1005513;
 Fri, 21 Feb 2020 11:25:36 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7E4390F69;
 Fri, 21 Feb 2020 11:25:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] luks: implement .bdrv_measure()
Date: Fri, 21 Feb 2020 11:25:20 +0000
Message-Id: <20200221112522.1497712-3-stefanha@redhat.com>
In-Reply-To: <20200221112522.1497712-1-stefanha@redhat.com>
References: <20200221112522.1497712-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

QWRkIHFlbXUtaW1nIG1lYXN1cmUgc3VwcG9ydCBpbiB0aGUgImx1a3MiIGJsb2NrIGRyaXZlci4K
ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2
aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+Ci0tLQogYmxvY2svY3J5cHRv
LmMgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ibG9jay9j
cnlwdG8uYyBiL2Jsb2NrL2NyeXB0by5jCmluZGV4IDI0ODIzODM1YzEuLjIzZTljNzRkNmYgMTAw
NjQ0Ci0tLSBhL2Jsb2NrL2NyeXB0by5jCisrKyBiL2Jsb2NrL2NyeXB0by5jCkBAIC00ODQsNiAr
NDg0LDY3IEBAIHN0YXRpYyBpbnQ2NF90IGJsb2NrX2NyeXB0b19nZXRsZW5ndGgoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMpCiB9CiAKIAorc3RhdGljIEJsb2NrTWVhc3VyZUluZm8gKmJsb2NrX2NyeXB0
b19tZWFzdXJlKFFlbXVPcHRzICpvcHRzLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmluX2JzLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkKK3sKKyAgICBnX2F1
dG9wdHIoUUNyeXB0b0Jsb2NrQ3JlYXRlT3B0aW9ucykgY3JlYXRlX29wdHMgPSBOVUxMOworICAg
IEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOworICAgIEJsb2NrTWVhc3VyZUluZm8gKmluZm87Cisg
ICAgdWludDY0X3Qgc2l6ZTsKKyAgICBzaXplX3QgbHVrc19wYXlsb2FkX3NpemU7CisgICAgUURp
Y3QgKmNyeXB0b29wdHM7CisKKyAgICAvKgorICAgICAqIFByZWFsbG9jYXRpb24gbW9kZSBkb2Vz
bid0IGFmZmVjdCBzaXplIHJlcXVpcmVtZW50cyBidXQgd2UgbXVzdCBjb25zdW1lCisgICAgICog
dGhlIG9wdGlvbi4KKyAgICAgKi8KKyAgICBnX2ZyZWUocWVtdV9vcHRfZ2V0X2RlbChvcHRzLCBC
TE9DS19PUFRfUFJFQUxMT0MpKTsKKworICAgIHNpemUgPSBxZW11X29wdF9nZXRfc2l6ZV9kZWwo
b3B0cywgQkxPQ0tfT1BUX1NJWkUsIDApOworCisgICAgaWYgKGluX2JzKSB7CisgICAgICAgIGlu
dDY0X3Qgc3NpemUgPSBiZHJ2X2dldGxlbmd0aChpbl9icyk7CisKKyAgICAgICAgaWYgKHNzaXpl
IDwgMCkgeworICAgICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubygmbG9jYWxfZXJyLCAtc3NpemUs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJVbmFibGUgdG8gZ2V0IGltYWdlIHZpcnR1
YWxfc2l6ZSIpOworICAgICAgICAgICAgZ290byBlcnI7CisgICAgICAgIH0KKworICAgICAgICBz
aXplID0gc3NpemU7CisgICAgfQorCisgICAgY3J5cHRvb3B0cyA9IHFlbXVfb3B0c190b19xZGlj
dF9maWx0ZXJlZChvcHRzLCBOVUxMLAorICAgICAgICAgICAgJmJsb2NrX2NyeXB0b19jcmVhdGVf
b3B0c19sdWtzLCB0cnVlKTsKKyAgICBxZGljdF9wdXRfc3RyKGNyeXB0b29wdHMsICJmb3JtYXQi
LCAibHVrcyIpOworICAgIGNyZWF0ZV9vcHRzID0gYmxvY2tfY3J5cHRvX2NyZWF0ZV9vcHRzX2lu
aXQoY3J5cHRvb3B0cywgJmxvY2FsX2Vycik7CisgICAgcW9iamVjdF91bnJlZihjcnlwdG9vcHRz
KTsKKyAgICBpZiAoIWNyZWF0ZV9vcHRzKSB7CisgICAgICAgIGdvdG8gZXJyOworICAgIH0KKwor
ICAgIGlmICghcWNyeXB0b19ibG9ja19jYWxjdWxhdGVfcGF5bG9hZF9vZmZzZXQoY3JlYXRlX29w
dHMsIE5VTEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmbHVrc19wYXlsb2FkX3NpemUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmbG9jYWxfZXJyKSkgeworICAgICAgICBnb3RvIGVycjsKKyAgICB9CisK
KyAgICAvKgorICAgICAqIFVuYWxsb2NhdGVkIGJsb2NrcyBhcmUgc3RpbGwgZW5jcnlwdGVkIHNv
IGFsbG9jYXRpb24gc3RhdHVzIG1ha2VzIG5vCisgICAgICogZGlmZmVyZW5jZSB0byB0aGUgZmls
ZSBzaXplLgorICAgICAqLworICAgIGluZm8gPSBnX25ldyhCbG9ja01lYXN1cmVJbmZvLCAxKTsK
KyAgICBpbmZvLT5mdWxseV9hbGxvY2F0ZWQgPSBsdWtzX3BheWxvYWRfc2l6ZSArIHNpemU7Cisg
ICAgaW5mby0+cmVxdWlyZWQgPSBsdWtzX3BheWxvYWRfc2l6ZSArIHNpemU7CisgICAgcmV0dXJu
IGluZm87CisKK2VycjoKKyAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsKKyAg
ICByZXR1cm4gTlVMTDsKK30KKworCiBzdGF0aWMgaW50IGJsb2NrX2NyeXB0b19wcm9iZV9sdWtz
KGNvbnN0IHVpbnQ4X3QgKmJ1ZiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IGJ1Zl9zaXplLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBj
aGFyICpmaWxlbmFtZSkgewpAQCAtNjcwLDYgKzczMSw3IEBAIHN0YXRpYyBCbG9ja0RyaXZlciBi
ZHJ2X2NyeXB0b19sdWtzID0gewogICAgIC5iZHJ2X2NvX3ByZWFkdiAgICAgPSBibG9ja19jcnlw
dG9fY29fcHJlYWR2LAogICAgIC5iZHJ2X2NvX3B3cml0ZXYgICAgPSBibG9ja19jcnlwdG9fY29f
cHdyaXRldiwKICAgICAuYmRydl9nZXRsZW5ndGggICAgID0gYmxvY2tfY3J5cHRvX2dldGxlbmd0
aCwKKyAgICAuYmRydl9tZWFzdXJlICAgICAgID0gYmxvY2tfY3J5cHRvX21lYXN1cmUsCiAgICAg
LmJkcnZfZ2V0X2luZm8gICAgICA9IGJsb2NrX2NyeXB0b19nZXRfaW5mb19sdWtzLAogICAgIC5i
ZHJ2X2dldF9zcGVjaWZpY19pbmZvID0gYmxvY2tfY3J5cHRvX2dldF9zcGVjaWZpY19pbmZvX2x1
a3MsCiAKLS0gCjIuMjQuMQoK


