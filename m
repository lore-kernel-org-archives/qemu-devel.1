Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3FBC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA752146F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA752146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCR7m-0004hY-Cl
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:51:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6F-0003m1-CO
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6D-0004Bm-4p
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCR68-00046c-C1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 048A63086208;
	Fri,  5 Apr 2019 15:49:42 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-242.ams2.redhat.com
	[10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 047F55D704;
	Fri,  5 Apr 2019 15:49:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, quintela@redhat.com,
	peterx@redhat.com
Date: Fri,  5 Apr 2019 16:49:33 +0100
Message-Id: <20190405154934.18664-2-dgilbert@redhat.com>
In-Reply-To: <20190405154934.18664-1-dgilbert@redhat.com>
References: <20190405154934.18664-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 05 Apr 2019 15:49:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] migration/ram.c: Fix codes conflict about
 bitmap_mutex
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405154933.c_JC6p8vEgApF4_5lLTRpAYAPkemLT-fxkTkPK2o9lk@z>

From: Zhang Chen <chen.zhang@intel.com>

I found upstream codes conflict with COLO and lead to crash,
and I located to this patch:

commit 386a907b37a9321bc5d699bc37104d6ffba1b34d
Author: Wei Wang <wei.w.wang@intel.com>
Date:   Tue Dec 11 16:24:49 2018 +0800

migration: use bitmap_mutex in migration_bitmap_clear_dirty

My colleague Wei's patch add bitmap_mutex in migration_bitmap_clear_dirty=
,
but COLO didn't initialize the bitmap_mutex. So we always get an error
when COLO start up. like that:
qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: As=
sertion `mutex->initialized' failed.

This patch add the bitmap_mutex initialize and destroy in COLO
lifecycle.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20190329222951.28945-1-chen.zhang@intel.com>
Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index d7f8fe45a8..f68beeeeff 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3918,6 +3918,7 @@ int colo_init_ram_cache(void)
     }
     ram_state =3D g_new0(RAMState, 1);
     ram_state->migration_dirty_pages =3D 0;
+    qemu_mutex_init(&ram_state->bitmap_mutex);
     memory_global_dirty_log_start();
=20
     return 0;
@@ -3956,6 +3957,7 @@ void colo_release_ram_cache(void)
     }
=20
     rcu_read_unlock();
+    qemu_mutex_destroy(&ram_state->bitmap_mutex);
     g_free(ram_state);
     ram_state =3D NULL;
 }
--=20
2.21.0


