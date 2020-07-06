Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55466C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250ED206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii8JoFWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250ED206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLa5-0004m6-Af
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYW-0003Oe-BP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYU-0004Iu-9z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594020525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=sl4lnePHTVMyRzh87za++kiW+h7Hwz5DLgCYMcy9GQQ=;
 b=ii8JoFWKK5BlYjzdMi6W41kIvmSrAtuEXN5cuUxnSbO8/84WnBHndJE3N1synKbcrDbPGE
 Hr315sAJpnZ0rD4XT8Z5sdu8UwOQeTTbuofrqiCO3NYclCXW3dTzjRWdBOF+2Avfd78y1v
 NaX3y1/7Q3yndm4ldFQ8y5SaT7ySsmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-m7SLHQaIOGO8X9RdE7hMWw-1; Mon, 06 Jul 2020 03:28:42 -0400
X-MC-Unique: m7SLHQaIOGO8X9RdE7hMWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B46A0EC1A1;
 Mon,  6 Jul 2020 07:28:41 +0000 (UTC)
Received: from thuth.com (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B87095D9CC;
 Mon,  6 Jul 2020 07:28:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] fuzz: do not use POSIX shm for coverage bitmap
Date: Mon,  6 Jul 2020 09:28:31 +0200
Message-Id: <20200706072835.23582-3-thuth@redhat.com>
In-Reply-To: <20200706072835.23582-1-thuth@redhat.com>
References: <20200706072835.23582-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

We used shm_open with mmap to share libfuzzer's coverage bitmap with
child (runner) processes. The same functionality can be achieved with
MAP_SHARED | MAP_ANONYMOUS, since we do not care about naming or
permissioning the shared memory object.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200622165040.15121-1-alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/fork_fuzz.c | 40 ++++++++++++------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/tests/qtest/fuzz/fork_fuzz.c b/tests/qtest/fuzz/fork_fuzz.c
index 2bd0851903..6ffb2a7937 100644
--- a/tests/qtest/fuzz/fork_fuzz.c
+++ b/tests/qtest/fuzz/fork_fuzz.c
@@ -17,39 +17,25 @@
 
 void counter_shm_init(void)
 {
-    char *shm_path = g_strdup_printf("/qemu-fuzz-cntrs.%d", getpid());
-    int fd = shm_open(shm_path, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-    g_free(shm_path);
-
-    if (fd == -1) {
-        perror("Error: ");
-        exit(1);
-    }
-    if (ftruncate(fd, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START) == -1) {
-        perror("Error: ");
-        exit(1);
-    }
-    /* Copy what's in the counter region to the shm.. */
-    void *rptr = mmap(NULL ,
-            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
-            PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-    memcpy(rptr,
+    /* Copy what's in the counter region to a temporary buffer.. */
+    void *copy = malloc(&__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+    memcpy(copy,
            &__FUZZ_COUNTERS_START,
            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
 
-    munmap(rptr, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
-
-    /* And map the shm over the counter region */
-    rptr = mmap(&__FUZZ_COUNTERS_START,
-            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
-            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
-
-    close(fd);
-
-    if (!rptr) {
+    /* Map a shared region over the counter region */
+    if (mmap(&__FUZZ_COUNTERS_START,
+             &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
+             PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED | MAP_ANONYMOUS,
+             0, 0) == MAP_FAILED) {
         perror("Error: ");
         exit(1);
     }
+
+    /* Copy the original data back to the counter-region */
+    memcpy(&__FUZZ_COUNTERS_START, copy,
+           &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
+    free(copy);
 }
 
 
-- 
2.18.1


