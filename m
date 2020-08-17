Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5835FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DEA207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGtXTz6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DEA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hUB-0003ev-65
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsf-0008Cp-CD
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:17:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsc-0003hm-SD
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meRVHQbFdBhSIhJPbJEZ5sqaW1AaKZ7lh6KoSI5vmn0=;
 b=OGtXTz6sAkX6nqk198UV+xlASwRZTDw+2Uv7ew2fDRPe/eV+ekIqGFqAYLSQPogZOSw64M
 2UYBs6ZdNASD81j2a+MJBTyTcdJhCVntOkAUIV8uUWvBkefr/ghh/bkNBt3fFpd6Rd2Unb
 t1aqmNaufo1sxCtjhvwtZv8jwT1pl/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-PA6NytbLNsudN8-8Gr1Xeg-1; Mon, 17 Aug 2020 11:16:55 -0400
X-MC-Unique: PA6NytbLNsudN8-8Gr1Xeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD2B1DDE9;
 Mon, 17 Aug 2020 15:16:54 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD3C35D6C4;
 Mon, 17 Aug 2020 15:16:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] aio-posix: keep aio_notify_me disabled during polling
Date: Mon, 17 Aug 2020 16:16:34 +0100
Message-Id: <20200817151634.35563-4-stefanha@redhat.com>
In-Reply-To: <20200817151634.35563-1-stefanha@redhat.com>
References: <20200817151634.35563-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UG9sbGluZyBvbmx5IG1vbml0b3JzIHRoZSBjdHgtPm5vdGlmaWVkIGZpZWxkIGFuZCBkb2VzIG5v
dCBuZWVkIHRoZQpjdHgtPm5vdGlmaWVyIEV2ZW50Tm90aWZpZXIgdG8gYmUgc2lnbmFsbGVkLiBL
ZWVwIGN0eC0+YWlvX25vdGlmeV9tZQpkaXNhYmxlZCB3aGlsZSBwb2xsaW5nIHRvIGF2b2lkIHVu
bmVjZXNzYXJ5IEV2ZW50Tm90aWZpZXIgc3lzY2FsbHMuCgpUaGlzIG9wdGltaXphdGlvbiBpbXBy
b3ZlcyB2aXJ0aW8tYmxrIDRLQiByYW5kb20gcmVhZCBwZXJmb3JtYW5jZSBieQoxOCUuIFRoZSBm
b2xsb3dpbmcgcmVzdWx0cyBhcmUgd2l0aCBhbiBJT1RocmVhZCBhbmQgdGhlIG51bGwtY28gYmxv
Y2sKZHJpdmVyOgoKVGVzdCAgICAgICAgIElPUFMgICBFcnJvcgpCZWZvcmUgIDI0NDUxOC42MiDC
sSAxLjIwJQpBZnRlciAgIDI5MDcwNi4xMSDCsSAwLjQ0JQoKU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA4MDYxMzE4MDIuNTY5NDc4
LTQtc3RlZmFuaGFAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0
ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9haW8tcG9zaXguYyB8IDQ3ICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9haW8tcG9z
aXguYyBiL3V0aWwvYWlvLXBvc2l4LmMKaW5kZXggMWIyYTNhZjY1Yi4uZjdmMTNlYmZjMiAxMDA2
NDQKLS0tIGEvdXRpbC9haW8tcG9zaXguYworKysgYi91dGlsL2Fpby1wb3NpeC5jCkBAIC00NjQs
OSArNDY0LDYgQEAgc3RhdGljIGJvb2wgcmVtb3ZlX2lkbGVfcG9sbF9oYW5kbGVycyhBaW9Db250
ZXh0ICpjdHgsIGludDY0X3Qgbm93KQogICoKICAqIFBvbGxzIGZvciBhIGdpdmVuIHRpbWUuCiAg
KgotICogTm90ZSB0aGF0IGN0eC0+bm90aWZ5X21lIG11c3QgYmUgbm9uLXplcm8gc28gdGhpcyBm
dW5jdGlvbiBjYW4gZGV0ZWN0Ci0gKiBhaW9fbm90aWZ5KCkuCi0gKgogICogTm90ZSB0aGF0IHRo
ZSBjYWxsZXIgbXVzdCBoYXZlIGluY3JlbWVudGVkIGN0eC0+bGlzdF9sb2NrLgogICoKICAqIFJl
dHVybnM6IHRydWUgaWYgcHJvZ3Jlc3Mgd2FzIG1hZGUsIGZhbHNlIG90aGVyd2lzZQpAQCAtNDc2
LDcgKzQ3Myw2IEBAIHN0YXRpYyBib29sIHJ1bl9wb2xsX2hhbmRsZXJzKEFpb0NvbnRleHQgKmN0
eCwgaW50NjRfdCBtYXhfbnMsIGludDY0X3QgKnRpbWVvdXQpCiAgICAgYm9vbCBwcm9ncmVzczsK
ICAgICBpbnQ2NF90IHN0YXJ0X3RpbWUsIGVsYXBzZWRfdGltZTsKIAotICAgIGFzc2VydChjdHgt
Pm5vdGlmeV9tZSk7CiAgICAgYXNzZXJ0KHFlbXVfbG9ja2NudF9jb3VudCgmY3R4LT5saXN0X2xv
Y2spID4gMCk7CiAKICAgICB0cmFjZV9ydW5fcG9sbF9oYW5kbGVyc19iZWdpbihjdHgsIG1heF9u
cywgKnRpbWVvdXQpOwpAQCAtNTIwLDggKzUxNiw2IEBAIHN0YXRpYyBib29sIHJ1bl9wb2xsX2hh
bmRsZXJzKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCBtYXhfbnMsIGludDY0X3QgKnRpbWVvdXQp
CiAgKiBAdGltZW91dDogdGltZW91dCBmb3IgYmxvY2tpbmcgd2FpdCwgY29tcHV0ZWQgYnkgdGhl
IGNhbGxlciBhbmQgdXBkYXRlZCBpZgogICogICAgcG9sbGluZyBzdWNjZWVkcy4KICAqCi0gKiBj
dHgtPm5vdGlmeV9tZSBtdXN0IGJlIG5vbi16ZXJvIHNvIHRoaXMgZnVuY3Rpb24gY2FuIGRldGVj
dCBhaW9fbm90aWZ5KCkuCi0gKgogICogTm90ZSB0aGF0IHRoZSBjYWxsZXIgbXVzdCBoYXZlIGlu
Y3JlbWVudGVkIGN0eC0+bGlzdF9sb2NrLgogICoKICAqIFJldHVybnM6IHRydWUgaWYgcHJvZ3Jl
c3Mgd2FzIG1hZGUsIGZhbHNlIG90aGVyd2lzZQpAQCAtNTU2LDYgKzU1MCw3IEBAIGJvb2wgYWlv
X3BvbGwoQWlvQ29udGV4dCAqY3R4LCBib29sIGJsb2NraW5nKQogICAgIEFpb0hhbmRsZXJMaXN0
IHJlYWR5X2xpc3QgPSBRTElTVF9IRUFEX0lOSVRJQUxJWkVSKHJlYWR5X2xpc3QpOwogICAgIGlu
dCByZXQgPSAwOwogICAgIGJvb2wgcHJvZ3Jlc3M7CisgICAgYm9vbCB1c2Vfbm90aWZ5X21lOwog
ICAgIGludDY0X3QgdGltZW91dDsKICAgICBpbnQ2NF90IHN0YXJ0ID0gMDsKIApAQCAtNTY2LDMz
ICs1NjEsMzkgQEAgYm9vbCBhaW9fcG9sbChBaW9Db250ZXh0ICpjdHgsIGJvb2wgYmxvY2tpbmcp
CiAgICAgICovCiAgICAgYXNzZXJ0KGluX2Fpb19jb250ZXh0X2hvbWVfdGhyZWFkKGN0eCkpOwog
Ci0gICAgLyogYWlvX25vdGlmeSBjYW4gYXZvaWQgdGhlIGV4cGVuc2l2ZSBldmVudF9ub3RpZmll
cl9zZXQgaWYKKyAgICBxZW11X2xvY2tjbnRfaW5jKCZjdHgtPmxpc3RfbG9jayk7CisKKyAgICBp
ZiAoY3R4LT5wb2xsX21heF9ucykgeworICAgICAgICBzdGFydCA9IHFlbXVfY2xvY2tfZ2V0X25z
KFFFTVVfQ0xPQ0tfUkVBTFRJTUUpOworICAgIH0KKworICAgIHRpbWVvdXQgPSBibG9ja2luZyA/
IGFpb19jb21wdXRlX3RpbWVvdXQoY3R4KSA6IDA7CisgICAgcHJvZ3Jlc3MgPSB0cnlfcG9sbF9t
b2RlKGN0eCwgJnRpbWVvdXQpOworICAgIGFzc2VydCghKHRpbWVvdXQgJiYgcHJvZ3Jlc3MpKTsK
KworICAgIC8qCisgICAgICogYWlvX25vdGlmeSBjYW4gYXZvaWQgdGhlIGV4cGVuc2l2ZSBldmVu
dF9ub3RpZmllcl9zZXQgaWYKICAgICAgKiBldmVyeXRoaW5nIChmaWxlIGRlc2NyaXB0b3JzLCBi
b3R0b20gaGFsdmVzLCB0aW1lcnMpIHdpbGwKICAgICAgKiBiZSByZS1ldmFsdWF0ZWQgYmVmb3Jl
IHRoZSBuZXh0IGJsb2NraW5nIHBvbGwoKS4gIFRoaXMgaXMKICAgICAgKiBhbHJlYWR5IHRydWUg
d2hlbiBhaW9fcG9sbCBpcyBjYWxsZWQgd2l0aCBibG9ja2luZyA9PSBmYWxzZTsKICAgICAgKiBp
ZiBibG9ja2luZyA9PSB0cnVlLCBpdCBpcyBvbmx5IHRydWUgYWZ0ZXIgcG9sbCgpIHJldHVybnMs
CiAgICAgICogc28gZGlzYWJsZSB0aGUgb3B0aW1pemF0aW9uIG5vdy4KICAgICAgKi8KLSAgICBp
ZiAoYmxvY2tpbmcpIHsKKyAgICB1c2Vfbm90aWZ5X21lID0gdGltZW91dCAhPSAwOworICAgIGlm
ICh1c2Vfbm90aWZ5X21lKSB7CiAgICAgICAgIGF0b21pY19zZXQoJmN0eC0+bm90aWZ5X21lLCBh
dG9taWNfcmVhZCgmY3R4LT5ub3RpZnlfbWUpICsgMik7CiAgICAgICAgIC8qCi0gICAgICAgICAq
IFdyaXRlIGN0eC0+bm90aWZ5X21lIGJlZm9yZSBjb21wdXRpbmcgdGhlIHRpbWVvdXQKLSAgICAg
ICAgICogKHJlYWRpbmcgYm90dG9tIGhhbGYgZmxhZ3MsIGV0Yy4pLiAgUGFpcnMgd2l0aAorICAg
ICAgICAgKiBXcml0ZSBjdHgtPm5vdGlmeV9tZSBiZWZvcmUgcmVhZGluZyBjdHgtPm5vdGlmaWVk
LiAgUGFpcnMgd2l0aAogICAgICAgICAgKiBzbXBfbWIgaW4gYWlvX25vdGlmeSgpLgogICAgICAg
ICAgKi8KICAgICAgICAgc21wX21iKCk7Ci0gICAgfQotCi0gICAgcWVtdV9sb2NrY250X2luYygm
Y3R4LT5saXN0X2xvY2spOwogCi0gICAgaWYgKGN0eC0+cG9sbF9tYXhfbnMpIHsKLSAgICAgICAg
c3RhcnQgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JFQUxUSU1FKTsKKyAgICAgICAg
LyogRG9uJ3QgYmxvY2sgaWYgYWlvX25vdGlmeSgpIHdhcyBjYWxsZWQgKi8KKyAgICAgICAgaWYg
KGF0b21pY19yZWFkKCZjdHgtPm5vdGlmaWVkKSkgeworICAgICAgICAgICAgdGltZW91dCA9IDA7
CisgICAgICAgIH0KICAgICB9CiAKLSAgICB0aW1lb3V0ID0gYmxvY2tpbmcgPyBhaW9fY29tcHV0
ZV90aW1lb3V0KGN0eCkgOiAwOwotICAgIHByb2dyZXNzID0gdHJ5X3BvbGxfbW9kZShjdHgsICZ0
aW1lb3V0KTsKLSAgICBhc3NlcnQoISh0aW1lb3V0ICYmIHByb2dyZXNzKSk7Ci0KICAgICAvKiBJ
ZiBwb2xsaW5nIGlzIGFsbG93ZWQsIG5vbi1ibG9ja2luZyBhaW9fcG9sbCBkb2VzIG5vdCBuZWVk
IHRoZQogICAgICAqIHN5c3RlbSBjYWxsLS0tYSBzaW5nbGUgcm91bmQgb2YgcnVuX3BvbGxfaGFu
ZGxlcnNfb25jZSBzdWZmaWNlcy4KICAgICAgKi8KQEAgLTYwMCwxMiArNjAxLDE0IEBAIGJvb2wg
YWlvX3BvbGwoQWlvQ29udGV4dCAqY3R4LCBib29sIGJsb2NraW5nKQogICAgICAgICByZXQgPSBj
dHgtPmZkbW9uX29wcy0+d2FpdChjdHgsICZyZWFkeV9saXN0LCB0aW1lb3V0KTsKICAgICB9CiAK
LSAgICBpZiAoYmxvY2tpbmcpIHsKKyAgICBpZiAodXNlX25vdGlmeV9tZSkgewogICAgICAgICAv
KiBGaW5pc2ggdGhlIHBvbGwgYmVmb3JlIGNsZWFyaW5nIHRoZSBmbGFnLiAgKi8KLSAgICAgICAg
YXRvbWljX3N0b3JlX3JlbGVhc2UoJmN0eC0+bm90aWZ5X21lLCBhdG9taWNfcmVhZCgmY3R4LT5u
b3RpZnlfbWUpIC0gMik7Ci0gICAgICAgIGFpb19ub3RpZnlfYWNjZXB0KGN0eCk7CisgICAgICAg
IGF0b21pY19zdG9yZV9yZWxlYXNlKCZjdHgtPm5vdGlmeV9tZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYXRvbWljX3JlYWQoJmN0eC0+bm90aWZ5X21lKSAtIDIpOwogICAgIH0KIAor
ICAgIGFpb19ub3RpZnlfYWNjZXB0KGN0eCk7CisKICAgICAvKiBBZGp1c3QgcG9sbGluZyB0aW1l
ICovCiAgICAgaWYgKGN0eC0+cG9sbF9tYXhfbnMpIHsKICAgICAgICAgaW50NjRfdCBibG9ja19u
cyA9IHFlbXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfUkVBTFRJTUUpIC0gc3RhcnQ7Ci0tIAoy
LjI2LjIKCg==


