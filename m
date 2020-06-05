Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AD9206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md8vlXhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AD9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8yv-00047t-QR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xg-00026m-Jh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xf-0006jl-KK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VT8da6AO0t3JbXMrqxhySw6haON/9sHK8mDulmzRzk8=;
 b=Md8vlXhJi/Xv+USq8VkAd3bEXNwvkq/+z9Xlx81yd0inSLwm4rGu2fBWnabrKamN/upz7c
 Egtf+QZBg+hP8G2kHNtvId73g4nY1vVw2xroWsGwPXT1iU0gI+sY7cTX9HpIHd6Hw91gGq
 +QOszKcHoyYDaCH0ujlI6rlUBcYVOdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-gruerc9LONKKiTe-3kXvGA-1; Fri, 05 Jun 2020 05:48:24 -0400
X-MC-Unique: gruerc9LONKKiTe-3kXvGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFB38872FE0;
 Fri,  5 Jun 2020 09:48:22 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78D5F5C3F8;
 Fri,  5 Jun 2020 09:48:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 02/11] io_uring: use io_uring_cq_ready() to check for ready cqes
Date: Fri,  5 Jun 2020 10:47:41 +0100
Message-Id: <20200605094750.149957-3-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKSW4gcWVtdV9s
dXJpbmdfcG9sbF9jYigpIHdlIGFyZSBub3QgdXNpbmcgdGhlIGNxZSBwZWVrZWQgZnJvbSB0aGUK
Q1EgcmluZy4gV2UgYXJlIHVzaW5nIGlvX3VyaW5nX3BlZWtfY3FlKCkgb25seSB0byBzZWUgaWYg
dGhlcmUKYXJlIGNxZXMgcmVhZHksIHNvIHdlIGNhbiByZXBsYWNlIGl0IHdpdGggaW9fdXJpbmdf
Y3FfcmVhZHkoKS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVA
cmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1MTkxMzQ5NDIuMTE4MTc4LTEtc2dhcnphcmVA
cmVkaGF0LmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogYmxvY2svaW9fdXJpbmcuYyB8IDkgKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2lv
X3VyaW5nLmMgYi9ibG9jay9pb191cmluZy5jCmluZGV4IDk3NjU2ODFmN2MuLjAzN2FmMDk0NzEg
MTAwNjQ0Ci0tLSBhL2Jsb2NrL2lvX3VyaW5nLmMKKysrIGIvYmxvY2svaW9fdXJpbmcuYwpAQCAt
Mjc3LDEzICsyNzcsMTAgQEAgc3RhdGljIHZvaWQgcWVtdV9sdXJpbmdfY29tcGxldGlvbl9jYih2
b2lkICpvcGFxdWUpCiBzdGF0aWMgYm9vbCBxZW11X2x1cmluZ19wb2xsX2NiKHZvaWQgKm9wYXF1
ZSkKIHsKICAgICBMdXJpbmdTdGF0ZSAqcyA9IG9wYXF1ZTsKLSAgICBzdHJ1Y3QgaW9fdXJpbmdf
Y3FlICpjcWVzOwogCi0gICAgaWYgKGlvX3VyaW5nX3BlZWtfY3FlKCZzLT5yaW5nLCAmY3Flcykg
PT0gMCkgewotICAgICAgICBpZiAoY3FlcykgewotICAgICAgICAgICAgbHVyaW5nX3Byb2Nlc3Nf
Y29tcGxldGlvbnNfYW5kX3N1Ym1pdChzKTsKLSAgICAgICAgICAgIHJldHVybiB0cnVlOwotICAg
ICAgICB9CisgICAgaWYgKGlvX3VyaW5nX2NxX3JlYWR5KCZzLT5yaW5nKSkgeworICAgICAgICBs
dXJpbmdfcHJvY2Vzc19jb21wbGV0aW9uc19hbmRfc3VibWl0KHMpOworICAgICAgICByZXR1cm4g
dHJ1ZTsKICAgICB9CiAKICAgICByZXR1cm4gZmFsc2U7Ci0tIAoyLjI1LjQKCg==


