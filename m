Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7582173E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS3YIPjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7582173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GIl-00040c-K0
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GEW-0005pg-Tn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GEU-0000UW-Gn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvLhYWwqvdmgtM6yZ1tfDDwvqZo2lbAzSYkQQNfkwsc=;
 b=VS3YIPjs3/N0osT797Qlgep/iQQtEZfnnFIFRKj+yBn/1+MbrngRkBKLvL1jyBe+eudTMM
 Ptsn/bredfOvTW3jjUcAU9yL6B7gXM7Ll9UCssi2RN04Se2LdvAlNpr3IrgFbc1Brv2oNL
 3Z3jcqRVTmwlFzbM7mH3uDeob7OwgZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-tE24ClGKOhaVISEZ8Oo1CQ-1; Wed, 05 Aug 2020 06:01:11 -0400
X-MC-Unique: tE24ClGKOhaVISEZ8Oo1CQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20F0101C8B1;
 Wed,  5 Aug 2020 10:01:10 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17B1689512;
 Wed,  5 Aug 2020 10:01:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] aio-posix: keep aio_notify_me disabled during polling
Date: Wed,  5 Aug 2020 11:00:51 +0100
Message-Id: <20200805100051.361547-4-stefanha@redhat.com>
In-Reply-To: <20200805100051.361547-1-stefanha@redhat.com>
References: <20200805100051.361547-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
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
OSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRleCAxYjJhM2FmNjViLi44
ZDEwOTEwYmNmIDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBv
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
bF9tYXhfbnMpIHsKQEAgLTU5NywxNSArNTc0LDQxIEBAIGJvb2wgYWlvX3BvbGwoQWlvQ29udGV4
dCAqY3R4LCBib29sIGJsb2NraW5nKQogICAgICAqIHN5c3RlbSBjYWxsLS0tYSBzaW5nbGUgcm91
bmQgb2YgcnVuX3BvbGxfaGFuZGxlcnNfb25jZSBzdWZmaWNlcy4KICAgICAgKi8KICAgICBpZiAo
dGltZW91dCB8fCBjdHgtPmZkbW9uX29wcy0+bmVlZF93YWl0KGN0eCkpIHsKKyAgICAgICAgYm9v
bCB1c2Vfbm90aWZ5X21lID0gdGltZW91dCAhPSAwOworCisgICAgICAgIC8qCisgICAgICAgICAq
IGFpb19ub3RpZnkgY2FuIGF2b2lkIHRoZSBleHBlbnNpdmUgZXZlbnRfbm90aWZpZXJfc2V0IGlm
CisgICAgICAgICAqIGV2ZXJ5dGhpbmcgKGZpbGUgZGVzY3JpcHRvcnMsIGJvdHRvbSBoYWx2ZXMs
IHRpbWVycykgd2lsbAorICAgICAgICAgKiBiZSByZS1ldmFsdWF0ZWQgYmVmb3JlIHRoZSBuZXh0
IGJsb2NraW5nIHBvbGwoKS4gIFRoaXMgaXMKKyAgICAgICAgICogYWxyZWFkeSB0cnVlIHdoZW4g
YWlvX3BvbGwgaXMgY2FsbGVkIHdpdGggYmxvY2tpbmcgPT0gZmFsc2U7CisgICAgICAgICAqIGlm
IGJsb2NraW5nID09IHRydWUsIGl0IGlzIG9ubHkgdHJ1ZSBhZnRlciBwb2xsKCkgcmV0dXJucywK
KyAgICAgICAgICogc28gZGlzYWJsZSB0aGUgb3B0aW1pemF0aW9uIG5vdy4KKyAgICAgICAgICov
CisgICAgICAgIGlmICh1c2Vfbm90aWZ5X21lKSB7CisgICAgICAgICAgICBhdG9taWNfc2V0KCZj
dHgtPm5vdGlmeV9tZSwgYXRvbWljX3JlYWQoJmN0eC0+bm90aWZ5X21lKSArIDIpOworICAgICAg
ICAgICAgLyoKKyAgICAgICAgICAgICAqIFdyaXRlIGN0eC0+bm90aWZ5X21lIGJlZm9yZSByZWFk
aW5nIGN0eC0+bm90aWZpZWQuICBQYWlycyB3aXRoCisgICAgICAgICAgICAgKiBzbXBfbWIgaW4g
YWlvX25vdGlmeSgpLgorICAgICAgICAgICAgICovCisgICAgICAgICAgICBzbXBfbWIoKTsKKwor
ICAgICAgICAgICAgLyogRG9uJ3QgYmxvY2sgaWYgYWlvX25vdGlmeSgpIHdhcyBjYWxsZWQgKi8K
KyAgICAgICAgICAgIGlmIChhdG9taWNfcmVhZCgmY3R4LT5ub3RpZmllZCkpIHsKKyAgICAgICAg
ICAgICAgICB0aW1lb3V0ID0gMDsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorCiAgICAgICAg
IHJldCA9IGN0eC0+ZmRtb25fb3BzLT53YWl0KGN0eCwgJnJlYWR5X2xpc3QsIHRpbWVvdXQpOwot
ICAgIH0KIAotICAgIGlmIChibG9ja2luZykgewotICAgICAgICAvKiBGaW5pc2ggdGhlIHBvbGwg
YmVmb3JlIGNsZWFyaW5nIHRoZSBmbGFnLiAgKi8KLSAgICAgICAgYXRvbWljX3N0b3JlX3JlbGVh
c2UoJmN0eC0+bm90aWZ5X21lLCBhdG9taWNfcmVhZCgmY3R4LT5ub3RpZnlfbWUpIC0gMik7Ci0g
ICAgICAgIGFpb19ub3RpZnlfYWNjZXB0KGN0eCk7CisgICAgICAgIGlmICh1c2Vfbm90aWZ5X21l
KSB7CisgICAgICAgICAgICAvKiBGaW5pc2ggdGhlIHBvbGwgYmVmb3JlIGNsZWFyaW5nIHRoZSBm
bGFnLiAgKi8KKyAgICAgICAgICAgIGF0b21pY19zdG9yZV9yZWxlYXNlKCZjdHgtPm5vdGlmeV9t
ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0b21pY19yZWFkKCZjdHgtPm5v
dGlmeV9tZSkgLSAyKTsKKyAgICAgICAgfQogICAgIH0KIAorICAgIGFpb19ub3RpZnlfYWNjZXB0
KGN0eCk7CisKICAgICAvKiBBZGp1c3QgcG9sbGluZyB0aW1lICovCiAgICAgaWYgKGN0eC0+cG9s
bF9tYXhfbnMpIHsKICAgICAgICAgaW50NjRfdCBibG9ja19ucyA9IHFlbXVfY2xvY2tfZ2V0X25z
KFFFTVVfQ0xPQ0tfUkVBTFRJTUUpIC0gc3RhcnQ7Ci0tIAoyLjI2LjIKCg==


