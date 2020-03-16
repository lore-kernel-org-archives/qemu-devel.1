Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8280AC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5074020658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7AMfBoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5074020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxSm-0002GI-F7
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHA-0002kr-Be
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH9-0001dE-2Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxH8-0001Z0-Sw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWSk6fKinz3OKAkyJIg3XMJxGORt82Mgq21y0f1z+g4=;
 b=a7AMfBoXmErQQnFqcJC8g7Au7A+tcb1nSGWaReOURl8WU8zhbgC9bhLPZm+a+oFdN6TVC9
 VcXiYMzt73JbJB6cu4qT5v72UfakkGltwSAIDCM8R3MhDrhf58m6r0CVeLM1EhUM9WSKD+
 mxsUojmGnGWnlwvFBveTz+L0V0NUdBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-615sNznOMaWIoWjimy4NEQ-1; Mon, 16 Mar 2020 17:27:50 -0400
X-MC-Unique: 615sNznOMaWIoWjimy4NEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2E268017DF;
 Mon, 16 Mar 2020 21:27:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07B3719C4F;
 Mon, 16 Mar 2020 21:27:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/61] oslib-posix: initialize mutex and condition variable
Date: Mon, 16 Mar 2020 22:26:38 +0100
Message-Id: <1584394048-44994-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mutex and condition variable were never initialized, causing
-mem-prealloc to abort with an assertion failure.

Fixes: 037fb5eb3941c80a2b7c36a843e47207ddb004d4
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: bauerchen <bauerchen@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 897e8f3..4dd6d7d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -466,10 +466,17 @@ static inline int get_memset_num_threads(int smp_cpus=
)
 static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
                             int smp_cpus)
 {
+    static gsize initialized =3D 0;
     size_t numpages_per_thread, leftover;
     char *addr =3D area;
     int i =3D 0;
=20
+    if (g_once_init_enter(&initialized)) {
+        qemu_mutex_init(&page_mutex);
+        qemu_cond_init(&page_cond);
+        g_once_init_leave(&initialized, 1);
+    }
+
     memset_thread_failed =3D false;
     threads_created_flag =3D false;
     memset_num_threads =3D get_memset_num_threads(smp_cpus);
--=20
1.8.3.1



