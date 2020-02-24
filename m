Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84175C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBE920828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqDISD8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBE920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6B5m-0002kI-IR
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j6B4D-0000TC-6t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j6B4C-0007m0-8A
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j6B4C-0007lm-4z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582540463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUBsFZa5Km+NRvGWPPSzT5mjOSKWnAkAeFx7tI26nEM=;
 b=SqDISD8TzS5fRtFNjTqZ6+J1J42CGArYSMPJgISN3PYjXxbjk1j1EjSnw+NQ0cLoam3oBf
 0+27XdAuYnvPTA7syc5AKMX0lNSvqHomH8WADPGmBvXXIUn8Y7X2PS8b7wKWEfT/SZViHF
 x/fM5qj90wdnIxFmtvrQexns/SVPwJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-FXvQdUtIOuian3xrOq9dCQ-1; Mon, 24 Feb 2020 05:34:21 -0500
X-MC-Unique: FXvQdUtIOuian3xrOq9dCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CAB7800D5B;
 Mon, 24 Feb 2020 10:34:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CA8B91851;
 Mon, 24 Feb 2020 10:34:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] aio-posix: remove confusing QLIST_SAFE_REMOVE()
Date: Mon, 24 Feb 2020 10:34:06 +0000
Message-Id: <20200224103406.1894923-3-stefanha@redhat.com>
In-Reply-To: <20200224103406.1894923-1-stefanha@redhat.com>
References: <20200224103406.1894923-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

UUxJU1RfU0FGRV9SRU1PVkUoKSBpcyBjb25mdXNpbmcgaGVyZSBiZWNhdXNlIHRoZSBub2RlIG11
c3QgYmUgb24gdGhlCmxpc3QuICBXZSBhY3R1YWxseSBqdXN0IHdhbnRlZCB0byBjbGVhciB0aGUg
bGlua2VkIGxpc3QgcG9pbnRlcnMgd2hlbgpyZW1vdmluZyBpdCBmcm9tIHRoZSBsaXN0LiAgUUxJ
U1RfUkVNT1ZFKCkgbm93IGRvZXMgdGhpcywgc28gc3dpdGNoIHRvCml0LgoKU3VnZ2VzdGVkLWJ5
OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9haW8tcG9zaXguYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IDdlNmM5
ODM1YmIuLjAyNmMxZjUyODYgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRp
bC9haW8tcG9zaXguYwpAQCAtNDkzLDcgKzQ5Myw3IEBAIHN0YXRpYyBib29sIGFpb19kaXNwYXRj
aF9yZWFkeV9oYW5kbGVycyhBaW9Db250ZXh0ICpjdHgsCiAgICAgQWlvSGFuZGxlciAqbm9kZTsK
IAogICAgIHdoaWxlICgobm9kZSA9IFFMSVNUX0ZJUlNUKHJlYWR5X2xpc3QpKSkgewotICAgICAg
ICBRTElTVF9TQUZFX1JFTU9WRShub2RlLCBub2RlX3JlYWR5KTsKKyAgICAgICAgUUxJU1RfUkVN
T1ZFKG5vZGUsIG5vZGVfcmVhZHkpOwogICAgICAgICBwcm9ncmVzcyA9IGFpb19kaXNwYXRjaF9o
YW5kbGVyKGN0eCwgbm9kZSkgfHwgcHJvZ3Jlc3M7CiAgICAgfQogCi0tIAoyLjI0LjEKCg==


