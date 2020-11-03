Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64563C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5EA21534
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMG+B2rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5EA21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxlB-0001ez-TQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPd-0005nq-0D
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPV-0006wa-3E
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0BE6BIYyp008EuFnEKAYjzMhrYRUbO0ZaRk54gDh4k=;
 b=OMG+B2rhsspzUWUJutwO30mgasxD2V66lSpxJCa8l/vM0ZZhp1WZF92VzZyURp4OKZhEEU
 SmSqBgJUm5hEMm9SxVtNcTWjcIQBKt5aRJWDSdjS4j9ryvRkuKGbwanySUVVxQqUXfackn
 n+c9f4lJgYmstlVe0mZobkcTLmuAoxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-HYsJju8uPGSueYleCp7IhA-1; Tue, 03 Nov 2020 09:35:40 -0500
X-MC-Unique: HYsJju8uPGSueYleCp7IhA-1
Received: by mail-wm1-f70.google.com with SMTP id c10so3822637wmh.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L0BE6BIYyp008EuFnEKAYjzMhrYRUbO0ZaRk54gDh4k=;
 b=Uv9SCgNVBs2qBJ82g4TDQR6vawtfLd6E56AxMI2cK/Z1gA070CdnUbK1/R1ESjZtNk
 wo/XWpyyzLIqJ9x5Bkurrrtxnwn8WcXd8pJYu7p1mzBCYg5k4qqAL+b2fOR8+mZeymB9
 FtI34PXGV2xRdz9QYwMyZNsIEi4IvfmFyw5O2kc1cMEjzeyZZ70b5wSRXf3VPncgJ8bg
 KwB5PKt7kpKlWKniawZpUflcDMSO7a77cB/An18xNaJm0vQTUvb/e3fdHT6qvqTH5ERO
 1hMrQrBhy7D+idvx9ntfiN+9olhDX6phvqC+veMdT+00j/jzrQRIBe4nzbVtDZBe8wo+
 BxhQ==
X-Gm-Message-State: AOAM5306ssHSNbLbzxyin1i91csHqKaefh04ehvYTKKLlfHqTYZk+Wdn
 X1/AjwZhojIYMA6ppbviV0Hy81+8FS6i1oqdOhQq8RfYwXVX/IKfEF/PKXdvxU/GXKh7b7YsXWH
 RFmTYR7Ujb/KUYFs=
X-Received: by 2002:a5d:4987:: with SMTP id r7mr25151041wrq.327.1604414138892; 
 Tue, 03 Nov 2020 06:35:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6eT8xSIAkLFdGF44qCEw81GfoHqealWC0BvlZUQ7Lze2P7OMlEvPznNZ+X2OmMquKrpWvLw==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr25151026wrq.327.1604414138695; 
 Tue, 03 Nov 2020 06:35:38 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id s202sm3127156wme.39.2020.11.03.06.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:37 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/38] vhost-user-blk-test: drop unused return value
Message-ID: <20201103142306.71782-38-mst@redhat.com>
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

The sock_path return value was unused and bogus (it doesn't make sense
when there are multiple drives because only the last path is arbitrarily
returned).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-12-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 15daf8ccbc..0d056cc189 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -705,8 +705,8 @@ static void quit_storage_daemon(void *qmp_test_state)
     g_free(qmp_test_state);
 }
 
-static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
-                                  int num_queues)
+static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
+                                 int num_queues)
 {
     const char *vhost_user_blk_bin = qtest_qemu_storage_daemon_binary();
     int fd, qmp_fd, i;
@@ -774,7 +774,6 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
     g_test_queue_destroy(quit_storage_daemon, qmp_test_state);
 
     qobject_unref(qtest_qmp(qmp_test_state, "{'execute': 'qmp_capabilities'}"));
-    return sock_path;
 }
 
 static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
-- 
MST


