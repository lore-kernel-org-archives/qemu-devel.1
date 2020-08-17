Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5ACC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB81020760
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z89SdUhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB81020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hI5-0000tF-1x
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsb-00088C-60
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:16:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsY-0003hH-IK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuRV43yqQdNCB2WTLyAguTX0OKSfy9SmIjrn7/b6Sko=;
 b=Z89SdUhmDZCgA1KRvU1VnbWBcp0LLVXqtAQfH+BxB7xJ5sj1gcwPqPT9QMwft8xK3bQbmn
 uKRvsdb2nyaFUB7cZLeIiZLaTLOgT/xWj5epJDR4rnNQeOPrbX4PXA7iFgDl8D3nCxicWi
 GiazTvVDPYZLZ1VRa4XFCoBpGOFqTR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-wLi6SOe_NzKFNacGDakofg-1; Mon, 17 Aug 2020 11:16:50 -0400
X-MC-Unique: wLi6SOe_NzKFNacGDakofg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AD8B81F017;
 Mon, 17 Aug 2020 15:16:49 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C380F10021AA;
 Mon, 17 Aug 2020 15:16:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/3] async: always set ctx->notified in aio_notify()
Date: Mon, 17 Aug 2020 16:16:33 +0100
Message-Id: <20200817151634.35563-3-stefanha@redhat.com>
In-Reply-To: <20200817151634.35563-1-stefanha@redhat.com>
References: <20200817151634.35563-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

YWlvX25vdGlmeSgpIGRvZXMgbm90IHNldCBjdHgtPm5vdGlmaWVkIHdoZW4gY2FsbGVkIHdpdGgK
Y3R4LT5haW9fbm90aWZ5X21lIGRpc2FibGVkLiBUaGVyZWZvcmUgYWlvX25vdGlmeV9tZSBuZWVk
cyB0byBiZSBlbmFibGVkCmR1cmluZyBwb2xsaW5nLgoKVGhpcyBpcyBzdWJvcHRpbWFsIHNpbmNl
IGV4cGVuc2l2ZSBldmVudF9ub3RpZmllcl9zZXQoJmN0eC0+bm90aWZpZXIpCmFuZCBldmVudF9u
b3RpZmllcl90ZXN0X2FuZF9jbGVhcigmY3R4LT5ub3RpZmllcikgY2FsbHMgYXJlIHJlcXVpcmVk
CndoZW4gY3R4LT5haW9fbm90aWZ5X21lIGlzIGVuYWJsZWQuCgpDaGFuZ2UgYWlvX25vdGlmeSgp
IHNvIHRoYXQgYWlvLT5ub3RpZmllZCBpcyBhbHdheXMgc2V0LCByZWdhcmRsZXNzIG9mCmN0eC0+
YWlvX25vdGlmeV9tZS4gVGhpcyB3aWxsIG1ha2UgcG9sbGluZyBjaGVhcGVyIHNpbmNlCmN0eC0+
YWlvX25vdGlmeV9tZSBjYW4gcmVtYWluIGRpc2FibGVkLiBNb3ZlIHRoZQpldmVudF9ub3RpZmll
cl90ZXN0X2FuZF9jbGVhcigpIHRvIHRoZSBmZCBoYW5kbGVyIGZ1bmN0aW9uICh3aGljaCBpcyBu
b3cKbm8gbG9uZ2VyIGFuIGVtcHR5IGZ1bmN0aW9uIHNvICJkdW1teSIgaGFzIGJlZW4gZHJvcHBl
ZCBmcm9tIGl0cyBuYW1lKS4KClRoZSBuZXh0IHBhdGNoIHRha2VzIGFkdmFudGFnZSBvZiB0aGlz
IGJ5IG9wdGltaXppbmcgcG9sbGluZyBpbgp1dGlsL2Fpby1wb3NpeC5jLgoKU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGFv
bG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA4MDYxMzE4
MDIuNTY5NDc4LTMtc3RlZmFuaGFAcmVkaGF0LmNvbQoKW1Bhb2xvIEJvbnppbmkgcG9pbnRlZCBv
dXQgdGhhdCB0aGUgc21wX3dtYigpIGluIGFpb19ub3RpZnlfYWNjZXB0KCkKc2hvdWxkIGJlIHNt
cF93YigpIGJ1dCB0aGUgY29tbWVudCBzaG91bGQgYmUgc21wX3dtYigpIGluc3RlYWQgb2YKc21w
X3diKCkuIEZpeGVkLgotLVN0ZWZhbl0KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL2FzeW5jLmMgfCAzMiArKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvYXN5bmMuYyBiL3V0aWwvYXN5bmMuYwpp
bmRleCBkOWY5ODdlMTMzLi40MjY2NzQ1ZGVlIDEwMDY0NAotLS0gYS91dGlsL2FzeW5jLmMKKysr
IGIvdXRpbC9hc3luYy5jCkBAIC00MTksMjUgKzQxOSwzMiBAQCBMdXJpbmdTdGF0ZSAqYWlvX2dl
dF9saW51eF9pb191cmluZyhBaW9Db250ZXh0ICpjdHgpCiAKIHZvaWQgYWlvX25vdGlmeShBaW9D
b250ZXh0ICpjdHgpCiB7Ci0gICAgLyogV3JpdGUgZS5nLiBiaC0+c2NoZWR1bGVkIGJlZm9yZSBy
ZWFkaW5nIGN0eC0+bm90aWZ5X21lLiAgUGFpcnMKKyAgICAvKgorICAgICAqIFdyaXRlIGUuZy4g
YmgtPmZsYWdzIGJlZm9yZSB3cml0aW5nIGN0eC0+bm90aWZpZWQuICBQYWlycyB3aXRoIHNtcF9t
YiBpbgorICAgICAqIGFpb19ub3RpZnlfYWNjZXB0LgorICAgICAqLworICAgIHNtcF93bWIoKTsK
KyAgICBhdG9taWNfc2V0KCZjdHgtPm5vdGlmaWVkLCB0cnVlKTsKKworICAgIC8qCisgICAgICog
V3JpdGUgY3R4LT5ub3RpZmllZCBiZWZvcmUgcmVhZGluZyBjdHgtPm5vdGlmeV9tZS4gIFBhaXJz
CiAgICAgICogd2l0aCBzbXBfbWIgaW4gYWlvX2N0eF9wcmVwYXJlIG9yIGFpb19wb2xsLgogICAg
ICAqLwogICAgIHNtcF9tYigpOwogICAgIGlmIChhdG9taWNfcmVhZCgmY3R4LT5ub3RpZnlfbWUp
KSB7CiAgICAgICAgIGV2ZW50X25vdGlmaWVyX3NldCgmY3R4LT5ub3RpZmllcik7Ci0gICAgICAg
IGF0b21pY19tYl9zZXQoJmN0eC0+bm90aWZpZWQsIHRydWUpOwogICAgIH0KIH0KIAogdm9pZCBh
aW9fbm90aWZ5X2FjY2VwdChBaW9Db250ZXh0ICpjdHgpCiB7Ci0gICAgaWYgKGF0b21pY194Y2hn
KCZjdHgtPm5vdGlmaWVkLCBmYWxzZSkKLSNpZmRlZiBXSU4zMgotICAgICAgICB8fCB0cnVlCi0j
ZW5kaWYKLSAgICApIHsKLSAgICAgICAgZXZlbnRfbm90aWZpZXJfdGVzdF9hbmRfY2xlYXIoJmN0
eC0+bm90aWZpZXIpOwotICAgIH0KKyAgICBhdG9taWNfc2V0KCZjdHgtPm5vdGlmaWVkLCBmYWxz
ZSk7CisKKyAgICAvKgorICAgICAqIFdyaXRlIGN0eC0+bm90aWZpZWQgYmVmb3JlIHJlYWRpbmcg
ZS5nLiBiaC0+ZmxhZ3MuICBQYWlycyB3aXRoIHNtcF93bWIKKyAgICAgKiBpbiBhaW9fbm90aWZ5
LgorICAgICAqLworICAgIHNtcF9tYigpOwogfQogCiBzdGF0aWMgdm9pZCBhaW9fdGltZXJsaXN0
X25vdGlmeSh2b2lkICpvcGFxdWUsIFFFTVVDbG9ja1R5cGUgdHlwZSkKQEAgLTQ0NSw4ICs0NTIs
MTEgQEAgc3RhdGljIHZvaWQgYWlvX3RpbWVybGlzdF9ub3RpZnkodm9pZCAqb3BhcXVlLCBRRU1V
Q2xvY2tUeXBlIHR5cGUpCiAgICAgYWlvX25vdGlmeShvcGFxdWUpOwogfQogCi1zdGF0aWMgdm9p
ZCBhaW9fY29udGV4dF9ub3RpZmllcl9kdW1teV9jYihFdmVudE5vdGlmaWVyICplKQorc3RhdGlj
IHZvaWQgYWlvX2NvbnRleHRfbm90aWZpZXJfY2IoRXZlbnROb3RpZmllciAqZSkKIHsKKyAgICBB
aW9Db250ZXh0ICpjdHggPSBjb250YWluZXJfb2YoZSwgQWlvQ29udGV4dCwgbm90aWZpZXIpOwor
CisgICAgZXZlbnRfbm90aWZpZXJfdGVzdF9hbmRfY2xlYXIoJmN0eC0+bm90aWZpZXIpOwogfQog
CiAvKiBSZXR1cm5zIHRydWUgaWYgYWlvX25vdGlmeSgpIHdhcyBjYWxsZWQgKGUuZy4gYSBCSCB3
YXMgc2NoZWR1bGVkKSAqLwpAQCAtNTA4LDcgKzUxOCw3IEBAIEFpb0NvbnRleHQgKmFpb19jb250
ZXh0X25ldyhFcnJvciAqKmVycnApCiAKICAgICBhaW9fc2V0X2V2ZW50X25vdGlmaWVyKGN0eCwg
JmN0eC0+bm90aWZpZXIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYWxzZSwKLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFpb19jb250ZXh0X25vdGlmaWVyX2R1bW15X2NiLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYWlvX2NvbnRleHRfbm90aWZpZXJfY2IsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhaW9fY29udGV4dF9ub3RpZmllcl9wb2xsKTsKICNpZmRlZiBD
T05GSUdfTElOVVhfQUlPCiAgICAgY3R4LT5saW51eF9haW8gPSBOVUxMOwotLSAKMi4yNi4yCgo=


