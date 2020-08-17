Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE12220888
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KklYrGTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE12220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hTX-00028o-TO
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsV-00082Q-DE
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsT-0003gh-1t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/DMxhuW673wXqaX8j5SE6+b3fbmzq8390hPvudVd3I=;
 b=KklYrGTs0tMMw1ZutzmhnbJN1t3dfI4psCT9lzgogCm5ykk7jwt3fKSazQ2MnGIsCt/pxO
 xB1Qm6usiWhF5Q3h9wRNLsUHC7AJ78KSg5kJJHc4fCCqZmZkXN8KGXd6ELU6pQn3dxPzlU
 IwB8Lv/T/hQVG0nq+sFCY+T6SSBf0C8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-_pNKUhz4P5mF_LUV4ucdJw-1; Mon, 17 Aug 2020 11:16:45 -0400
X-MC-Unique: _pNKUhz4P5mF_LUV4ucdJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E16F1DDEE;
 Mon, 17 Aug 2020 15:16:44 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEA757A21D;
 Mon, 17 Aug 2020 15:16:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] async: rename event_notifier_dummy_cb/poll()
Date: Mon, 17 Aug 2020 16:16:32 +0100
Message-Id: <20200817151634.35563-2-stefanha@redhat.com>
In-Reply-To: <20200817151634.35563-1-stefanha@redhat.com>
References: <20200817151634.35563-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGV2ZW50X25vdGlmaWVyXyooKSBwcmVmaXggY2FuIGJlIGNvbmZ1c2VkIHdpdGggdGhlIEV2
ZW50Tm90aWZpZXIKQVBJcyB0aGF0IGFyZSBhbHNvIGNhbGxlZCBldmVudF9ub3RpZmllcl8qKCku
CgpSZW5hbWUgdGhlIGZ1bmN0aW9ucyB0byBhaW9fY29udGV4dF9ub3RpZmllcl8qKCkgdG8gbWFr
ZSBpdCBjbGVhciB0aGF0CnRoZXkgcmVsYXRlIHRvIHRoZSBBaW9Db250ZXh0Ojpub3RpZmllciBm
aWVsZC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNv
bT4KUmV2aWV3ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ck1lc3Nh
Z2UtaWQ6IDIwMjAwODA2MTMxODAyLjU2OTQ3OC0yLXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwv
YXN5bmMuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9hc3luYy5jIGIvdXRpbC9hc3luYy5jCmlu
ZGV4IDEzMTllZWUzYmMuLmQ5Zjk4N2UxMzMgMTAwNjQ0Ci0tLSBhL3V0aWwvYXN5bmMuYworKysg
Yi91dGlsL2FzeW5jLmMKQEAgLTQ0NSwxMiArNDQ1LDEyIEBAIHN0YXRpYyB2b2lkIGFpb190aW1l
cmxpc3Rfbm90aWZ5KHZvaWQgKm9wYXF1ZSwgUUVNVUNsb2NrVHlwZSB0eXBlKQogICAgIGFpb19u
b3RpZnkob3BhcXVlKTsKIH0KIAotc3RhdGljIHZvaWQgZXZlbnRfbm90aWZpZXJfZHVtbXlfY2Io
RXZlbnROb3RpZmllciAqZSkKK3N0YXRpYyB2b2lkIGFpb19jb250ZXh0X25vdGlmaWVyX2R1bW15
X2NiKEV2ZW50Tm90aWZpZXIgKmUpCiB7CiB9CiAKIC8qIFJldHVybnMgdHJ1ZSBpZiBhaW9fbm90
aWZ5KCkgd2FzIGNhbGxlZCAoZS5nLiBhIEJIIHdhcyBzY2hlZHVsZWQpICovCi1zdGF0aWMgYm9v
bCBldmVudF9ub3RpZmllcl9wb2xsKHZvaWQgKm9wYXF1ZSkKK3N0YXRpYyBib29sIGFpb19jb250
ZXh0X25vdGlmaWVyX3BvbGwodm9pZCAqb3BhcXVlKQogewogICAgIEV2ZW50Tm90aWZpZXIgKmUg
PSBvcGFxdWU7CiAgICAgQWlvQ29udGV4dCAqY3R4ID0gY29udGFpbmVyX29mKGUsIEFpb0NvbnRl
eHQsIG5vdGlmaWVyKTsKQEAgLTUwOCw4ICs1MDgsOCBAQCBBaW9Db250ZXh0ICphaW9fY29udGV4
dF9uZXcoRXJyb3IgKiplcnJwKQogCiAgICAgYWlvX3NldF9ldmVudF9ub3RpZmllcihjdHgsICZj
dHgtPm5vdGlmaWVyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFsc2UsCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgICBldmVudF9ub3RpZmllcl9kdW1teV9jYiwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGV2ZW50X25vdGlmaWVyX3BvbGwpOworICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYWlvX2NvbnRleHRfbm90aWZpZXJfZHVtbXlfY2IsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhaW9fY29udGV4dF9ub3RpZmllcl9wb2xsKTsKICNpZmRlZiBDT05GSUdfTElO
VVhfQUlPCiAgICAgY3R4LT5saW51eF9haW8gPSBOVUxMOwogI2VuZGlmCi0tIAoyLjI2LjIKCg==


