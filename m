Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E27C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567E622D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567E622D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uac-0004sQ-8I
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPm-0007Ad-Jh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPl-0005aL-6j
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPl-0005Zj-1M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C083308219F;
 Wed, 21 Aug 2019 17:28:52 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57C2460F88;
 Wed, 21 Aug 2019 17:28:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:20 +0200
Message-Id: <1566408501-48680-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 21 Aug 2019 17:28:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/13] main-loop: Fix GSource leak in
 qio_task_thread_worker()
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
Cc: Alberto Garcia <berto@igalia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

After g_source_attach() the GMainContext holds a reference to the
GSource, so the caller does not need to keep it.

qio_task_thread_worker() is not releasing its reference so the GSource
is being leaked since a17536c594bfed94d05667b419f747b692f5fc7f.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <1565625509-404969-2-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 io/task.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/task.c b/io/task.c
index 64c4c71..1ae7b86 100644
--- a/io/task.c
+++ b/io/task.c
@@ -136,6 +136,7 @@ static gpointer qio_task_thread_worker(gpointer opaqu=
e)
                           qio_task_thread_result, task, NULL);
     g_source_attach(task->thread->completion,
                     task->thread->context);
+    g_source_unref(task->thread->completion);
     trace_qio_task_thread_source_attach(task, task->thread->completion);
=20
     qemu_cond_signal(&task->thread_cond);
--=20
1.8.3.1



