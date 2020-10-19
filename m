Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64CC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED9C22200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrUp7Uqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED9C22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUe7L-00006g-Qj
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5q-00070P-VJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUe5o-0005cJ-IK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603148247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=WrUp7UqjNSJnhPiGza7P0Iv87t/y2LN4l/f22wdWkkvs6jwaKxvTfYa7O2HYDDYYGmH5Eu
 fKT+CEuaAH2mumYeYIIJhb0WoIhBC0XQSLiHDGv+mTeDXd7f1KeUky6J+Yn0WG+1sdsz8U
 S0U1nNl3Y7ZwXsYDBF468Wupo9iR4+s=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-_tvVK4qIMt2CMa5Yv7a6hQ-1; Mon, 19 Oct 2020 18:57:25 -0400
X-MC-Unique: _tvVK4qIMt2CMa5Yv7a6hQ-1
Received: by mail-il1-f197.google.com with SMTP id p17so1456595ilj.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=iW2EUcUN5F4UofdWyPy1rCt4jcfCvsdrj8BMwbfLaZcTA6iiupgwWek37qEwcYPm0J
 GXz3uFfr2CAn8D2Kvu39iuSI44wF3s9OvQJBTXk9vI/Nr5Y9c4/DkqxFW4IC321J2AtQ
 RmTw5v2jFjSJJLTuzt5ksdkoiTdJVeqTOjY71psxt57JMXX3UP3Qk6XioymrzfrVUDyo
 p1LS5XuFN0/oerVDtv/bPVKQN674FAmtXKC8RvkH7ktx3JbsfLVXHDFjToOjCEEbTJZ1
 PCkoaN/ivFD2eXbFSpy9WyQHmYmjhCMucNj2G4CR0KYEA/xYJqKqb0CqsGrqwt2Cho7F
 FaXw==
X-Gm-Message-State: AOAM533fXHfjQqgGyLiVInWF7qh3AI/bpsjO/S0dL4w6/ZWPuRt5FWcU
 rey/LP2zW6ZozRjmpAvrFUctQN0m2LIW82CDiKwjpXAFzzqWV4k0DIQYctPxVMzYfSB8aJF8HsJ
 zmInw3dQ3DQ5rayE=
X-Received: by 2002:a5e:d719:: with SMTP id v25mr54997iom.32.1603148244718;
 Mon, 19 Oct 2020 15:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN63MEt+Wcot7AwVcM3Pym62fevDxqfrAUC6UTLm3lhCFpqeNaRvMAGxgrorpA04e/7B+9iQ==
X-Received: by 2002:a5e:d719:: with SMTP id v25mr54983iom.32.1603148244536;
 Mon, 19 Oct 2020 15:57:24 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z89sm6017ilk.4.2020.10.19.15.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 15:57:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/6] migration: Pass incoming state into
 qemu_ufd_copy_ioctl()
Date: Mon, 19 Oct 2020 18:57:15 -0400
Message-Id: <20201019225720.172743-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019225720.172743-1-peterx@redhat.com>
References: <20201019225720.172743-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It'll be used in follow up patches to access more fields out of it.  Meanwhile
fetch the userfaultfd inside the function.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0a2f88a87d..722034dc01 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1128,10 +1128,12 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
     return 0;
 }
 
-static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
+static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
                                void *from_addr, uint64_t pagesize, RAMBlock *rb)
 {
+    int userfault_fd = mis->userfault_fd;
     int ret;
+
     if (from_addr) {
         struct uffdio_copy copy_struct;
         copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
@@ -1185,7 +1187,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
      * which would be slightly cheaper, but we'd have to be careful
      * of the order of updating our page state.
      */
-    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
+    if (qemu_ufd_copy_ioctl(mis, host, from, pagesize, rb)) {
         int e = errno;
         error_report("%s: %s copy host: %p from: %p (size: %zd)",
                      __func__, strerror(e), host, from, pagesize);
@@ -1212,7 +1214,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
      * but it's not available for everything (e.g. hugetlbpages)
      */
     if (qemu_ram_is_uf_zeroable(rb)) {
-        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, pagesize, rb)) {
+        if (qemu_ufd_copy_ioctl(mis, host, NULL, pagesize, rb)) {
             int e = errno;
             error_report("%s: %s zero host: %p",
                          __func__, strerror(e), host);
-- 
2.26.2


