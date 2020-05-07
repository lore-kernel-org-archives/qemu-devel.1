Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0901C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71C82083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKDnbfxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71C82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk2H-000065-Qg
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvD-0005FJ-CO
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvC-0001q0-BT
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IuwYfgcmEXRuiMlm1v2p47xGtCKQ+grahx6H/ThOIQ=;
 b=LKDnbfxSl6NqiAwCi4KUmJDmv3QVmaEIhCth06RzvxUEsXL4zHd8XEze158HNd98qTJCBs
 8XLhiIzVABn7UKvxKgE7Z1Tb8M4ljCY1vZfE1nbqNZ5QioHwJ3gnq1owJblimwzOw84+ia
 cml9ucVo3cb2YXJuLtgL1O8s92Lax6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-9e0ZN6hzNIKrfH1OftJfGg-1; Thu, 07 May 2020 13:02:51 -0400
X-MC-Unique: 9e0ZN6hzNIKrfH1OftJfGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078E380183C;
 Thu,  7 May 2020 17:02:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3A1E10013BD;
 Thu,  7 May 2020 17:02:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 09/12] migration/rdma: fix a memleak on error path in
 rdma_start_incoming_migration
Date: Thu,  7 May 2020 18:02:08 +0100
Message-Id: <20200507170211.238283-10-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

'rdma->host' is malloced in qemu_rdma_data_init, but forgot to free on the =
error
path in rdma_start_incoming_migration(), this patch fix that.

The leak stack:
Direct leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x7fb7add18ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7fb7ad0df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x7fb7ad0f8b32 in g_strdup (/lib64/libglib-2.0.so.0+0x6cb32)
    #3 0x55a0464a0f6f in qemu_rdma_data_init /mnt/sdb/qemu/migration/rdma.c=
:2647
    #4 0x55a0464b0e76 in rdma_start_incoming_migration /mnt/sdb/qemu/migrat=
ion/rdma.c:4020
    #5 0x55a0463f898a in qemu_start_incoming_migration /mnt/sdb/qemu/migrat=
ion/migration.c:365
    #6 0x55a0458c75d3 in qemu_init /mnt/sdb/qemu/softmmu/vl.c:4438
    #7 0x55a046a3d811 in main /mnt/sdb/qemu/softmmu/main.c:48
    #8 0x7fb7a8417872 in __libc_start_main (/lib64/libc.so.6+0x23872)
    #9 0x55a04536b26d in _start (/mnt/sdb/qemu/build/x86_64-softmmu/qemu-sy=
stem-x86_64+0x286926d)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200420102727.17339-1-pannengyuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index f61587891b..967fda5b0c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4056,6 +4056,7 @@ void rdma_start_incoming_migration(const char *host_p=
ort, Error **errp)
     return;
 err:
     error_propagate(errp, local_err);
+    g_free(rdma->host);
     g_free(rdma);
     g_free(rdma_return_path);
 }
--=20
2.26.2


