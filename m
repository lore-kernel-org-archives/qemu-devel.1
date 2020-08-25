Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED890C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32BC2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjQPWujR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32BC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUhn-0006jw-1o
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPf-0005WD-TP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPc-0000kz-Be
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pICOX+Zyo3ETu/4gyJf/aQ+Uh3WU6G99th0gZuNTS6Y=;
 b=fjQPWujRrBN7wEGZhwO03umXndwfkpAUEGvyd/OSR4BPw8w84SrSeS7UUeNx38f3ch0D9v
 vKnulFHr4OmLb3PsT9SR1rZLr31jEbr7kQZu+ocDk9ZJcEVNwY8ItkUvexl1rOi4LQU2FI
 03lQ/sOoHGjewbVtG0Ch9rTRWcYJd08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-VKVv0cWkPg2p6tpDmf0UpA-1; Tue, 25 Aug 2020 04:34:29 -0400
X-MC-Unique: VKVv0cWkPg2p6tpDmf0UpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C45480732F;
 Tue, 25 Aug 2020 08:34:28 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB795F707;
 Tue, 25 Aug 2020 08:34:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 32/34] qcow2: Allow preallocation and backing files if
 extended_l2 is set
Date: Tue, 25 Aug 2020 10:33:09 +0200
Message-Id: <20200825083311.1098442-33-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

Traditional qcow2 images don't allow preallocation if a backing file
is set. This is because once a cluster is allocated there is no way to
tell that its data should be read from the backing file.

Extended L2 entries have individual allocation bits for each
subcluster, and therefore it is perfectly possible to have an
allocated cluster with all its subclusters unallocated.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <6d5b0f38e7dc5f2f31d8cab1cb92044e9909aece.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              | 7 ++++---
 tests/qemu-iotests/206.out | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 00cda5696b..da56b1a4df 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3449,10 +3449,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         qcow2_opts->preallocation = PREALLOC_MODE_OFF;
     }
     if (qcow2_opts->has_backing_file &&
-        qcow2_opts->preallocation != PREALLOC_MODE_OFF)
+        qcow2_opts->preallocation != PREALLOC_MODE_OFF &&
+        !qcow2_opts->extended_l2)
     {
-        error_setg(errp, "Backing file and preallocation cannot be used at "
-                   "the same time");
+        error_setg(errp, "Backing file and preallocation can only be used at "
+                   "the same time if extended_l2 is on");
         ret = -EINVAL;
         goto out;
     }
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 363c5abe35..a100849fcb 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -203,7 +203,7 @@ Job failed: Different refcount widths than 16 bits require compatibility level 1
 === Invalid backing file options ===
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"backing-file": "/dev/null", "driver": "qcow2", "file": "node0", "preallocation": "full", "size": 67108864}}}
 {"return": {}}
-Job failed: Backing file and preallocation cannot be used at the same time
+Job failed: Backing file and preallocation can only be used at the same time if extended_l2 is on
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
-- 
2.26.2


