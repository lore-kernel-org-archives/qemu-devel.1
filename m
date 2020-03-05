Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF6DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25303207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSe+yGnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25303207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9u2D-00056m-8i
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j9tz1-00008B-0B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j9tyy-0003Gb-Qm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30735
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j9tyy-0003Fp-E3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLh97FKAtkQVrPTIRRGRfMOyXgffESfmfCUhzdaV6WI=;
 b=TSe+yGnEQQv/hnnGuFtmhkkiz/wd/hkj/VEFLAVW9ZfWMiXGgXhYOQnPocY4Fg8prjDH4m
 DQl46GBxaJX4RLow2c0hrZaBT8T+2zUPzFscyYFoeHcLDmBgq6F5zJLhPp27McgheHtmUT
 yEIOz7dCljcVdvURgDpEby/jUz+sAhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-i6IrNr6kP_yzyan2glhuyg-1; Thu, 05 Mar 2020 12:08:21 -0500
X-MC-Unique: i6IrNr6kP_yzyan2glhuyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C928800D53;
 Thu,  5 Mar 2020 17:08:20 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02F1690538;
 Thu,  5 Mar 2020 17:08:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] aio-posix: move RCU_READ_LOCK() into run_poll_handlers()
Date: Thu,  5 Mar 2020 17:08:01 +0000
Message-Id: <20200305170806.1313245-3-stefanha@redhat.com>
In-Reply-To: <20200305170806.1313245-1-stefanha@redhat.com>
References: <20200305170806.1313245-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tm93IHRoYXQgcnVuX3BvbGxfaGFuZGxlcnNfb25jZSgpIGlzIG9ubHkgY2FsbGVkIGJ5IHJ1bl9w
b2xsX2hhbmRsZXJzKCkKd2UgY2FuIGltcHJvdmUgdGhlIENQVSB0aW1lIHByb2ZpbGUgYnkgbW92
aW5nIHRoZSBleHBlbnNpdmUKUkNVX1JFQURfTE9DSygpIG91dCBvZiB0aGUgcG9sbGluZyBsb29w
LgoKVGhpcyByZWR1Y2VzIHRoZSBydW5fcG9sbF9oYW5kbGVycygpIGZyb20gNDAlIENQVSB0byAx
MCUgQ1BVIGluIHBlcmYncwpzYW1wbGluZyBwcm9maWxlciBvdXRwdXQuCgpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9haW8tcG9z
aXguYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9haW8tcG9zaXguYyBi
L3V0aWwvYWlvLXBvc2l4LmMKaW5kZXggMDI5ZjE0NjQ1NS4uMzhjNTFmNWQ4ZiAxMDA2NDQKLS0t
IGEvdXRpbC9haW8tcG9zaXguYworKysgYi91dGlsL2Fpby1wb3NpeC5jCkBAIC01ODMsMTYgKzU4
Myw2IEBAIHN0YXRpYyBib29sIHJ1bl9wb2xsX2hhbmRsZXJzX29uY2UoQWlvQ29udGV4dCAqY3R4
LCBpbnQ2NF90ICp0aW1lb3V0KQogICAgIGJvb2wgcHJvZ3Jlc3MgPSBmYWxzZTsKICAgICBBaW9I
YW5kbGVyICpub2RlOwogCi0gICAgLyoKLSAgICAgKiBPcHRpbWl6YXRpb246IC0+aW9fcG9sbCgp
IGhhbmRsZXJzIG9mdGVuIGNvbnRhaW4gUkNVIHJlYWQgY3JpdGljYWwKLSAgICAgKiBzZWN0aW9u
cyBhbmQgd2UgdGhlcmVmb3JlIHNlZSBtYW55IHJjdV9yZWFkX2xvY2soKSAtPiByY3VfcmVhZF91
bmxvY2soKQotICAgICAqIC0+IHJjdV9yZWFkX2xvY2soKSAtPiAuLi4gc2VxdWVuY2VzIHdpdGgg
ZXhwZW5zaXZlIG1lbW9yeQotICAgICAqIHN5bmNocm9uaXphdGlvbiBwcmltaXRpdmVzLiAgTWFr
ZSB0aGUgZW50aXJlIHBvbGxpbmcgbG9vcCBhbiBSQ1UKLSAgICAgKiBjcml0aWNhbCBzZWN0aW9u
IGJlY2F1c2UgbmVzdGVkIHJjdV9yZWFkX2xvY2soKS9yY3VfcmVhZF91bmxvY2soKSBjYWxscwot
ICAgICAqIGFyZSBjaGVhcC4KLSAgICAgKi8KLSAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7Ci0K
ICAgICBRTElTVF9GT1JFQUNIX1JDVShub2RlLCAmY3R4LT5haW9faGFuZGxlcnMsIG5vZGUpIHsK
ICAgICAgICAgaWYgKCFRTElTVF9JU19JTlNFUlRFRChub2RlLCBub2RlX2RlbGV0ZWQpICYmIG5v
ZGUtPmlvX3BvbGwgJiYKICAgICAgICAgICAgIGFpb19ub2RlX2NoZWNrKGN0eCwgbm9kZS0+aXNf
ZXh0ZXJuYWwpICYmCkBAIC02MzYsNiArNjI2LDE2IEBAIHN0YXRpYyBib29sIHJ1bl9wb2xsX2hh
bmRsZXJzKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCBtYXhfbnMsIGludDY0X3QgKnRpbWVvdXQp
CiAKICAgICB0cmFjZV9ydW5fcG9sbF9oYW5kbGVyc19iZWdpbihjdHgsIG1heF9ucywgKnRpbWVv
dXQpOwogCisgICAgLyoKKyAgICAgKiBPcHRpbWl6YXRpb246IC0+aW9fcG9sbCgpIGhhbmRsZXJz
IG9mdGVuIGNvbnRhaW4gUkNVIHJlYWQgY3JpdGljYWwKKyAgICAgKiBzZWN0aW9ucyBhbmQgd2Ug
dGhlcmVmb3JlIHNlZSBtYW55IHJjdV9yZWFkX2xvY2soKSAtPiByY3VfcmVhZF91bmxvY2soKQor
ICAgICAqIC0+IHJjdV9yZWFkX2xvY2soKSAtPiAuLi4gc2VxdWVuY2VzIHdpdGggZXhwZW5zaXZl
IG1lbW9yeQorICAgICAqIHN5bmNocm9uaXphdGlvbiBwcmltaXRpdmVzLiAgTWFrZSB0aGUgZW50
aXJlIHBvbGxpbmcgbG9vcCBhbiBSQ1UKKyAgICAgKiBjcml0aWNhbCBzZWN0aW9uIGJlY2F1c2Ug
bmVzdGVkIHJjdV9yZWFkX2xvY2soKS9yY3VfcmVhZF91bmxvY2soKSBjYWxscworICAgICAqIGFy
ZSBjaGVhcC4KKyAgICAgKi8KKyAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7CisKICAgICBzdGFy
dF90aW1lID0gcWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSk7CiAgICAgZG8g
ewogICAgICAgICBwcm9ncmVzcyA9IHJ1bl9wb2xsX2hhbmRsZXJzX29uY2UoY3R4LCB0aW1lb3V0
KTsKLS0gCjIuMjQuMQoK


