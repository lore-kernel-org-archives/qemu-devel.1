Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A2C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6482072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw0WI8fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6482072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEyBI-0001V8-9p
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jEy9c-0008Rs-L9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jEy9b-0004XA-Kc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:36:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jEy9b-0004VY-GG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584635779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pgrBJVqrDcRBvnrD83fggUJtxyGyTTnG81DGVacbk3A=;
 b=Zw0WI8fEsDe85zCteB+ocaW4k++Wqdk8doHrBVPICcAtU9ukQ7jdHwnWLNfzy9ompjJYaI
 TdWTXE6aNEbF/fqWXuB/QlKZlZPg3p9MY8XHOmEXcURvPSquZ9WTQVM3agC14fjj+B+c91
 +Ya6C0Ah8VqSi73zpS1rhBSHeZX2Ts8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-6Az1v6vcMI61YzZoSV8hHg-1; Thu, 19 Mar 2020 12:36:17 -0400
X-MC-Unique: 6Az1v6vcMI61YzZoSV8hHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63961088381;
 Thu, 19 Mar 2020 16:36:16 +0000 (UTC)
Received: from localhost (ovpn-113-148.ams2.redhat.com [10.36.113.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18EE89B919;
 Thu, 19 Mar 2020 16:36:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] aio-posix: fix io_uring with external events
Date: Thu, 19 Mar 2020 16:35:59 +0000
Message-Id: <20200319163559.117903-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Julia Suvorova <jusual@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2hlbiBleHRlcm5hbCBldmVudCBzb3VyY2VzIGFyZSBkaXNhYmxlZCBmZG1vbi1pb191cmluZyBm
YWxscyBiYWNrIHRvCmZkbW9uLXBvbGwuICBUaGUgLT5uZWVkX3dhaXQoKSBjYWxsYmFjayBuZWVk
cyB0byB3YXRjaCBmb3IgdGhpcyBzbyBpdApjYW4gcmV0dXJuIHRydWUgd2hlbiBleHRlcm5hbCBl
dmVudCBzb3VyY2VzIGFyZSBkaXNhYmxlZC4KCkl0IGlzIGFsc28gbmVjZXNzYXJ5IHRvIGNhbGwg
LT53YWl0KCkgd2hlbiBBaW9IYW5kbGVycyBoYXZlIGNoYW5nZWQKYmVjYXVzZSBpb191cmluZyBp
cyBhc3luY2hyb25vdXMgYW5kIHdlIG11c3Qgc3VibWl0IG5ldyBzcWVzLgoKQm90aCBvZiB0aGVz
ZSBjaGFuZ2VzIHRvIC0+bmVlZF93YWl0KCkgdG9nZXRoZXIgZml4IHRlc3RzL3Rlc3QtYWlvIC1w
Ci9haW8vZXh0ZXJuYWwtY2xpZW50LCB3aGljaCBmYWlsZWQgd2l0aDoKCiAgdGVzdC1haW86IHRl
c3RzL3Rlc3QtYWlvLmM6NDA0OiB0ZXN0X2Fpb19leHRlcm5hbF9jbGllbnQ6IEFzc2VydGlvbiBg
YWlvX3BvbGwoY3R4LCBmYWxzZSknIGZhaWxlZC4KClJlcG9ydGVkLWJ5OiBKdWxpYSBTdXZvcm92
YSA8anVzdWFsQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL2ZkbW9uLWlvX3VyaW5nLmMgfCAxMyArKysrKysr
KysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3V0aWwvZmRtb24taW9fdXJpbmcuYyBiL3V0aWwvZmRtb24taW9fdXJpbmcu
YwppbmRleCA4OTNiNzliNjIyLi43ZTE0M2VmNTE1IDEwMDY0NAotLS0gYS91dGlsL2ZkbW9uLWlv
X3VyaW5nLmMKKysrIGIvdXRpbC9mZG1vbi1pb191cmluZy5jCkBAIC0yOTAsNyArMjkwLDE4IEBA
IHN0YXRpYyBpbnQgZmRtb25faW9fdXJpbmdfd2FpdChBaW9Db250ZXh0ICpjdHgsIEFpb0hhbmRs
ZXJMaXN0ICpyZWFkeV9saXN0LAogCiBzdGF0aWMgYm9vbCBmZG1vbl9pb191cmluZ19uZWVkX3dh
aXQoQWlvQ29udGV4dCAqY3R4KQogewotICAgIHJldHVybiBpb191cmluZ19jcV9yZWFkeSgmY3R4
LT5mZG1vbl9pb191cmluZyk7CisgICAgLyogSGF2ZSBpb191cmluZyBldmVudHMgY29tcGxldGVk
PyAqLworICAgIGlmIChpb191cmluZ19jcV9yZWFkeSgmY3R4LT5mZG1vbl9pb191cmluZykpIHsK
KyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorCisgICAgLyogRG8gd2UgbmVlZCB0byBzdWJt
aXQgbmV3IGlvX3VyaW5nIHNxZXM/ICovCisgICAgaWYgKCFRU0xJU1RfRU1QVFlfUkNVKCZjdHgt
PnN1Ym1pdF9saXN0KSkgeworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisKKyAgICAvKiBB
cmUgd2UgZmFsbGluZyBiYWNrIHRvIGZkbW9uLXBvbGw/ICovCisgICAgcmV0dXJuIGF0b21pY19y
ZWFkKCZjdHgtPmV4dGVybmFsX2Rpc2FibGVfY250KTsKIH0KIAogc3RhdGljIGNvbnN0IEZETW9u
T3BzIGZkbW9uX2lvX3VyaW5nX29wcyA9IHsKLS0gCjIuMjQuMQoK


