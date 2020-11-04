Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D6EC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9498A2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW35lSCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9498A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKjX-0002fm-EE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKa3-0006mP-5T
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKa1-00080s-6D
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vc0NwBAYp9PUVSZXf09QtzF61OX71oHpVzROsVcIOQc=;
 b=VW35lSCS8RUs/XV6JfcD9BzFwSJsUg7WbubMM79UnYbVdst4u+J3/qf+m2+Zr9xJ+KV4v3
 YYw6dRaIbAwqliZDj++0w8Kx7qzlrCTh9W+w5u24qMrgVjdf4Uc3KiuNPDFuiNvSKRe4h8
 Y82xjHDsbz254ZH/jAKCUzAoLbuTkgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-hX5bbP4SPmK680cQBQNzkg-1; Wed, 04 Nov 2020 10:20:04 -0500
X-MC-Unique: hX5bbP4SPmK680cQBQNzkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 768F4186DD25;
 Wed,  4 Nov 2020 15:20:02 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D297319D61;
 Wed,  4 Nov 2020 15:19:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/33] block/nvme: Make nvme_identify() return boolean
 indicating error
Date: Wed,  4 Nov 2020 15:18:07 +0000
Message-Id: <20201104151828.405824-13-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKSnVzdCBm
b3IgY29uc2lzdGVuY3ksIGZvbGxvd2luZyB0aGUgZXhhbXBsZSBkb2N1bWVudGVkIHNpbmNlCmNv
bW1pdCBlM2ZlMzk4OGQ3ICgiZXJyb3I6IERvY3VtZW50IEVycm9yIEFQSSB1c2FnZSBydWxlcyIp
LApyZXR1cm4gYSBib29sZWFuIHZhbHVlIGluZGljYXRpbmcgYW4gZXJyb3IgaXMgc2V0IG9yIG5v
dC4KRGlyZWN0bHkgcGFzcyBlcnJwIGFzIHRoZSBsb2NhbF9lcnIgaXMgbm90IHJlcXVlc3RlZCBp
biBvdXIKY2FzZS4KClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1l
c3NhZ2UtaWQ6IDIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMTEtcGhpbG1kQHJlZGhhdC5jb20KU2ln
bmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMg
fCAxMiArKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmluZGV4
IGM0NTA0OTkxMTEuLjk4MzM1MDEyNDUgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysgYi9i
bG9jay9udm1lLmMKQEAgLTUwNiw5ICs1MDYsMTEgQEAgc3RhdGljIGludCBudm1lX2NtZF9zeW5j
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBOVk1lUXVldWVQYWlyICpxLAogICAgIHJldHVybiByZXQ7
CiB9CiAKLXN0YXRpYyB2b2lkIG52bWVfaWRlbnRpZnkoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGlu
dCBuYW1lc3BhY2UsIEVycm9yICoqZXJycCkKKy8qIFJldHVybnMgdHJ1ZSBvbiBzdWNjZXNzLCBm
YWxzZSBvbiBmYWlsdXJlLiAqLworc3RhdGljIGJvb2wgbnZtZV9pZGVudGlmeShCbG9ja0RyaXZl
clN0YXRlICpicywgaW50IG5hbWVzcGFjZSwgRXJyb3IgKiplcnJwKQogewogICAgIEJEUlZOVk1l
U3RhdGUgKnMgPSBicy0+b3BhcXVlOworICAgIGJvb2wgcmV0ID0gZmFsc2U7CiAgICAgdW5pb24g
ewogICAgICAgICBOdm1lSWRDdHJsIGN0cmw7CiAgICAgICAgIE52bWVJZE5zIG5zOwpAQCAtNTg1
LDEwICs1ODcsMTMgQEAgc3RhdGljIHZvaWQgbnZtZV9pZGVudGlmeShCbG9ja0RyaXZlclN0YXRl
ICpicywgaW50IG5hbWVzcGFjZSwgRXJyb3IgKiplcnJwKQogICAgICAgICBnb3RvIG91dDsKICAg
ICB9CiAKKyAgICByZXQgPSB0cnVlOwogICAgIHMtPmJsa3NoaWZ0ID0gbGJhZi0+ZHM7CiBvdXQ6
CiAgICAgcWVtdV92ZmlvX2RtYV91bm1hcChzLT52ZmlvLCBpZCk7CiAgICAgcWVtdV92ZnJlZShp
ZCk7CisKKyAgICByZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgYm9vbCBudm1lX3BvbGxfcXVldWUo
TlZNZVF1ZXVlUGFpciAqcSkKQEAgLTcwMSw3ICs3MDYsNiBAQCBzdGF0aWMgaW50IG52bWVfaW5p
dChCbG9ja0RyaXZlclN0YXRlICpicywgY29uc3QgY2hhciAqZGV2aWNlLCBpbnQgbmFtZXNwYWNl
LAogICAgIHVpbnQ2NF90IGNhcDsKICAgICB1aW50NjRfdCB0aW1lb3V0X21zOwogICAgIHVpbnQ2
NF90IGRlYWRsaW5lLCBub3c7Ci0gICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7CiAgICAgdm9s
YXRpbGUgTnZtZUJhciAqcmVncyA9IE5VTEw7CiAKICAgICBxZW11X2NvX211dGV4X2luaXQoJnMt
PmRtYV9tYXBfbG9jayk7CkBAIC04MTgsOSArODIyLDcgQEAgc3RhdGljIGludCBudm1lX2luaXQo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IGNoYXIgKmRldmljZSwgaW50IG5hbWVzcGFjZSwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5pcnFfbm90aWZpZXJbTVNJWF9TSEFSRURf
SVJRX0lEWF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYWxzZSwgbnZtZV9oYW5kbGVf
ZXZlbnQsIG52bWVfcG9sbF9jYik7CiAKLSAgICBudm1lX2lkZW50aWZ5KGJzLCBuYW1lc3BhY2Us
ICZsb2NhbF9lcnIpOwotICAgIGlmIChsb2NhbF9lcnIpIHsKLSAgICAgICAgZXJyb3JfcHJvcGFn
YXRlKGVycnAsIGxvY2FsX2Vycik7CisgICAgaWYgKCFudm1lX2lkZW50aWZ5KGJzLCBuYW1lc3Bh
Y2UsIGVycnApKSB7CiAgICAgICAgIHJldCA9IC1FSU87CiAgICAgICAgIGdvdG8gb3V0OwogICAg
IH0KLS0gCjIuMjguMAoK


