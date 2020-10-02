Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5760EC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC656206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpriClCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC656206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPH7-0002VC-SF
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOPFZ-0001I5-0s
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOPFX-00056r-AQ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601661222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=CpriClChmq0QWDaCZV2w70Vxcg57nFNXim7hp+uzFT6lTTNv9YUWCnfutLTaTsV6oTwPwR
 l4ZRylWT61SLvqnms4jKsjwf0OggvxAG4TcEzn59dTrFyVgcTxBFo6M8e3dO/bGAB6LqI8
 V4bdHtumOPMM3aAlbLmnbE81PHVBCcA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-iHJH8sICNOuIXoPy1FEVUA-1; Fri, 02 Oct 2020 13:53:40 -0400
X-MC-Unique: iHJH8sICNOuIXoPy1FEVUA-1
Received: by mail-qt1-f198.google.com with SMTP id y20so143019qta.6
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=mJhQgRyLcxqxHL1Pm7AZ9DGM4fheu+SDYWOghrR+7P9ReQT91tXOWqID7/cu2Ops0+
 RibKkauuc3Vnv/DWJ9Lm9D+/3Pip+8MwdbDaDsZ/4MVCOjFhMuSh4b5RBrhJDyG4PqDf
 hwgCS5tr2wZC8IYBdv4Rbghy6ie7zCYgwb+FtsA6Cnsct910kuRlPqVBQblevejQnWYx
 dlXL5HD1u5p7BRdk6cQu4FB+xRYDlp8bOW8GO7SkZBhDu3w7ZXwEczeh3c2zErAclWHS
 YazdapSw3oADLkAGf1k9rkCZ6Cy+OBVioIyLcYdM1XlESgbowRoAfWkjkCIzO/lVAeRX
 QwKQ==
X-Gm-Message-State: AOAM530obCJ6V5+MSwRXehxhkufSk28ne0q1kemd6Rn0lpf7WWvoOIyl
 siRAOv/unQYrpY1VwwJ45eiJYVDcEOuz7L1+4RRAkh0V3sG68T6sALnrLttYjo/kgK4zxbvAR9N
 eggf9eLlPIZlHbwE=
X-Received: by 2002:aed:278a:: with SMTP id a10mr3579714qtd.261.1601661220211; 
 Fri, 02 Oct 2020 10:53:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7DN7dwDxIW3w9Rmt7xM7ZdW13boK2yoAnuKZENMhrjpAOuqT4kZ81tLEmcajYW2Dy1gMpVA==
X-Received: by 2002:aed:278a:: with SMTP id a10mr3579691qtd.261.1601661219987; 
 Fri, 02 Oct 2020 10:53:39 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id a3sm1562229qtp.63.2020.10.02.10.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:53:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/4] migration: Pass incoming state into
 qemu_ufd_copy_ioctl()
Date: Fri,  2 Oct 2020 13:53:33 -0400
Message-Id: <20201002175336.30858-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002175336.30858-1-peterx@redhat.com>
References: <20201002175336.30858-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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


