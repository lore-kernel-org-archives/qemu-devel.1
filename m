Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3CEC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38D12072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJSOZMOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38D12072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrBR-0004OD-1Y
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8e-0000IX-87
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8c-0000E6-FB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNN9HMxErQBgUM+loGmpJTxuhPYQQVhkbsp50pLpF+c=;
 b=RJSOZMOirC+FFmRFAsu7Z7Alfq/Z2+XKK9+IS7XodMvyWgxZdQMu5VS9FVkEUQUVb5jUA8
 Knz9fla0PwX9J+5fmPsFAn2fmxJd106Mz93X0Yyrpf/HGUnCJncMp+LY+K46PooRlRgdnu
 aSjKv9ZCC7mnjetc42nrcS8ksHGg/YY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-SA9GxHsdNJ2BjR_p84eRYg-1; Thu, 03 Sep 2020 11:26:55 -0400
X-MC-Unique: SA9GxHsdNJ2BjR_p84eRYg-1
Received: by mail-qt1-f199.google.com with SMTP id j35so2350750qtk.14
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yNN9HMxErQBgUM+loGmpJTxuhPYQQVhkbsp50pLpF+c=;
 b=F1UhqyLgotfvZTUvcE9+l6Ee9X4msTS/ts/1VmeK8DUqXVLqQ1+C1ylht5yzjYML72
 ukyY5m3DZ/RNBjad/9w2bRydOygtLbaARVUF+v1HJaNvmiHGmuo9nwiao1Hz2uxxNUNC
 WZ+6+aKssDS6Jz+QyOGnX1QjS19G1aySPR6VoLbncyblv3ytwDapwK7yLZ1PChWeb+yL
 RQzDDxBWPeRRoGwU6ple3xyvChtQrebs5uE/qp0tIHnlEYVmkLpQ4PSxagCaeI3byP8W
 ZIjI+Pyk7U9NsfWAd/utprND16IpU3oP7nbJzvlewYycK7YpSETLkuRIwEwXHOpuQqo2
 9OTA==
X-Gm-Message-State: AOAM5300O3nQFDdR9ks6fcNMaSD4zpT0NcH/uzjg13gq1yfb3rJDP1R2
 WDN3Py+g55b6SPGg1ds9vbELGfLeb+/ujPUcmUTAS7CBhLUJnKLLKUWu61S9Nz0wPdQZnV11JwR
 Xi//Yfh8hgJpMI14=
X-Received: by 2002:a37:68c7:: with SMTP id d190mr3553533qkc.127.1599146813432; 
 Thu, 03 Sep 2020 08:26:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhbtQYN6UmM0Ksh7FFhjMatqeLXu86Q7riw5gzhopdLkqndQyT0hc81xQA1N+MNil12P3LoA==
X-Received: by 2002:a37:68c7:: with SMTP id d190mr3553514qkc.127.1599146813196; 
 Thu, 03 Sep 2020 08:26:53 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id l38sm2319889qtl.58.2020.09.03.08.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 08:26:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] migration: Pass incoming state into qemu_ufd_copy_ioctl()
Date: Thu,  3 Sep 2020 11:26:44 -0400
Message-Id: <20200903152646.93336-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903152646.93336-1-peterx@redhat.com>
References: <20200903152646.93336-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It'll be used in follow up patches to access more fields out of it.  Meanwhile
fetch the userfaultfd inside the function.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 11a70441a6..d333c3fd0e 100644
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


