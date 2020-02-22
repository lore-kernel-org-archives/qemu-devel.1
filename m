Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D29C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C292071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVJp/8vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C292071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QWB-0006BX-CT
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QUx-0004Q3-W2
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QUw-0007kU-EH
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:50:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QUw-0007k7-Al
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lv+Nq9qisTd862fmiem1ttPq4X3JyfXmf2QWIQn8FLI=;
 b=DVJp/8vWF2knnG7hBe79sDDkAAdk7wpQv28MCv/LuvKDyQjtn93dDHybukzvgD1gVgXGQd
 FgllLDFl+3+1hU+a4ieqfcMfazAA+AmJUUl4Ve42r9wnYnHyoEAuSAnpNpwYZyPL1ktogd
 XHZNGCVOnxNv7m8OZPL/Qq2PpVZcaIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-GgpRy3wvNd--asPVF7DoaA-1; Sat, 22 Feb 2020 03:50:51 -0500
X-MC-Unique: GgpRy3wvNd--asPVF7DoaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F028017DF;
 Sat, 22 Feb 2020 08:50:49 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6BB991835;
 Sat, 22 Feb 2020 08:50:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/31] aio-posix: avoid reacquiring rcu_read_lock() when polling
Date: Sat, 22 Feb 2020 08:50:01 +0000
Message-Id: <20200222085030.1760640-3-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZpcnN0IHJjdV9yZWFkX2xvY2svdW5sb2NrKCkgaXMgZXhwZW5zaXZlLiAgTmVzdGVkIGNh
bGxzIGFyZSBjaGVhcC4KClRoaXMgb3B0aW1pemF0aW9uIGluY3JlYXNlcyBJT1BTIGZyb20gNzNr
IHRvIDE2Mmsgd2l0aCBhIExpbnV4IGd1ZXN0CnRoYXQgaGFzIDIgdmlydGlvLWJsayxudW0tcXVl
dWVzPTEgYW5kIDk5IHZpcnRpby1ibGssbnVtLXF1ZXVlcz0zMgpkZXZpY2VzLgoKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTog
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDAyMTgx
ODI3MDguOTE0NTUyLTEtc3RlZmFuaGFAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9haW8tcG9zaXguYyB8IDEx
ICsrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IGE0OTc3ZjUzOGUu
LmY2N2Y1YjM0ZTkgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRpbC9haW8t
cG9zaXguYwpAQCAtMTUsNiArMTUsNyBAQAogCiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgogI2lu
Y2x1ZGUgImJsb2NrL2Jsb2NrLmgiCisjaW5jbHVkZSAicWVtdS9yY3UuaCIKICNpbmNsdWRlICJx
ZW11L3JjdV9xdWV1ZS5oIgogI2luY2x1ZGUgInFlbXUvc29ja2V0cy5oIgogI2luY2x1ZGUgInFl
bXUvY3V0aWxzLmgiCkBAIC01MTQsNiArNTE1LDE2IEBAIHN0YXRpYyBib29sIHJ1bl9wb2xsX2hh
bmRsZXJzX29uY2UoQWlvQ29udGV4dCAqY3R4LCBpbnQ2NF90ICp0aW1lb3V0KQogICAgIGJvb2wg
cHJvZ3Jlc3MgPSBmYWxzZTsKICAgICBBaW9IYW5kbGVyICpub2RlOwogCisgICAgLyoKKyAgICAg
KiBPcHRpbWl6YXRpb246IC0+aW9fcG9sbCgpIGhhbmRsZXJzIG9mdGVuIGNvbnRhaW4gUkNVIHJl
YWQgY3JpdGljYWwKKyAgICAgKiBzZWN0aW9ucyBhbmQgd2UgdGhlcmVmb3JlIHNlZSBtYW55IHJj
dV9yZWFkX2xvY2soKSAtPiByY3VfcmVhZF91bmxvY2soKQorICAgICAqIC0+IHJjdV9yZWFkX2xv
Y2soKSAtPiAuLi4gc2VxdWVuY2VzIHdpdGggZXhwZW5zaXZlIG1lbW9yeQorICAgICAqIHN5bmNo
cm9uaXphdGlvbiBwcmltaXRpdmVzLiAgTWFrZSB0aGUgZW50aXJlIHBvbGxpbmcgbG9vcCBhbiBS
Q1UKKyAgICAgKiBjcml0aWNhbCBzZWN0aW9uIGJlY2F1c2UgbmVzdGVkIHJjdV9yZWFkX2xvY2so
KS9yY3VfcmVhZF91bmxvY2soKSBjYWxscworICAgICAqIGFyZSBjaGVhcC4KKyAgICAgKi8KKyAg
ICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7CisKICAgICBRTElTVF9GT1JFQUNIX1JDVShub2RlLCAm
Y3R4LT5haW9faGFuZGxlcnMsIG5vZGUpIHsKICAgICAgICAgaWYgKCFub2RlLT5kZWxldGVkICYm
IG5vZGUtPmlvX3BvbGwgJiYKICAgICAgICAgICAgIGFpb19ub2RlX2NoZWNrKGN0eCwgbm9kZS0+
aXNfZXh0ZXJuYWwpICYmCi0tIAoyLjI0LjEKCg==


