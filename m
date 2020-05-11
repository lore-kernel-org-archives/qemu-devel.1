Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A994C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EE6206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuNTUnWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EE6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDKA-00032Q-9s
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYDIK-0007ae-W5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:36:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYDIK-0005Cd-1B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589222211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhOQI+A1nf+HXVI8yeJRo+ww5eOdXYoY9cww+n33/4o=;
 b=DuNTUnWz9+a6zWQeqxqa9HNOLnlXCcNVXfLVp1fVRj8AussDKqK4g3KGbMdUebgOzlWf32
 5Z9h8ys5pJQplkMM1QhZApqOpmXNGnZKtzHhZiERbimmAonJ5piCbUCYQiUk9zaOjPOvRK
 mtP+DbNBiKQE46WEpDlw1wWXoKJKAo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-QDKD1pNXPOu3p7z4gVJmjw-1; Mon, 11 May 2020 14:36:47 -0400
X-MC-Unique: QDKD1pNXPOu3p7z4gVJmjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 365EE19057AA;
 Mon, 11 May 2020 18:36:46 +0000 (UTC)
Received: from localhost (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A79F5C1B5;
 Mon, 11 May 2020 18:36:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] aio-posix: disable fdmon-io_uring when GSource is used
Date: Mon, 11 May 2020 19:36:30 +0100
Message-Id: <20200511183630.279750-3-stefanha@redhat.com>
In-Reply-To: <20200511183630.279750-1-stefanha@redhat.com>
References: <20200511183630.279750-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGdsaWIgZXZlbnQgbG9vcCBkb2VzIG5vdCBjYWxsIGZkbW9uX2lvX3VyaW5nX3dhaXQoKSBz
byBmZCBoYW5kbGVycwp3YWl0aW5nIHRvIGJlIHN1Ym1pdHRlZCBidWlsZCB1cCBpbiB0aGUgbGlz
dC4gVGhlcmUgaXMgbm8gYmVuZWZpdCBpcwp1c2luZyBpb191cmluZyB3aGVuIHRoZSBnbGliIEdT
b3VyY2UgaXMgYmVpbmcgdXNlZCwgc28gZGlzYWJsZSBpdAppbnN0ZWFkIG9mIGltcGxlbWVudGlu
ZyBhIG1vcmUgY29tcGxleCBmaXguCgpUaGlzIGZpeGVzIGEgbWVtb3J5IGxlYWsgd2hlcmUgQWlv
SGFuZGxlcnMgd291bGQgYnVpbGQgdXAgYW5kIGluY3JlYXNpbmcKYW1vdW50cyBvZiBDUFUgdGlt
ZSB3ZXJlIHNwZW50IGl0ZXJhdGluZyB0aGVtIGluIGFpb19wZW5kaW5nKCkuIFRoZQpzeW1wdG9t
IGlzIHRoYXQgZ3Vlc3RzIGJlY29tZSBzbG93IHdoZW4gUUVNVSBpcyBidWlsdCB3aXRoIGlvX3Vy
aW5nCnN1cHBvcnQuCgpCdWdsaW5rOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9xZW11Lyti
dWcvMTg3NzcxNgpGaXhlczogNzNmZDI4MmU3YjZkZDRlNGVhMWMzYmJiM2QzMDJjOGRiNTFlNGNj
ZiAoImFpby1wb3NpeDogYWRkIGlvX3VyaW5nIGZkIG1vbml0b3JpbmcgaW1wbGVtZW50YXRpb24i
KQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0t
LQogaW5jbHVkZS9ibG9jay9haW8uaCB8ICAzICsrKwogdXRpbC9haW8tcG9zaXguYyAgICB8IDEy
ICsrKysrKysrKysrKwogdXRpbC9haW8td2luMzIuYyAgICB8ICA0ICsrKysKIHV0aWwvYXN5bmMu
YyAgICAgICAgfCAgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Fpby5oIGIvaW5jbHVkZS9ibG9jay9haW8uaAppbmRleCA2
MmVkOTU0MzQ0Li5iMmY3MDNmYTNmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Fpby5oCisr
KyBiL2luY2x1ZGUvYmxvY2svYWlvLmgKQEAgLTcwMSw2ICs3MDEsOSBAQCB2b2lkIGFpb19jb250
ZXh0X3NldHVwKEFpb0NvbnRleHQgKmN0eCk7CiAgKi8KIHZvaWQgYWlvX2NvbnRleHRfZGVzdHJv
eShBaW9Db250ZXh0ICpjdHgpOwogCisvKiBVc2VkIGludGVybmFsbHksIGRvIG5vdCBjYWxsIG91
dHNpZGUgQWlvQ29udGV4dCBjb2RlICovCit2b2lkIGFpb19jb250ZXh0X3VzZV9nX3NvdXJjZShB
aW9Db250ZXh0ICpjdHgpOworCiAvKioKICAqIGFpb19jb250ZXh0X3NldF9wb2xsX3BhcmFtczoK
ICAqIEBjdHg6IHRoZSBhaW8gY29udGV4dApkaWZmIC0tZ2l0IGEvdXRpbC9haW8tcG9zaXguYyBi
L3V0aWwvYWlvLXBvc2l4LmMKaW5kZXggOGFmMzM0YWIxOS4uMWIyYTNhZjY1YiAxMDA2NDQKLS0t
IGEvdXRpbC9haW8tcG9zaXguYworKysgYi91dGlsL2Fpby1wb3NpeC5jCkBAIC02ODIsNiArNjgy
LDE4IEBAIHZvaWQgYWlvX2NvbnRleHRfZGVzdHJveShBaW9Db250ZXh0ICpjdHgpCiAgICAgYWlv
X2ZyZWVfZGVsZXRlZF9oYW5kbGVycyhjdHgpOwogfQogCit2b2lkIGFpb19jb250ZXh0X3VzZV9n
X3NvdXJjZShBaW9Db250ZXh0ICpjdHgpCit7CisgICAgLyoKKyAgICAgKiBEaXNhYmxlIGlvX3Vy
aW5nIHdoZW4gdGhlIGdsaWIgbWFpbiBsb29wIGlzIHVzZWQgYmVjYXVzZSBpdCBkb2Vzbid0Cisg
ICAgICogc3VwcG9ydCBtaXhlZCBnbGliL2Fpb19wb2xsKCkgdXNhZ2UuIEl0IHJlbGllcyBvbiBh
aW9fcG9sbCgpIGJlaW5nCisgICAgICogY2FsbGVkIHJlZ3VsYXJseSBzbyB0aGF0IGNoYW5nZXMg
dG8gdGhlIG1vbml0b3JlZCBmaWxlIGRlc2NyaXB0b3JzIGFyZQorICAgICAqIHN1Ym1pdHRlZCwg
b3RoZXJ3aXNlIGEgbGlzdCBvZiBwZW5kaW5nIGZkIGhhbmRsZXJzIGJ1aWxkcyB1cC4KKyAgICAg
Ki8KKyAgICBmZG1vbl9pb191cmluZ19kZXN0cm95KGN0eCk7CisgICAgYWlvX2ZyZWVfZGVsZXRl
ZF9oYW5kbGVycyhjdHgpOworfQorCiB2b2lkIGFpb19jb250ZXh0X3NldF9wb2xsX3BhcmFtcyhB
aW9Db250ZXh0ICpjdHgsIGludDY0X3QgbWF4X25zLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50NjRfdCBncm93LCBpbnQ2NF90IHNocmluaywgRXJyb3IgKiplcnJwKQogewpk
aWZmIC0tZ2l0IGEvdXRpbC9haW8td2luMzIuYyBiL3V0aWwvYWlvLXdpbjMyLmMKaW5kZXggNzI5
ZDUzM2ZhZi4uOTUzYzU2YWI0OCAxMDA2NDQKLS0tIGEvdXRpbC9haW8td2luMzIuYworKysgYi91
dGlsL2Fpby13aW4zMi5jCkBAIC00MTQsNiArNDE0LDEwIEBAIHZvaWQgYWlvX2NvbnRleHRfZGVz
dHJveShBaW9Db250ZXh0ICpjdHgpCiB7CiB9CiAKK3ZvaWQgYWlvX2NvbnRleHRfdXNlX2dfc291
cmNlKEFpb0NvbnRleHQgKmN0eCkKK3sKK30KKwogdm9pZCBhaW9fY29udGV4dF9zZXRfcG9sbF9w
YXJhbXMoQWlvQ29udGV4dCAqY3R4LCBpbnQ2NF90IG1heF9ucywKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludDY0X3QgZ3JvdywgaW50NjRfdCBzaHJpbmssIEVycm9yICoqZXJy
cCkKIHsKZGlmZiAtLWdpdCBhL3V0aWwvYXN5bmMuYyBiL3V0aWwvYXN5bmMuYwppbmRleCAzMTY1
YTI4ZjJmLi4xMzE5ZWVlM2JjIDEwMDY0NAotLS0gYS91dGlsL2FzeW5jLmMKKysrIGIvdXRpbC9h
c3luYy5jCkBAIC0zNjIsNiArMzYyLDcgQEAgc3RhdGljIEdTb3VyY2VGdW5jcyBhaW9fc291cmNl
X2Z1bmNzID0gewogCiBHU291cmNlICphaW9fZ2V0X2dfc291cmNlKEFpb0NvbnRleHQgKmN0eCkK
IHsKKyAgICBhaW9fY29udGV4dF91c2VfZ19zb3VyY2UoY3R4KTsKICAgICBnX3NvdXJjZV9yZWYo
JmN0eC0+c291cmNlKTsKICAgICByZXR1cm4gJmN0eC0+c291cmNlOwogfQotLSAKMi4yNS4zCgo=


