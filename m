Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C5C433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3691F205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvxEqol0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3691F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzVr-0008KF-Et
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juzKZ-0006bt-Ni
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:21:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juzKX-00085H-QQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594650077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cR38izSMX6UNQ6106BAAWY0oYRYZqleeDbvwyj0w04=;
 b=GvxEqol0kbMN3O1KtbvdkElOYFc1SPDlwA/XIvxaXiv8C8dCgAv5o1YqyalCrKNB0qI1zS
 /T5cTSsL628xYZq6qih1LcMofPCnb0Ih3pnqjMnDhEl0HfeMRBOCzIj4rRnEtCMxPfZ51m
 sMRpgwRVWOhlea8J/y1EiSa/F9zY/8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-EAb9lFE1NxG2lJ9HNyKQWA-1; Mon, 13 Jul 2020 10:21:11 -0400
X-MC-Unique: EAb9lFE1NxG2lJ9HNyKQWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0AD100960F;
 Mon, 13 Jul 2020 14:21:10 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BFF776203;
 Mon, 13 Jul 2020 14:21:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] hax: Fix setting of FD_CLOEXEC
Date: Mon, 13 Jul 2020 09:21:03 -0500
Message-Id: <20200713142106.261809-3-eblake@redhat.com>
In-Reply-To: <20200713142106.261809-1-eblake@redhat.com>
References: <20200713142106.261809-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wenchao Wang <wenchao.wang@intel.com>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>, Colin Xu <colin.xu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Blindly setting FD_CLOEXEC without a read-modify-write will
inadvertently clear any other intentionally-set bits, such as a
proposed new bit for designating a fd that must behave in 32-bit mode.
Use our wrapper function instead of an incorrect hand-rolled version.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200420175309.75894-2-eblake@redhat.com>
Reviewed-by: Colin Xu <colin.xu@intel.com>
---
 target/i386/hax-posix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index 3bad89f13337..5f9d1b803dec 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -23,7 +23,7 @@ hax_fd hax_mod_open(void)
         fprintf(stderr, "Failed to open the hax module\n");
     }

-    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(fd);

     return fd;
 }
@@ -147,7 +147,7 @@ hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
     fd = open(vm_name, O_RDWR);
     g_free(vm_name);

-    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(fd);

     return fd;
 }
@@ -200,7 +200,7 @@ hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
     if (fd < 0) {
         fprintf(stderr, "Failed to open the vcpu devfs\n");
     }
-    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(fd);
     return fd;
 }

-- 
2.27.0


