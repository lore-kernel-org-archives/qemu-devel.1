Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EFD20855
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtfyLk9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EFD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3nEG-000208-MR
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k3nD4-000103-Ub
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k3nD2-0004xu-NB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596748435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIki7BkJI/FNlCnDsTEZAmAzJTFNKhAObM7QePqmCck=;
 b=WtfyLk9qoEriQmdNDBuoBvUpTyoIN5AzkSzYwkAAAjcaG7JFN4VFQg5yKHpG55KB4UrlZb
 NnI756dOf4yWKY8Mh85y/A2axhqeegoREwm775e1SVsV7esqwTo1Is3JqiPrMjAvWG3a+f
 QNhGrddvQU3EoNlPqujL0Wmx+SYDPcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-Y1apFi7lO5S5ng57qM1uYQ-1; Thu, 06 Aug 2020 17:13:53 -0400
X-MC-Unique: Y1apFi7lO5S5ng57qM1uYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 993E31800D42;
 Thu,  6 Aug 2020 21:13:52 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-117-179.rdu2.redhat.com [10.10.117.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B906079CE3;
 Thu,  6 Aug 2020 21:13:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] block/rbd: remove runtime_opts
Date: Thu,  6 Aug 2020 17:13:44 -0400
Message-Id: <20200806211345.2925343-2-jsnow@redhat.com>
In-Reply-To: <20200806211345.2925343-1-jsnow@redhat.com>
References: <20200806211345.2925343-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 13:48:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Dillaman <dillaman@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This saw its last use in 4bfb274165ba.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/rbd.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 688074c64b7..171c67e3a01 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -341,48 +341,6 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
     }
 }
 
-static QemuOptsList runtime_opts = {
-    .name = "rbd",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
-    .desc = {
-        {
-            .name = "pool",
-            .type = QEMU_OPT_STRING,
-            .help = "Rados pool name",
-        },
-        {
-            .name = "namespace",
-            .type = QEMU_OPT_STRING,
-            .help = "Rados namespace name in the pool",
-        },
-        {
-            .name = "image",
-            .type = QEMU_OPT_STRING,
-            .help = "Image name in the pool",
-        },
-        {
-            .name = "conf",
-            .type = QEMU_OPT_STRING,
-            .help = "Rados config file location",
-        },
-        {
-            .name = "snapshot",
-            .type = QEMU_OPT_STRING,
-            .help = "Ceph snapshot name",
-        },
-        {
-            /* maps to 'id' in rados_create() */
-            .name = "user",
-            .type = QEMU_OPT_STRING,
-            .help = "Rados id name",
-        },
-        /*
-         * server.* extracted manually, see qemu_rbd_mon_host()
-         */
-        { /* end of list */ }
-    },
-};
-
 /* FIXME Deprecate and remove keypairs or make it available in QMP. */
 static int qemu_rbd_do_create(BlockdevCreateOptions *options,
                               const char *keypairs, const char *password_secret,
-- 
2.26.2


