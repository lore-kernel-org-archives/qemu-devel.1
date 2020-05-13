Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF12C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B2E20675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duJoZTmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B2E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrxx-0001Ot-6P
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jYrwX-0000NI-Gk
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:01:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jYrwW-0002zh-Km
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589378463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elJpFRjL7L8vS4tJJiDj0rgRnL8BOZyY/mJqzTqXtQ0=;
 b=duJoZTmSISnomQu790NoMPhGZ8tyHRLwyIvh1jJredpoREtcFsm90vngCQyN8Rw/URuzAd
 Vl3T8KjS9syRNzDXJJjMLR9VAnPn1AF570M0xQryOFnXM5R9xgn5nH5fI210ERd4ZpZEtQ
 8wuicl+TawAa7TCU+Yc2L+8387rxhHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-VPbIUzHZP4yvam144kgtAQ-1; Wed, 13 May 2020 10:01:01 -0400
X-MC-Unique: VPbIUzHZP4yvam144kgtAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E790F53;
 Wed, 13 May 2020 14:00:59 +0000 (UTC)
Received: from localhost (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 612966B8C1;
 Wed, 13 May 2020 14:00:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] hostmem: don't use mbind() if host-nodes is empty
Date: Wed, 13 May 2020 10:00:57 -0400
Message-Id: <20200513140057.576234-2-ehabkost@redhat.com>
In-Reply-To: <20200513140057.576234-1-ehabkost@redhat.com>
References: <20200513140057.576234-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
The backend however calls mbind() which is typically NOP
in case of default policy/absent host-nodes bitmap.
However when runing in container with black-listed mbind()
syscall, QEMU fails to start with error
 "cannot bind memory to host NUMA nodes: Operation not permitted"
even when user hasn't provided host-nodes to pin to explictly
(which is the case with -m option)

To fix issue, call mbind() only in case when user has provided
host-nodes explicitly (i.e. host_nodes bitmap is not empty).
That should allow to run QEMU in containers with black-listed
mbind() without memory pinning. If QEMU provided memory-pinning
is required user still has to white-list mbind() in container
configuration.

Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200430154606.6421-1-imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 327f9eebc3..0efd7b7bd6 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         assert(sizeof(backend->host_nodes) >=
                BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
         assert(maxnode <= MAX_NODES);
-        if (mbind(ptr, sz, backend->policy,
-                  maxnode ? backend->host_nodes : NULL, maxnode + 1, flags)) {
+
+        if (maxnode &&
+            mbind(ptr, sz, backend->policy, backend->host_nodes, maxnode + 1,
+                  flags)) {
             if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
                 error_setg_errno(errp, errno,
                                  "cannot bind memory to host NUMA nodes");
-- 
2.26.2


