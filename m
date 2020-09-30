Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A0C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1770206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LytOGkM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1770206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNazP-0005xH-Qa
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNaxE-0003lj-FO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNaxC-00079d-N5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601467885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2vTvpMUs/R+7+oon1oKvJdjTeI/HB6VBRES9SzXx2Q=;
 b=LytOGkM/uptK/ZTQ3uHLA0iYDIIG+7DOtC1kUU6uEFM/rDTCZ9ueULFQ7qL38eX8+MsvRz
 j7WmjbKZ2Dzbsuqx+9p7KGJTfSy+Io+vCpr/Xclkew80m6sccLfPCSsmznB/IAn1eGSrU9
 flMeOsyrb9M1H3xStQU1IEe8Cjt05Oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-9imyaUpBNGiaOzQLglCR1w-1; Wed, 30 Sep 2020 08:11:21 -0400
X-MC-Unique: 9imyaUpBNGiaOzQLglCR1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6494425D0;
 Wed, 30 Sep 2020 12:11:19 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EE3B6198B;
 Wed, 30 Sep 2020 12:11:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] qemu-nbd: Honor SIGINT and SIGHUP
Date: Wed, 30 Sep 2020 07:11:01 -0500
Message-Id: <20200930121105.667049-2-eblake@redhat.com>
In-Reply-To: <20200930121105.667049-1-eblake@redhat.com>
References: <20200930121105.667049-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 rjones@redhat.com, vsementsov@virtuozzo.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Honoring just SIGTERM on Linux is too weak; we also want to handle
other common signals, and do so even on BSD.  Why?  Because at least
'qemu-nbd -B bitmap' needs a chance to clean up the in-use bit on
bitmaps when the server is shut down via a signal.

See also: http://bugzilla.redhat.com/1883608

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index bacb69b0898b..e7520261134f 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -581,7 +581,7 @@ int main(int argc, char **argv)
     const char *pid_file_name = NULL;
     BlockExportOptions *export_opts;

-#if HAVE_NBD_DEVICE
+#ifdef CONFIG_POSIX
     /* The client thread uses SIGTERM to interrupt the server.  A signal
      * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
      */
@@ -589,9 +589,9 @@ int main(int argc, char **argv)
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


