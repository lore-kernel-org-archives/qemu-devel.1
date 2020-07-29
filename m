Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BFBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB8720656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3EBLdKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB8720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uPl-0003B9-C4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLU-0003cj-MN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLR-0001Az-Qy
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596060880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRoiGntPr/roRN7z30VYKhnG5GEpKOXqS3TTBjzQ2PQ=;
 b=b3EBLdKBl9TZHGeimT8swq+HKLqDR8updg9GVW2XL15rftpS9i4TsKluXEgPoT3S25jlsT
 V1RLPd4t5OZbsppzMIuzRSxgjvicJW+s3N0nJFpA+7/ud/1ytsKAvgk1rksh7qRNP7kQPQ
 LZY38skadAINetrWgINLZX4KFsNI+1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-DkppzhKjPAasRBiuTm0K9Q-1; Wed, 29 Jul 2020 18:14:38 -0400
X-MC-Unique: DkppzhKjPAasRBiuTm0K9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D639C8015F4
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 22:14:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-149.rdu2.redhat.com [10.10.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F007712FF;
 Wed, 29 Jul 2020 22:14:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C2020223D04; Wed, 29 Jul 2020 18:14:31 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] virtiofsd: Add notion of unprivileged mode
Date: Wed, 29 Jul 2020 18:14:06 -0400
Message-Id: <20200729221410.147556-2-vgoyal@redhat.com>
In-Reply-To: <20200729221410.147556-1-vgoyal@redhat.com>
References: <20200729221410.147556-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, vromanso@redhat.com, dgilbert@redhat.com,
 virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At startup if we are running as non-root user, then internall set
unpriviliged mode set. Also add a notion of sandbox NONE and set
that internally in unprivileged mode. setting up namespaces and
chroot() fails when one does not have privileges.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index e2fbc614fd..cd91c4a831 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -147,11 +147,13 @@ enum {
 enum {
     SANDBOX_NAMESPACE,
     SANDBOX_CHROOT,
+    SANDBOX_NONE,
 };
 
 struct lo_data {
     pthread_mutex_t mutex;
     int sandbox;
+    bool unprivileged;
     int debug;
     int writeback;
     int flock;
@@ -3288,6 +3290,12 @@ int main(int argc, char *argv[])
     lo_map_init(&lo.dirp_map);
     lo_map_init(&lo.fd_map);
 
+    if (geteuid() != 0) {
+       lo.unprivileged = true;
+       lo.sandbox = SANDBOX_NONE;
+       fuse_log(FUSE_LOG_DEBUG, "Running in unprivileged passthrough mode.\n");
+    }
+
     if (fuse_parse_cmdline(&args, &opts) != 0) {
         goto err_out1;
     }
-- 
2.25.4


