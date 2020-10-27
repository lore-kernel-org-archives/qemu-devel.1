Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C03C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4E62054F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQcEkyY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4E62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT08-0005UY-IU
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStx-0006KO-CT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStq-0003N8-Eo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yjv/jsRzpMBOMTMOOxfwrq2j/QcphVAypLqc78rRKyc=;
 b=hQcEkyY+4fTTby76zQQjWbKnm30bzcnSXR3fpdyaGGioYCz0Yni0l/sGkgi3qw7pKg4vtO
 TfudWZsKIfsf03geCtL3a62edxOc8wZQgeBW89jC68EdaGKUn1UhFG45SSquTs0bkEIx1e
 bmqxnrkb0a1g+35Pt7cuc1NBwkKynYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-kOWiYHyrPK-IruuNyr2Zqw-1; Tue, 27 Oct 2020 13:36:41 -0400
X-MC-Unique: kOWiYHyrPK-IruuNyr2Zqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8E48CFF52;
 Tue, 27 Oct 2020 17:36:39 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73D5A19C4F;
 Tue, 27 Oct 2020 17:36:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] vhost-user-blk-test: close fork child file descriptors
Date: Tue, 27 Oct 2020 17:35:26 +0000
Message-Id: <20201027173528.213464-11-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG8gbm90IGxlYXZlIHN0ZGluLCBzdGRvdXQsIHN0ZGVyciBvcGVuIGFmdGVyIGZvcmsuIHN0ZG91
dCBpcyB0aGUKdGFwLWRyaXZlci5wbCBwaXBlLiBJZiB3ZSBrZWVwIHRoZSBwaXBlIG9wZW4gdGhl
biB0YXAtZHJpdmVyLnBsIHdpbGwgbm90CmRldGVjdCB0aGF0IHFvcy10ZXN0IGhhcyB0ZXJtaW5h
dGVkIGFuZCBpdCB3aWxsIGhhbmcuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0
ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5j
IHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jIGIvdGVzdHMvcXRlc3Qv
dmhvc3QtdXNlci1ibGstdGVzdC5jCmluZGV4IGYwNWYxNGMxOTIuLjE1ZGFmOGNjYmMgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYworKysgYi90ZXN0cy9xdGVz
dC92aG9zdC11c2VyLWJsay10ZXN0LmMKQEAgLTc0OSw2ICs3NDksMTcgQEAgc3RhdGljIGNoYXIg
KnN0YXJ0X3Zob3N0X3VzZXJfYmxrKEdTdHJpbmcgKmNtZF9saW5lLCBpbnQgdnVzX2luc3RhbmNl
cywKICAgICAgICAgICAgICAgICAgICBzdG9yYWdlX2RhZW1vbl9jb21tYW5kLT5zdHIpOwogICAg
IHBpZF90IHBpZCA9IGZvcmsoKTsKICAgICBpZiAocGlkID09IDApIHsKKyAgICAgICAgLyoKKyAg
ICAgICAgICogQ2xvc2Ugc3RhbmRhcmQgZmlsZSBkZXNjcmlwdG9ycyBzbyB0YXAtZHJpdmVyLnBs
IHBpcGUgZGV0ZWN0cyB3aGVuCisgICAgICAgICAqIG91ciBwYXJlbnQgdGVybWluYXRlcy4KKyAg
ICAgICAgICovCisgICAgICAgIGNsb3NlKDApOworICAgICAgICBjbG9zZSgxKTsKKyAgICAgICAg
Y2xvc2UoMik7CisgICAgICAgIG9wZW4oIi9kZXYvbnVsbCIsIE9fUkRPTkxZKTsKKyAgICAgICAg
b3BlbigiL2Rldi9udWxsIiwgT19XUk9OTFkpOworICAgICAgICBvcGVuKCIvZGV2L251bGwiLCBP
X1dST05MWSk7CisKICAgICAgICAgZXhlY2xwKCIvYmluL3NoIiwgInNoIiwgIi1jIiwgc3RvcmFn
ZV9kYWVtb25fY29tbWFuZC0+c3RyLCBOVUxMKTsKICAgICAgICAgZXhpdCgxKTsKICAgICB9Ci0t
IAoyLjI2LjIKCg==


