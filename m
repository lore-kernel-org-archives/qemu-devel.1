Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417AAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0795120729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfmU9/9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0795120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEOk-0008FX-6f
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEO4-0007VU-C1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:02:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEO2-0005xw-Ak
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595422937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oDpcY7ez8wSBK04VaUdTLgUobPM5eBs/gRy4DYtUGuQ=;
 b=OfmU9/9DUzUsusWhGk7XfGUEsRgOxKJEAeWcLkLBj9HxQEvRYqsyh0yHm1eN4Y2K/s9XJ6
 kr3BG4aCzP3LtPQZjNFn5B8hUip8acXbQdeFOdgiSpnsVE4/Iy8AADSWbiqH+3n643tQPF
 xGlGAfFuqTcng4TmGlWp9qJThT3WRZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-mTQYxpq2OzCNqdswKgc0JA-1; Wed, 22 Jul 2020 09:02:15 -0400
X-MC-Unique: mTQYxpq2OzCNqdswKgc0JA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56AB71923769
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 13:02:14 +0000 (UTC)
Received: from localhost (ovpn-114-42.ams2.redhat.com [10.36.114.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E57E8872FB;
 Wed, 22 Jul 2020 13:02:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/3] virtiofsd: allow virtiofsd to run in a container
Date: Wed, 22 Jul 2020 14:02:03 +0100
Message-Id: <20200722130206.224898-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

Q29udGFpbmVyIHJ1bnRpbWVzIGhhbmRsZSBuYW1lc3BhY2Ugc2V0dXAgYW5kIHJlbW92ZSBwcml2
aWxlZ2VzIG5lZWRlZCBieQ0KdmlydGlvZnNkIHRvIHBlcmZvcm0gc2FuZGJveGluZy4gTHVja2ls
eSB0aGUgY29udGFpbmVyIGVudmlyb25tZW50IGFscmVhZHkNCnByb3ZpZGVzIG1vc3Qgb2YgdGhl
IHNhbmRib3ggdGhhdCB2aXJ0aW9mc2QgbmVlZHMgZm9yIHNlY3VyaXR5Lg0KDQpJbnRyb2R1Y2Ug
YSBuZXcgInZpcnRpb2ZzZCAtbyBjaHJvb3QiIG9wdGlvbiB0aGF0IHVzZXMgY2hyb290KDIpIGlu
c3RlYWQgb2YNCm5hbWVzcGFjZXMuIFRoaXMgb3B0aW9uIGFsbG93cyB2aXJ0aW9mc2QgdG8gd29y
ayBpbnNpZGUgYSBjb250YWluZXIuDQoNClBsZWFzZSBzZWUgdGhlIGluZGl2aWR1YWwgcGF0Y2hl
cyBmb3IgZGV0YWlscyBvbiB0aGUgY2hhbmdlcyBhbmQgc2VjdXJpdHkNCmltcGxpY2F0aW9ucy4N
Cg0KR2l2ZW4gdGhhdCBwZW9wbGUgYXJlIHN0YXJ0aW5nIHRvIGF0dGVtcHQgcnVubmluZyB2aXJ0
aW9mc2QgaW4gY29udGFpbmVycyBJDQp0aGluayB0aGlzIHNob3VsZCBnbyBpbnRvIFFFTVUgNS4x
Lg0KDQpTdGVmYW4gSGFqbm9jemkgKDMpOg0KICB2aXJ0aW9mc2Q6IGRyb3AgQ0FQX0RBQ19SRUFE
X1NFQVJDSA0KICB2aXJ0aW9mc2Q6IGFkZCBjb250YWluZXItZnJpZW5kbHkgLW8gY2hyb290IHNh
bmRib3hpbmcgb3B0aW9uDQogIHZpcnRpb2ZzZDogcHJvYmUgdW5zaGFyZShDTE9ORV9GUykgYW5k
IHByaW50IGFuIGVycm9yDQoNCiB0b29scy92aXJ0aW9mc2QvZnVzZV92aXJ0aW8uYyAgICB8IDEz
ICsrKysrKysrKw0KIHRvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIuYyAgICAgICAgIHwgIDMgKysrDQog
dG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgfCA0NSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KLS0gDQoyLjI2LjINCg0K


