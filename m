Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA9E20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejaobmaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9E20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEPR-0001Gw-UT
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEOi-0008SS-BP
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:03:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEOe-00063D-NF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595422975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtaU6XyqFP8NrLJA88HkSXJMVAjAdcRT0OOcexGICOs=;
 b=ejaobmaAlIKEmzGAihgNplVWwZK2PX6s/rf7/rqevWlmNvpP5q+lx7V0zxoKM0/2Jv3tay
 1FohM9EdPSm6FtXKWBvip8Ml9C5ZJ6Da6Hg2vgAXntuq6g97Nz0scwi7FJq58G5sAikBK3
 5TBb+gX6PmUAwFE6sSVlPvzUhry+AoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-G4rBlAc3O-CIqbpyd23T0g-1; Wed, 22 Jul 2020 09:02:39 -0400
X-MC-Unique: G4rBlAc3O-CIqbpyd23T0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 480B559;
 Wed, 22 Jul 2020 13:02:38 +0000 (UTC)
Received: from localhost (ovpn-114-42.ams2.redhat.com [10.36.114.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B29EC619B5;
 Wed, 22 Jul 2020 13:02:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Date: Wed, 22 Jul 2020 14:02:06 +0100
Message-Id: <20200722130206.224898-4-stefanha@redhat.com>
In-Reply-To: <20200722130206.224898-1-stefanha@redhat.com>
References: <20200722130206.224898-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
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
Cc: vromanso@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QW4gYXNzZXJ0aW9uIGZhaWx1cmUgaXMgcmFpc2VkIGR1cmluZyByZXF1ZXN0IHByb2Nlc3Npbmcg
aWYKdW5zaGFyZShDTE9ORV9GUykgZmFpbHMuIEltcGxlbWVudCBhIHByb2JlIGF0IHN0YXJ0dXAg
c28gdGhlIHByb2JsZW0gY2FuCmJlIGRldGVjdGVkIHJpZ2h0IGF3YXkuCgpVbmZvcnR1bmF0ZWx5
IERvY2tlci9Nb2J5IGRvZXMgbm90IGluY2x1ZGUgdW5zaGFyZSBpbiB0aGUgc2VjY29tcC5qc29u
Cmxpc3QgdW5sZXNzIENBUF9TWVNfQURNSU4gaXMgZ2l2ZW4uIE90aGVyIHNlY2NvbXAuanNvbiBs
aXN0cyBhbHdheXMKaW5jbHVkZSB1bnNoYXJlIChlLmcuIHBvZG1hbiBpcyB1bmFmZmVjdGVkKToK
aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3NlY2NvbXAvY29udGFpbmVycy1nb2xh
bmcvbWFzdGVyL3NlY2NvbXAuanNvbgoKVXNlICJkb2NrZXIgcnVuIC0tc2VjdXJpdHktb3B0IHNl
Y2NvbXA9cGF0aC90by9zZWNjb21wLmpzb24gLi4uIiBpZiB0aGUKZGVmYXVsdCBzZWNjb21wLmpz
b24gaXMgbWlzc2luZyB1bnNoYXJlLgoKQ2M6IE1pc29ubyBUb21vaGlybyA8bWlzb25vLnRvbW9o
aXJvQGpwLmZ1aml0c3UuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMgfCAxMyAr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX3ZpcnRpby5jIGIvdG9vbHMvdmlydGlvZnNkL2Z1c2Vf
dmlydGlvLmMKaW5kZXggM2I2ZDE2YTA0MS4uZWJlYjM1MjUxNCAxMDA2NDQKLS0tIGEvdG9vbHMv
dmlydGlvZnNkL2Z1c2VfdmlydGlvLmMKKysrIGIvdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlv
LmMKQEAgLTk0OSw2ICs5NDksMTkgQEAgaW50IHZpcnRpb19zZXNzaW9uX21vdW50KHN0cnVjdCBm
dXNlX3Nlc3Npb24gKnNlKQogewogICAgIGludCByZXQ7CiAKKyAgICAvKgorICAgICAqIFRlc3Qg
dGhhdCB1bnNoYXJlKENMT05FX0ZTKSB3b3Jrcy4gZnZfcXVldWVfd29ya2VyKCkgd2lsbCBuZWVk
IGl0LiBJdCdzCisgICAgICogYW4gdW5wcml2aWxlZ2VkIHN5c3RlbSBjYWxsIGJ1dCBzb21lIERv
Y2tlci9Nb2J5IHZlcnNpb25zIGFyZSBrbm93biB0bworICAgICAqIHJlamVjdCBpdCB2aWEgc2Vj
Y29tcCB3aGVuIENBUF9TWVNfQURNSU4gaXMgbm90IGdpdmVuLgorICAgICAqLworICAgIHJldCA9
IHVuc2hhcmUoQ0xPTkVfRlMpOworICAgIGlmIChyZXQgPT0gLTEgJiYgZXJybm8gPT0gRVBFUk0p
IHsKKyAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLCAidW5zaGFyZShDTE9ORV9GUykgZmFp
bGVkIHdpdGggRVBFUk0uIElmICIKKyAgICAgICAgICAgICAgICAicnVubmluZyBpbiBhIGNvbnRh
aW5lciBwbGVhc2UgY2hlY2sgdGhhdCB0aGUgY29udGFpbmVyICIKKyAgICAgICAgICAgICAgICAi
cnVudGltZSBzZWNjb21wIHBvbGljeSBhbGxvd3MgdW5zaGFyZS5cbiIpOworICAgICAgICByZXR1
cm4gLTE7CisgICAgfQorCiAgICAgcmV0ID0gZnZfY3JlYXRlX2xpc3Rlbl9zb2NrZXQoc2UpOwog
ICAgIGlmIChyZXQgPCAwKSB7CiAgICAgICAgIHJldHVybiByZXQ7Ci0tIAoyLjI2LjIKCg==


