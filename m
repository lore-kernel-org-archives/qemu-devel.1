Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833AFC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5405B206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405B206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0U8-00060i-2D
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PT-0000Di-4T
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PR-0003lC-A5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0PQ-0003k1-Vi
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5FCBC057EC0;
 Fri, 11 Oct 2019 19:17:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA02C5D6C8;
 Fri, 11 Oct 2019 19:17:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 05/21] migration: Use automatic rcu_read unlock in rdma.c
Date: Fri, 11 Oct 2019 20:16:30 +0100
Message-Id: <20191011191646.226814-6-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 11 Oct 2019 19:17:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use the automatic read unlocker in migration/rdma.c.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20191007143642.301445-5-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 57 ++++++++++--------------------------------------
 1 file changed, 11 insertions(+), 46 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4c74e88a37..e241dcb992 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -88,7 +88,6 @@ static uint32_t known_capabilities =3D RDMA_CAPABILITY_=
PIN_ALL;
                                 " to abort!"); \
                 rdma->error_reported =3D 1; \
             } \
-            rcu_read_unlock(); \
             return rdma->error_state; \
         } \
     } while (0)
@@ -2678,11 +2677,10 @@ static ssize_t qio_channel_rdma_writev(QIOChannel=
 *ioc,
     size_t i;
     size_t len =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmaout);
=20
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
@@ -2695,7 +2693,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
     ret =3D qemu_rdma_write_flush(f, rdma);
     if (ret < 0) {
         rdma->error_state =3D ret;
-        rcu_read_unlock();
         return ret;
     }
=20
@@ -2715,7 +2712,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
=20
             if (ret < 0) {
                 rdma->error_state =3D ret;
-                rcu_read_unlock();
                 return ret;
             }
=20
@@ -2724,7 +2720,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
         }
     }
=20
-    rcu_read_unlock();
     return done;
 }
=20
@@ -2764,11 +2759,10 @@ static ssize_t qio_channel_rdma_readv(QIOChannel =
*ioc,
     ssize_t i;
     size_t done =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmain);
=20
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
@@ -2805,7 +2799,6 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *i=
oc,
=20
         if (ret < 0) {
             rdma->error_state =3D ret;
-            rcu_read_unlock();
             return ret;
         }
=20
@@ -2819,14 +2812,12 @@ static ssize_t qio_channel_rdma_readv(QIOChannel =
*ioc,
         /* Still didn't get enough, so lets just return */
         if (want) {
             if (done =3D=3D 0) {
-                rcu_read_unlock();
                 return QIO_CHANNEL_ERR_BLOCK;
             } else {
                 break;
             }
         }
     }
-    rcu_read_unlock();
     return done;
 }
=20
@@ -2882,7 +2873,7 @@ qio_channel_rdma_source_prepare(GSource *source,
     GIOCondition cond =3D 0;
     *timeout =3D -1;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (rsource->condition =3D=3D G_IO_IN) {
         rdma =3D atomic_rcu_read(&rsource->rioc->rdmain);
     } else {
@@ -2891,7 +2882,6 @@ qio_channel_rdma_source_prepare(GSource *source,
=20
     if (!rdma) {
         error_report("RDMAContext is NULL when prepare Gsource");
-        rcu_read_unlock();
         return FALSE;
     }
=20
@@ -2900,7 +2890,6 @@ qio_channel_rdma_source_prepare(GSource *source,
     }
     cond |=3D G_IO_OUT;
=20
-    rcu_read_unlock();
     return cond & rsource->condition;
 }
=20
@@ -2911,7 +2900,7 @@ qio_channel_rdma_source_check(GSource *source)
     RDMAContext *rdma;
     GIOCondition cond =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (rsource->condition =3D=3D G_IO_IN) {
         rdma =3D atomic_rcu_read(&rsource->rioc->rdmain);
     } else {
@@ -2920,7 +2909,6 @@ qio_channel_rdma_source_check(GSource *source)
=20
     if (!rdma) {
         error_report("RDMAContext is NULL when check Gsource");
-        rcu_read_unlock();
         return FALSE;
     }
=20
@@ -2929,7 +2917,6 @@ qio_channel_rdma_source_check(GSource *source)
     }
     cond |=3D G_IO_OUT;
=20
-    rcu_read_unlock();
     return cond & rsource->condition;
 }
=20
@@ -2943,7 +2930,7 @@ qio_channel_rdma_source_dispatch(GSource *source,
     RDMAContext *rdma;
     GIOCondition cond =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (rsource->condition =3D=3D G_IO_IN) {
         rdma =3D atomic_rcu_read(&rsource->rioc->rdmain);
     } else {
@@ -2952,7 +2939,6 @@ qio_channel_rdma_source_dispatch(GSource *source,
=20
     if (!rdma) {
         error_report("RDMAContext is NULL when dispatch Gsource");
-        rcu_read_unlock();
         return FALSE;
     }
=20
@@ -2961,7 +2947,6 @@ qio_channel_rdma_source_dispatch(GSource *source,
     }
     cond |=3D G_IO_OUT;
=20
-    rcu_read_unlock();
     return (*func)(QIO_CHANNEL(rsource->rioc),
                    (cond & rsource->condition),
                    user_data);
@@ -3073,7 +3058,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
     QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
     RDMAContext *rdmain, *rdmaout;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
=20
     rdmain =3D atomic_rcu_read(&rioc->rdmain);
     rdmaout =3D atomic_rcu_read(&rioc->rdmain);
@@ -3100,7 +3085,6 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
         break;
     }
=20
-    rcu_read_unlock();
     return 0;
 }
=20
@@ -3146,18 +3130,16 @@ static size_t qemu_rdma_save_page(QEMUFile *f, vo=
id *opaque,
     RDMAContext *rdma;
     int ret;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmaout);
=20
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
     CHECK_ERROR_STATE();
=20
     if (migration_in_postcopy()) {
-        rcu_read_unlock();
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
=20
@@ -3242,11 +3224,9 @@ static size_t qemu_rdma_save_page(QEMUFile *f, voi=
d *opaque,
         }
     }
=20
-    rcu_read_unlock();
     return RAM_SAVE_CONTROL_DELAYED;
 err:
     rdma->error_state =3D ret;
-    rcu_read_unlock();
     return ret;
 }
=20
@@ -3470,11 +3450,10 @@ static int qemu_rdma_registration_handle(QEMUFile=
 *f, void *opaque)
     int count =3D 0;
     int i =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmain);
=20
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
@@ -3717,7 +3696,6 @@ out:
     if (ret < 0) {
         rdma->error_state =3D ret;
     }
-    rcu_read_unlock();
     return ret;
 }
=20
@@ -3735,11 +3713,10 @@ rdma_block_notification_handle(QIOChannelRDMA *ri=
oc, const char *name)
     int curr;
     int found =3D -1;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmain);
=20
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
@@ -3753,7 +3730,6 @@ rdma_block_notification_handle(QIOChannelRDMA *rioc=
, const char *name)
=20
     if (found =3D=3D -1) {
         error_report("RAMBlock '%s' not found on destination", name);
-        rcu_read_unlock();
         return -ENOENT;
     }
=20
@@ -3761,7 +3737,6 @@ rdma_block_notification_handle(QIOChannelRDMA *rioc=
, const char *name)
     trace_rdma_block_notification_handle(name, rdma->next_src_index);
     rdma->next_src_index++;
=20
-    rcu_read_unlock();
     return 0;
 }
=20
@@ -3786,17 +3761,15 @@ static int qemu_rdma_registration_start(QEMUFile =
*f, void *opaque,
     QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(opaque);
     RDMAContext *rdma;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmaout);
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
     CHECK_ERROR_STATE();
=20
     if (migration_in_postcopy()) {
-        rcu_read_unlock();
         return 0;
     }
=20
@@ -3804,7 +3777,6 @@ static int qemu_rdma_registration_start(QEMUFile *f=
, void *opaque,
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
=20
-    rcu_read_unlock();
     return 0;
 }
=20
@@ -3821,17 +3793,15 @@ static int qemu_rdma_registration_stop(QEMUFile *=
f, void *opaque,
     RDMAControlHeader head =3D { .len =3D 0, .repeat =3D 1 };
     int ret =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     rdma =3D atomic_rcu_read(&rioc->rdmaout);
     if (!rdma) {
-        rcu_read_unlock();
         return -EIO;
     }
=20
     CHECK_ERROR_STATE();
=20
     if (migration_in_postcopy()) {
-        rcu_read_unlock();
         return 0;
     }
=20
@@ -3863,7 +3833,6 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
                     qemu_rdma_reg_whole_ram_blocks : NULL);
         if (ret < 0) {
             ERROR(errp, "receiving remote info!");
-            rcu_read_unlock();
             return ret;
         }
=20
@@ -3887,7 +3856,6 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
                         "not identical on both the source and destinatio=
n.",
                         local->nb_blocks, nb_dest_blocks);
             rdma->error_state =3D -EINVAL;
-            rcu_read_unlock();
             return -EINVAL;
         }
=20
@@ -3904,7 +3872,6 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
                             local->block[i].length,
                             rdma->dest_blocks[i].length);
                 rdma->error_state =3D -EINVAL;
-                rcu_read_unlock();
                 return -EINVAL;
             }
             local->block[i].remote_host_addr =3D
@@ -3922,11 +3889,9 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
         goto err;
     }
=20
-    rcu_read_unlock();
     return 0;
 err:
     rdma->error_state =3D ret;
-    rcu_read_unlock();
     return ret;
 }
=20
--=20
2.23.0


