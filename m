Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A35BC18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B71222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTahsydW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B71222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0iS-0003FI-0K
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0fm-0006nP-KL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0fl-0000He-FN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0fl-0000HG-B5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vEhsnHdkrdmlhhoxg4gu84Vi1CeoTvkMYk4LdIuEGI=;
 b=OTahsydW2jtjd5emneYS8G8U7hyoHXmp3d/12Fe6Y6vzPdjpoNLP7DZ8Kt9GB6AfsqWWdD
 CJihxOzmqBBvpgeUdCLP7shyHtK3prpivfXxVG+lhxd07uD+3sOMssUCqsbbZl1KFbQCbj
 BoLDi6KgLSiDekbmb8gtLP77F9K+dEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-HZF3W29oPL6OHaIlFysOwA-1; Wed, 11 Mar 2020 08:41:10 -0400
X-MC-Unique: HZF3W29oPL6OHaIlFysOwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BC498024CF;
 Wed, 11 Mar 2020 12:41:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F8E392D27;
 Wed, 11 Mar 2020 12:41:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] aio-posix: move RCU_READ_LOCK() into run_poll_handlers()
Date: Wed, 11 Mar 2020 12:40:40 +0000
Message-Id: <20200311124045.277969-5-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
References: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tm93IHRoYXQgcnVuX3BvbGxfaGFuZGxlcnNfb25jZSgpIGlzIG9ubHkgY2FsbGVkIGJ5IHJ1bl9w
b2xsX2hhbmRsZXJzKCkKd2UgY2FuIGltcHJvdmUgdGhlIENQVSB0aW1lIHByb2ZpbGUgYnkgbW92
aW5nIHRoZSBleHBlbnNpdmUKUkNVX1JFQURfTE9DSygpIG91dCBvZiB0aGUgcG9sbGluZyBsb29w
LgoKVGhpcyByZWR1Y2VzIHRoZSBydW5fcG9sbF9oYW5kbGVycygpIGZyb20gNDAlIENQVSB0byAx
MCUgQ1BVIGluIHBlcmYncwpzYW1wbGluZyBwcm9maWxlciBvdXRwdXQuCgpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ckxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyMDAzMDUxNzA4MDYuMTMxMzI0NS0zLXN0ZWZhbmhhQHJlZGhhdC5j
b20KTWVzc2FnZS1JZDogPDIwMjAwMzA1MTcwODA2LjEzMTMyNDUtMy1zdGVmYW5oYUByZWRoYXQu
Y29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3V0aWwvYWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IDY1OTY0YTI1OTcu
LjExYTQ5NzE5NTUgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRpbC9haW8t
cG9zaXguYwpAQCAtNTgzLDE2ICs1ODMsNiBAQCBzdGF0aWMgYm9vbCBydW5fcG9sbF9oYW5kbGVy
c19vbmNlKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCAqdGltZW91dCkKICAgICBib29sIHByb2dy
ZXNzID0gZmFsc2U7CiAgICAgQWlvSGFuZGxlciAqbm9kZTsKIAotICAgIC8qCi0gICAgICogT3B0
aW1pemF0aW9uOiAtPmlvX3BvbGwoKSBoYW5kbGVycyBvZnRlbiBjb250YWluIFJDVSByZWFkIGNy
aXRpY2FsCi0gICAgICogc2VjdGlvbnMgYW5kIHdlIHRoZXJlZm9yZSBzZWUgbWFueSByY3VfcmVh
ZF9sb2NrKCkgLT4gcmN1X3JlYWRfdW5sb2NrKCkKLSAgICAgKiAtPiByY3VfcmVhZF9sb2NrKCkg
LT4gLi4uIHNlcXVlbmNlcyB3aXRoIGV4cGVuc2l2ZSBtZW1vcnkKLSAgICAgKiBzeW5jaHJvbml6
YXRpb24gcHJpbWl0aXZlcy4gIE1ha2UgdGhlIGVudGlyZSBwb2xsaW5nIGxvb3AgYW4gUkNVCi0g
ICAgICogY3JpdGljYWwgc2VjdGlvbiBiZWNhdXNlIG5lc3RlZCByY3VfcmVhZF9sb2NrKCkvcmN1
X3JlYWRfdW5sb2NrKCkgY2FsbHMKLSAgICAgKiBhcmUgY2hlYXAuCi0gICAgICovCi0gICAgUkNV
X1JFQURfTE9DS19HVUFSRCgpOwotCiAgICAgUUxJU1RfRk9SRUFDSF9SQ1Uobm9kZSwgJmN0eC0+
YWlvX2hhbmRsZXJzLCBub2RlKSB7CiAgICAgICAgIGlmICghUUxJU1RfSVNfSU5TRVJURUQobm9k
ZSwgbm9kZV9kZWxldGVkKSAmJiBub2RlLT5pb19wb2xsICYmCiAgICAgICAgICAgICBhaW9fbm9k
ZV9jaGVjayhjdHgsIG5vZGUtPmlzX2V4dGVybmFsKSAmJgpAQCAtNjM2LDYgKzYyNiwxNiBAQCBz
dGF0aWMgYm9vbCBydW5fcG9sbF9oYW5kbGVycyhBaW9Db250ZXh0ICpjdHgsIGludDY0X3QgbWF4
X25zLCBpbnQ2NF90ICp0aW1lb3V0KQogCiAgICAgdHJhY2VfcnVuX3BvbGxfaGFuZGxlcnNfYmVn
aW4oY3R4LCBtYXhfbnMsICp0aW1lb3V0KTsKIAorICAgIC8qCisgICAgICogT3B0aW1pemF0aW9u
OiAtPmlvX3BvbGwoKSBoYW5kbGVycyBvZnRlbiBjb250YWluIFJDVSByZWFkIGNyaXRpY2FsCisg
ICAgICogc2VjdGlvbnMgYW5kIHdlIHRoZXJlZm9yZSBzZWUgbWFueSByY3VfcmVhZF9sb2NrKCkg
LT4gcmN1X3JlYWRfdW5sb2NrKCkKKyAgICAgKiAtPiByY3VfcmVhZF9sb2NrKCkgLT4gLi4uIHNl
cXVlbmNlcyB3aXRoIGV4cGVuc2l2ZSBtZW1vcnkKKyAgICAgKiBzeW5jaHJvbml6YXRpb24gcHJp
bWl0aXZlcy4gIE1ha2UgdGhlIGVudGlyZSBwb2xsaW5nIGxvb3AgYW4gUkNVCisgICAgICogY3Jp
dGljYWwgc2VjdGlvbiBiZWNhdXNlIG5lc3RlZCByY3VfcmVhZF9sb2NrKCkvcmN1X3JlYWRfdW5s
b2NrKCkgY2FsbHMKKyAgICAgKiBhcmUgY2hlYXAuCisgICAgICovCisgICAgUkNVX1JFQURfTE9D
S19HVUFSRCgpOworCiAgICAgc3RhcnRfdGltZSA9IHFlbXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xP
Q0tfUkVBTFRJTUUpOwogICAgIGRvIHsKICAgICAgICAgcHJvZ3Jlc3MgPSBydW5fcG9sbF9oYW5k
bGVyc19vbmNlKGN0eCwgdGltZW91dCk7Ci0tIAoyLjI0LjEKCg==


