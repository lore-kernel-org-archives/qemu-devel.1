Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EECC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B1C20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L61geNtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B1C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEOt-0008RS-86
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEOA-0007aR-Tl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:02:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEO9-0005z5-GG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595422944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yr1CGgd6WDzMgvUeb/6N1RZejGtuOVs/NxBt67a6fu8=;
 b=L61geNtNfXYJFolhsW89Q0mqjYm6Y3To6PMBU7HhiqBwDFOdJjwyVjOtB2i+qIxmtKh822
 BPrh6KeponAo7b6hyIlZzcoNZgSDEz8PwVrskRqj5fUmcRAyc/BKWs41kAK03gOo+ElbBO
 /rhF8VzFgFAVSYO+EIETKrRUFymd4bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-q8e5NzvpOsuFUaUlqGZh-A-1; Wed, 22 Jul 2020 09:02:22 -0400
X-MC-Unique: q8e5NzvpOsuFUaUlqGZh-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDD9157
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 13:02:21 +0000 (UTC)
Received: from localhost (ovpn-114-42.ams2.redhat.com [10.36.114.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A33E28559;
 Wed, 22 Jul 2020 13:02:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 1/3] virtiofsd: drop CAP_DAC_READ_SEARCH
Date: Wed, 22 Jul 2020 14:02:04 +0100
Message-Id: <20200722130206.224898-2-stefanha@redhat.com>
In-Reply-To: <20200722130206.224898-1-stefanha@redhat.com>
References: <20200722130206.224898-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dmlydGlvZnNkIGRvZXMgbm90IG5lZWQgQ0FQX0RBQ19SRUFEX1NFQVJDSCBiZWNhdXNlIGl0IGFs
cmVhZHkgaGFzCnRoZSBtb3JlIHBvd2VyZnVsIENBUF9EQUNfT1ZFUlJJREUuIERyb3AgaXQgZnJv
bSB0aGUgbGlzdCBvZgpjYXBhYmlsaXRpZXMuCgpUaGlzIGlzIGltcG9ydGFudCBiZWNhdXNlIGNv
bnRhaW5lciBydW50aW1lcyBtYXkgbm90IGluY2x1ZGUKQ0FQX0RBQ19SRUFEX1NFQVJDSCBieSBk
ZWZhdWx0LiBUaGlzIHBhdGNoIGFsbG93cyB2aXJ0aW9mc2QgdG8gcmVkdWNlCml0cyBjYXBhYmls
aXRpZXMgd2hlbiBydW5uaW5nIGluc2lkZSBhIERvY2tlciBjb250YWluZXIuCgpOb3RlIHRoYXQg
Q0FQX0RBQ19SRUFEX1NFQVJDSCBtYXkgYmUgbmVjZXNzYXJ5IGFnYWluIGluIHRoZSBmdXR1cmUg
aWYKdmlydGlvZnNkIHN0YXJ0cyB1c2luZyBvcGVuX2J5X2hhbmRsZV9hdCgyKS4KClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0b29scy92
aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS90b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYyBiL3Rv
b2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5jCmluZGV4IDk0ZTBkZTJkMmIuLjUwYTE2NGE1
OTkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5jCisrKyBiL3Rv
b2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5jCkBAIC0yNTk2LDcgKzI1OTYsNiBAQCBzdGF0
aWMgdm9pZCBzZXR1cF9jYXBhYmlsaXRpZXMoY2hhciAqbW9kY2Fwc19pbikKICAgICBpZiAoY2Fw
bmdfdXBkYXRldihDQVBOR19BREQsIENBUE5HX1BFUk1JVFRFRCB8IENBUE5HX0VGRkVDVElWRSwK
ICAgICAgICAgICAgIENBUF9DSE9XTiwKICAgICAgICAgICAgIENBUF9EQUNfT1ZFUlJJREUsCi0g
ICAgICAgICAgICBDQVBfREFDX1JFQURfU0VBUkNILAogICAgICAgICAgICAgQ0FQX0ZPV05FUiwK
ICAgICAgICAgICAgIENBUF9GU0VUSUQsCiAgICAgICAgICAgICBDQVBfU0VUR0lELAotLSAKMi4y
Ni4yCgo=


