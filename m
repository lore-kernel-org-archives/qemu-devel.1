Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE7C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002C920838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFkgq7k0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002C920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2wM-00005Q-Ug
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2a2-0005Mc-QP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2a0-0004JA-Ht
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7bm674skGiXTOIOUgCjRtaAQ5TwmqJJ5o5uOKPqBfo=;
 b=NFkgq7k0dO3xi6THIeAKXljP1CuQZs8ITBCe1vSGO1GAIcMeFeZ8rEgrFnc8o2aO88q0Pv
 8V1HMZL5FLvZzW6B459rLVfTiFqLHbXyskchZpjf+3oFRGxkcI+UfS+ESdpI09bw2McRwc
 vw+KzZseMEij6E+xeJG8w+5Lk5bHEyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-TKBAn-cyMvCA62Wz3loA-g-1; Mon, 12 Oct 2020 14:29:49 -0400
X-MC-Unique: TKBAn-cyMvCA62Wz3loA-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59A171062720;
 Mon, 12 Oct 2020 18:29:47 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E72816198C;
 Mon, 12 Oct 2020 18:29:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 28/30] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Mon, 12 Oct 2020 19:27:58 +0100
Message-Id: <20201012182800.157697-29-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKV2UgYXJlIGdvaW5nIHRvIHJldXNlIGJkcnZfY29tbW9uX2Jsb2NrX3N0YXR1c19hYm92
ZSBpbgpiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZS4gYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUgbWF5
IGJlIGNhbGxlZCB3aXRoCmluY2x1ZGVfYmFzZSA9PSBmYWxzZSBhbmQgc3RpbGwgYnMgPT0gYmFz
ZSAoZm9yIGV4LiBmcm9tIGltZ19yZWJhc2UoKSkuCgpTbywgc3VwcG9ydCB0aGlzIGNvcm5lciBj
YXNlLgoKU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tPgpSZXZpZXdlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0
LmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAw
OTI0MTk0MDAzLjIyMDgwLTQtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tClNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9pby5jIHwg
NiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9ibG9jay9pby5jIGIvYmxvY2svaW8uYwppbmRleCA4NmY3NmQwNGJmLi5i
NjE2YmM0YWRhIDEwMDY0NAotLS0gYS9ibG9jay9pby5jCisrKyBiL2Jsb2NrL2lvLmMKQEAgLTIz
NTUsOSArMjM1NSwxMyBAQCBiZHJ2X2NvX2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmUoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsCiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqcDsKICAgICBpbnQ2NF90IGVv
ZiA9IDA7CiAKLSAgICBhc3NlcnQoaW5jbHVkZV9iYXNlIHx8IGJzICE9IGJhc2UpOwogICAgIGFz
c2VydCghaW5jbHVkZV9iYXNlIHx8IGJhc2UpOyAvKiBDYW4ndCBpbmNsdWRlIE5VTEwgYmFzZSAq
LwogCisgICAgaWYgKCFpbmNsdWRlX2Jhc2UgJiYgYnMgPT0gYmFzZSkgeworICAgICAgICAqcG51
bSA9IGJ5dGVzOworICAgICAgICByZXR1cm4gMDsKKyAgICB9CisKICAgICByZXQgPSBiZHJ2X2Nv
X2Jsb2NrX3N0YXR1cyhicywgd2FudF96ZXJvLCBvZmZzZXQsIGJ5dGVzLCBwbnVtLCBtYXAsIGZp
bGUpOwogICAgIGlmIChyZXQgPCAwIHx8ICpwbnVtID09IDAgfHwgcmV0ICYgQkRSVl9CTE9DS19B
TExPQ0FURUQgfHwgYnMgPT0gYmFzZSkgewogICAgICAgICByZXR1cm4gcmV0OwotLSAKMi4yNi4y
Cgo=


