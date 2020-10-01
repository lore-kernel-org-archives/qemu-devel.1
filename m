Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EBBC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9DC20796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeB2Djnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9DC20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3Pd-00027K-Dr
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kO3I6-0002Uy-EW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kO3I3-0003gD-8L
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601576807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=IeB2DjnhBODBRec4Q0vfrnhMUEMvA6pTAAVKya3Zc3l6hy/K56c26UoqjOhJwBJnpqdlon
 WPICf+5DsoDWppc9ohVTjFb2NT8H24hVbMELUDQQhwizWZm4lvXIcT3YsKnWz8WpkJBtqf
 AK64Ktpl578vqD5/z4WQ1SP5Aw6VNGo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-18DrE5bVMSmn7IHIq8Mg5g-1; Thu, 01 Oct 2020 14:26:45 -0400
X-MC-Unique: 18DrE5bVMSmn7IHIq8Mg5g-1
Received: by mail-qt1-f198.google.com with SMTP id w92so4369524qte.19
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 11:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=ai3r/JQhi0hUQUz2BhZHOeZcTc/lLCk0VDwFkWxohxVlWB/nzwcMlDjQfRNqIayJBQ
 g4tC34A90eK3hkhE7d5Qc3Rs8jXB66zWlAK/9zJXbLC1TYS36yIIMWfpwgfjMx0vQ1O5
 HXxOf73t2gUN1QpNGoWHZfNVD1QLEb0HsTS36tWtZ8PCMaNx4k+VqkwBlnQ8Jig6ee0f
 q6jV0IRha63TarIfksWjHeRl2QZiSSuQAi3TtKH5ZxmfeVwvL+yBzE8beeasLMuPFGap
 2zoBY3RiofxrUx0RrtF7OpKtkIntW4D6oFCKhtWo7GO7EcIBylhaizAlwWPXIHYSJ4bB
 qxBA==
X-Gm-Message-State: AOAM532qAqFFSgntptl2mGbpJA/7h+EZzwbcRN1NC2lRNrifTFIdXpAi
 Ru8/sk7a87NZds1G+9SRp8BHfV9rxWp+SrLBsQtH+k06Jg9dc+oGcP7MUP85tyM5Gz6mXc9kCFL
 PAqfXnpaXiLLAaW0=
X-Received: by 2002:a05:620a:200d:: with SMTP id
 c13mr8627019qka.499.1601576804963; 
 Thu, 01 Oct 2020 11:26:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCbbMFpMCsfRF4FMFhvulPIvAG8ebmJ825JzVhQZTzDeBWMmF7VftAMt+KMqW7p3K9CYAtpw==
X-Received: by 2002:a05:620a:200d:: with SMTP id
 c13mr8627006qka.499.1601576804728; 
 Thu, 01 Oct 2020 11:26:44 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id v56sm7892699qtc.49.2020.10.01.11.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 11:26:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] migration: Pass incoming state into
 qemu_ufd_copy_ioctl()
Date: Thu,  1 Oct 2020 14:26:38 -0400
Message-Id: <20201001182641.80232-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001182641.80232-1-peterx@redhat.com>
References: <20201001182641.80232-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
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


