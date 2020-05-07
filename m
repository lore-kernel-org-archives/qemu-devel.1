Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F07C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749A72083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjoNxZMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749A72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjyy-0001zF-K9
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvP-0005h9-Rx
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:03:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvO-0001wT-QZ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3mSP3+ZZbdihoIHFS6AI5mby/iNLpFsgph7o8h9bYA=;
 b=QjoNxZMCkjp0PAR1LyNsDhmXGSEi0ZXGrpwpJN4VPMYG3JjTDuGiG7LMN2aswaIphxwpXf
 gmtVEKQZ8G0PX/NaEFp/kEHMKVwGJb9L9aFLBEwTrlJMlX9Gz8Het1wSIXkdoA78lJvBa4
 /OI+rjg0Sv+JbnPttQyN0tEWD6X9Vew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-pLp3JQV_Peq0NbSOw4thEQ-1; Thu, 07 May 2020 13:03:03 -0400
X-MC-Unique: pLp3JQV_Peq0NbSOw4thEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416171005510;
 Thu,  7 May 2020 17:03:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3980410013BD;
 Thu,  7 May 2020 17:03:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 12/12] migration/multifd: Do error_free after migrate_set_error
 to avoid memleaks
Date: Thu,  7 May 2020 18:02:11 +0100
Message-Id: <20200507170211.238283-13-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

When error happen in multifd_send_thread, it use error_copy to set migrate =
error in
multifd_send_terminate_threads(). We should call error_free after it.

Similarly, fix another two places in multifd_recv_thread/multifd_save_clean=
up.

The leak stack:
Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f781af07cf0 in calloc (/lib64/libasan.so.5+0xefcf0)
    #1 0x7f781a2ce22d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5322d)
    #2 0x55ee1d075c17 in error_setv /mnt/sdb/backup/qemu/util/error.c:61
    #3 0x55ee1d076464 in error_setg_errno_internal /mnt/sdb/backup/qemu/uti=
l/error.c:109
    #4 0x55ee1cef066e in qio_channel_socket_writev /mnt/sdb/backup/qemu/io/=
channel-socket.c:569
    #5 0x55ee1cee806b in qio_channel_writev /mnt/sdb/backup/qemu/io/channel=
.c:207
    #6 0x55ee1cee806b in qio_channel_writev_all /mnt/sdb/backup/qemu/io/cha=
nnel.c:171
    #7 0x55ee1cee8248 in qio_channel_write_all /mnt/sdb/backup/qemu/io/chan=
nel.c:257
    #8 0x55ee1ca12c9a in multifd_send_thread /mnt/sdb/backup/qemu/migration=
/multifd.c:657
    #9 0x55ee1d0607fc in qemu_thread_start /mnt/sdb/backup/qemu/util/qemu-t=
hread-posix.c:519
    #10 0x7f78159ae2dd in start_thread (/lib64/libpthread.so.0+0x82dd)
    #11 0x7f78156df4b2 in __GI___clone (/lib64/libc.so.6+0xfc4b2)

Indirect leak of 52 byte(s) in 1 object(s) allocated from:
    #0 0x7f781af07f28 in __interceptor_realloc (/lib64/libasan.so.5+0xeff28=
)
    #1 0x7f78156f07d9 in __GI___vasprintf_chk (/lib64/libc.so.6+0x10d7d9)
    #2 0x7f781a30ea6c in g_vasprintf (/lib64/libglib-2.0.so.0+0x93a6c)
    #3 0x7f781a2e7cd0 in g_strdup_vprintf (/lib64/libglib-2.0.so.0+0x6ccd0)
    #4 0x7f781a2e7d8c in g_strdup_printf (/lib64/libglib-2.0.so.0+0x6cd8c)
    #5 0x55ee1d075c86 in error_setv /mnt/sdb/backup/qemu/util/error.c:65
    #6 0x55ee1d076464 in error_setg_errno_internal /mnt/sdb/backup/qemu/uti=
l/error.c:109
    #7 0x55ee1cef066e in qio_channel_socket_writev /mnt/sdb/backup/qemu/io/=
channel-socket.c:569
    #8 0x55ee1cee806b in qio_channel_writev /mnt/sdb/backup/qemu/io/channel=
.c:207
    #9 0x55ee1cee806b in qio_channel_writev_all /mnt/sdb/backup/qemu/io/cha=
nnel.c:171
    #10 0x55ee1cee8248 in qio_channel_write_all /mnt/sdb/backup/qemu/io/cha=
nnel.c:257
    #11 0x55ee1ca12c9a in multifd_send_thread /mnt/sdb/backup/qemu/migratio=
n/multifd.c:657
    #12 0x55ee1d0607fc in qemu_thread_start /mnt/sdb/backup/qemu/util/qemu-=
thread-posix.c:519
    #13 0x7f78159ae2dd in start_thread (/lib64/libpthread.so.0+0x82dd)
    #14 0x7f78156df4b2 in __GI___clone (/lib64/libc.so.6+0xfc4b2)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200506095416.26099-3-pannengyuan@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/multifd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index e3efd33a0d..5a3e4d0d46 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -550,6 +550,7 @@ void multifd_save_cleanup(void)
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
+            error_free(local_err);
         }
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
@@ -688,6 +689,7 @@ out:
     if (local_err) {
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
+        error_free(local_err);
     }
=20
     /*
@@ -965,6 +967,7 @@ static void *multifd_recv_thread(void *opaque)
=20
     if (local_err) {
         multifd_recv_terminate_threads(local_err);
+        error_free(local_err);
     }
     qemu_mutex_lock(&p->mutex);
     p->running =3D false;
--=20
2.26.2


