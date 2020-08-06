Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65992313B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/PobuC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65992313B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fnq-0007L5-UY
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3fmp-0005qG-FT
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:18:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3fmn-0000VP-QI
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596719900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4PwkMGshFxmi68nIF7KUnKd3VjQJQcBJWUnXo9qyuk=;
 b=d/PobuC8Is5fw9kSOaeO7pSiGv2/8iluw052hCEm9lyZiHTtFYf0+VnQx3HsVHNO7FzGcN
 0vrt6MzA7aXuZjSw8SdcSJ54TWfeGncYNIdCKuBRNb4IqexM+CYscM44/+55lxytiROWEw
 vXO77VVl8uYDF0K8HL4cOdjIJdhRs4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-gfVQr0v9MTGuKr1ICIxyzg-1; Thu, 06 Aug 2020 09:18:18 -0400
X-MC-Unique: gfVQr0v9MTGuKr1ICIxyzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97EC479EC1;
 Thu,  6 Aug 2020 13:18:17 +0000 (UTC)
Received: from localhost (ovpn-114-7.ams2.redhat.com [10.36.114.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD8605F1EF;
 Thu,  6 Aug 2020 13:18:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] async: always set ctx->notified in aio_notify()
Date: Thu,  6 Aug 2020 14:18:01 +0100
Message-Id: <20200806131802.569478-3-stefanha@redhat.com>
In-Reply-To: <20200806131802.569478-1-stefanha@redhat.com>
References: <20200806131802.569478-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
bG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL2FzeW5jLmMgfCAzMiAr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvYXN5bmMuYyBiL3V0
aWwvYXN5bmMuYwppbmRleCBkOWY5ODdlMTMzLi45OWUxNTY0NGQ5IDEwMDY0NAotLS0gYS91dGls
L2FzeW5jLmMKKysrIGIvdXRpbC9hc3luYy5jCkBAIC00MTksMjUgKzQxOSwzMiBAQCBMdXJpbmdT
dGF0ZSAqYWlvX2dldF9saW51eF9pb191cmluZyhBaW9Db250ZXh0ICpjdHgpCiAKIHZvaWQgYWlv
X25vdGlmeShBaW9Db250ZXh0ICpjdHgpCiB7Ci0gICAgLyogV3JpdGUgZS5nLiBiaC0+c2NoZWR1
bGVkIGJlZm9yZSByZWFkaW5nIGN0eC0+bm90aWZ5X21lLiAgUGFpcnMKKyAgICAvKgorICAgICAq
IFdyaXRlIGUuZy4gYmgtPmZsYWdzIGJlZm9yZSB3cml0aW5nIGN0eC0+bm90aWZpZWQuICBQYWly
cyB3aXRoIHNtcF9tYiBpbgorICAgICAqIGFpb19ub3RpZnlfYWNjZXB0LgorICAgICAqLworICAg
IHNtcF93bWIoKTsKKyAgICBhdG9taWNfc2V0KCZjdHgtPm5vdGlmaWVkLCB0cnVlKTsKKworICAg
IC8qCisgICAgICogV3JpdGUgY3R4LT5ub3RpZmllZCBiZWZvcmUgcmVhZGluZyBjdHgtPm5vdGlm
eV9tZS4gIFBhaXJzCiAgICAgICogd2l0aCBzbXBfbWIgaW4gYWlvX2N0eF9wcmVwYXJlIG9yIGFp
b19wb2xsLgogICAgICAqLwogICAgIHNtcF9tYigpOwogICAgIGlmIChhdG9taWNfcmVhZCgmY3R4
LT5ub3RpZnlfbWUpKSB7CiAgICAgICAgIGV2ZW50X25vdGlmaWVyX3NldCgmY3R4LT5ub3RpZmll
cik7Ci0gICAgICAgIGF0b21pY19tYl9zZXQoJmN0eC0+bm90aWZpZWQsIHRydWUpOwogICAgIH0K
IH0KIAogdm9pZCBhaW9fbm90aWZ5X2FjY2VwdChBaW9Db250ZXh0ICpjdHgpCiB7Ci0gICAgaWYg
KGF0b21pY194Y2hnKCZjdHgtPm5vdGlmaWVkLCBmYWxzZSkKLSNpZmRlZiBXSU4zMgotICAgICAg
ICB8fCB0cnVlCi0jZW5kaWYKLSAgICApIHsKLSAgICAgICAgZXZlbnRfbm90aWZpZXJfdGVzdF9h
bmRfY2xlYXIoJmN0eC0+bm90aWZpZXIpOwotICAgIH0KKyAgICBhdG9taWNfc2V0KCZjdHgtPm5v
dGlmaWVkLCBmYWxzZSk7CisKKyAgICAvKgorICAgICAqIFdyaXRlIGN0eC0+bm90aWZpZWQgYmVm
b3JlIHJlYWRpbmcgZS5nLiBiaC0+ZmxhZ3MuICBQYWlycyB3aXRoIHNtcF9tYiBpbgorICAgICAq
IGFpb19ub3RpZnkuCisgICAgICovCisgICAgc21wX3dtYigpOwogfQogCiBzdGF0aWMgdm9pZCBh
aW9fdGltZXJsaXN0X25vdGlmeSh2b2lkICpvcGFxdWUsIFFFTVVDbG9ja1R5cGUgdHlwZSkKQEAg
LTQ0NSw4ICs0NTIsMTEgQEAgc3RhdGljIHZvaWQgYWlvX3RpbWVybGlzdF9ub3RpZnkodm9pZCAq
b3BhcXVlLCBRRU1VQ2xvY2tUeXBlIHR5cGUpCiAgICAgYWlvX25vdGlmeShvcGFxdWUpOwogfQog
Ci1zdGF0aWMgdm9pZCBhaW9fY29udGV4dF9ub3RpZmllcl9kdW1teV9jYihFdmVudE5vdGlmaWVy
ICplKQorc3RhdGljIHZvaWQgYWlvX2NvbnRleHRfbm90aWZpZXJfY2IoRXZlbnROb3RpZmllciAq
ZSkKIHsKKyAgICBBaW9Db250ZXh0ICpjdHggPSBjb250YWluZXJfb2YoZSwgQWlvQ29udGV4dCwg
bm90aWZpZXIpOworCisgICAgZXZlbnRfbm90aWZpZXJfdGVzdF9hbmRfY2xlYXIoJmN0eC0+bm90
aWZpZXIpOwogfQogCiAvKiBSZXR1cm5zIHRydWUgaWYgYWlvX25vdGlmeSgpIHdhcyBjYWxsZWQg
KGUuZy4gYSBCSCB3YXMgc2NoZWR1bGVkKSAqLwpAQCAtNTA4LDcgKzUxOCw3IEBAIEFpb0NvbnRl
eHQgKmFpb19jb250ZXh0X25ldyhFcnJvciAqKmVycnApCiAKICAgICBhaW9fc2V0X2V2ZW50X25v
dGlmaWVyKGN0eCwgJmN0eC0+bm90aWZpZXIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBm
YWxzZSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgIGFpb19jb250ZXh0X25vdGlmaWVyX2R1
bW15X2NiLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgYWlvX2NvbnRleHRfbm90aWZpZXJf
Y2IsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBhaW9fY29udGV4dF9ub3RpZmllcl9wb2xs
KTsKICNpZmRlZiBDT05GSUdfTElOVVhfQUlPCiAgICAgY3R4LT5saW51eF9haW8gPSBOVUxMOwot
LSAKMi4yNi4yCgo=


