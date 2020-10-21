Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC2CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C494221F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVGeQq4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C494221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLiZ-0007Cy-5E
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLe2-0003F0-An
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLdp-00025K-GT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603315647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=KVGeQq4GMNs7kPib77huokFb590Ar7utEEx3phWtiK6Tq9DOpkkWp97TpFmGGAhXeazsVE
 LuCblgaWUebNpwRFXSg7tX5l7B9no+5juNPDzOPXJ1B9ef3Yc6bz9Ld2wEjz5OtBGo0bHR
 9LNefAIVLuA3NBolCenmf/tZ7DkMwho=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-PSukzV2IPfyFFlk4nl-Yiw-1; Wed, 21 Oct 2020 17:27:26 -0400
X-MC-Unique: PSukzV2IPfyFFlk4nl-Yiw-1
Received: by mail-qv1-f69.google.com with SMTP id m11so2097868qvt.11
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n4IR530G0jn3KaGrAMU+kHWU9guPG9Q80wHEffp3OJw=;
 b=LTKkHcfZmuBPr23rLxLjCP1wcaC6KNcaEYcPy7SfEZLf0mQg3X9qCCpPxxUgvxettV
 CD2uOgdv+aI/gYaIpCCCqWBUTFnF0RSoWQbhu4sKfTwRdt2gUwf2SerypHUCrcluj/gC
 0jmudEXDnKgmIMjG8HxI0MGpkEMdZSSNQ5jGZYboGY7pUQVBflzB0H+7ZEtO2eJLIzG3
 zC6USm89xWSw8NHKW8s1HNbwW7Jh9SDdGwJX1c9nRW+HnlzErNtNx5/sqB88S6CK08nf
 gwd14JwKx4+2bIGV/C8xQD4XFVmSdvcPT9u5AHsKwE2EePgwW/hq8psnMEcKkKxbTdum
 +CWw==
X-Gm-Message-State: AOAM532rveMDEcl96iKsd2iFE9bBaRZma9EbME9/gcgnNh2MPTc3l9YN
 0gZrKq+gtaViPgdtkhmqODUK+UMKM06IGZVV1/S7yuvKQDNDhUfLUCqr7N3cyAnHxHEzaJK4h2W
 kDMYP2SYwv/Jrygg=
X-Received: by 2002:ae9:c005:: with SMTP id u5mr5254154qkk.41.1603315645405;
 Wed, 21 Oct 2020 14:27:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+g7pHqA+gM/cCHBZfxkOPa8HFEBdHpKkMoChWdYtjvPTZC0UJfk3dIFiL5wOF2bT1ds4GOg==
X-Received: by 2002:ae9:c005:: with SMTP id u5mr5254126qkk.41.1603315645117;
 Wed, 21 Oct 2020 14:27:25 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id p187sm2089145qkf.70.2020.10.21.14.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 14:27:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/6] migration: Pass incoming state into
 qemu_ufd_copy_ioctl()
Date: Wed, 21 Oct 2020 17:27:16 -0400
Message-Id: <20201021212721.440373-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021212721.440373-1-peterx@redhat.com>
References: <20201021212721.440373-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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


