Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD1C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28EE20684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28EE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PrC-0007Gp-2S
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUL-0006dx-Mo
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUJ-0002iX-OH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUJ-0002hK-94
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5588D3086202;
 Thu, 12 Sep 2019 13:50:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 020FB5D717;
 Thu, 12 Sep 2019 13:50:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:49:55 +0100
Message-Id: <20190912135006.14820-2-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 12 Sep 2019 13:50:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/12] migration: multifd_send_thread always
 post p->sem_sync when error happen
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

When encounter error, multifd_send_thread should always notify who pay
attention to it before exit. Otherwise it may block migration_thread
at multifd_send_sync_main forever.

Error as follow:
-------------------------------------------------------------------------=
------
 (gdb) bt
 #0  0x00007f4d669dfa0b in do_futex_wait.constprop.1 () from /lib64/libpt=
hread.so.0
 #1  0x00007f4d669dfa9f in __new_sem_wait_slow.constprop.0 () from /lib64=
/libpthread.so.0
 #2  0x00007f4d669dfb3b in sem_wait@@GLIBC_2.2.5 () from /lib64/libpthrea=
d.so.0
 #3  0x0000562ccf0a5614 in qemu_sem_wait (sem=3Dsem@entry=3D0x562cd1b698e=
8) at util/qemu-thread-posix.c:319
 #4  0x0000562ccecb4752 in multifd_send_sync_main (rs=3D<optimized out>) =
at /qemu/migration/ram.c:1099
 #5  0x0000562ccecb95f4 in ram_save_iterate (f=3D0x562cd0ecc000, opaque=3D=
<optimized out>) at /qemu/migration/ram.c:3550
 #6  0x0000562ccef43c23 in qemu_savevm_state_iterate (f=3D0x562cd0ecc000,=
 postcopy=3Dfalse) at migration/savevm.c:1189
 #7  0x0000562ccef3dcf3 in migration_iteration_run (s=3D0x562cd09fabf0) a=
t migration/migration.c:3131
 #8  migration_thread (opaque=3Dopaque@entry=3D0x562cd09fabf0) at migrati=
on/migration.c:3258
 #9  0x0000562ccf0a4c26 in qemu_thread_start (args=3D<optimized out>) at =
util/qemu-thread-posix.c:502
 #10 0x00007f4d669d9e25 in start_thread () from /lib64/libpthread.so.0
 #11 0x00007f4d6670635d in clone () from /lib64/libc.so.6
 (gdb) f 4
 #4  0x0000562ccecb4752 in multifd_send_sync_main (rs=3D<optimized out>) =
at /qemu/migration/ram.c:1099
 1099	        qemu_sem_wait(&p->sem_sync);
 (gdb) list
 1094	    }
 1095	    for (i =3D 0; i < migrate_multifd_channels(); i++) {
 1096	        MultiFDSendParams *p =3D &multifd_send_state->params[i];
 1097
 1098	        trace_multifd_send_sync_main_wait(p->id);
 1099	        qemu_sem_wait(&p->sem_sync);
 1100	    }
 1101	    trace_multifd_send_sync_main(multifd_send_state->packet_num);
 1102	}
 1103
 (gdb) p i
 $1 =3D 0
 (gdb)  p multifd_send_state->params[0].pending_job
 $2 =3D 2    //It means the job before MULTIFD_FLAG_SYNC has already fail
 (gdb)  p multifd_send_state->params[0].quit
 $3 =3D true

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Message-Id: <1567044996-2362-1-git-send-email-ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b01a37e7ca..0047286b7e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1112,6 +1112,7 @@ static void *multifd_send_thread(void *opaque)
     rcu_register_thread();
=20
     if (multifd_send_initial_packet(p, &local_err) < 0) {
+        ret =3D -1;
         goto out;
     }
     /* initial packet */
@@ -1179,9 +1180,7 @@ out:
      * who pay attention to me.
      */
     if (ret !=3D 0) {
-        if (flags & MULTIFD_FLAG_SYNC) {
-            qemu_sem_post(&p->sem_sync);
-        }
+        qemu_sem_post(&p->sem_sync);
         qemu_sem_post(&multifd_send_state->channels_ready);
     }
=20
--=20
2.21.0


