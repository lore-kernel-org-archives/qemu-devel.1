Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB5C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80405208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtGR6CAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80405208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0iB-0002cN-Lv
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0fc-0006Ts-Lc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0fb-0000Dc-Iu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0fb-0000DS-Fl
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYqKUmaJke914092shDhJOwoKcdjeHSS5ptesBdfPMI=;
 b=GtGR6CAP7NwfQoOVNrkxwvjHzZ0hmmGXHczvICfriXx4ITuCavkKoIZUnZBjFHmVJcoefh
 F6QQmUK7TsaLM/YbHlVCmKaltacu/kMByDHLYsHZrwUXj3EQ8lo2VvWebdYUa/xGIbxdk3
 7tBWoNJIgPVvFDDz8I2TbLL5WIeOAO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-rRoVyL-vM7yTf0u4DTwryA-1; Wed, 11 Mar 2020 08:41:01 -0400
X-MC-Unique: rRoVyL-vM7yTf0u4DTwryA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB6788010E3;
 Wed, 11 Mar 2020 12:40:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF105C28E;
 Wed, 11 Mar 2020 12:40:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] aio-posix: remove confusing QLIST_SAFE_REMOVE()
Date: Wed, 11 Mar 2020 12:40:38 +0000
Message-Id: <20200311124045.277969-3-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
References: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUxJU1RfU0FGRV9SRU1PVkUoKSBpcyBjb25mdXNpbmcgaGVyZSBiZWNhdXNlIHRoZSBub2RlIG11
c3QgYmUgb24gdGhlCmxpc3QuICBXZSBhY3R1YWxseSBqdXN0IHdhbnRlZCB0byBjbGVhciB0aGUg
bGlua2VkIGxpc3QgcG9pbnRlcnMgd2hlbgpyZW1vdmluZyBpdCBmcm9tIHRoZSBsaXN0LiAgUUxJ
U1RfUkVNT1ZFKCkgbm93IGRvZXMgdGhpcywgc28gc3dpdGNoIHRvCml0LgoKU3VnZ2VzdGVkLWJ5
OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyMDAyMjQxMDM0MDYuMTg5NDkyMy0zLXN0ZWZhbmhhQHJlZGhhdC5jb20KTWVz
c2FnZS1JZDogPDIwMjAwMjI0MTAzNDA2LjE4OTQ5MjMtMy1zdGVmYW5oYUByZWRoYXQuY29tPgot
LS0KIHV0aWwvYWlvLXBvc2l4LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9h
aW8tcG9zaXguYwppbmRleCA5ZTFiZWZjMGMwLi5iMzM5YWFiMTJjIDEwMDY0NAotLS0gYS91dGls
L2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBvc2l4LmMKQEAgLTQ5Myw3ICs0OTMsNyBAQCBz
dGF0aWMgYm9vbCBhaW9fZGlzcGF0Y2hfcmVhZHlfaGFuZGxlcnMoQWlvQ29udGV4dCAqY3R4LAog
ICAgIEFpb0hhbmRsZXIgKm5vZGU7CiAKICAgICB3aGlsZSAoKG5vZGUgPSBRTElTVF9GSVJTVChy
ZWFkeV9saXN0KSkpIHsKLSAgICAgICAgUUxJU1RfU0FGRV9SRU1PVkUobm9kZSwgbm9kZV9yZWFk
eSk7CisgICAgICAgIFFMSVNUX1JFTU9WRShub2RlLCBub2RlX3JlYWR5KTsKICAgICAgICAgcHJv
Z3Jlc3MgPSBhaW9fZGlzcGF0Y2hfaGFuZGxlcihjdHgsIG5vZGUpIHx8IHByb2dyZXNzOwogICAg
IH0KIAotLSAKMi4yNC4xCgo=


