Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95886207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gl3lHeBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95886207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99Ik-0005Ya-T8
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k99I1-00053H-Bq
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:49:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k99Hz-0000tm-0U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598024949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9AkYi/06F0vW6OwRPHGsyAkVtaOyjTXBnCWZWRihv+8=;
 b=Gl3lHeBXfP6Tz5jXsQrR+kFhBu777v44EKLqDG7AA2wEK3a00hAiOBmgb11TBatmu4hfR1
 06jpJ+bdrF5kuivCQTPz634xIWCS5EF5jtkkJ2zhkg/5yegErWLqMHZF3cM2sMRMUTjXV8
 qpHJGLXtgMNAIDGcaMBKuOAf9ekqAqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354--0Bv16emPFirY1dCZWVrVg-1; Fri, 21 Aug 2020 11:49:05 -0400
X-MC-Unique: -0Bv16emPFirY1dCZWVrVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D895481CBE7;
 Fri, 21 Aug 2020 15:49:04 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D40360BF1;
 Fri, 21 Aug 2020 15:48:54 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] util/meson.build: fix fdmon-io_uring build
Date: Fri, 21 Aug 2020 17:48:53 +0200
Message-Id: <20200821154853.94379-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libqemuutil.a build fails with this error:

  /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `get_sqe':
  qemu/build/../util/fdmon-io_uring.c:83: undefined reference to `io_uring_get_sqe'
  /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:92: undefined reference to `io_uring_submit'
  /usr/bin/ld: qemu/build/../util/fdmon-io_uring.c:96: undefined reference to `io_uring_get_sqe'
  /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_wait':
  qemu/build/../util/fdmon-io_uring.c:289: undefined reference to `io_uring_submit_and_wait'
  /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_setup':
  qemu/build/../util/fdmon-io_uring.c:328: undefined reference to `io_uring_queue_init'
  /usr/bin/ld: libqemuutil.a(util_fdmon-io_uring.c.o): in function `fdmon_io_uring_destroy':
  qemu/build/../util/fdmon-io_uring.c:343: undefined reference to `io_uring_queue_exit'
  collect2: error: ld returned 1 exit status

This patch fix the issue adding 'linux_io_uring' dependency for
fdmon-io_uring.c

Fixes: a81df1b68b ("libqemuutil, qapi, trace: convert to meson")
Cc: pbonzini@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 util/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/meson.build b/util/meson.build
index 23b8ad459b..e6b207a99e 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -4,7 +4,7 @@ util_ss.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
 util_ss.add(when: 'CONFIG_EPOLL_CREATE1', if_true: files('fdmon-epoll.c'))
-util_ss.add(when: 'CONFIG_LINUX_IO_URING', if_true: files('fdmon-io_uring.c'))
+util_ss.add(when: ['CONFIG_LINUX_IO_URING', linux_io_uring], if_true: files('fdmon-io_uring.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
-- 
2.26.2


