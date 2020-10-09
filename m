Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B0422280
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRUvNK/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B0422280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyDU-0003H4-1R
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyBJ-0000Os-H6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyBG-0002s2-Fu
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EZdYt16YWuJFdVFl2nWGZ6CRGtlctxL0AjPsJnvegM=;
 b=XRUvNK/AGhZ4Xouo+4KS1KFOCO5It+px+ncvvMZllbUNEpjw9Z7j6Q0Rw/MtWZObTvK7DH
 XZ+/Mg6IKigRJMUv8YSVhXXiRMee4wQJ1zonwbu0uLE3+EG1uawnQGeoV1XTWOe7sCyXj3
 +pYAJcBcX5HUgWpqVxwkhWYM/C6++Uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-jPIay6yhNO6AWznXjExHnw-1; Fri, 09 Oct 2020 15:35:51 -0400
X-MC-Unique: jPIay6yhNO6AWznXjExHnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9288A805F05;
 Fri,  9 Oct 2020 19:35:50 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 675136EF6D;
 Fri,  9 Oct 2020 19:35:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 03/30] libvhost-user: remove watch for kick_fd when
 de-initialize vu-dev
Date: Fri,  9 Oct 2020 20:35:02 +0100
Message-Id: <20201009193529.322822-4-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQ29pYnkgWHUgPGNvaWJ5Lnh1QGdtYWlsLmNvbT4KCldoZW4gdGhlIGNsaWVudCBpcyBy
dW5uaW5nIGluIGdkYiBhbmQgcXVpdCBjb21tYW5kIGlzIHJ1biBpbiBnZGIsClFFTVUgd2lsbCBz
dGlsbCBkaXNwYXRjaCB0aGUgZXZlbnQgd2hpY2ggd2lsbCBjYXVzZSBzZWdtZW50IGZhdWx0IGlu
CnRoZSBjYWxsYmFjayBmdW5jdGlvbi4KClNpZ25lZC1vZmYtYnk6IENvaWJ5IFh1IDxjb2lieS54
dUBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA5MTgwODA5MTIuMzIxMjk5LTMtY29pYnkueHVA
Z21haWwuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KLS0tCiBjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jIHwgMSArCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9jb250cmliL2xpYnZo
b3N0LXVzZXIvbGlidmhvc3QtdXNlci5jIGIvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0
LXVzZXIuYwppbmRleCAwOWJkZmYxOGYzLi5iZmVjOGE4ODFhIDEwMDY0NAotLS0gYS9jb250cmli
L2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jCisrKyBiL2NvbnRyaWIvbGlidmhvc3QtdXNl
ci9saWJ2aG9zdC11c2VyLmMKQEAgLTE5MTgsNiArMTkxOCw3IEBAIHZ1X2RlaW5pdChWdURldiAq
ZGV2KQogICAgICAgICB9CiAKICAgICAgICAgaWYgKHZxLT5raWNrX2ZkICE9IC0xKSB7CisgICAg
ICAgICAgICBkZXYtPnJlbW92ZV93YXRjaChkZXYsIHZxLT5raWNrX2ZkKTsKICAgICAgICAgICAg
IGNsb3NlKHZxLT5raWNrX2ZkKTsKICAgICAgICAgICAgIHZxLT5raWNrX2ZkID0gLTE7CiAgICAg
ICAgIH0KLS0gCjIuMjYuMgoK


