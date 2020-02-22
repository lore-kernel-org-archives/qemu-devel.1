Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BABC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA68620656
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blOGnhgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA68620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QZf-00056i-SW
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QXD-0000FI-6a
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QXC-0000fq-2d
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QXB-0000fe-VU
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrK+bzXPRozx+keyuQtDPZG5g6inbUPrUA+5OZ3CBoU=;
 b=blOGnhgKoAoYBgiVOrOE5mst9I2I11KSfe9lzlCOPahiAtlQhzOAZjtq8xcc3IFifVD9Wq
 FIKkfBJZKjKeH0jpM4ESgTQ4pd3/sLrFKpFKYPlSqs+MYvlAZJ1675cRpdHqkPSRvxrHGc
 MnONtfNI14LIOWK1lGQkqDngvcZIRSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-yf0G5G9lODCEWvMUhbef5A-1; Sat, 22 Feb 2020 03:53:11 -0500
X-MC-Unique: yf0G5G9lODCEWvMUhbef5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBEF68017CC;
 Sat, 22 Feb 2020 08:53:09 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A4C75C1C3;
 Sat, 22 Feb 2020 08:52:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/31] qtest: add qtest_server_send abstraction
Date: Sat, 22 Feb 2020 08:50:13 +0000
Message-Id: <20200222085030.1760640-15-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpxdGVzdF9zZXJ2ZXJfc2Vu
ZCBpcyBhIGZ1bmN0aW9uIHBvaW50ZXIgc3BlY2lmeWluZyB0aGUgaGFuZGxlciB1c2VkIHRvCnRy
YW5zbWl0IGRhdGEgdG8gdGhlIHF0ZXN0IGNsaWVudC4gSW4gdGhlIHN0YW5kYXJkIGNvbmZpZ3Vy
YXRpb24sIHRoaXMKY2FsbHMgdGhlIENoYXJCYWNrZW5kIGhhbmRsZXIsIGJ1dCBub3cgaXQgaXMg
cG9zc2libGUgZm9yIG90aGVyIHR5cGVzIG9mCmhhbmRsZXJzLCBlLmcgZGlyZWN0LWZ1bmN0aW9u
IGNhbGxzIGlmIHRoZSBxdGVzdCBjbGllbnQgYW5kIHNlcnZlcgpleGlzdCB3aXRoaW4gdGhlIHNh
bWUgcHJvY2VzcyAoaW5wcm9jKQoKU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEJ1bGVrb3YgPGFs
eG5kckBidS5lZHU+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJlbi5rZW5ueUBvcmFjbGUuY29t
PgpBY2tlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIw
MjAwMjIwMDQxMTE4LjIzMjY0LTYtYWx4bmRyQGJ1LmVkdQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9zeXNlbXUvcXRlc3Qu
aCB8ICAzICsrKwogcXRlc3QuYyAgICAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKyst
LQogMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvc3lzZW11L3F0ZXN0LmggYi9pbmNsdWRlL3N5c2VtdS9xdGVzdC5o
CmluZGV4IDVlZDA5YzgwYjEuLmUyZjEwNDdmZDcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvc3lzZW11
L3F0ZXN0LmgKKysrIGIvaW5jbHVkZS9zeXNlbXUvcXRlc3QuaApAQCAtMjYsNCArMjYsNyBAQCBi
b29sIHF0ZXN0X2RyaXZlcih2b2lkKTsKIAogdm9pZCBxdGVzdF9zZXJ2ZXJfaW5pdChjb25zdCBj
aGFyICpxdGVzdF9jaHJkZXYsIGNvbnN0IGNoYXIgKnF0ZXN0X2xvZywgRXJyb3IgKiplcnJwKTsK
IAordm9pZCBxdGVzdF9zZXJ2ZXJfc2V0X3NlbmRfaGFuZGxlcih2b2lkICgqc2VuZCkodm9pZCAq
LCBjb25zdCBjaGFyICopLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
b3BhcXVlKTsKKwogI2VuZGlmCmRpZmYgLS1naXQgYS9xdGVzdC5jIGIvcXRlc3QuYwppbmRleCA1
ODdkY2JiNGI1Li44YTRiYTU5ODI4IDEwMDY0NAotLS0gYS9xdGVzdC5jCisrKyBiL3F0ZXN0LmMK
QEAgLTQzLDYgKzQzLDggQEAgc3RhdGljIEdTdHJpbmcgKmluYnVmOwogc3RhdGljIGludCBpcnFf
bGV2ZWxzW01BWF9JUlFdOwogc3RhdGljIHFlbXVfdGltZXZhbCBzdGFydF90aW1lOwogc3RhdGlj
IGJvb2wgcXRlc3Rfb3BlbmVkOworc3RhdGljIHZvaWQgKCpxdGVzdF9zZXJ2ZXJfc2VuZCkodm9p
ZCosIGNvbnN0IGNoYXIqKTsKK3N0YXRpYyB2b2lkICpxdGVzdF9zZXJ2ZXJfc2VuZF9vcGFxdWU7
CiAKICNkZWZpbmUgRk1UX3RpbWV2YWwgIiVsZC4lMDZsZCIKIApAQCAtMjI5LDggKzIzMSwxMCBA
QCBzdGF0aWMgdm9pZCBHQ0NfRk1UX0FUVFIoMSwgMikgcXRlc3RfbG9nX3NlbmQoY29uc3QgY2hh
ciAqZm10LCAuLi4pCiAgICAgdmFfZW5kKGFwKTsKIH0KIAotc3RhdGljIHZvaWQgZG9fcXRlc3Rf
c2VuZChDaGFyQmFja2VuZCAqY2hyLCBjb25zdCBjaGFyICpzdHIsIHNpemVfdCBsZW4pCitzdGF0
aWMgdm9pZCBxdGVzdF9zZXJ2ZXJfY2hhcl9iZV9zZW5kKHZvaWQgKm9wYXF1ZSwgY29uc3QgY2hh
ciAqc3RyKQogeworICAgIHNpemVfdCBsZW4gPSBzdHJsZW4oc3RyKTsKKyAgICBDaGFyQmFja2Vu
ZCogY2hyID0gKENoYXJCYWNrZW5kICopb3BhcXVlOwogICAgIHFlbXVfY2hyX2ZlX3dyaXRlX2Fs
bChjaHIsICh1aW50OF90ICopc3RyLCBsZW4pOwogICAgIGlmIChxdGVzdF9sb2dfZnAgJiYgcXRl
c3Rfb3BlbmVkKSB7CiAgICAgICAgIGZwcmludGYocXRlc3RfbG9nX2ZwLCAiJXMiLCBzdHIpOwpA
QCAtMjM5LDcgKzI0Myw3IEBAIHN0YXRpYyB2b2lkIGRvX3F0ZXN0X3NlbmQoQ2hhckJhY2tlbmQg
KmNociwgY29uc3QgY2hhciAqc3RyLCBzaXplX3QgbGVuKQogCiBzdGF0aWMgdm9pZCBxdGVzdF9z
ZW5kKENoYXJCYWNrZW5kICpjaHIsIGNvbnN0IGNoYXIgKnN0cikKIHsKLSAgICBkb19xdGVzdF9z
ZW5kKGNociwgc3RyLCBzdHJsZW4oc3RyKSk7CisgICAgcXRlc3Rfc2VydmVyX3NlbmQocXRlc3Rf
c2VydmVyX3NlbmRfb3BhcXVlLCBzdHIpOwogfQogCiBzdGF0aWMgdm9pZCBHQ0NfRk1UX0FUVFIo
MiwgMykgcXRlc3Rfc2VuZGYoQ2hhckJhY2tlbmQgKmNociwKQEAgLTc4NCw2ICs3ODgsMTYgQEAg
dm9pZCBxdGVzdF9zZXJ2ZXJfaW5pdChjb25zdCBjaGFyICpxdGVzdF9jaHJkZXYsIGNvbnN0IGNo
YXIgKnF0ZXN0X2xvZywgRXJyb3IgKioKICAgICBxZW11X2Nocl9mZV9zZXRfZWNobygmcXRlc3Rf
Y2hyLCB0cnVlKTsKIAogICAgIGluYnVmID0gZ19zdHJpbmdfbmV3KCIiKTsKKworICAgIGlmICgh
cXRlc3Rfc2VydmVyX3NlbmQpIHsKKyAgICAgICAgcXRlc3Rfc2VydmVyX3NldF9zZW5kX2hhbmRs
ZXIocXRlc3Rfc2VydmVyX2NoYXJfYmVfc2VuZCwgJnF0ZXN0X2Nocik7CisgICAgfQorfQorCit2
b2lkIHF0ZXN0X3NlcnZlcl9zZXRfc2VuZF9oYW5kbGVyKHZvaWQgKCpzZW5kKSh2b2lkKiwgY29u
c3QgY2hhciopLCB2b2lkICpvcGFxdWUpCit7CisgICAgcXRlc3Rfc2VydmVyX3NlbmQgPSBzZW5k
OworICAgIHF0ZXN0X3NlcnZlcl9zZW5kX29wYXF1ZSA9IG9wYXF1ZTsKIH0KIAogYm9vbCBxdGVz
dF9kcml2ZXIodm9pZCkKLS0gCjIuMjQuMQoK


