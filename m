Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89FBC35674
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D8D208C4
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4SvkP9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D8D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QeE-0005tG-HN
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QZh-0005pH-OC
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QZg-0003p7-Hb
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QZg-0003oy-DE
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xjIWdceQ94gWbLoWq2aenWjAqIrpnUIhHjLw8y6vYo=;
 b=N4SvkP9RHZrsRe7h3ghbCfZKpfybhcI1mjCvvj9XmfkRJdE4VLp+yOVJoyUP+tZHyGjJPN
 cz04ro95g0FkD4i10GeZ6wv4ik54k9mbfZHXrG7R8UP+2Z4Oaxalst3DIR8vF5GteD4WK5
 fPk4URFJNaJ51QOdGtO0cbHVu/yVds0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-NZ88Qxi_PVmmnMftRrBoDA-1; Sat, 22 Feb 2020 03:55:45 -0500
X-MC-Unique: NZ88Qxi_PVmmnMftRrBoDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62687107ACC5;
 Sat, 22 Feb 2020 08:55:44 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FDBE60BE0;
 Sat, 22 Feb 2020 08:55:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/31] fuzz: add configure flag --enable-fuzzing
Date: Sat, 22 Feb 2020 08:50:26 +0000
Message-Id: <20200222085030.1760640-28-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpu
b2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IERhcnJlbiBLZW5ueSA8ZGFy
cmVuLmtlbm55QG9yYWNsZS5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMjIwMDQxMTE4LjIzMjY0LTE5
LWFseG5kckBidS5lZHUKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIGNvbmZpZ3VyZSB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9jb25maWd1cmUgYi9jb25maWd1cmUKaW5kZXggZDU3MjYxZTNhZC4uNDhkNmY4OWQ1NyAx
MDA3NTUKLS0tIGEvY29uZmlndXJlCisrKyBiL2NvbmZpZ3VyZQpAQCAtNTA1LDYgKzUwNSw3IEBA
IGRlYnVnX211dGV4PSJubyIKIGxpYnBtZW09IiIKIGRlZmF1bHRfZGV2aWNlcz0ieWVzIgogcGx1
Z2lucz0ibm8iCitmdXp6aW5nPSJubyIKIAogc3VwcG9ydGVkX2NwdT0ibm8iCiBzdXBwb3J0ZWRf
b3M9Im5vIgpAQCAtNjM1LDYgKzYzNiwxNSBAQCBpbnQgbWFpbih2b2lkKSB7IHJldHVybiAwOyB9
CiBFT0YKIH0KIAord3JpdGVfY19mdXp6ZXJfc2tlbGV0b24oKSB7CisgICAgY2F0ID4gJFRNUEMg
PDxFT0YKKyNpbmNsdWRlIDxzdGRpbnQuaD4KKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KK2ludCBM
TFZNRnV6emVyVGVzdE9uZUlucHV0KGNvbnN0IHVpbnQ4X3QgKkRhdGEsIHNpemVfdCBTaXplKTsK
K2ludCBMTFZNRnV6emVyVGVzdE9uZUlucHV0KGNvbnN0IHVpbnQ4X3QgKkRhdGEsIHNpemVfdCBT
aXplKSB7IHJldHVybiAwOyB9CitFT0YKK30KKwogaWYgY2hlY2tfZGVmaW5lIF9fbGludXhfXyA7
IHRoZW4KICAgdGFyZ2V0b3M9IkxpbnV4IgogZWxpZiBjaGVja19kZWZpbmUgX1dJTjMyIDsgdGhl
bgpAQCAtMTU1OCw2ICsxNTY4LDEwIEBAIGZvciBvcHQgZG8KICAgOzsKICAgLS1kaXNhYmxlLWNv
bnRhaW5lcnMpIHVzZV9jb250YWluZXJzPSJubyIKICAgOzsKKyAgLS1lbmFibGUtZnV6emluZykg
ZnV6emluZz15ZXMKKyAgOzsKKyAgLS1kaXNhYmxlLWZ1enppbmcpIGZ1enppbmc9bm8KKyAgOzsK
ICAgKikKICAgICAgIGVjaG8gIkVSUk9SOiB1bmtub3duIG9wdGlvbiAkb3B0IgogICAgICAgZWNo
byAiVHJ5ICckMCAtLWhlbHAnIGZvciBtb3JlIGluZm9ybWF0aW9uIgpAQCAtNjA3Miw2ICs2MDg2
LDE1IEBAIEVPRgogICBmaQogZmkKIAorIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjCisjIGNoZWNrcyBmb3IgZnV6emVyCitpZiB0ZXN0ICIkZnV6emluZyIgPSAieWVz
IiA7IHRoZW4KKyAgd3JpdGVfY19mdXp6ZXJfc2tlbGV0b24KKyAgaWYgY29tcGlsZV9wcm9nICIk
Q1BVX0NGTEFHUyAtV2Vycm9yIC1mc2FuaXRpemU9YWRkcmVzcyxmdXp6ZXIiICIiOyB0aGVuCisg
ICAgICBoYXZlX2Z1enplcj15ZXMKKyAgZmkKK2ZpCisKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwogIyBjaGVjayBmb3IgbGlicG1lbQogCkBAIC02NjY2LDYgKzY2
ODksNyBAQCBlY2hvICJsaWJwbWVtIHN1cHBvcnQgICAkbGlicG1lbSIKIGVjaG8gImxpYnVkZXYg
ICAgICAgICAgICRsaWJ1ZGV2IgogZWNobyAiZGVmYXVsdCBkZXZpY2VzICAgJGRlZmF1bHRfZGV2
aWNlcyIKIGVjaG8gInBsdWdpbiBzdXBwb3J0ICAgICRwbHVnaW5zIgorZWNobyAiZnV6emluZyBz
dXBwb3J0ICAgJGZ1enppbmciCiAKIGlmIHRlc3QgIiRzdXBwb3J0ZWRfY3B1IiA9ICJubyI7IHRo
ZW4KICAgICBlY2hvCkBAIC03NTA0LDYgKzc1MjgsMTYgQEAgZmkKIGlmIHRlc3QgIiRzaGVlcGRv
ZyIgPSAieWVzIiA7IHRoZW4KICAgZWNobyAiQ09ORklHX1NIRUVQRE9HPXkiID4+ICRjb25maWdf
aG9zdF9tYWsKIGZpCitpZiB0ZXN0ICIkZnV6emluZyIgPSAieWVzIiA7IHRoZW4KKyAgaWYgdGVz
dCAiJGhhdmVfZnV6emVyIiA9ICJ5ZXMiOyB0aGVuCisgICAgRlVaWl9MREZMQUdTPSIgLWZzYW5p
dGl6ZT1hZGRyZXNzLGZ1enplciIKKyAgICBGVVpaX0NGTEFHUz0iIC1mc2FuaXRpemU9YWRkcmVz
cyxmdXp6ZXIiCisgICAgQ0ZMQUdTPSIgLWZzYW5pdGl6ZT1hZGRyZXNzLGZ1enplci1uby1saW5r
IgorICBlbHNlCisgICAgZXJyb3JfZXhpdCAiWW91ciBjb21waWxlciBkb2Vzbid0IHN1cHBvcnQg
LWZzYW5pdGl6ZT1hZGRyZXNzLGZ1enplciIKKyAgICBleGl0IDEKKyAgZmkKK2ZpCiAKIGlmIHRl
c3QgIiRwbHVnaW5zIiA9ICJ5ZXMiIDsgdGhlbgogICAgIGVjaG8gIkNPTkZJR19QTFVHSU49eSIg
Pj4gJGNvbmZpZ19ob3N0X21hawpAQCAtNzYwNSw2ICs3NjM5LDExIEBAIGlmIHRlc3QgIiRsaWJ1
ZGV2IiAhPSAibm8iOyB0aGVuCiAgICAgZWNobyAiQ09ORklHX0xJQlVERVY9eSIgPj4gJGNvbmZp
Z19ob3N0X21hawogICAgIGVjaG8gIkxJQlVERVZfTElCUz0kbGlidWRldl9saWJzIiA+PiAkY29u
ZmlnX2hvc3RfbWFrCiBmaQoraWYgdGVzdCAiJGZ1enppbmciICE9ICJubyI7IHRoZW4KKyAgICBl
Y2hvICJDT05GSUdfRlVaWj15IiA+PiAkY29uZmlnX2hvc3RfbWFrCisgICAgZWNobyAiRlVaWl9D
RkxBR1M9JEZVWlpfQ0ZMQUdTIiA+PiAkY29uZmlnX2hvc3RfbWFrCisgICAgZWNobyAiRlVaWl9M
REZMQUdTPSRGVVpaX0xERkxBR1MiID4+ICRjb25maWdfaG9zdF9tYWsKK2ZpCiAKIGlmIHRlc3Qg
IiRlZGsyX2Jsb2JzIiA9ICJ5ZXMiIDsgdGhlbgogICBlY2hvICJERUNPTVBSRVNTX0VESzJfQkxP
QlM9eSIgPj4gJGNvbmZpZ19ob3N0X21hawotLSAKMi4yNC4xCgo=


