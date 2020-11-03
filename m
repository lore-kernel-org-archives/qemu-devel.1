Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B663C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E834320757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="by6Qp17Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E834320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxkl-0000sX-0B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPd-0005nw-3P
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPT-0006vm-EJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rcR22V11VaSxRGTj44Apo/6OVNtdiu3pQdLqlX7HYbs=;
 b=by6Qp17ZBff0EDP4UmwQTZKX4W2MmXkfnygUP+34iWfqsYwIuthSczxFTsJNRK0GErdECq
 6nBvoQ9Xli1KzUJpvH9ZWLcB6tedVnHgp/EroTKw/dLZRf8yUZpcOhWdPRqNQnxNDEICz7
 ce5DEJMVBsxAx16PWB+kfORiRaCkfOk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-wHBijEJFNTCOKjFUpp4FdQ-1; Tue, 03 Nov 2020 09:35:37 -0500
X-MC-Unique: wHBijEJFNTCOKjFUpp4FdQ-1
Received: by mail-wr1-f72.google.com with SMTP id h8so7919474wrt.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rcR22V11VaSxRGTj44Apo/6OVNtdiu3pQdLqlX7HYbs=;
 b=kaEUhZOL1OvGyMTxKZUx4rF8Ag4oCZyM3+d+TFF5fbWnJXUJNIklgjDUF+2hzcfqZe
 pDtj+geQH28OpkvlAjqVIWoAckCjjGm5jTLBiYaAtiuiaSLt1YtAm2PoODI5ULMVaQDB
 pKGeFLaJUVrIP+ZC5IKIfnt2U8ke0uL9gFChtqdl8FrSwB9A2TjTgRwhoLWPGXM5QJE3
 wY5kxMcjISJ4+qCAv4YFzhjSmWLzKYIOVRlStaRgk6+i+DR708Lw8inEqqObDljD2xxH
 SgQfsU9Fb1+vBDYIbaKDhzBZ/WVBb/VV3M9aZmEnWi9WQKYf6Wtd02s/BW+7vkckblIt
 jAhg==
X-Gm-Message-State: AOAM531Fi64fmwojbxjcjb1IznRZ8TtjUx1SGBf0dGJAH/ZpBqKqTMq3
 WauWSIHzgCY7CTzWBJdKsNtDAQR29QEQ/EFr+P9np51K5jE+LweeSirQQrJ742P29L/hL3eOGS3
 dWCUlDMUSputKolE=
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr74311wmj.112.1604414136240;
 Tue, 03 Nov 2020 06:35:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaeOPGVrJl8XK6+gPd8MFdygPE5F3FcdAmUH4JOkHIQmkR+9ZPJUdSX9+z0v5X5T0CaUuzOA==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr74291wmj.112.1604414136060;
 Tue, 03 Nov 2020 06:35:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id o7sm26452454wrp.23.2020.11.03.06.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:35 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/38] vhost-user-blk-test: close fork child file descriptors
Message-ID: <20201103142306.71782-37-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Do not leave stdin, stdout, stderr open after fork. stdout is the
tap-driver.pl pipe. If we keep the pipe open then tap-driver.pl will not
detect that qos-test has terminated and it will hang.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-11-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index f05f14c192..15daf8ccbc 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -749,6 +749,17 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
                    storage_daemon_command->str);
     pid_t pid = fork();
     if (pid == 0) {
+        /*
+         * Close standard file descriptors so tap-driver.pl pipe detects when
+         * our parent terminates.
+         */
+        close(0);
+        close(1);
+        close(2);
+        open("/dev/null", O_RDONLY);
+        open("/dev/null", O_WRONLY);
+        open("/dev/null", O_WRONLY);
+
         execlp("/bin/sh", "sh", "-c", storage_daemon_command->str, NULL);
         exit(1);
     }
-- 
MST


