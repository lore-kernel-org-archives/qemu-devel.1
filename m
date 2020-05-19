Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB2D207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBDyAvjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB2D207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxIj-0005gY-CR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxCE-0004Y7-PH
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxCE-0001bZ-1v
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBzccGP4gJPkYq8or5+zdtu/07pnY56MY8L4UJhgkdA=;
 b=YBDyAvjKVMreDHb/jUWG0hqLTeO/mhghM65wyNFXCcKZId4ueR/u1kdRF+PFMiy3EaASVl
 rKIqBW8ZmpSBmS/4ZQpmi19rQWFK02LMqGpXoAyqUGAWOrHkSUsbAqYg9Ro5pWhk9YYN6o
 ZdFkFTW5cDajBfwDt4KCMYV4v9BtXyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-faYzyhcgNVy-2670jXhkhA-1; Tue, 19 May 2020 04:01:48 -0400
X-MC-Unique: faYzyhcgNVy-2670jXhkhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77C29835B40;
 Tue, 19 May 2020 08:01:47 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D346196AE;
 Tue, 19 May 2020 08:01:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] tests/fuzz: Extract ioport_fuzz_qtest() method
Date: Tue, 19 May 2020 09:00:52 +0100
Message-Id: <20200519080054.146495-7-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKRXh0cmFj
dCBnZW5lcmljIGlvcG9ydF9mdXp6X3F0ZXN0KCkgbWV0aG9kIGZyb20KaTQ0MGZ4X2Z1enpfcXRl
c3QoKS4gVGhpcyB3aWxsIGhlbHAgdG8gd3JpdGUgdGVzdHMKbm90IHNwZWNpZmljIHRvIHRoZSBp
NDQwRlggY29udHJvbGxlci4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1MTQxNDM0MzMuMTg1NjktNy1w
aGlsbWRAcmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jIHwgMTEgKysr
KysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jIGIvdGVzdHMvcXRl
c3QvZnV6ei9pNDQwZnhfZnV6ei5jCmluZGV4IDU1OGZhMTdjOTMuLmJjZDY3NjliNGMgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYworKysgYi90ZXN0cy9xdGVzdC9m
dXp6L2k0NDBmeF9mdXp6LmMKQEAgLTM5LDcgKzM5LDcgQEAgZW51bSBhY3Rpb25faWQgewogICAg
IEFDVElPTl9NQVgKIH07CiAKLXN0YXRpYyB2b2lkIGk0NDBmeF9mdXp6X3F0ZXN0KFFUZXN0U3Rh
dGUgKnMsCitzdGF0aWMgdm9pZCBpb3BvcnRfZnV6el9xdGVzdChRVGVzdFN0YXRlICpzLAogICAg
ICAgICBjb25zdCB1bnNpZ25lZCBjaGFyICpEYXRhLCBzaXplX3QgU2l6ZSkgewogICAgIC8qCiAg
ICAgICogbG9vcCBvdmVyIHRoZSBEYXRhLCBicmVha2luZyBpdCB1cCBpbnRvIGFjdGlvbnMuIGVh
Y2ggYWN0aW9uIGhhcyBhbgpAQCAtODQsMTAgKzg0LDE3IEBAIHN0YXRpYyB2b2lkIGk0NDBmeF9m
dXp6X3F0ZXN0KFFUZXN0U3RhdGUgKnMsCiAgICAgZmx1c2hfZXZlbnRzKHMpOwogfQogCitzdGF0
aWMgdm9pZCBpNDQwZnhfZnV6el9xdGVzdChRVGVzdFN0YXRlICpzLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uc3QgdW5zaWduZWQgY2hhciAqRGF0YSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNpemVfdCBTaXplKQoreworICAgIGlvcG9ydF9mdXp6X3F0ZXN0KHMs
IERhdGEsIFNpemUpOworfQorCiBzdGF0aWMgdm9pZCBwY2ljb25maWdfZnV6el9xb3MoUVRlc3RT
dGF0ZSAqcywgUVBDSUJ1cyAqYnVzLAogICAgICAgICBjb25zdCB1bnNpZ25lZCBjaGFyICpEYXRh
LCBzaXplX3QgU2l6ZSkgewogICAgIC8qCi0gICAgICogU2FtZSBhcyBpNDQwZnhfZnV6el9xdGVz
dCwgYnV0IHVzaW5nIFFPUy4gZGV2Zm4gaXMgaW5jb3Jwb3JhdGVkIGludG8gdGhlCisgICAgICog
U2FtZSBhcyBpb3BvcnRfZnV6el9xdGVzdCwgYnV0IHVzaW5nIFFPUy4gZGV2Zm4gaXMgaW5jb3Jw
b3JhdGVkIGludG8gdGhlCiAgICAgICogdmFsdWUgd3JpdHRlbiBvdmVyIFBvcnQgSU8KICAgICAg
Ki8KICAgICBzdHJ1Y3QgewotLSAKMi4yNS4zCgo=


