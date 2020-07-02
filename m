Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A627C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350382070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayAgVPpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350382070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxBR-0007lj-AD
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx6F-0006p9-AT
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx66-000104-PP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNVC3r+da6uEOg41yOkbaOLTXajBe4ySeLsmYbm0j8o=;
 b=ayAgVPpkdBl+Yzw3UZdZP251fcapQhj8FUnebV/JURZyG64Wc/42knvXQTy+RwtIi/EZiX
 Vd2VllqEaEe+Qx8HSukxMmMBfoTKtjVhHZ0jTfm2BronzcnP2GcudypZxlHlxMVgJXXbfg
 oiXIZbaQqmA4tZiaNZSmZ8GOWTCj6fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-4to7cL2VOMKrioXDioynhQ-1; Thu, 02 Jul 2020 07:09:40 -0400
X-MC-Unique: 4to7cL2VOMKrioXDioynhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66F19107ACF6
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 11:09:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36ED379256;
 Thu,  2 Jul 2020 11:09:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 545321138488; Thu,  2 Jul 2020 13:09:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/28] migration/rdma: Plug memory leaks in
 qemu_rdma_registration_stop()
Date: Thu,  2 Jul 2020 13:09:31 +0200
Message-Id: <20200702110931.2953148-29-armbru@redhat.com>
In-Reply-To: <20200702110931.2953148-1-armbru@redhat.com>
References: <20200702110931.2953148-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_rdma_registration_stop() uses the ERROR() macro to create, report
to stderr, and store an Error object.  The stored Error object is
never used, and its memory is leaked.

Even where ERROR() doesn't leak, it is ill-advised.  The whole point
of passing an Error to the caller is letting the caller handle the
error.  Error handling may report to stderr, to somewhere else, or not
at all.  Also reporting in the callee mixes up concerns that should be
kept separate.  Since I don't know what reporting to stderr is
supposed to accomplish, I'm not touching it.

Commit 2a1bc8bde7 "migration/rdma: rdma_accept_incoming_migration fix
error handling" plugged the same leak in
rdma_accept_incoming_migration().

Plug the memory leak the same way: keep the report part, delete the
store part.

The report part uses fprintf().  If it's truly an error, it should use
error_report() instead.  But I don't know, so I leave it alone, just
like commit 2a1bc8bde7 did.

Fixes: 2da776db4846eadcb808598a5d3484d149773c05
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200630090351.1247703-27-armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ec45d33ba3..3b18823268 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3787,7 +3787,6 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
 static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                                        uint64_t flags, void *data)
 {
-    Error *local_err = NULL, **errp = &local_err;
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
@@ -3832,7 +3831,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                     &reg_result_idx, rdma->pin_all ?
                     qemu_rdma_reg_whole_ram_blocks : NULL);
         if (ret < 0) {
-            ERROR(errp, "receiving remote info!");
+            fprintf(stderr, "receiving remote info!");
             return ret;
         }
 
@@ -3851,10 +3850,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
          */
 
         if (local->nb_blocks != nb_dest_blocks) {
-            ERROR(errp, "ram blocks mismatch (Number of blocks %d vs %d) "
-                        "Your QEMU command line parameters are probably "
-                        "not identical on both the source and destination.",
-                        local->nb_blocks, nb_dest_blocks);
+            fprintf(stderr, "ram blocks mismatch (Number of blocks %d vs %d) "
+                    "Your QEMU command line parameters are probably "
+                    "not identical on both the source and destination.",
+                    local->nb_blocks, nb_dest_blocks);
             rdma->error_state = -EINVAL;
             return -EINVAL;
         }
@@ -3867,10 +3866,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
 
             /* We require that the blocks are in the same order */
             if (rdma->dest_blocks[i].length != local->block[i].length) {
-                ERROR(errp, "Block %s/%d has a different length %" PRIu64
-                            "vs %" PRIu64, local->block[i].block_name, i,
-                            local->block[i].length,
-                            rdma->dest_blocks[i].length);
+                fprintf(stderr, "Block %s/%d has a different length %" PRIu64
+                        "vs %" PRIu64, local->block[i].block_name, i,
+                        local->block[i].length,
+                        rdma->dest_blocks[i].length);
                 rdma->error_state = -EINVAL;
                 return -EINVAL;
             }
-- 
2.26.2


