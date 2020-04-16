Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C427EC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916842223E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEWZ38OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916842223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP7kc-0001aI-Po
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 12:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jP7hm-0006r1-Pn
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jP7hl-0000Pr-R4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:49:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jP7hl-0000Pa-NE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 12:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587055773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfPb5Xn/B/myf3QvtDqfsuKstRVK4hF/CQiBtI98nAY=;
 b=ZEWZ38OMEwm9w1EFgdOXtsAr4NbTtdjLZ6O9SrxsTQwATjEXfV5RfKYUy4JDLVBvfcrw26
 /IRHulMzxz4fV7s4198t8qIOGHSEq0y1Eo0AtlMmNYVseBqDPfoYA8wNia3FO1gfidA06k
 XgrQJlorRnZLIAKYjAVaTgSIuhINfMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-1r7NIdbSNDixjmlBnkk9qw-1; Thu, 16 Apr 2020 12:49:30 -0400
X-MC-Unique: 1r7NIdbSNDixjmlBnkk9qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E58802683
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 16:49:29 +0000 (UTC)
Received: from localhost (ovpn-114-223.ams2.redhat.com [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE0639A265;
 Thu, 16 Apr 2020 16:49:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] virtiofsd: drop all capabilities in the wait parent
 process
Date: Thu, 16 Apr 2020 17:49:07 +0100
Message-Id: <20200416164907.244868-3-stefanha@redhat.com>
In-Reply-To: <20200416164907.244868-1-stefanha@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWxsIHRoaXMgcHJvY2VzcyBkb2VzIGlzIHdhaXQgZm9yIGl0cyBjaGlsZC4gIE5vIGNhcGFiaWxp
dGllcyBhcmUKbmVlZGVkLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPgotLS0KIHRvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5jIHwgMTMg
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYyBiL3Rvb2xzL3ZpcnRpb2ZzZC9w
YXNzdGhyb3VnaF9sbC5jCmluZGV4IGFmOTdiYTFjNDEuLjBjM2YzM2IwNzQgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5jCisrKyBiL3Rvb2xzL3ZpcnRpb2ZzZC9w
YXNzdGhyb3VnaF9sbC5jCkBAIC0yNTMwLDYgKzI1MzAsMTcgQEAgc3RhdGljIHZvaWQgcHJpbnRf
Y2FwYWJpbGl0aWVzKHZvaWQpCiAgICAgcHJpbnRmKCJ9XG4iKTsKIH0KIAorLyoKKyAqIERyb3Ag
YWxsIExpbnV4IGNhcGFiaWxpdGllcyBiZWNhdXNlIHRoZSB3YWl0IHBhcmVudCBwcm9jZXNzIG9u
bHkgbmVlZHMgdG8KKyAqIHNpdCBpbiB3YWl0cGlkKDIpIGFuZCB0ZXJtaW5hdGUuCisgKi8KK3N0
YXRpYyB2b2lkIHNldHVwX3dhaXRfcGFyZW50X2NhcGFiaWxpdGllcyh2b2lkKQoreworICAgIGNh
cG5nX3NldHBpZChzeXNjYWxsKFNZU19nZXR0aWQpKTsKKyAgICBjYXBuZ19jbGVhcihDQVBOR19T
RUxFQ1RfQk9USCk7CisgICAgY2FwbmdfYXBwbHkoQ0FQTkdfU0VMRUNUX0JPVEgpOworfQorCiAv
KgogICogTW92ZSB0byBhIG5ldyBtb3VudCwgbmV0LCBhbmQgcGlkIG5hbWVzcGFjZXMgdG8gaXNv
bGF0ZSB0aGlzIHByb2Nlc3MuCiAgKi8KQEAgLTI1NjEsNiArMjU3Miw4IEBAIHN0YXRpYyB2b2lk
IHNldHVwX25hbWVzcGFjZXMoc3RydWN0IGxvX2RhdGEgKmxvLCBzdHJ1Y3QgZnVzZV9zZXNzaW9u
ICpzZSkKICAgICAgICAgcGlkX3Qgd2FpdGVkOwogICAgICAgICBpbnQgd3N0YXR1czsKIAorICAg
ICAgICBzZXR1cF93YWl0X3BhcmVudF9jYXBhYmlsaXRpZXMoKTsKKwogICAgICAgICAvKiBUaGUg
cGFyZW50IHdhaXRzIGZvciB0aGUgY2hpbGQgKi8KICAgICAgICAgZG8gewogICAgICAgICAgICAg
d2FpdGVkID0gd2FpdHBpZChjaGlsZCwgJndzdGF0dXMsIDApOwotLSAKMi4yNS4xCgo=


