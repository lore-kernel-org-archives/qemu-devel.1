Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE248C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA3220872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuU43Kqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA3220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdqJ-0006Zd-RD
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdlK-0007RW-1A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdlH-0006Kx-R2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598618743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R271ftWMEeSXwV22G2lrWiKoQD8HQLpz+9iqjHu2GlE=;
 b=fuU43KqnqT+qL+xN7ny6qJL1GI5NltE2XxdgNwb7aAEEOxgutMXAMmfRIgPpLKqqO6p/P+
 5aQ+jQxcNUd0Z54KiRHoRBS31muc9ApydDfo+dMknG7YN42UyCE7/nvpDLVaCQkqWJKpZ4
 37ZGYoPGp+wA7gTLpkJODy/MEFwLu+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-x0eW2JqLPN63F-4V4pm7ag-1; Fri, 28 Aug 2020 08:45:39 -0400
X-MC-Unique: x0eW2JqLPN63F-4V4pm7ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169D9189E61A;
 Fri, 28 Aug 2020 12:45:38 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-100.ams2.redhat.com
 [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 970EA74E12;
 Fri, 28 Aug 2020 12:45:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 slp@redhat.com, yezhenyu2@huawei.com, longpeng2@huawei.com,
 berrange@redhat.com
Subject: [PULL 8/8] virtiofsd: probe unshare(CLONE_FS) and print an error
Date: Fri, 28 Aug 2020 13:45:09 +0100
Message-Id: <20200828124509.311210-9-dgilbert@redhat.com>
In-Reply-To: <20200828124509.311210-1-dgilbert@redhat.com>
References: <20200828124509.311210-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.001
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

From: Stefan Hajnoczi <stefanha@redhat.com>

An assertion failure is raised during request processing if
unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
be detected right away.

Unfortunately Docker/Moby does not include unshare in the seccomp.json
list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
include unshare (e.g. podman is unaffected):
https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json

Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if the
default seccomp.json is missing unshare.

Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200727190223.422280-4-stefanha@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 3b6d16a041..9e5537506c 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session *se)
 {
     int ret;
 
+    /*
+     * Test that unshare(CLONE_FS) works. fv_queue_worker() will need it. It's
+     * an unprivileged system call but some Docker/Moby versions are known to
+     * reject it via seccomp when CAP_SYS_ADMIN is not given.
+     *
+     * Note that the program is single-threaded here so this syscall has no
+     * visible effect and is safe to make.
+     */
+    ret = unshare(CLONE_FS);
+    if (ret == -1 && errno == EPERM) {
+        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EPERM. If "
+                "running in a container please check that the container "
+                "runtime seccomp policy allows unshare.\n");
+        return -1;
+    }
+
     ret = fv_create_listen_socket(se);
     if (ret < 0) {
         return ret;
-- 
2.26.2


