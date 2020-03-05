Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FFC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDFF207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdOVONoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDFF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9uAp-0001bJ-5S
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j9tyq-00081X-Dp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j9tyo-00037x-V9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j9tyo-000376-RU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583428093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AqsHto9y4V8PpLHE+o99t7LHwdNEllZ3gp1C7BUQwZM=;
 b=FdOVONoYJz4yN2ZJEQiUrsC8aVsJ75vDfQfvvdS+ZN2PRuto4zkw5qccfHDAA+bL5KjwZh
 xb0at65WJmr7YRtSFzAgbLndEgCwOe8DWMYhIYysqW4qBeWQEVUSIBoj4W1iDT5EjOztDu
 t2vF0osU6EUkxAVsRKRcui3XsRyjzEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-XsugWi-hMrqoai5BsUDdAg-1; Thu, 05 Mar 2020 12:08:12 -0500
X-MC-Unique: XsugWi-hMrqoai5BsUDdAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19B0B801E74;
 Thu,  5 Mar 2020 17:08:11 +0000 (UTC)
Received: from localhost (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 017975C219;
 Thu,  5 Mar 2020 17:08:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] aio-posix: polling scalability improvements
Date: Thu,  5 Mar 2020 17:07:59 +0000
Message-Id: <20200305170806.1313245-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QSBndWVzdCB3aXRoIDEwMCB2aXJ0aW8tYmxrLXBjaSxudW0tcXVldWVzPTMyIGRldmljZXMgb25s
eSByZWFjaGVzIDEwayBJT1BTCndoaWxlIGEgZ3Vlc3Qgd2l0aCBhIHNpbmdsZSBkZXZpY2UgcmVh
Y2hlcyAxMDVrIElPUFMKKHJ3PXJhbmRyZWFkLGJzPTRrLGlvZGVwdGg9MSxpb2VuZ2luZT1saWJh
aW8pLgoKVGhlIGJvdHRsZW5lY2sgaXMgdGhhdCBhaW9fcG9sbCgpIHVzZXJzcGFjZSBwb2xsaW5n
IGl0ZXJhdGVzIG92ZXIgYWxsCkFpb0hhbmRsZXJzIHRvIGludm9rZSB0aGVpciAtPmlvX3BvbGwo
KSBjYWxsYmFja3MuICBBbGwgQWlvSGFuZGxlcnMgYXJlIHBvbGxlZApldmVuIGlmIG9ubHkgb25l
IG9mIHRoZW0gd2FzIHJlY2VudGx5IGFjdGl2ZS4gIFRoZXJlZm9yZSBhIGd1ZXN0IHdpdGggbWFu
eQpkaXNrcyBpcyBzbG93ZXIgdGhhbiBhIGd1ZXN0IHdpdGggYSBzaW5nbGUgZGlzayBldmVuIHdo
ZW4gdGhlIHdvcmtsb2FkIG9ubHkKYWNjZXNzZXMgYSBzaW5nbGUgZGlzay4KClRoaXMgcGF0Y2gg
c2VyaWVzIHNvbHZlcyB0aGlzIHNjYWxhYmlsaXR5IHByb2JsZW0gc28gdGhhdCBJT1BTIGlzIHVu
YWZmZWN0ZWQgYnkKdGhlIG51bWJlciBvZiBkZXZpY2VzLiAgVGhlIHRyaWNrIGlzIHRvIHBvbGwg
b25seSBBaW9IYW5kbGVycyB0aGF0IHdlcmUKcmVjZW50bHkgYWN0aXZlIHNvIHRoYXQgdXNlcnNw
YWNlIHBvbGxpbmcgc2NhbGVzIHdlbGwuCgpVbmZvcnR1bmF0ZWx5IGl0J3Mgbm90IHBvc3NpYmxl
IHRvIGFjY29tcGxpc2ggdGhpcyB3aXRoIHRoZSBleGlzdGluZyBlcG9sbCg3KQpmZCBtb25pdG9y
aW5nIGltcGxlbWVudGF0aW9uLiAgVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBhIExpbnV4IGlvX3Vy
aW5nIGZkCm1vbml0b3JpbmcgaW1wbGVtZW50YXRpb24uICBUaGUgY3JpdGljYWwgZmVhdHVyZSBp
cyB0aGF0IGlvX3VyaW5nIGNhbiBjaGVjayB0aGUKcmVhZGluZXNzIG9mIGZpbGUgZGVzY3JpcHRv
cnMgdGhyb3VnaCB1c2Vyc3BhY2UgcG9sbGluZy4gIFRoaXMgbWFrZXMgaXQKcG9zc2libGUgdG8g
c2FmZWx5IHBvbGwgYSBzdWJzZXQgb2YgQWlvSGFuZGxlcnMgZnJvbSB1c2Vyc3BhY2Ugd2l0aG91
dCByaXNrIG9mCnN0YXJ2aW5nIHRoZSBvdGhlciBBaW9IYW5kbGVycy4KClN0ZWZhbiBIYWpub2N6
aSAoNyk6CiAgYWlvLXBvc2l4OiBjb21wbGV0ZWx5IHN0b3AgcG9sbGluZyB3aGVuIGRpc2FibGVk
CiAgYWlvLXBvc2l4OiBtb3ZlIFJDVV9SRUFEX0xPQ0soKSBpbnRvIHJ1bl9wb2xsX2hhbmRsZXJz
KCkKICBhaW8tcG9zaXg6IGV4dHJhY3QgcHBvbGwoMikgYW5kIGVwb2xsKDcpIGZkIG1vbml0b3Jp
bmcKICBhaW8tcG9zaXg6IHNpbXBsaWZ5IEZETW9uT3BzLT51cGRhdGUoKSBwcm90b3R5cGUKICBh
aW8tcG9zaXg6IGFkZCBpb191cmluZyBmZCBtb25pdG9yaW5nIGltcGxlbWVudGF0aW9uCiAgYWlv
LXBvc2l4OiBzdXBwb3J0IHVzZXJzcGFjZSBwb2xsaW5nIG9mIGZkIG1vbml0b3JpbmcKICBhaW8t
cG9zaXg6IHJlbW92ZSBpZGxlIHBvbGwgaGFuZGxlcnMgdG8gaW1wcm92ZSBzY2FsYWJpbGl0eQoK
IE1BSU5UQUlORVJTICAgICAgICAgICB8ICAgMiArCiBjb25maWd1cmUgICAgICAgICAgICAgfCAg
IDUgKwogaW5jbHVkZS9ibG9jay9haW8uaCAgIHwgIDcwICsrKysrKy0KIHV0aWwvTWFrZWZpbGUu
b2JqcyAgICB8ICAgMyArCiB1dGlsL2Fpby1wb3NpeC5jICAgICAgfCA0NDkgKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB1dGlsL2Fpby1wb3NpeC5oICAgICAgfCAg
ODEgKysrKysrKysKIHV0aWwvZmRtb24tZXBvbGwuYyAgICB8IDE1NSArKysrKysrKysrKysrKysK
IHV0aWwvZmRtb24taW9fdXJpbmcuYyB8IDMzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiB1dGlsL2ZkbW9uLXBvbGwuYyAgICAgfCAxMDcgKysrKysrKysrKwogdXRpbC90cmFjZS1l
dmVudHMgICAgIHwgICAyICsKIDEwIGZpbGVzIGNoYW5nZWQsIDg5OCBpbnNlcnRpb25zKCspLCAz
MDggZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9haW8tcG9zaXguaAogY3Jl
YXRlIG1vZGUgMTAwNjQ0IHV0aWwvZmRtb24tZXBvbGwuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHV0
aWwvZmRtb24taW9fdXJpbmcuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvZmRtb24tcG9sbC5j
CgotLSAKMi4yNC4xCgo=


