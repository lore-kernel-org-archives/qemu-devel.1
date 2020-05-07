Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE10C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46A02083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvSy4IIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46A02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk22-00087g-Rh
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvN-0005cF-Cu
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:03:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvM-0001wF-9m
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69iwy14t1+6cbjGSeNo9V98Dan4VlhAmJ/+tJaYa+t8=;
 b=fvSy4IIs50Pq5ZSQR5vgaEQ3nddB2+6YrCcGLE4AvJNeBddBci5HbEEVGqE5B89UXCDKYe
 ERbFxo8Cku3rgdrqoORJqBBX3TctOiAwlmcHWPLAzN2NVGNArzme8sPgC/i0qQk+gmb5Tz
 VFPcqPs5MQ2pImvy4ELVP+Z0X4HxyXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-_vddQd6RNBGwxBvdfTGoZA-1; Thu, 07 May 2020 13:03:01 -0400
X-MC-Unique: _vddQd6RNBGwxBvdfTGoZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5BF98018AD;
 Thu,  7 May 2020 17:02:59 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9DB210016EB;
 Thu,  7 May 2020 17:02:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 11/12] migration/multifd: fix memleaks in
 multifd_new_send_channel_async
Date: Thu,  7 May 2020 18:02:10 +0100
Message-Id: <20200507170211.238283-12-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

When error happen in multifd_new_send_channel_async, 'sioc' will not be use=
d
to create the multifd_send_thread. Let's free it to avoid a memleak. And al=
so
do error_free after migrate_set_error() to avoid another leak in the same p=
lace.

The leak stack:
Direct leak of 2880 byte(s) in 8 object(s) allocated from:
    #0 0x7f20b5118ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f20b44df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x564133bce18b in object_new_with_type /mnt/sdb/backup/qemu/qom/obje=
ct.c:683
    #3 0x564133eea950 in qio_channel_socket_new /mnt/sdb/backup/qemu/io/cha=
nnel-socket.c:56
    #4 0x5641339cfe4f in socket_send_channel_create /mnt/sdb/backup/qemu/mi=
gration/socket.c:37
    #5 0x564133a10328 in multifd_save_setup /mnt/sdb/backup/qemu/migration/=
multifd.c:772
    #6 0x5641339cebed in migrate_fd_connect /mnt/sdb/backup/qemu/migration/=
migration.c:3530
    #7 0x5641339d15e4 in migration_channel_connect /mnt/sdb/backup/qemu/mig=
ration/channel.c:92
    #8 0x5641339cf5b7 in socket_outgoing_migration /mnt/sdb/backup/qemu/mig=
ration/socket.c:108

Direct leak of 384 byte(s) in 8 object(s) allocated from:
    #0 0x7f20b5118cf0 in calloc (/lib64/libasan.so.5+0xefcf0)
    #1 0x7f20b44df22d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5322d)
    #2 0x56413406fc17 in error_setv /mnt/sdb/backup/qemu/util/error.c:61
    #3 0x564134070464 in error_setg_errno_internal /mnt/sdb/backup/qemu/uti=
l/error.c:109
    #4 0x5641340851be in inet_connect_addr /mnt/sdb/backup/qemu/util/qemu-s=
ockets.c:379
    #5 0x5641340851be in inet_connect_saddr /mnt/sdb/backup/qemu/util/qemu-=
sockets.c:458
    #6 0x5641340870ab in socket_connect /mnt/sdb/backup/qemu/util/qemu-sock=
ets.c:1105
    #7 0x564133eeaabf in qio_channel_socket_connect_sync /mnt/sdb/backup/qe=
mu/io/channel-socket.c:145
    #8 0x564133eeabf5 in qio_channel_socket_connect_worker /mnt/sdb/backup/=
qemu/io/channel-socket.c:168

Indirect leak of 360 byte(s) in 8 object(s) allocated from:
    #0 0x7f20b5118ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f20af901817 in __GI___vasprintf_chk (/lib64/libc.so.6+0x10d817)
    #2 0x7f20b451fa6c in g_vasprintf (/lib64/libglib-2.0.so.0+0x93a6c)
    #3 0x7f20b44f8cd0 in g_strdup_vprintf (/lib64/libglib-2.0.so.0+0x6ccd0)
    #4 0x7f20b44f8d8c in g_strdup_printf (/lib64/libglib-2.0.so.0+0x6cd8c)
    #5 0x56413406fc86 in error_setv /mnt/sdb/backup/qemu/util/error.c:65
    #6 0x564134070464 in error_setg_errno_internal /mnt/sdb/backup/qemu/uti=
l/error.c:109
    #7 0x5641340851be in inet_connect_addr /mnt/sdb/backup/qemu/util/qemu-s=
ockets.c:379
    #8 0x5641340851be in inet_connect_saddr /mnt/sdb/backup/qemu/util/qemu-=
sockets.c:458
    #9 0x5641340870ab in socket_connect /mnt/sdb/backup/qemu/util/qemu-sock=
ets.c:1105
    #10 0x564133eeaabf in qio_channel_socket_connect_sync /mnt/sdb/backup/q=
emu/io/channel-socket.c:145
    #11 0x564133eeabf5 in qio_channel_socket_connect_worker /mnt/sdb/backup=
/qemu/io/channel-socket.c:168

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200506095416.26099-2-pannengyuan@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9123c111a3..e3efd33a0d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -727,6 +727,8 @@ static void multifd_new_send_channel_async(QIOTask *tas=
k, gpointer opaque)
          * its status.
          */
         p->quit =3D true;
+        object_unref(OBJECT(sioc));
+        error_free(local_err);
     } else {
         p->c =3D QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
--=20
2.26.2


