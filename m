Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C15C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC61206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnzdAXgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC61206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYpw-0001G0-PC
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYlA-0003wi-NU
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYl9-00050Q-B7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603366074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EZdYt16YWuJFdVFl2nWGZ6CRGtlctxL0AjPsJnvegM=;
 b=NnzdAXgOtKeSYYyeU2eG1RQ57MditJijYmSGSyhugEUt8ivhokfciBJ0KjGxZCbixnGBWB
 Dk4XZ/R8KyfTzRaqFiuY/kHhE22xgTN1Ac69c9mVUkwsOFRSQLebFxPCj3vyjOBlX9FqmP
 IypQJtUX8/BFSo9ggIj/7dsFEZyBCxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-1vUfS6dkPO-LaE49Hl6_ZQ-1; Thu, 22 Oct 2020 07:27:49 -0400
X-MC-Unique: 1vUfS6dkPO-LaE49Hl6_ZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A671084D78;
 Thu, 22 Oct 2020 11:27:48 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7691919C4F;
 Thu, 22 Oct 2020 11:27:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 03/28] libvhost-user: remove watch for kick_fd when
 de-initialize vu-dev
Date: Thu, 22 Oct 2020 12:27:01 +0100
Message-Id: <20201022112726.736757-4-stefanha@redhat.com>
In-Reply-To: <20201022112726.736757-1-stefanha@redhat.com>
References: <20201022112726.736757-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
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


