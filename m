Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DDAC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C162086A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWiQpG9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C162086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlCO-0006k2-M5
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkxC-0007gF-8A
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKkx8-0007qq-SQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600791337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LX/tRWhvQdbHE+td9jJrkcTKAjU6Xk+V7/V7qmQ1XQ=;
 b=IWiQpG9+Sf9ZqS6VpSrNvfkarONCrh9HcrPzVU9D9XQX9hT6Q9O3xqw79vasDWm//IgAZI
 YWZa5okNUT0wZ31Zhsq60UByxvu1vjHHN2AFyodjUqZljwaR/1JvI6DOjZAHHeF7A2PTcn
 S0rQGnj2FxkvEnvoP6/YmkCFhiDYsRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-1BfTWMYWO1mSvl_7zg4Unw-1; Tue, 22 Sep 2020 12:04:17 -0400
X-MC-Unique: 1BfTWMYWO1mSvl_7zg4Unw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F382186841A;
 Tue, 22 Sep 2020 16:04:16 +0000 (UTC)
Received: from localhost (ovpn-115-55.ams2.redhat.com [10.36.115.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1817478825;
 Tue, 22 Sep 2020 16:04:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] util/vhost-user-server: drop unnecessary QOM cast
Date: Tue, 22 Sep 2020 17:03:53 +0100
Message-Id: <20200922160401.294055-4-stefanha@redhat.com>
In-Reply-To: <20200922160401.294055-1-stefanha@redhat.com>
References: <20200922160401.294055-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2UgYWxyZWFkeSBoYXZlIGFjY2VzcyB0byB0aGUgdmFsdWUgd2l0aCB0aGUgY29ycmVjdCB0eXBl
IChpb2MgYW5kIHNpb2MKYXJlIHRoZSBzYW1lIFFJT0NoYW5uZWwpLgoKU2lnbmVkLW9mZi1ieTog
U3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvdmhvc3QtdXNl
ci1zZXJ2ZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYyBiL3V0aWwvdmhv
c3QtdXNlci1zZXJ2ZXIuYwppbmRleCAyY2QwY2Y4Mjc3Li5lYmU0Nzg4NWY1IDEwMDY0NAotLS0g
YS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKKysrIGIvdXRpbC92aG9zdC11c2VyLXNlcnZlci5j
CkBAIC0zMzcsNyArMzM3LDcgQEAgc3RhdGljIHZvaWQgdnVfYWNjZXB0KFFJT05ldExpc3RlbmVy
ICpsaXN0ZW5lciwgUUlPQ2hhbm5lbFNvY2tldCAqc2lvYywKICAgICBzZXJ2ZXItPmlvYyA9IFFJ
T19DSEFOTkVMKHNpb2MpOwogICAgIG9iamVjdF9yZWYoT0JKRUNUKHNlcnZlci0+aW9jKSk7CiAg
ICAgcWlvX2NoYW5uZWxfYXR0YWNoX2Fpb19jb250ZXh0KHNlcnZlci0+aW9jLCBzZXJ2ZXItPmN0
eCk7Ci0gICAgcWlvX2NoYW5uZWxfc2V0X2Jsb2NraW5nKFFJT19DSEFOTkVMKHNlcnZlci0+c2lv
YyksIGZhbHNlLCBOVUxMKTsKKyAgICBxaW9fY2hhbm5lbF9zZXRfYmxvY2tpbmcoc2VydmVyLT5p
b2MsIGZhbHNlLCBOVUxMKTsKICAgICB2dV9jbGllbnRfc3RhcnQoc2VydmVyKTsKIH0KIAotLSAK
Mi4yNi4yCgo=


