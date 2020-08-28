Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98424C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6749A20872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsltD5LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6749A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdoi-0003vb-Ll
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdlC-0007G9-2M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl9-0006J0-82
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598618733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOjpi5aDbVKbhupvDfjI+zgd5MOMOYyjWIyqirdog6k=;
 b=bsltD5LMSLSp41C1GE55uRxTvnzuGUH5En5EYfOC90D+pYIp/uqfD+2nzNO6W673pQxJ0i
 Bjsxd6bs8sDk2FY3woFPUNmgzjmYfzEXB5TSllyiSJbxLOkvdzxxox9bv6AN6LAnMG9t+D
 ++Gdom/PnFoohlQdRuy1mCJ5//JJB4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-egFatznMOsiWWEAN9UpHIw-1; Fri, 28 Aug 2020 08:45:28 -0400
X-MC-Unique: egFatznMOsiWWEAN9UpHIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0D510066FB;
 Fri, 28 Aug 2020 12:45:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-100.ams2.redhat.com
 [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD57974E12;
 Fri, 28 Aug 2020 12:45:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 slp@redhat.com, yezhenyu2@huawei.com, longpeng2@huawei.com,
 berrange@redhat.com
Subject: [PULL 5/8] virtiofsd: Disable remote posix locks by default
Date: Fri, 28 Aug 2020 13:45:06 +0100
Message-Id: <20200828124509.311210-6-dgilbert@redhat.com>
In-Reply-To: <20200828124509.311210-1-dgilbert@redhat.com>
References: <20200828124509.311210-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

Right now we enable remote posix locks by default. That means when guest
does a posix lock it sends request to server (virtiofsd). But currently
we only support non-blocking posix lock and return -EOPNOTSUPP for
blocking version.

This means that existing applications which are doing blocking posix
locks get -EOPNOTSUPP and fail. To avoid this, people have been
running virtiosd with option "-o no_posix_lock". For new users it
is still a surprise and trial and error takes them to this option.

Given posix lock implementation is not complete in virtiofsd, disable
it by default. This means that posix locks will work with-in applications
in a guest but not across guests. Anyway we don't support sharing
filesystem among different guests yet in virtiofs so this should
not lead to any kind of surprise or regression and will make life
little easier for virtiofs users.

Reported-by: Aa Aa <jimbothom@yandex.com>
Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst         | 2 +-
 tools/virtiofsd/passthrough_ll.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 824e713491..2cfdfd9ba2 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -67,7 +67,7 @@ Options
     Disable racy fallback.  The default is false.
 
   * posix_lock|no_posix_lock -
-    Enable/disable remote POSIX locks.  The default is ``posix_lock``.
+    Enable/disable remote POSIX locks.  The default is ``no_posix_lock``.
 
   * readdirplus|no_readdirplus -
     Enable/disable readdirplus.  The default is ``readdirplus``.
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 63d1d00565..a9feb90fd0 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2823,7 +2823,7 @@ int main(int argc, char *argv[])
     struct lo_data lo = {
         .debug = 0,
         .writeback = 0,
-        .posix_lock = 1,
+        .posix_lock = 0,
         .proc_self_fd = -1,
     };
     struct lo_map_elem *root_elem;
-- 
2.26.2


