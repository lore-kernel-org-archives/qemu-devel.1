Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5402074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0C+0csl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5402074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08Pj-000427-52
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k08OU-0002y7-4Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:02:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k08OR-0007I3-Gq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595876553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=US8Pt7QJOnv4S7blifgxVX8+m8OxZb8Dr/ndHjUvHtk=;
 b=e0C+0cslthGr+QxnhqBA+8b7/qILY9mybYFuMC0AFe794/Q4yFPcXKGQi0at92tppeU7rS
 Pn4mH52VBLC+U1krbwyrNvKGU6hDidLpjz4DaWfZccYjjXcjYFisCDWeHSvCWiMXgfesEA
 7cZ+uFsTFh3WNikWdr4g43g9DC6QpTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-ly_nk1UsOyW_qHgdCO331A-1; Mon, 27 Jul 2020 15:02:32 -0400
X-MC-Unique: ly_nk1UsOyW_qHgdCO331A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C861DE1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 19:02:31 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B47FF5D9F3;
 Mon, 27 Jul 2020 19:02:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] virtiofsd: allow virtiofsd to run in a container
Date: Mon, 27 Jul 2020 20:02:20 +0100
Message-Id: <20200727190223.422280-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vromanso@redhat.com, Daniel Walsh <dwalsh@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rmohr@redhat.com,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, mpatel@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6DQogKiBVcGRhdGUgdmlydGlvZnNkLnJzdCBkb2N1bWVudGF0aW9uIG9uIHNhbmRib3hpbmcg
bW9kZXMNCiAqIENoYW5nZSBzeW50YXggdG8gLW8gc2FuZGJveD1uYW1lc3BhY2V8Y2hyb290DQog
KiBBZGQgY29tbWVudCBleHBsYWluaW5nIHRoYXQgdW5zaGFyZShDTE9ORV9GUykgaGFzIG5vIHZp
c2libGUgc2lkZS1lZmZlY3QNCiAgIHdoaWxlIHNpbmdsZS10aHJlYWRlZA0KICogeGZzdGVzdHMg
YW5kIHBqZGZzdGVzdCBwYXNzLiBEaWQgbm90IHJ1biB0ZXN0cyBvbiBvdmVybGF5ZnMgYmVjYXVz
ZSByZXF1aXJlZA0KICAgeGF0dHJzIGRvIG5vdCB3b3JrIHdpdGhvdXQgQ0FQX1NZU19BRE1JTi4N
Cg0KTXJ1bmFsIGFuZCBEYW46IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgYSBzYW5kYm94aW5nIG1v
ZGUgd2hlcmUgdmlydGlvZnNkIHJlbGllcw0Kb24gdGhlIGNvbnRhaW5lciBydW50aW1lIGZvciBp
c29sYXRpb24uIEl0IG9ubHkgZG9lcw0KY2hyb290KCJwYXRoL3RvL3NoYXJlZC1kaXIiKSwgc2Vj
Y29tcCwgYW5kIGRyb3BzIExpbnV4IGNhcGFiaWxpdGllcy4gUHJldmlvdXNseQ0KaXQgY3JlYXRl
ZCBhIG5ldyBtb3VudCwgcGlkLCBhbmQgbmV0IG5hbWVzcGFjZSBidXQgY2Fubm90IGRvIHRoaXMg
d2l0aG91dA0KQ0FQX1NZU19BRE1JTiB3aGVuIHJ1biBpbnNpZGUgYSBjb250YWluZXIuIHBpdm90
X3Jvb3QoInBhdGgvdG8vc2hhcmVkLWRpciIpIGhhcw0KYmVlbiByZXBsYWNlZCB3aXRoIGNocm9v
dCgicGF0aC90by9zaGFyZWQtZGlyIiksIGFnYWluIGJlY2F1c2UgQ0FQX1NZU19BRE1JTiBpcw0K
dW5hdmFpbGFibGUuIFRoZSBwb2ludCBvZiB0aGUgY2hyb290KCkgaXMgdG8gcHJldmVudCBlc2Nh
cGVzIGZyb20gdGhlIHNoYXJlZA0KZGlyZWN0b3J5IGR1cmluZyBwYXRoIHRyYXZlcnNhbC4gRG9l
cyB0aGlzIHJpbmcgYW55IGFsYXJtIGJlbGxzIG9yIGRvZXMgaXQNCnNvdW5kIHNhbmU/DQoNCkNv
bnRhaW5lciBydW50aW1lcyBoYW5kbGUgbmFtZXNwYWNlIHNldHVwIGFuZCByZW1vdmUgcHJpdmls
ZWdlcyBuZWVkZWQgYnkNCnZpcnRpb2ZzZCB0byBwZXJmb3JtIHNhbmRib3hpbmcuIEx1Y2tpbHkg
dGhlIGNvbnRhaW5lciBlbnZpcm9ubWVudCBhbHJlYWR5DQpwcm92aWRlcyBtb3N0IG9mIHRoZSBz
YW5kYm94IHRoYXQgdmlydGlvZnNkIG5lZWRzIGZvciBzZWN1cml0eS4NCg0KSW50cm9kdWNlIGEg
bmV3ICJ2aXJ0aW9mc2QgLW8gc2FuZGJveD1jaHJvb3QiIG9wdGlvbiB0aGF0IHVzZXMgY2hyb290
KDIpDQppbnN0ZWFkIG9mIG5hbWVzcGFjZXMuIFRoaXMgb3B0aW9uIGFsbG93cyB2aXJ0aW9mc2Qg
dG8gd29yayBpbnNpZGUgYSBjb250YWluZXIuDQoNClBsZWFzZSBzZWUgdGhlIGluZGl2aWR1YWwg
cGF0Y2hlcyBmb3IgZGV0YWlscyBvbiB0aGUgY2hhbmdlcyBhbmQgc2VjdXJpdHkNCmltcGxpY2F0
aW9ucy4NCg0KR2l2ZW4gdGhhdCBwZW9wbGUgYXJlIHN0YXJ0aW5nIHRvIGF0dGVtcHQgcnVubmlu
ZyB2aXJ0aW9mc2QgaW4gY29udGFpbmVycyBJDQp0aGluayB0aGlzIHNob3VsZCBnbyBpbnRvIFFF
TVUgNS4xLg0KDQpTdGVmYW4gSGFqbm9jemkgKDMpOg0KICB2aXJ0aW9mc2Q6IGRyb3AgQ0FQX0RB
Q19SRUFEX1NFQVJDSA0KICB2aXJ0aW9mc2Q6IGFkZCBjb250YWluZXItZnJpZW5kbHkgLW8gc2Fu
ZGJveD1jaHJvb3Qgb3B0aW9uDQogIHZpcnRpb2ZzZDogcHJvYmUgdW5zaGFyZShDTE9ORV9GUykg
YW5kIHByaW50IGFuIGVycm9yDQoNCiB0b29scy92aXJ0aW9mc2QvZnVzZV92aXJ0aW8uYyAgICB8
IDE2ICsrKysrKysrKw0KIHRvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIuYyAgICAgICAgIHwgIDggKysr
KysNCiB0b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYyB8IDU4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tDQogZG9jcy90b29scy92aXJ0aW9mc2QucnN0ICAgICAgICAgfCAz
MiArKysrKysrKysrKysrKy0tLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI2LjINCg0K


