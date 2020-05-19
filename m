Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B072FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395E3207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2MYAbuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395E3207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxJl-0006mU-6r
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxCO-0004tb-2k
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:02:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57600
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxCN-0001dQ-AT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZQYqyJDDytFdKeDX7BQ9v3ONr1NxDeFstGIXsm97BM=;
 b=i2MYAbuLrCCXzvTzQMpD1d0HYblXV67E0NVATMsKalmFaodg7RY8jO9Nf7L7TOPsSvle3c
 2Cj0NCokiKt+p65ScwtFQpiRtWNWxL2lPs8/jj/PeL2HRpd/sXEw8Bd7CCrkeRgoLTAtj3
 hlqo4w9As02XvVY0eXSdh6vtGwYZR5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-fe2EQ68gMEqbGoCrk9eriw-1; Tue, 19 May 2020 04:01:58 -0400
X-MC-Unique: fe2EQ68gMEqbGoCrk9eriw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43502107ACCA;
 Tue, 19 May 2020 08:01:57 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18B7A79581;
 Tue, 19 May 2020 08:01:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] aio-posix: don't duplicate fd handler deletion in
 fdmon_io_uring_destroy()
Date: Tue, 19 May 2020 09:00:53 +0100
Message-Id: <20200519080054.146495-8-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 qemu-block@nongnu.org, Oleksandr Natalenko <oleksandr@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGlvX3VyaW5nIGZpbGUgZGVzY3JpcHRvciBtb25pdG9yaW5nIGltcGxlbWVudGF0aW9uIGhh
cyBhbiBpbnRlcm5hbApsaXN0IG9mIGZkIGhhbmRsZXJzIHRoYXQgYXJlIHBlbmRpbmcgc3VibWlz
c2lvbiB0byBpb191cmluZy4KZmRtb25faW9fdXJpbmdfZGVzdHJveSgpIGRlbGV0ZXMgYWxsIGZk
IGhhbmRsZXJzIG9uIHRoZSBsaXN0LgoKRG9uJ3QgZGVsZXRlIGZkIGhhbmRsZXJzIGRpcmVjdGx5
IGluIGZkbW9uX2lvX3VyaW5nX2Rlc3Ryb3koKSBmb3IgdHdvCnJlYXNvbnM6CjEuIFRoaXMgZHVw
bGljYXRlcyB0aGUgYWlvLXBvc2l4LmMgQWlvSGFuZGxlciBkZWxldGlvbiBjb2RlIGFuZCBjb3Vs
ZAogICBiZWNvbWUgb3V0ZGF0ZWQgaWYgdGhlIHN0cnVjdCBjaGFuZ2VzLgoyLiBPbmx5IGhhbmRs
ZXJzIHdpdGggdGhlIEZETU9OX0lPX1VSSU5HX1JFTU9WRSBmbGFnIHNldCBhcmUgc2FmZSB0bwog
ICByZW1vdmUuIElmIHRoZSBmbGFnIGlzIG5vdCBzZXQgdGhlbiBzb21ldGhpbmcgc3RpbGwgaGFz
IGEgcG9pbnRlciB0bwogICB0aGUgZmQgaGFuZGxlci4gTGV0IGFpby1wb3NpeC5jIGFuZCBpdHMg
dXNlciB3b3JyeSBhYm91dCB0aGF0LiBJbgogICBwcmFjdGljZSB0aGlzIGlzbid0IGFuIGlzc3Vl
IGJlY2F1c2UgZmRtb25faW9fdXJpbmdfZGVzdHJveSgpIGlzIG9ubHkKICAgY2FsbGVkIHdoZW4g
c2h1dHRpbmcgZG93biBzbyBhbGwgdXNlcnMgaGF2ZSByZW1vdmVkIHRoZWlyIGZkCiAgIGhhbmRs
ZXJzLCBidXQgdGhlIG5leHQgcGF0Y2ggd2lsbCBuZWVkIHRoaXMhCgpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogT2xla3NhbmRy
IE5hdGFsZW5rbyA8b2xla3NhbmRyQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwNTExMTgz
NjMwLjI3OTc1MC0yLXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhh
am5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgICAgICB8
ICAxICsKIHV0aWwvZmRtb24taW9fdXJpbmcuYyB8IDEzICsrKysrKysrKystLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91
dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRleCBjMzYxM2QyOTllLi44YWYz
MzRhYjE5IDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBvc2l4
LmMKQEAgLTY3OSw2ICs2NzksNyBAQCB2b2lkIGFpb19jb250ZXh0X2Rlc3Ryb3koQWlvQ29udGV4
dCAqY3R4KQogewogICAgIGZkbW9uX2lvX3VyaW5nX2Rlc3Ryb3koY3R4KTsKICAgICBmZG1vbl9l
cG9sbF9kaXNhYmxlKGN0eCk7CisgICAgYWlvX2ZyZWVfZGVsZXRlZF9oYW5kbGVycyhjdHgpOwog
fQogCiB2b2lkIGFpb19jb250ZXh0X3NldF9wb2xsX3BhcmFtcyhBaW9Db250ZXh0ICpjdHgsIGlu
dDY0X3QgbWF4X25zLApkaWZmIC0tZ2l0IGEvdXRpbC9mZG1vbi1pb191cmluZy5jIGIvdXRpbC9m
ZG1vbi1pb191cmluZy5jCmluZGV4IGQ1YTgwZWQ2ZmIuLjFkMTQxNzdkZjAgMTAwNjQ0Ci0tLSBh
L3V0aWwvZmRtb24taW9fdXJpbmcuYworKysgYi91dGlsL2ZkbW9uLWlvX3VyaW5nLmMKQEAgLTM0
MiwxMSArMzQyLDE4IEBAIHZvaWQgZmRtb25faW9fdXJpbmdfZGVzdHJveShBaW9Db250ZXh0ICpj
dHgpCiAKICAgICAgICAgaW9fdXJpbmdfcXVldWVfZXhpdCgmY3R4LT5mZG1vbl9pb191cmluZyk7
CiAKLSAgICAgICAgLyogTm8gbmVlZCB0byBzdWJtaXQgdGhlc2UgYW55bW9yZSwganVzdCBmcmVl
IHRoZW0uICovCisgICAgICAgIC8qIE1vdmUgaGFuZGxlcnMgZHVlIHRvIGJlIHJlbW92ZWQgb250
byB0aGUgZGVsZXRlZCBsaXN0ICovCiAgICAgICAgIHdoaWxlICgobm9kZSA9IFFTTElTVF9GSVJT
VF9SQ1UoJmN0eC0+c3VibWl0X2xpc3QpKSkgeworICAgICAgICAgICAgdW5zaWduZWQgZmxhZ3Mg
PSBhdG9taWNfZmV0Y2hfYW5kKCZub2RlLT5mbGFncywKKyAgICAgICAgICAgICAgICAgICAgfihG
RE1PTl9JT19VUklOR19QRU5ESU5HIHwKKyAgICAgICAgICAgICAgICAgICAgICBGRE1PTl9JT19V
UklOR19BREQgfAorICAgICAgICAgICAgICAgICAgICAgIEZETU9OX0lPX1VSSU5HX1JFTU9WRSkp
OworCisgICAgICAgICAgICBpZiAoZmxhZ3MgJiBGRE1PTl9JT19VUklOR19SRU1PVkUpIHsKKyAg
ICAgICAgICAgICAgICBRTElTVF9JTlNFUlRfSEVBRF9SQ1UoJmN0eC0+ZGVsZXRlZF9haW9faGFu
ZGxlcnMsIG5vZGUsIG5vZGVfZGVsZXRlZCk7CisgICAgICAgICAgICB9CisKICAgICAgICAgICAg
IFFTTElTVF9SRU1PVkVfSEVBRF9SQ1UoJmN0eC0+c3VibWl0X2xpc3QsIG5vZGVfc3VibWl0dGVk
KTsKLSAgICAgICAgICAgIFFMSVNUX1JFTU9WRShub2RlLCBub2RlKTsKLSAgICAgICAgICAgIGdf
ZnJlZShub2RlKTsKICAgICAgICAgfQogCiAgICAgICAgIGN0eC0+ZmRtb25fb3BzID0gJmZkbW9u
X3BvbGxfb3BzOwotLSAKMi4yNS4zCgo=


