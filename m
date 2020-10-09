Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D7C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4556D221FD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWKrod/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4556D221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyoo-0000YM-CI
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQygG-0000R7-FM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQyg8-0007QC-Qv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602274068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYjVE2VFRDXGvlQ06vD3869NYaSOfANpD5uHf5tCdrM=;
 b=QWKrod/UUYfvfaAyh6CjvS+2bRtvVPx5ugWFK/V6P6/nZFFxZ2ECbl6n21VMP9K+aqvoCb
 lcfYwEJcEin7Qav6V1rEGxQUCCHMk/rcoPED3FDPcD921686ETvyhBO3AbmNkt/+r5OM0/
 0E5HQTsYMYsCW3QIc0NOUnGo0uAn5LY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-DwIp_0nyPoCMehK0VAgHFQ-1; Fri, 09 Oct 2020 16:07:45 -0400
X-MC-Unique: DwIp_0nyPoCMehK0VAgHFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 923B41084C92;
 Fri,  9 Oct 2020 20:07:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 416FE10027AB;
 Fri,  9 Oct 2020 20:07:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 6/8] qemu-nbd: Honor SIGINT and SIGHUP
Date: Fri,  9 Oct 2020 15:07:18 -0500
Message-Id: <20201009200720.1169904-7-eblake@redhat.com>
In-Reply-To: <20201009200720.1169904-1-eblake@redhat.com>
References: <20201009200720.1169904-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Honoring just SIGTERM on Linux is too weak; we also want to handle
other common signals, and do so even on BSD.  Why?  Because at least
'qemu-nbd -B bitmap' needs a chance to clean up the in-use bit on
bitmaps when the server is shut down via a signal.

See also: http://bugzilla.redhat.com/1883608

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200930121105.667049-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: apply comment tweak suggested by Vladimir; fix ifdef around
termsig_handler]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index bacb69b0898b..bc644a0670b6 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -154,13 +154,13 @@ QEMU_COPYRIGHT "\n"
     , name);
 }

-#if HAVE_NBD_DEVICE
+#ifdef CONFIG_POSIX
 static void termsig_handler(int signum)
 {
     qatomic_cmpxchg(&state, RUNNING, TERMINATE);
     qemu_notify_event();
 }
-#endif /* HAVE_NBD_DEVICE */
+#endif /* CONFIG_POSIX */

 static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
                                 const char *hostname)
@@ -581,17 +581,18 @@ int main(int argc, char **argv)
     const char *pid_file_name = NULL;
     BlockExportOptions *export_opts;

-#if HAVE_NBD_DEVICE
-    /* The client thread uses SIGTERM to interrupt the server.  A signal
-     * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
+#ifdef CONFIG_POSIX
+    /*
+     * Exit gracefully on various signals, which includes SIGTERM used
+     * by 'qemu-nbd -v -c'.
      */
     struct sigaction sa_sigterm;
     memset(&sa_sigterm, 0, sizeof(sa_sigterm));
     sa_sigterm.sa_handler = termsig_handler;
     sigaction(SIGTERM, &sa_sigterm, NULL);
-#endif /* HAVE_NBD_DEVICE */
+    sigaction(SIGINT, &sa_sigterm, NULL);
+    sigaction(SIGHUP, &sa_sigterm, NULL);

-#ifdef CONFIG_POSIX
     signal(SIGPIPE, SIG_IGN);
 #endif

-- 
2.28.0


