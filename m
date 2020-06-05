Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB16C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C271206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3HLDNNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C271206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8yg-0003Xt-NR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xX-0001rz-Hk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44890
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xW-0006is-OA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KR6x6asC/HYUxAOydHgzfA0NWWwl9rylofm3HE79GE=;
 b=P3HLDNNpa0qp7Z36dPbJNV81Jry9Qt1aCsfRn78Vl+ymQLziSmRCOxq5cPbLMVwWFMEi7i
 +mlCQYCTgSRWd1GwUpaGqNzWl9htd+3LE4CDD+w5TauKTCfCp1aUq/an4LWIihDASZjubv
 2N1w1N7h1Y3oXYMiEYkB9+WgMNWSKEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-sLx1jlAlOB--0T_DW9qpiw-1; Fri, 05 Jun 2020 05:48:14 -0400
X-MC-Unique: sLx1jlAlOB--0T_DW9qpiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD0BA107ACCA;
 Fri,  5 Jun 2020 09:48:12 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97E236606D;
 Fri,  5 Jun 2020 09:48:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 01/11] io_uring: retry io_uring_submit() if it fails with
 errno=EINTR
Date: Fri,  5 Jun 2020 10:47:40 +0100
Message-Id: <20200605094750.149957-2-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

RnJvbTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKQXMgcmVjZW50
bHkgZG9jdW1lbnRlZCBbMV0sIGlvX3VyaW5nX2VudGVyKDIpIHN5c2NhbGwgY2FuIHJldHVybiBh
bgplcnJvciAoZXJybm89RUlOVFIpIGlmIHRoZSBvcGVyYXRpb24gd2FzIGludGVycnVwdGVkIGJ5
IGEgZGVsaXZlcnkKb2YgYSBzaWduYWwgYmVmb3JlIGl0IGNvdWxkIGNvbXBsZXRlLgoKVGhpcyBz
aG91bGQgaGFwcGVuIHdoZW4gSU9SSU5HX0VOVEVSX0dFVEVWRU5UUyBmbGFnIGlzIHVzZWQsIGZv
cgpleGFtcGxlIGR1cmluZyBpb191cmluZ19zdWJtaXRfYW5kX3dhaXQoKSBvciBkdXJpbmcgaW9f
dXJpbmdfc3VibWl0KCkKd2hlbiBJT1JJTkdfU0VUVVBfSU9QT0xMIGlzIGVuYWJsZWQuCgpXZSBz
aG91bGRuJ3QgaGF2ZSB0aGlzIHByb2JsZW0gZm9yIG5vdywgYnV0IGl0J3MgYmV0dGVyIHRvIHBy
ZXZlbnQgaXQuCgpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2F4Ym9lL2xpYnVyaW5nL2NvbW1pdC8z
NDQzNTVlYzY2MTlkZThmNGU2NDU4NGM5NzM2NTMwYjUzNDZlNGY0CgpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAw
NTE5MTMzMDQxLjExMjEzOC0xLXNnYXJ6YXJlQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3Rl
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGJsb2NrL2lvX3VyaW5nLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9ibG9jay9pb191cmluZy5jIGIvYmxvY2svaW9fdXJpbmcuYwppbmRleCBhMzE0
MmNhOTg5Li45NzY1NjgxZjdjIDEwMDY0NAotLS0gYS9ibG9jay9pb191cmluZy5jCisrKyBiL2Js
b2NrL2lvX3VyaW5nLmMKQEAgLTIzMSw3ICsyMzEsNyBAQCBzdGF0aWMgaW50IGlvcV9zdWJtaXQo
THVyaW5nU3RhdGUgKnMpCiAgICAgICAgIHRyYWNlX2x1cmluZ19pb191cmluZ19zdWJtaXQocywg
cmV0KTsKICAgICAgICAgLyogUHJldmVudCBpbmZpbml0ZSBsb29wIGlmIHN1Ym1pc3Npb24gaXMg
cmVmdXNlZCAqLwogICAgICAgICBpZiAocmV0IDw9IDApIHsKLSAgICAgICAgICAgIGlmIChyZXQg
PT0gLUVBR0FJTikgeworICAgICAgICAgICAgaWYgKHJldCA9PSAtRUFHQUlOIHx8IHJldCA9PSAt
RUlOVFIpIHsKICAgICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgIH0KICAgICAg
ICAgICAgIGJyZWFrOwotLSAKMi4yNS40Cgo=


