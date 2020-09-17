Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5CCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF3B20838
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpxtbqCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF3B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqWt-0003Dz-2u
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqTX-0000GY-An
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIqTV-0008Jv-Nt
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600335908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O9mDTYA5qe8qu/X/1UavXBVpYchW1cXUNFPPY7AUkDI=;
 b=hpxtbqCGpisDKRuRcFAzNOyfaxBafimVdNe4FMKBYpej3YT0MwaYpT0rtwuWk7493oxElq
 9qGm/nxsVbo99/Hf5Pwy/eM4Ug65PdTPEBaDuFIl+YF9joDutWIvupiCMBfZ+9zmN1V4hs
 M7T/l4HDG5aHAMqMWCXY80sfkgiXwHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-hxCNU_7LPWuVj0bJuJwHbg-1; Thu, 17 Sep 2020 05:45:04 -0400
X-MC-Unique: hxCNU_7LPWuVj0bJuJwHbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15CC018B9ED1;
 Thu, 17 Sep 2020 09:45:03 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 293CE1992F;
 Thu, 17 Sep 2020 09:44:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] virtio: restore elem->in/out_sg after
 iov_discard_front/back()
Date: Thu, 17 Sep 2020 10:44:52 +0100
Message-Id: <20200917094455.822379-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djI6CiAqIEFkZCBtaXNzaW5nIHVuZG8gaW4gdmlydGlvLWJsayB3cml0ZSB6ZXJvZXMgZXJyb3Ig
cGF0aCBbTGkgUWlhbmddCgpCb3RoIHZpcnRpby1ibGsgYW5kIHZpcnRpby1jcnlwdG8gdXNlIGRl
c3RydWN0aXZlIGlvdl9kaXNjYXJkX2Zyb250L2JhY2soKQpvcGVyYXRpb25zIG9uIGVsZW0tPmlu
L291dF9zZy4gdmlydHF1ZXVlX3B1c2goKSBjYWxscyBkbWFfbWVtb3J5X3VubWFwKCkgb24gdGhl
Cm1vZGlmaWVkIGlvdmVjIGFycmF5cy4gVGhlIG1lbW9yeSBhZGRyZXNzZXMgbWF5IG5vdCBtYXRj
aCB0aG9zZSBvcmlnaW5hbGx5Cm1hcHBlZCB3aXRoIGRtYV9tZW1vcnlfbWFwKCkuCgpUaGlzIHJh
aXNlcyBzZXZlcmFsIGlzc3VlczoKMS4gTWVtb3J5UmVnaW9uIHJlZmVyZW5jZXMgY2FuIGJlIGxl
YWtlZC4KMi4gRGlydHkgbWVtb3J5IG1heSBub3QgYmUgdHJhY2tlZC4KMy4gVGhlIG5vbi1SQU0g
Ym91bmNlIGJ1ZmZlciBjYW4gYmUgbGVha2VkLgoKVGhpcyBwYXRjaCBzZXJpZXMgc29sdmVzIHRo
ZSBpc3N1ZSBpbiB0d28gd2F5czoKMS4gdmlydGlvLWJsayB1c2VzIGEgbmV3IGlvdl9kaXNjYXJk
X3VuZG8oKSBBUEkgdG8gcmVzdG9yZSBpb3ZlYyBhcnJheXMuCjIuIHZpcnRpby1jcnlwdG8gdXNl
cyBnX21lbWR1cCgpIHRvIGF2b2lkIG1vZGlmeWluZyB0aGUgb3JpZ2luYWwgaW92ZWMgYXJyYXlz
LgoKVGhlIGdfbWVtZHVwKCkgYXBwcm9hY2ggaXMgc2xvd2VyIHRoYW4gaW92X2Rpc2NhcmRfdW5k
bygpIGJ1dCBsZXNzCmNvbXBsZXgvZnJhZ2lsZS4gSSBhbSBsZXNzIGZhbWlsaWFyIHdpdGggdGhl
IHZpcnRpby1jcnlwdG8gY29kZSBhbmQgaXQgdXNlcwptb3JlIGNvbXBsZXggc2VxdWVuY2VzIG9m
IGlvdl9kaXNjYXJkX2Zyb250L2JhY2soKSBjYWxscyB0aGFuIHZpcnRpby1ibGsuIElmCmFueW9u
ZSBmZWVscyBsaWtlIG9wdGltaXppbmcgdmlydGlvLWNyeXB0bywgcGxlYXNlIGdvIGFoZWFkLgoK
VGhlIHZpcnRpby1ibGsgYnVnIHdhcyBmb3VuZCBieSBBbGV4YW5kZXIgQnVsZWtvdidzIGZ1enpp
bmcgZWZmb3J0LiBJIGZvdW5kIHRoZQp2aXJ0aW8tY3J5cHRvIGJ1ZyB0aHJvdWdoIGNvZGUgaW5z
cGVjdGlvbi4KClN0ZWZhbiBIYWpub2N6aSAoMyk6CiAgdXRpbC9pb3Y6IGFkZCBpb3ZfZGlzY2Fy
ZF91bmRvKCkKICB2aXJ0aW8tYmxrOiB1bmRvIGRlc3RydWN0aXZlIGlvdl9kaXNjYXJkXyooKSBv
cGVyYXRpb25zCiAgdmlydGlvLWNyeXB0bzogZG9uJ3QgbW9kaWZ5IGVsZW0tPmluL291dF9zZwoK
IGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ibGsuaCB8ICAgMiArCiBpbmNsdWRlL3FlbXUvaW92
LmggICAgICAgICAgICAgfCAgMjMgKysrKysKIGh3L2Jsb2NrL3ZpcnRpby1ibGsuYyAgICAgICAg
ICB8ICAxMSArKy0KIGh3L3ZpcnRpby92aXJ0aW8tY3J5cHRvLmMgICAgICB8ICAxNyArKystCiB0
ZXN0cy90ZXN0LWlvdi5jICAgICAgICAgICAgICAgfCAxNjUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiB1dGlsL2lvdi5jICAgICAgICAgICAgICAgICAgICAgfCAgNTAgKysrKysr
KysrLQogNiBmaWxlcyBjaGFuZ2VkLCAyNTkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkK
Ci0tIAoyLjI2LjIKCg==


