Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A178C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC1A2051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flrttfbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC1A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEww-0005UI-4O
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jFEvc-00045U-Io
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jFEvb-00014T-FL
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:31:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jFEvb-00014N-Cu
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584700259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xoy+WPkqglAejEtg7CTFVi68ySe7CCF9354S+IT/UmY=;
 b=flrttfbZb29aifGIJKbXsbGBUa9kQ7Bf0gQVcaSfYJs2+huR0Ho6ae2nL8ED4zaxlPIl0r
 Ivdu0atFkSb/pq19unYxe+HcJCCo+44xcccyssdPnCAbu5TyT7AVWSh2G4IAhzrSsp/bSU
 20Lqrfd+KqCA+CuCAg8vcKKvLXNegUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-izvchxIJMR-Tdx9opKyLjw-1; Fri, 20 Mar 2020 06:30:55 -0400
X-MC-Unique: izvchxIJMR-Tdx9opKyLjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58297800EBD;
 Fri, 20 Mar 2020 10:30:53 +0000 (UTC)
Received: from localhost (ovpn-114-252.ams2.redhat.com [10.36.114.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAF52BBBC5;
 Fri, 20 Mar 2020 10:30:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 0/4] virtio-pci: enable blk and scsi multi-queue by
 default
Date: Fri, 20 Mar 2020 10:30:37 +0000
Message-Id: <20200320103041.129527-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djM6CiAqIEFkZCBuZXcgcGVyZm9ybWFuY2UgcmVzdWx0cyB0aGF0IGRlbW9uc3RyYXRlIHRoZSBz
Y2FsYWJpbGl0eQogKiBNZW50aW9uIHRoYXQgdGhpcyBpcyBQQ0ktc3BlY2lmaWMgW0Nvcm5lbGlh
XQp2MjoKICogTGV0IHRoZSB2aXJ0aW8tREVWSUNFLXBjaSBkZXZpY2Ugc2VsZWN0IG51bS1xdWV1
ZXMgYmVjYXVzZSB0aGUgb3B0aW1hbAogICBtdWx0aS1xdWV1ZSBjb25maWd1cmF0aW9uIG1heSBk
aWZmZXIgYmV0d2VlbiB2aXJ0aW8tcGNpLCB2aXJ0aW8tbW1pbywgYW5kCiAgIHZpcnRpby1jY3cg
W0Nvcm5lbGlhXQoKRW5hYmxpbmcgbXVsdGktcXVldWUgb24gdmlydGlvLXBjaSBzdG9yYWdlIGRl
dmljZXMgaW1wcm92ZXMgcGVyZm9ybWFuY2Ugb24gU01QCmd1ZXN0cyBiZWNhdXNlIHRoZSBjb21w
bGV0aW9uIGludGVycnVwdCBpcyBoYW5kbGVkIG9uIHRoZSB2Q1BVIHRoYXQgc3VibWl0dGVkCnRo
ZSBJL08gcmVxdWVzdC4gIFRoaXMgYXZvaWRzIElQSXMgaW5zaWRlIHRoZSBndWVzdC4KCk5vdGUg
dGhhdCBwZXJmb3JtYW5jZSBpcyB1bmNoYW5nZWQgaW4gdGhlc2UgY2FzZXM6CjEuIFVuaXByb2Nl
c3NvciBndWVzdHMuICBUaGV5IGRvbid0IGhhdmUgSVBJcy4KMi4gQXBwbGljYXRpb24gdGhyZWFk
cyBtaWdodCBiZSBzY2hlZHVsZWQgb24gdGhlIHNvbGUgdkNQVSB0aGF0IGhhbmRsZXMKICAgY29t
cGxldGlvbiBpbnRlcnJ1cHRzIHB1cmVseSBieSBjaGFuY2UuICAoVGhpcyBpcyBvbmUgcmVhc29u
IHdoeSBiZW5jaG1hcmsKICAgcmVzdWx0cyBjYW4gdmFyeSBub3RpY2FibHkgYmV0d2VlbiBydW5z
LikKMy4gVXNlcnMgbWF5IGJpbmQgdGhlIGFwcGxpY2F0aW9uIHRvIHRoZSB2Q1BVIHRoYXQgaGFu
ZGxlcyBjb21wbGV0aW9uCiAgIGludGVycnVwdHMuCgpTZXQgdGhlIG51bWJlciBvZiBxdWV1ZXMg
dG8gdGhlIG51bWJlciBvZiB2Q1BVcyBieSBkZWZhdWx0IG9uIHZpcnRpby1ibGsgYW5kCnZpcnRp
by1zY3NpIFBDSSBkZXZpY2VzLiAgT2xkZXIgbWFjaGluZSB0eXBlcyBjb250aW51ZSB0byBkZWZh
dWx0IHRvIDEgcXVldWUKZm9yIGxpdmUgbWlncmF0aW9uIGNvbXBhdGliaWxpdHkuCgpSYW5kb20g
cmVhZCBwZXJmb3JtYW5jZToKICAgICAgSU9QUwpxPTEgICAgNzhrCnE9MzIgIDEwNGsgICszMyUK
CkJvb3QgdGltZToKICAgICAgRHVyYXRpb24KcT0xICAgICAgICA1MXMKcT0zMiAgICAgMW00MXMg
ICs5OCUKCkd1ZXN0IGNvbmZpZ3VyYXRpb246IDMyIHZDUFVzLCAxMDEgdmlydGlvLWJsay1wY2kg
ZGlza3MKClByZXZpb3VzbHkgbWVhc3VyZWQgcmVzdWx0cyBvbiBhIDQgdkNQVSBndWVzdCB3ZXJl
IGFsc28gcG9zaXRpdmUgYnV0IHNob3dlZCBhCnNtYWxsZXIgMS00JSBwZXJmb3JtYW5jZSBpbXBy
b3ZlbWVudC4gIFRoZXkgYXJlIG5vIGxvbmdlciB2YWxpZCBiZWNhdXNlCnNpZ25pZmljYW50IGV2
ZW50IGxvb3Agb3B0aW1pemF0aW9ucyBoYXZlIGJlZW4gbWVyZ2VkLgoKU3RlZmFuIEhham5vY3pp
ICg0KToKICB2aXJ0aW8tc2NzaTogaW50cm9kdWNlIGEgY29uc3RhbnQgZm9yIGZpeGVkIHZpcnRx
dWV1ZXMKICB2aXJ0aW8tc2NzaTogZGVmYXVsdCBudW1fcXVldWVzIHRvIC1zbXAgTgogIHZpcnRp
by1ibGs6IGRlZmF1bHQgbnVtX3F1ZXVlcyB0byAtc21wIE4KICB2aG9zdC11c2VyLWJsazogZGVm
YXVsdCBudW1fcXVldWVzIHRvIC1zbXAgTgoKIGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMgICAg
ICAgICAgfCAgNiArKysrKy0KIGh3L2Jsb2NrL3ZpcnRpby1ibGsuYyAgICAgICAgICAgICAgfCAg
NiArKysrKy0KIGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAgICAgICAgICAgfCAgNSArKysrKwog
aHcvc2NzaS92aG9zdC1zY3NpLmMgICAgICAgICAgICAgICB8ICAzICsrLQogaHcvc2NzaS92aG9z
dC11c2VyLXNjc2kuYyAgICAgICAgICB8ICA1ICsrKy0tCiBody9zY3NpL3ZpcnRpby1zY3NpLmMg
ICAgICAgICAgICAgIHwgMTMgKysrKysrKysrLS0tLQogaHcvdmlydGlvL3Zob3N0LXNjc2ktcGNp
LmMgICAgICAgICB8IDEwICsrKysrKysrLS0KIGh3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2ku
YyAgICAgfCAgNiArKysrKysKIGh3L3ZpcnRpby92aG9zdC11c2VyLXNjc2ktcGNpLmMgICAgfCAx
MCArKysrKysrKy0tCiBody92aXJ0aW8vdmlydGlvLWJsay1wY2kuYyAgICAgICAgIHwgIDkgKysr
KysrKystCiBody92aXJ0aW8vdmlydGlvLXNjc2ktcGNpLmMgICAgICAgIHwgMTAgKysrKysrKyst
LQogaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsuaCB8ICAyICsrCiBpbmNsdWRlL2h3
L3ZpcnRpby92aXJ0aW8tYmxrLmggICAgIHwgIDIgKysKIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRp
by1zY3NpLmggICAgfCAgNSArKysrKwogMTQgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygr
KSwgMTYgZGVsZXRpb25zKC0pCgotLSAKMi4yNC4xCgo=


