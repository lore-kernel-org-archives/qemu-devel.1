Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BBEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6916D20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eG2qsuml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6916D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEPq-0001vu-ON
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEOI-0007nl-P5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:02:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44193
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyEOH-00060r-20
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595422952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAuM4mefPmI3Vs+rJUkeuqoZLzhq6DcjUvSlKGO0anc=;
 b=eG2qsuml4r61nuXUAVffPJ7jVVXoKK1Jz2aereaWpQj4RS6C16DZkkXB74bnkfnqgoRtKo
 WyyCc0IeoYeJjSRlG517pTMRI5a1d7bp3H6hvND6KGQeoMeSt79b+7EQjS1RM5H3UujNjy
 A7ulWsOFIvfc2dhFDskq1Z+DB+KYOLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-Hif9rI84OqupGnjWkK6AMQ-1; Wed, 22 Jul 2020 09:02:30 -0400
X-MC-Unique: Hif9rI84OqupGnjWkK6AMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89F3A91271
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 13:02:29 +0000 (UTC)
Received: from localhost (ovpn-114-42.ams2.redhat.com [10.36.114.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05D2C1001B0B;
 Wed, 22 Jul 2020 13:02:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 2/3] virtiofsd: add container-friendly -o chroot
 sandboxing option
Date: Wed, 22 Jul 2020 14:02:05 +0100
Message-Id: <20200722130206.224898-3-stefanha@redhat.com>
In-Reply-To: <20200722130206.224898-1-stefanha@redhat.com>
References: <20200722130206.224898-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dmlydGlvZnNkIGNhbm5vdCBydW4gaW4gYW4gdW5wcml2aWxlZ2VkIGNvbnRhaW5lciBiZWNhdXNl
IENBUF9TWVNfQURNSU4KaXMgcmVxdWlyZWQgdG8gY3JlYXRlIG5hbWVzcGFjZXMuCgpJbnRyb2R1
Y2UgYSB3ZWFrZXIgc2FuZGJveCB0aGF0IGlzIHN1ZmZpY2llbnQgaW4gY29udGFpbmVyIGVudmly
b25tZW50cwpiZWNhdXNlIHRoZSBjb250YWluZXIgcnVudGltZSBhbHJlYWR5IHNldHMgdXAgbmFt
ZXNwYWNlcy4gVXNlIGNocm9vdCB0bwpyZXN0cmljdCBwYXRoIHRyYXZlcnNhbCB0byB0aGUgc2hh
cmVkIGRpcmVjdG9yeS4KCnZpcnRpb2ZzZCBsb3NlcyB0aGUgZm9sbG93aW5nOgoKMS4gTW91bnQg
bmFtZXNwYWNlLiBUaGUgcHJvY2VzcyBjaHJvb3RzIHRvIHRoZSBzaGFyZWQgZGlyZWN0b3J5IGJ1
dAogICBsZWF2ZXMgdGhlIG1vdW50cyBpbiBwbGFjZS4gU2VjY29tcCByZWplY3RzIG1vdW50KDIp
L3Vtb3VudCgyKQogICBzeXNjYWxscy4KCjIuIFBpZCBuYW1lc3BhY2UuIFRoaXMgc2hvdWxkIGJl
IGZpbmUgYmVjYXVzZSB2aXJ0aW9mc2QgaXMgdGhlIG9ubHkKICAgcHJvY2VzcyBydW5uaW5nIGlu
IHRoZSBjb250YWluZXIuCgozLiBOZXR3b3JrIG5hbWVzcGFjZS4gVGhpcyBzaG91bGQgYmUgZmlu
ZSBiZWNhdXNlIHNlY2NvbXAgYWxyZWFkeQogICByZWplY3RzIHRoZSBjb25uZWN0KDIpIHN5c2Nh
bGwsIGJ1dCBhbiBhZGRpdGlvbmFsIGxheWVyIG9mIHNlY3VyaXR5CiAgIGlzIGxvc3QuIENvbnRh
aW5lciBydW50aW1lLXNwZWNpZmljIG5ldHdvcmsgc2VjdXJpdHkgcG9saWNpZXMgY2FuIGJlCiAg
IHVzZWQgZHJvcCBuZXR3b3JrIHRyYWZmaWMgKGV4Y2VwdCBmb3IgdGhlIHZob3N0LXVzZXIgVU5J
WCBkb21haW4KICAgc29ja2V0KS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0b29scy92aXJ0aW9mc2QvaGVscGVyLmMgICAgICAgICB8
ICAzICsrKwogdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgfCA0NCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIuYyBi
L3Rvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIuYwppbmRleCAzMTA1YjZjMjNhLi43NDIxYzljYTFhIDEw
MDY0NAotLS0gYS90b29scy92aXJ0aW9mc2QvaGVscGVyLmMKKysrIGIvdG9vbHMvdmlydGlvZnNk
L2hlbHBlci5jCkBAIC0xNTEsNiArMTUxLDkgQEAgdm9pZCBmdXNlX2NtZGxpbmVfaGVscCh2b2lk
KQogICAgICAgICAgICAiICAgIC1vIGNhY2hlPTxtb2RlPiAgICAgICAgICAgIGNhY2hlIG1vZGUu
IGNvdWxkIGJlIG9uZSBvZiBcImF1dG8sICIKICAgICAgICAgICAgImFsd2F5cywgbm9uZVwiXG4i
CiAgICAgICAgICAgICIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVsdDogYXV0
b1xuIgorICAgICAgICAgICAiICAgIC1vIGNocm9vdHxub19jaHJvb3QgICAgICAgIHVzZSBjb250
YWluZXItZnJpZW5kbHkgY2hyb290IGluc3RlYWRcbiIKKyAgICAgICAgICAgIiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBvZiBzdHJvbmdlciBtb3VudCBuYW1lc3BhY2Ugc2FuZGJveFxu
IgorICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQ6IGZh
bHNlXG4iCiAgICAgICAgICAgICIgICAgLW8gZmxvY2t8bm9fZmxvY2sgICAgICAgICAgZW5hYmxl
L2Rpc2FibGUgZmxvY2tcbiIKICAgICAgICAgICAgIiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZWZhdWx0OiBub19mbG9ja1xuIgogICAgICAgICAgICAiICAgIC1vIGxvZ19sZXZlbD08
bGV2ZWw+ICAgICAgIGxvZyBsZXZlbCwgZGVmYXVsdCB0byBcImluZm9cIlxuIgpkaWZmIC0tZ2l0
IGEvdG9vbHMvdmlydGlvZnNkL3Bhc3N0aHJvdWdoX2xsLmMgYi90b29scy92aXJ0aW9mc2QvcGFz
c3Rocm91Z2hfbGwuYwppbmRleCA1MGExNjRhNTk5Li45OTBjMGE4YTcwIDEwMDY0NAotLS0gYS90
b29scy92aXJ0aW9mc2QvcGFzc3Rocm91Z2hfbGwuYworKysgYi90b29scy92aXJ0aW9mc2QvcGFz
c3Rocm91Z2hfbGwuYwpAQCAtMTM5LDYgKzEzOSw3IEBAIGVudW0gewogCiBzdHJ1Y3QgbG9fZGF0
YSB7CiAgICAgcHRocmVhZF9tdXRleF90IG11dGV4OworICAgIGludCBjaHJvb3Q7IC8qIDEgLSB1
c2UgY2hyb290LCAwIC0gdXNlIG1vdW50IG5hbWVzcGFjZSAqLwogICAgIGludCBkZWJ1ZzsKICAg
ICBpbnQgd3JpdGViYWNrOwogICAgIGludCBmbG9jazsKQEAgLTE2Miw2ICsxNjMsOCBAQCBzdHJ1
Y3QgbG9fZGF0YSB7CiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGZ1c2Vfb3B0IGxvX29wdHNb
XSA9IHsKKyAgICB7ICJjaHJvb3QiLCBvZmZzZXRvZihzdHJ1Y3QgbG9fZGF0YSwgY2hyb290KSwg
MSB9LAorICAgIHsgIm5vX2Nocm9vdCIsIG9mZnNldG9mKHN0cnVjdCBsb19kYXRhLCBjaHJvb3Qp
LCAwIH0sCiAgICAgeyAid3JpdGViYWNrIiwgb2Zmc2V0b2Yoc3RydWN0IGxvX2RhdGEsIHdyaXRl
YmFjayksIDEgfSwKICAgICB7ICJub193cml0ZWJhY2siLCBvZmZzZXRvZihzdHJ1Y3QgbG9fZGF0
YSwgd3JpdGViYWNrKSwgMCB9LAogICAgIHsgInNvdXJjZT0lcyIsIG9mZnNldG9mKHN0cnVjdCBs
b19kYXRhLCBzb3VyY2UpLCAwIH0sCkBAIC0yNjY1LDYgKzI2NjgsMzcgQEAgc3RhdGljIHZvaWQg
c2V0dXBfY2FwYWJpbGl0aWVzKGNoYXIgKm1vZGNhcHNfaW4pCiAgICAgcHRocmVhZF9tdXRleF91
bmxvY2soJmNhcC5tdXRleCk7CiB9CiAKKy8qCisgKiBVc2UgY2hyb290IGFzIGEgd2Vha2VyIHNh
bmRib3ggZm9yIGVudmlyb25tZW50IHdoZXJlIHRoZSBwcm9jZXNzIGlzIGxhdW5jaGVkCisgKiB3
aXRob3V0IENBUF9TWVNfQURNSU4uCisgKi8KK3N0YXRpYyB2b2lkIHNldHVwX2Nocm9vdChzdHJ1
Y3QgbG9fZGF0YSAqbG8pCit7CisgICAgbG8tPnByb2Nfc2VsZl9mZCA9IG9wZW4oIi9wcm9jL3Nl
bGYvZmQiLCBPX1BBVEgpOworICAgIGlmIChsby0+cHJvY19zZWxmX2ZkID09IC0xKSB7CisgICAg
ICAgIGZ1c2VfbG9nKEZVU0VfTE9HX0VSUiwgIm9wZW4oXCIvcHJvYy9zZWxmL2ZkXCIsIE9fUEFU
SCk6ICVtXG4iKTsKKyAgICAgICAgZXhpdCgxKTsKKyAgICB9CisKKyAgICAvKgorICAgICAqIE1h
a2UgdGhlIHNoYXJlZCBkaXJlY3RvcnkgdGhlIGZpbGUgc3lzdGVtIHJvb3Qgc28gdGhhdCBGVVNF
X09QRU4KKyAgICAgKiAobG9fb3BlbigpKSBjYW5ub3QgZXNjYXBlIHRoZSBzaGFyZWQgZGlyZWN0
b3J5IGJ5IG9wZW5pbmcgYSBzeW1saW5rLgorICAgICAqCisgICAgICogSXQncyBzdGlsbCBwb3Nz
aWJsZSB0byBlc2NhcGUgdGhlIGNocm9vdCB2aWEgbG8tPnByb2Nfc2VsZl9mZCBidXQgdGhhdAor
ICAgICAqIHJlcXVpcmVzIGdhaW5pbmcgY29udHJvbCBvZiB0aGUgcHJvY2VzcyBmaXJzdC4KKyAg
ICAgKi8KKyAgICBpZiAoY2hyb290KGxvLT5zb3VyY2UpICE9IDApIHsKKyAgICAgICAgZnVzZV9s
b2coRlVTRV9MT0dfRVJSLCAiY2hyb290KFwiJXNcIik6ICVtXG4iLCBsby0+c291cmNlKTsKKyAg
ICAgICAgZXhpdCgxKTsKKyAgICB9CisKKyAgICAvKiBNb3ZlIGludG8gdGhlIGNocm9vdCAqLwor
ICAgIGlmIChjaGRpcigiLyIpICE9IDApIHsKKyAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJS
LCAiY2hkaXIoXCIvXCIpOiAlbVxuIik7CisgICAgICAgIGV4aXQoMSk7CisgICAgfQorfQorCiAv
KgogICogTG9jayBkb3duIHRoaXMgcHJvY2VzcyB0byBwcmV2ZW50IGFjY2VzcyB0byBvdGhlciBw
cm9jZXNzZXMgb3IgZmlsZXMgb3V0c2lkZQogICogc291cmNlIGRpcmVjdG9yeS4gIFRoaXMgcmVk
dWNlcyB0aGUgaW1wYWN0IG9mIGFyYml0cmFyeSBjb2RlIGV4ZWN1dGlvbiBidWdzLgpAQCAtMjY3
Miw4ICsyNzA2LDEzIEBAIHN0YXRpYyB2b2lkIHNldHVwX2NhcGFiaWxpdGllcyhjaGFyICptb2Rj
YXBzX2luKQogc3RhdGljIHZvaWQgc2V0dXBfc2FuZGJveChzdHJ1Y3QgbG9fZGF0YSAqbG8sIHN0
cnVjdCBmdXNlX3Nlc3Npb24gKnNlLAogICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGVu
YWJsZV9zeXNsb2cpCiB7Ci0gICAgc2V0dXBfbmFtZXNwYWNlcyhsbywgc2UpOwotICAgIHNldHVw
X21vdW50cyhsby0+c291cmNlKTsKKyAgICBpZiAobG8tPmNocm9vdCkgeworICAgICAgICBzZXR1
cF9jaHJvb3QobG8pOworICAgIH0gZWxzZSB7CisgICAgICAgIHNldHVwX25hbWVzcGFjZXMobG8s
IHNlKTsKKyAgICAgICAgc2V0dXBfbW91bnRzKGxvLT5zb3VyY2UpOworICAgIH0KKwogICAgIHNl
dHVwX3NlY2NvbXAoZW5hYmxlX3N5c2xvZyk7CiAgICAgc2V0dXBfY2FwYWJpbGl0aWVzKGdfc3Ry
ZHVwKGxvLT5tb2RjYXBzKSk7CiB9CkBAIC0yODIwLDYgKzI4NTksNyBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQogICAgIHN0cnVjdCBmdXNlX3Nlc3Npb24gKnNlOwogICAgIHN0
cnVjdCBmdXNlX2NtZGxpbmVfb3B0cyBvcHRzOwogICAgIHN0cnVjdCBsb19kYXRhIGxvID0gewor
ICAgICAgICAuY2hyb290ID0gMCwKICAgICAgICAgLmRlYnVnID0gMCwKICAgICAgICAgLndyaXRl
YmFjayA9IDAsCiAgICAgICAgIC5wb3NpeF9sb2NrID0gMSwKLS0gCjIuMjYuMgoK


