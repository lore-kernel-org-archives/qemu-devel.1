Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0154CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99BA20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO+0w1AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99BA20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08R5-00065w-24
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k08Op-0003N3-20
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:02:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k08On-0007JG-5G
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595876575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DTzCWtkAYWXXwDS71eiC1B/ZYAtPEUDUkQAuCNxmV0=;
 b=FO+0w1AQKuhLRS/B0XsKaxVIJ4TMt6Vb1mgLYT+zNPAEPMRsQt2S9BkCcjqkaGLVlHNehH
 JPjyMMjjWE+qDtjPqC3rSlspO/EipRkXP7r2y6dVT16agPgHdzq+FXZslqNjIm3iUVlVNy
 qpga4EJjZK3iDUd1FZ7m2w5MBkNjG40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-5SAXAgUaPwKyb32WpT4kTw-1; Mon, 27 Jul 2020 15:02:50 -0400
X-MC-Unique: 5SAXAgUaPwKyb32WpT4kTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F2E106B243;
 Mon, 27 Jul 2020 19:02:48 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A84890E63;
 Mon, 27 Jul 2020 19:02:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an error
Date: Mon, 27 Jul 2020 20:02:23 +0100
Message-Id: <20200727190223.422280-4-stefanha@redhat.com>
In-Reply-To: <20200727190223.422280-1-stefanha@redhat.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 virtio-fs@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, mpatel@redhat.com, vgoyal@redhat.com
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
bmhhQHJlZGhhdC5jb20+Ci0tLQogdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMgfCAxNiAr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX3ZpcnRpby5jIGIvdG9vbHMvdmlydGlvZnNkL2Z1
c2VfdmlydGlvLmMKaW5kZXggM2I2ZDE2YTA0MS4uOWU1NTM3NTA2YyAxMDA2NDQKLS0tIGEvdG9v
bHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMKKysrIGIvdG9vbHMvdmlydGlvZnNkL2Z1c2Vfdmly
dGlvLmMKQEAgLTk0OSw2ICs5NDksMjIgQEAgaW50IHZpcnRpb19zZXNzaW9uX21vdW50KHN0cnVj
dCBmdXNlX3Nlc3Npb24gKnNlKQogewogICAgIGludCByZXQ7CiAKKyAgICAvKgorICAgICAqIFRl
c3QgdGhhdCB1bnNoYXJlKENMT05FX0ZTKSB3b3Jrcy4gZnZfcXVldWVfd29ya2VyKCkgd2lsbCBu
ZWVkIGl0LiBJdCdzCisgICAgICogYW4gdW5wcml2aWxlZ2VkIHN5c3RlbSBjYWxsIGJ1dCBzb21l
IERvY2tlci9Nb2J5IHZlcnNpb25zIGFyZSBrbm93biB0bworICAgICAqIHJlamVjdCBpdCB2aWEg
c2VjY29tcCB3aGVuIENBUF9TWVNfQURNSU4gaXMgbm90IGdpdmVuLgorICAgICAqCisgICAgICog
Tm90ZSB0aGF0IHRoZSBwcm9ncmFtIGlzIHNpbmdsZS10aHJlYWRlZCBoZXJlIHNvIHRoaXMgc3lz
Y2FsbCBoYXMgbm8KKyAgICAgKiB2aXNpYmxlIGVmZmVjdCBhbmQgaXMgc2FmZSB0byBtYWtlLgor
ICAgICAqLworICAgIHJldCA9IHVuc2hhcmUoQ0xPTkVfRlMpOworICAgIGlmIChyZXQgPT0gLTEg
JiYgZXJybm8gPT0gRVBFUk0pIHsKKyAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLCAidW5z
aGFyZShDTE9ORV9GUykgZmFpbGVkIHdpdGggRVBFUk0uIElmICIKKyAgICAgICAgICAgICAgICAi
cnVubmluZyBpbiBhIGNvbnRhaW5lciBwbGVhc2UgY2hlY2sgdGhhdCB0aGUgY29udGFpbmVyICIK
KyAgICAgICAgICAgICAgICAicnVudGltZSBzZWNjb21wIHBvbGljeSBhbGxvd3MgdW5zaGFyZS5c
biIpOworICAgICAgICByZXR1cm4gLTE7CisgICAgfQorCiAgICAgcmV0ID0gZnZfY3JlYXRlX2xp
c3Rlbl9zb2NrZXQoc2UpOwogICAgIGlmIChyZXQgPCAwKSB7CiAgICAgICAgIHJldHVybiByZXQ7
Ci0tIAoyLjI2LjIKCg==


