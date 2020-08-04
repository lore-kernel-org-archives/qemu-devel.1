Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64960C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576AB2067D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4vXa+Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576AB2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2pYp-00084C-H8
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 01:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pUy-0005ju-EY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:28:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2pUw-0004iI-Ci
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596518905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDL1wmc+f6rJIU/rl7Kd5c/L+K1FGTcHl2d4/l6FJQQ=;
 b=C4vXa+CbppKg2t6Tl4tE68PIdeT/JCTdoTgwZJljIvYUlryNf7bpYY9C8flgKOCyp8iw6x
 tUrRHVkJ+ybIVj3q5D/5CqQgV/5utJScTmisODE6mM+rH+hH2UcvSywNY7ohhx9eilOEhz
 7d+ecKiCP2l+cTQaKX0AWLPw2vHVUHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-sJwo89WUNPuCOU1bsIFwyw-1; Tue, 04 Aug 2020 01:28:21 -0400
X-MC-Unique: sJwo89WUNPuCOU1bsIFwyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E449C106B242;
 Tue,  4 Aug 2020 05:28:20 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6884387E3B;
 Tue,  4 Aug 2020 05:28:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] aio-posix: keep aio_notify_me disabled during polling
Date: Tue,  4 Aug 2020 06:28:04 +0100
Message-Id: <20200804052804.1165291-4-stefanha@redhat.com>
In-Reply-To: <20200804052804.1165291-1-stefanha@redhat.com>
References: <20200804052804.1165291-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
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
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgfCA1
NiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRleCAxYjJhM2FmNjViLi4w
NzhlYzE1ODkwIDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBv
c2l4LmMKQEAgLTQ2NCw5ICs0NjQsNiBAQCBzdGF0aWMgYm9vbCByZW1vdmVfaWRsZV9wb2xsX2hh
bmRsZXJzKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCBub3cpCiAgKgogICogUG9sbHMgZm9yIGEg
Z2l2ZW4gdGltZS4KICAqCi0gKiBOb3RlIHRoYXQgY3R4LT5ub3RpZnlfbWUgbXVzdCBiZSBub24t
emVybyBzbyB0aGlzIGZ1bmN0aW9uIGNhbiBkZXRlY3QKLSAqIGFpb19ub3RpZnkoKS4KLSAqCiAg
KiBOb3RlIHRoYXQgdGhlIGNhbGxlciBtdXN0IGhhdmUgaW5jcmVtZW50ZWQgY3R4LT5saXN0X2xv
Y2suCiAgKgogICogUmV0dXJuczogdHJ1ZSBpZiBwcm9ncmVzcyB3YXMgbWFkZSwgZmFsc2Ugb3Ro
ZXJ3aXNlCkBAIC00NzYsNyArNDczLDYgQEAgc3RhdGljIGJvb2wgcnVuX3BvbGxfaGFuZGxlcnMo
QWlvQ29udGV4dCAqY3R4LCBpbnQ2NF90IG1heF9ucywgaW50NjRfdCAqdGltZW91dCkKICAgICBi
b29sIHByb2dyZXNzOwogICAgIGludDY0X3Qgc3RhcnRfdGltZSwgZWxhcHNlZF90aW1lOwogCi0g
ICAgYXNzZXJ0KGN0eC0+bm90aWZ5X21lKTsKICAgICBhc3NlcnQocWVtdV9sb2NrY250X2NvdW50
KCZjdHgtPmxpc3RfbG9jaykgPiAwKTsKIAogICAgIHRyYWNlX3J1bl9wb2xsX2hhbmRsZXJzX2Jl
Z2luKGN0eCwgbWF4X25zLCAqdGltZW91dCk7CkBAIC01MjAsOCArNTE2LDYgQEAgc3RhdGljIGJv
b2wgcnVuX3BvbGxfaGFuZGxlcnMoQWlvQ29udGV4dCAqY3R4LCBpbnQ2NF90IG1heF9ucywgaW50
NjRfdCAqdGltZW91dCkKICAqIEB0aW1lb3V0OiB0aW1lb3V0IGZvciBibG9ja2luZyB3YWl0LCBj
b21wdXRlZCBieSB0aGUgY2FsbGVyIGFuZCB1cGRhdGVkIGlmCiAgKiAgICBwb2xsaW5nIHN1Y2Nl
ZWRzLgogICoKLSAqIGN0eC0+bm90aWZ5X21lIG11c3QgYmUgbm9uLXplcm8gc28gdGhpcyBmdW5j
dGlvbiBjYW4gZGV0ZWN0IGFpb19ub3RpZnkoKS4KLSAqCiAgKiBOb3RlIHRoYXQgdGhlIGNhbGxl
ciBtdXN0IGhhdmUgaW5jcmVtZW50ZWQgY3R4LT5saXN0X2xvY2suCiAgKgogICogUmV0dXJuczog
dHJ1ZSBpZiBwcm9ncmVzcyB3YXMgbWFkZSwgZmFsc2Ugb3RoZXJ3aXNlCkBAIC01NjYsMjMgKzU2
MCw2IEBAIGJvb2wgYWlvX3BvbGwoQWlvQ29udGV4dCAqY3R4LCBib29sIGJsb2NraW5nKQogICAg
ICAqLwogICAgIGFzc2VydChpbl9haW9fY29udGV4dF9ob21lX3RocmVhZChjdHgpKTsKIAotICAg
IC8qIGFpb19ub3RpZnkgY2FuIGF2b2lkIHRoZSBleHBlbnNpdmUgZXZlbnRfbm90aWZpZXJfc2V0
IGlmCi0gICAgICogZXZlcnl0aGluZyAoZmlsZSBkZXNjcmlwdG9ycywgYm90dG9tIGhhbHZlcywg
dGltZXJzKSB3aWxsCi0gICAgICogYmUgcmUtZXZhbHVhdGVkIGJlZm9yZSB0aGUgbmV4dCBibG9j
a2luZyBwb2xsKCkuICBUaGlzIGlzCi0gICAgICogYWxyZWFkeSB0cnVlIHdoZW4gYWlvX3BvbGwg
aXMgY2FsbGVkIHdpdGggYmxvY2tpbmcgPT0gZmFsc2U7Ci0gICAgICogaWYgYmxvY2tpbmcgPT0g
dHJ1ZSwgaXQgaXMgb25seSB0cnVlIGFmdGVyIHBvbGwoKSByZXR1cm5zLAotICAgICAqIHNvIGRp
c2FibGUgdGhlIG9wdGltaXphdGlvbiBub3cuCi0gICAgICovCi0gICAgaWYgKGJsb2NraW5nKSB7
Ci0gICAgICAgIGF0b21pY19zZXQoJmN0eC0+bm90aWZ5X21lLCBhdG9taWNfcmVhZCgmY3R4LT5u
b3RpZnlfbWUpICsgMik7Ci0gICAgICAgIC8qCi0gICAgICAgICAqIFdyaXRlIGN0eC0+bm90aWZ5
X21lIGJlZm9yZSBjb21wdXRpbmcgdGhlIHRpbWVvdXQKLSAgICAgICAgICogKHJlYWRpbmcgYm90
dG9tIGhhbGYgZmxhZ3MsIGV0Yy4pLiAgUGFpcnMgd2l0aAotICAgICAgICAgKiBzbXBfbWIgaW4g
YWlvX25vdGlmeSgpLgotICAgICAgICAgKi8KLSAgICAgICAgc21wX21iKCk7Ci0gICAgfQotCiAg
ICAgcWVtdV9sb2NrY250X2luYygmY3R4LT5saXN0X2xvY2spOwogCiAgICAgaWYgKGN0eC0+cG9s
bF9tYXhfbnMpIHsKQEAgLTU5NywxNSArNTc0LDM4IEBAIGJvb2wgYWlvX3BvbGwoQWlvQ29udGV4
dCAqY3R4LCBib29sIGJsb2NraW5nKQogICAgICAqIHN5c3RlbSBjYWxsLS0tYSBzaW5nbGUgcm91
bmQgb2YgcnVuX3BvbGxfaGFuZGxlcnNfb25jZSBzdWZmaWNlcy4KICAgICAgKi8KICAgICBpZiAo
dGltZW91dCB8fCBjdHgtPmZkbW9uX29wcy0+bmVlZF93YWl0KGN0eCkpIHsKKyAgICAgICAgLyoK
KyAgICAgICAgICogYWlvX25vdGlmeSBjYW4gYXZvaWQgdGhlIGV4cGVuc2l2ZSBldmVudF9ub3Rp
Zmllcl9zZXQgaWYKKyAgICAgICAgICogZXZlcnl0aGluZyAoZmlsZSBkZXNjcmlwdG9ycywgYm90
dG9tIGhhbHZlcywgdGltZXJzKSB3aWxsCisgICAgICAgICAqIGJlIHJlLWV2YWx1YXRlZCBiZWZv
cmUgdGhlIG5leHQgYmxvY2tpbmcgcG9sbCgpLiAgVGhpcyBpcworICAgICAgICAgKiBhbHJlYWR5
IHRydWUgd2hlbiBhaW9fcG9sbCBpcyBjYWxsZWQgd2l0aCBibG9ja2luZyA9PSBmYWxzZTsKKyAg
ICAgICAgICogaWYgYmxvY2tpbmcgPT0gdHJ1ZSwgaXQgaXMgb25seSB0cnVlIGFmdGVyIHBvbGwo
KSByZXR1cm5zLAorICAgICAgICAgKiBzbyBkaXNhYmxlIHRoZSBvcHRpbWl6YXRpb24gbm93Lgor
ICAgICAgICAgKi8KKyAgICAgICAgaWYgKHRpbWVvdXQpIHsKKyAgICAgICAgICAgIGF0b21pY19z
ZXQoJmN0eC0+bm90aWZ5X21lLCBhdG9taWNfcmVhZCgmY3R4LT5ub3RpZnlfbWUpICsgMik7Cisg
ICAgICAgICAgICAvKgorICAgICAgICAgICAgICogV3JpdGUgY3R4LT5ub3RpZnlfbWUgYmVmb3Jl
IGNvbXB1dGluZyB0aGUgdGltZW91dAorICAgICAgICAgICAgICogKHJlYWRpbmcgYm90dG9tIGhh
bGYgZmxhZ3MsIGV0Yy4pLiAgUGFpcnMgd2l0aAorICAgICAgICAgICAgICogc21wX21iIGluIGFp
b19ub3RpZnkoKS4KKyAgICAgICAgICAgICAqLworICAgICAgICAgICAgc21wX21iKCk7CisKKyAg
ICAgICAgICAgIC8qIENoZWNrIGFnYWluIGluIGNhc2UgYSBzaG9ydGVyIHRpbWVyIHdhcyBhZGRl
ZCAqLworICAgICAgICAgICAgdGltZW91dCA9IHFlbXVfc29vbmVzdF90aW1lb3V0KHRpbWVvdXQs
IGFpb19jb21wdXRlX3RpbWVvdXQoY3R4KSk7CisgICAgICAgIH0KKwogICAgICAgICByZXQgPSBj
dHgtPmZkbW9uX29wcy0+d2FpdChjdHgsICZyZWFkeV9saXN0LCB0aW1lb3V0KTsKLSAgICB9CiAK
LSAgICBpZiAoYmxvY2tpbmcpIHsKLSAgICAgICAgLyogRmluaXNoIHRoZSBwb2xsIGJlZm9yZSBj
bGVhcmluZyB0aGUgZmxhZy4gICovCi0gICAgICAgIGF0b21pY19zdG9yZV9yZWxlYXNlKCZjdHgt
Pm5vdGlmeV9tZSwgYXRvbWljX3JlYWQoJmN0eC0+bm90aWZ5X21lKSAtIDIpOwotICAgICAgICBh
aW9fbm90aWZ5X2FjY2VwdChjdHgpOworICAgICAgICBpZiAodGltZW91dCkgeworICAgICAgICAg
ICAgLyogRmluaXNoIHRoZSBwb2xsIGJlZm9yZSBjbGVhcmluZyB0aGUgZmxhZy4gICovCisgICAg
ICAgICAgICBhdG9taWNfc3RvcmVfcmVsZWFzZSgmY3R4LT5ub3RpZnlfbWUsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfcmVhZCgmY3R4LT5ub3RpZnlfbWUpIC0gMik7
CisgICAgICAgIH0KICAgICB9CiAKKyAgICBhaW9fbm90aWZ5X2FjY2VwdChjdHgpOworCiAgICAg
LyogQWRqdXN0IHBvbGxpbmcgdGltZSAqLwogICAgIGlmIChjdHgtPnBvbGxfbWF4X25zKSB7CiAg
ICAgICAgIGludDY0X3QgYmxvY2tfbnMgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1JF
QUxUSU1FKSAtIHN0YXJ0OwotLSAKMi4yNi4yCgo=


