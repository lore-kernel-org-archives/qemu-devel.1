Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C516C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8691F20786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvK0kp6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8691F20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZycA-0003M1-J1
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kZyDS-0000pt-SU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kZyDP-0007Ow-N3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604417238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8Z76YkFndCKXfmICdrTuHcPQ4+kdhOB48dxkWsImBs=;
 b=QvK0kp6QAh3t3r8Tqkq9fKOG4fqd8MWTvFLRXcm9e8GzoIX3b7h9+oOC5/yKYkjGCibaUT
 GEqpsh/xyiIkUBlumh86OWyO6JvAKNNGQjpjaJO7wQmcyUG2zX+4KjaHpehM7KnsqOqP7B
 00fC8isoH1OUh6TgFKIUY7cZziZp+rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-sKv6t3SIPj-26a-_VPJAHg-1; Tue, 03 Nov 2020 10:27:15 -0500
X-MC-Unique: sKv6t3SIPj-26a-_VPJAHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E7E41006CAB;
 Tue,  3 Nov 2020 15:27:14 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-164.ams2.redhat.com [10.36.113.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 581AA6EF70;
 Tue,  3 Nov 2020 15:27:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 6/6] block/vvfat: Fix bad printf format specifiers
Date: Tue,  3 Nov 2020 16:26:58 +0100
Message-Id: <20201103152658.119563-7-kwolf@redhat.com>
In-Reply-To: <20201103152658.119563-1-kwolf@redhat.com>
References: <20201103152658.119563-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: AlexChen <alex.chen@huawei.com>

We should use printf format specifier "%u" instead of "%d" for
argument of type "unsigned int".
In addition, fix two error format problems found by checkpatch.pl:
ERROR: space required after that ',' (ctx:VxV)
+        fprintf(stderr,"%s attributes=0x%02x begin=%u size=%d\n",
                       ^
ERROR: line over 90 characters
+        fprintf(stderr, "%d, %s (%u, %d)\n", i, commit->path ? commit->path : "(null)", commit->param.rename.cluster, commit->action);

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
Message-Id: <5FA12620.6030705@huawei.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 5abb90e7c7..54807f82ca 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1437,7 +1437,7 @@ static void print_direntry(const direntry_t* direntry)
         for(i=0;i<11;i++)
             ADD_CHAR(direntry->name[i]);
         buffer[j] = 0;
-        fprintf(stderr,"%s attributes=0x%02x begin=%d size=%d\n",
+        fprintf(stderr, "%s attributes=0x%02x begin=%u size=%u\n",
                 buffer,
                 direntry->attributes,
                 begin_of_direntry(direntry),le32_to_cpu(direntry->size));
@@ -1446,7 +1446,7 @@ static void print_direntry(const direntry_t* direntry)
 
 static void print_mapping(const mapping_t* mapping)
 {
-    fprintf(stderr, "mapping (%p): begin, end = %d, %d, dir_index = %d, "
+    fprintf(stderr, "mapping (%p): begin, end = %u, %u, dir_index = %u, "
         "first_mapping_index = %d, name = %s, mode = 0x%x, " ,
         mapping, mapping->begin, mapping->end, mapping->dir_index,
         mapping->first_mapping_index, mapping->path, mapping->mode);
@@ -1454,7 +1454,7 @@ static void print_mapping(const mapping_t* mapping)
     if (mapping->mode & MODE_DIRECTORY)
         fprintf(stderr, "parent_mapping_index = %d, first_dir_index = %d\n", mapping->info.dir.parent_mapping_index, mapping->info.dir.first_dir_index);
     else
-        fprintf(stderr, "offset = %d\n", mapping->info.file.offset);
+        fprintf(stderr, "offset = %u\n", mapping->info.file.offset);
 }
 #endif
 
@@ -1588,7 +1588,7 @@ typedef struct commit_t {
 static void clear_commits(BDRVVVFATState* s)
 {
     int i;
-DLOG(fprintf(stderr, "clear_commits (%d commits)\n", s->commits.next));
+DLOG(fprintf(stderr, "clear_commits (%u commits)\n", s->commits.next));
     for (i = 0; i < s->commits.next; i++) {
         commit_t* commit = array_get(&(s->commits), i);
         assert(commit->path || commit->action == ACTION_WRITEOUT);
@@ -2648,7 +2648,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
     fprintf(stderr, "handle_renames\n");
     for (i = 0; i < s->commits.next; i++) {
         commit_t* commit = array_get(&(s->commits), i);
-        fprintf(stderr, "%d, %s (%d, %d)\n", i, commit->path ? commit->path : "(null)", commit->param.rename.cluster, commit->action);
+        fprintf(stderr, "%d, %s (%u, %d)\n", i,
+                commit->path ? commit->path : "(null)",
+                commit->param.rename.cluster, commit->action);
     }
 #endif
 
-- 
2.28.0


