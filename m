Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DFBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEB120663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtaDc8IG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEB120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDoRb-0004GN-UT
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jDne0-0002tb-RR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jDndz-0005Mc-DQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:10:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jDndz-0005CS-5L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584357050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgE+vdHZP8+R7ZEnD4oIE/yB0B6AtgFjwBdfiemBG0c=;
 b=UtaDc8IGZAs9cBWmp2Zy7T2PJ1uU0aNgs+FLllHPlrauveRN0PpDQqBkqx3ZzNbrPXKDfS
 7e5n65UpyiUWBbXMoTEcpRKwV6Id+W9ySLRv59jWkqcLcW/ULYoKLQKAii9Ij1VkQjVt83
 0Xsa76VrEcQXDSRC4gaZDYfsCoXSvmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-I_bLVJ0gPdeQwc2FAwTqeQ-1; Mon, 16 Mar 2020 07:10:48 -0400
X-MC-Unique: I_bLVJ0gPdeQwc2FAwTqeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0699518FE881;
 Mon, 16 Mar 2020 11:10:48 +0000 (UTC)
Received: from localhost (unknown [10.36.119.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA733610DC;
 Mon, 16 Mar 2020 11:10:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] lockable: add QemuRecMutex support
Date: Mon, 16 Mar 2020 11:09:57 +0000
Message-Id: <20200316110957.449700-3-stefanha@redhat.com>
In-Reply-To: <20200316110957.449700-1-stefanha@redhat.com>
References: <20200316110957.449700-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHBvbHltb3JwaGljIGxvY2tpbmcgbWFjcm9zIGRvbid0IHN1cHBvcnQgUWVtdVJlY011dGV4
IHlldC4gIEFkZCBpdApzbyB0aGF0IGxvY2sgZ3VhcmRzIGNhbiBiZSB1c2VkIHdpdGggUWVtdVJl
Y011dGV4LgoKQ29udmVydCBUQ0cgcGx1Z2lucyBmdW5jdGlvbnMgdGhhdCBiZW5lZml0IGZyb20g
dGhlc2UgbWFjcm9zLiAgTWFudWFsCnFlbXVfcmVjX211dGV4X2xvY2svdW5sb2NrKCkgY2FsbGVy
cyBhcmUgbGVmdCB1bm1vZGlmaWVkIGluIGNhc2VzIHdoZXJlCmNsYXJpdHkgd291bGQgbm90IGlt
cHJvdmUgYnkgc3dpdGNoaW5nIHRvIHRoZSBtYWNyb3MuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9xZW11L2xvY2thYmxl
LmggfCAgMiArKwogcGx1Z2lucy9jb3JlLmMgICAgICAgICAgfCAgNyArKystLS0tCiBwbHVnaW5z
L2xvYWRlci5jICAgICAgICB8IDE2ICsrKysrKysrLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9x
ZW11L2xvY2thYmxlLmggYi9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaAppbmRleCAyYjUyYzdjMWU1
Li40NGIzZjRiZTcyIDEwMDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaAorKysgYi9p
bmNsdWRlL3FlbXUvbG9ja2FibGUuaApAQCAtNTAsNiArNTAsNyBAQCBxZW11X21ha2VfbG9ja2Fi
bGUodm9pZCAqeCwgUWVtdUxvY2thYmxlICpsb2NrYWJsZSkKICNkZWZpbmUgUUVNVV9MT0NLX0ZV
TkMoeCkgKChRZW11TG9ja1VubG9ja0Z1bmMgKikgICAgXAogICAgIFFFTVVfR0VORVJJQyh4LCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgIChRZW11
TXV0ZXggKiwgcWVtdV9tdXRleF9sb2NrKSwgICAgIFwKKyAgICAgICAgICAgICAgICAgKFFlbXVS
ZWNNdXRleCAqLCBxZW11X3JlY19tdXRleF9sb2NrKSwgXAogICAgICAgICAgICAgICAgICAoQ29N
dXRleCAqLCBxZW11X2NvX211dGV4X2xvY2spLCAgICBcCiAgICAgICAgICAgICAgICAgIChRZW11
U3BpbiAqLCBxZW11X3NwaW5fbG9jayksICAgICAgIFwKICAgICAgICAgICAgICAgICAgdW5rbm93
bl9sb2NrX3R5cGUpKQpAQCAtNTcsNiArNTgsNyBAQCBxZW11X21ha2VfbG9ja2FibGUodm9pZCAq
eCwgUWVtdUxvY2thYmxlICpsb2NrYWJsZSkKICNkZWZpbmUgUUVNVV9VTkxPQ0tfRlVOQyh4KSAo
KFFlbXVMb2NrVW5sb2NrRnVuYyAqKSAgXAogICAgIFFFTVVfR0VORVJJQyh4LCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgIChRZW11TXV0ZXggKiwg
cWVtdV9tdXRleF91bmxvY2spLCAgIFwKKyAgICAgICAgICAgICAgICAgKFFlbXVSZWNNdXRleCAq
LCBxZW11X3JlY19tdXRleF91bmxvY2spLCBcCiAgICAgICAgICAgICAgICAgIChDb011dGV4ICos
IHFlbXVfY29fbXV0ZXhfdW5sb2NrKSwgIFwKICAgICAgICAgICAgICAgICAgKFFlbXVTcGluICos
IHFlbXVfc3Bpbl91bmxvY2spLCAgICAgXAogICAgICAgICAgICAgICAgICB1bmtub3duX2xvY2tf
dHlwZSkpCmRpZmYgLS1naXQgYS9wbHVnaW5zL2NvcmUuYyBiL3BsdWdpbnMvY29yZS5jCmluZGV4
IGVkODYzMDExYmEuLjUxYmZjOTQ3ODcgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvY29yZS5jCisrKyBi
L3BsdWdpbnMvY29yZS5jCkBAIC0xNSw2ICsxNSw3IEBACiAjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCIKICNpbmNsdWRlICJxZW11L2NvbmZpZy1maWxlLmgiCiAjaW5jbHVkZSAicWFwaS9l
cnJvci5oIgorI2luY2x1ZGUgInFlbXUvbG9ja2FibGUuaCIKICNpbmNsdWRlICJxZW11L29wdGlv
bi5oIgogI2luY2x1ZGUgInFlbXUvcmN1X3F1ZXVlLmgiCiAjaW5jbHVkZSAicWVtdS94eGhhc2gu
aCIKQEAgLTE1MCwxMSArMTUxLDExIEBAIGRvX3BsdWdpbl9yZWdpc3Rlcl9jYihxZW11X3BsdWdp
bl9pZF90IGlkLCBlbnVtIHFlbXVfcGx1Z2luX2V2ZW50IGV2LAogewogICAgIHN0cnVjdCBxZW11
X3BsdWdpbl9jdHggKmN0eDsKIAotICAgIHFlbXVfcmVjX211dGV4X2xvY2soJnBsdWdpbi5sb2Nr
KTsKKyAgICBRRU1VX0xPQ0tfR1VBUkQoJnBsdWdpbi5sb2NrKTsKICAgICBjdHggPSBwbHVnaW5f
aWRfdG9fY3R4X2xvY2tlZChpZCk7CiAgICAgLyogaWYgdGhlIHBsdWdpbiBpcyBvbiBpdHMgd2F5
IG91dCwgaWdub3JlIHRoaXMgcmVxdWVzdCAqLwogICAgIGlmICh1bmxpa2VseShjdHgtPnVuaW5z
dGFsbGluZykpIHsKLSAgICAgICAgZ290byBvdXRfdW5sb2NrOworICAgICAgICByZXR1cm47CiAg
ICAgfQogICAgIGlmIChmdW5jKSB7CiAgICAgICAgIHN0cnVjdCBxZW11X3BsdWdpbl9jYiAqY2Ig
PSBjdHgtPmNhbGxiYWNrc1tldl07CkBAIC0xNzgsOCArMTc5LDYgQEAgZG9fcGx1Z2luX3JlZ2lz
dGVyX2NiKHFlbXVfcGx1Z2luX2lkX3QgaWQsIGVudW0gcWVtdV9wbHVnaW5fZXZlbnQgZXYsCiAg
ICAgfSBlbHNlIHsKICAgICAgICAgcGx1Z2luX3VucmVnaXN0ZXJfY2JfX2xvY2tlZChjdHgsIGV2
KTsKICAgICB9Ci0gb3V0X3VubG9jazoKLSAgICBxZW11X3JlY19tdXRleF91bmxvY2soJnBsdWdp
bi5sb2NrKTsKIH0KIAogdm9pZCBwbHVnaW5fcmVnaXN0ZXJfY2IocWVtdV9wbHVnaW5faWRfdCBp
ZCwgZW51bSBxZW11X3BsdWdpbl9ldmVudCBldiwKZGlmZiAtLWdpdCBhL3BsdWdpbnMvbG9hZGVy
LmMgYi9wbHVnaW5zL2xvYWRlci5jCmluZGV4IDE1ZmM3ZTU1MTUuLjY4NWQzMzRlMWEgMTAwNjQ0
Ci0tLSBhL3BsdWdpbnMvbG9hZGVyLmMKKysrIGIvcGx1Z2lucy9sb2FkZXIuYwpAQCAtMTksNiAr
MTksNyBAQAogI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiCiAjaW5jbHVkZSAicWVtdS9j
b25maWctZmlsZS5oIgogI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKKyNpbmNsdWRlICJxZW11L2xv
Y2thYmxlLmgiCiAjaW5jbHVkZSAicWVtdS9vcHRpb24uaCIKICNpbmNsdWRlICJxZW11L3JjdV9x
dWV1ZS5oIgogI2luY2x1ZGUgInFlbXUvcWh0LmgiCkBAIC0zNjcsMTUgKzM2OCwxNCBAQCB2b2lk
IHBsdWdpbl9yZXNldF91bmluc3RhbGwocWVtdV9wbHVnaW5faWRfdCBpZCwKICAgICBzdHJ1Y3Qg
cWVtdV9wbHVnaW5fcmVzZXRfZGF0YSAqZGF0YTsKICAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fY3R4
ICpjdHg7CiAKLSAgICBxZW11X3JlY19tdXRleF9sb2NrKCZwbHVnaW4ubG9jayk7Ci0gICAgY3R4
ID0gcGx1Z2luX2lkX3RvX2N0eF9sb2NrZWQoaWQpOwotICAgIGlmIChjdHgtPnVuaW5zdGFsbGlu
ZyB8fCAocmVzZXQgJiYgY3R4LT5yZXNldHRpbmcpKSB7Ci0gICAgICAgIHFlbXVfcmVjX211dGV4
X3VubG9jaygmcGx1Z2luLmxvY2spOwotICAgICAgICByZXR1cm47CisgICAgV0lUSF9RRU1VX0xP
Q0tfR1VBUkQoJnBsdWdpbi5sb2NrKSB7CisgICAgICAgIGN0eCA9IHBsdWdpbl9pZF90b19jdHhf
bG9ja2VkKGlkKTsKKyAgICAgICAgaWYgKGN0eC0+dW5pbnN0YWxsaW5nIHx8IChyZXNldCAmJiBj
dHgtPnJlc2V0dGluZykpIHsKKyAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQorICAgICAg
ICBjdHgtPnJlc2V0dGluZyA9IHJlc2V0OworICAgICAgICBjdHgtPnVuaW5zdGFsbGluZyA9ICFy
ZXNldDsKICAgICB9Ci0gICAgY3R4LT5yZXNldHRpbmcgPSByZXNldDsKLSAgICBjdHgtPnVuaW5z
dGFsbGluZyA9ICFyZXNldDsKLSAgICBxZW11X3JlY19tdXRleF91bmxvY2soJnBsdWdpbi5sb2Nr
KTsKIAogICAgIGRhdGEgPSBnX25ldyhzdHJ1Y3QgcWVtdV9wbHVnaW5fcmVzZXRfZGF0YSwgMSk7
CiAgICAgZGF0YS0+Y3R4ID0gY3R4OwotLSAKMi4yNC4xCgo=


