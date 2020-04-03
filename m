Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647D42078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnVSyH8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647D42078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKu0-0002CM-Gn
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jKKs0-0006y1-MZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jKKrz-0002qS-BW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jKKrz-0002q7-7y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585914738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVgjL2U3XiNM2V2E3TmxtaKINmOxqSXhRnhGHxJw9Xk=;
 b=LnVSyH8qYWhRLMYuUBzKZcMCY10nudnJRK2oos7jURwsLel3ab+ZuceTIz3lUhw9ICBt6Z
 XHJ8r+icAEC62xhnwNfOEPOvH7L1VhdiJthtFQqAODcjMSGcO4m5KrRVjY1JxMX6dUsZGl
 BUCMo00/DqneXhGYd6W4xiW/nhO6pKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457--K8wIaNQNQWNb2fT6hXOoA-1; Fri, 03 Apr 2020 07:52:17 -0400
X-MC-Unique: -K8wIaNQNQWNb2fT6hXOoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA3698018A1;
 Fri,  3 Apr 2020 11:52:15 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 812C2A63CE;
 Fri,  3 Apr 2020 11:52:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 1/1] aio-posix: fix test-aio /aio/event/wait with
 fdmon-io_uring
Date: Fri,  3 Apr 2020 12:52:09 +0100
Message-Id: <20200403115209.145810-2-stefanha@redhat.com>
In-Reply-To: <20200403115209.145810-1-stefanha@redhat.com>
References: <20200403115209.145810-1-stefanha@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2hlbiBhIGZpbGUgZGVzY3JpcHRvciBiZWNvbWVzIHJlYWR5IHdlIG11c3QgcmUtYXJtIFBPTExf
QURELiAgVGhpcyBpcwpkb25lIGJ5IGFkZGluZyBhbiBzcWUgdG8gdGhlIGlvX3VyaW5nIHNxIHJp
bmcuICBUaGUgLT5uZWVkX3dhaXQoKQpmdW5jdGlvbiB3YXNuJ3QgdGFraW5nIHBlbmRpbmcgc3Fl
cyBpbnRvIGFjY291bnQgYW5kIHRoZXJlZm9yZQppb191cmluZ19zdWJtaXRfYW5kX3dhaXQoKSB3
YXMgbm90IGJlaW5nIGNhbGxlZC4gIFBvbGxpbmcgZm9yIGNxZXMKZmFpbGVkIHRvIGRldGVjdCBm
ZCByZWFkaW5lc3Mgc2luY2Ugd2UgaGFkbid0IHN1Ym1pdHRlZCB0aGUgc3FlIHRvCmlvX3VyaW5n
LgoKVGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHRlc3RzL3Rlc3QtYWlvIC1wIC9haW8v
ZXZlbnQvd2FpdApmYWlsdXJlOgoKICBvayAxMSAvYWlvL2V2ZW50L3dhaXQKICAqKgogIEVSUk9S
OnRlc3RzL3Rlc3QtYWlvLmM6Mzc0OnRlc3RfZmx1c2hfZXZlbnRfbm90aWZpZXI6IGFzc2VydGlv
biBmYWlsZWQ6IChhaW9fcG9sbChjdHgsIGZhbHNlKSkKClJlcG9ydGVkLWJ5OiBDb2xlIFJvYmlu
c29uIDxjcm9iaW5zb0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxh
IDxzZ2FyemFyZUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IENvbGUgUm9iaW5zb24gPGNyb2JpbnNv
QHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA0MDIxNDU0MzQuOTkzNDktMS1zdGVmYW5oYUByZWRo
YXQuY29tCkZpeGVzOiA3M2ZkMjgyZTdiNmRkNGU0ZWExYzNiYmIzZDMwMmM4ZGI1MWU0Y2NmCiAg
ICAgICAoImFpby1wb3NpeDogYWRkIGlvX3VyaW5nIGZkIG1vbml0b3JpbmcgaW1wbGVtZW50YXRp
b24iKQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
Ci0tLQogdXRpbC9mZG1vbi1pb191cmluZy5jIHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9mZG1vbi1p
b191cmluZy5jIGIvdXRpbC9mZG1vbi1pb191cmluZy5jCmluZGV4IDdlMTQzZWY1MTUuLmI0ZDYx
MDlmMjAgMTAwNjQ0Ci0tLSBhL3V0aWwvZmRtb24taW9fdXJpbmcuYworKysgYi91dGlsL2ZkbW9u
LWlvX3VyaW5nLmMKQEAgLTI5NSw3ICsyOTUsMTIgQEAgc3RhdGljIGJvb2wgZmRtb25faW9fdXJp
bmdfbmVlZF93YWl0KEFpb0NvbnRleHQgKmN0eCkKICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAg
fQogCi0gICAgLyogRG8gd2UgbmVlZCB0byBzdWJtaXQgbmV3IGlvX3VyaW5nIHNxZXM/ICovCisg
ICAgLyogQXJlIHRoZXJlIHBlbmRpbmcgc3FlcyB0byBzdWJtaXQ/ICovCisgICAgaWYgKGlvX3Vy
aW5nX3NxX3JlYWR5KCZjdHgtPmZkbW9uX2lvX3VyaW5nKSkgeworICAgICAgICByZXR1cm4gdHJ1
ZTsKKyAgICB9CisKKyAgICAvKiBEbyB3ZSBuZWVkIHRvIHByb2Nlc3MgQWlvSGFuZGxlcnMgZm9y
IGlvX3VyaW5nIGNoYW5nZXM/ICovCiAgICAgaWYgKCFRU0xJU1RfRU1QVFlfUkNVKCZjdHgtPnN1
Ym1pdF9saXN0KSkgewogICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICB9Ci0tIAoyLjI1LjEKCg==


