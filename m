Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0353C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFADA207DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFlcqx/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFADA207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHcn-0008H2-V0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbl-0006Wi-4s
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbj-0004Mx-E8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZqj3bTam91VJKMgXj5mJaby8iNVg3MqxY1e+jpggf8=;
 b=aFlcqx/3vcke3nbIlpYeh3UhfvXWTySBbPxF5FD0CXoEFmo3+b1zQI4+EIF7DXmKhUDmS8
 aNQFVs3UQ4OJRLnsZwdWuPk1+KWFyp8Wbqv/oqn69yg11VTtQCQzsmQMvJPqCcT6TKdPZR
 v4FrTtbceVj7AprCG/qlvS7abhnlJ/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-V_WzGbf8NfeAIg1YKSX-WQ-1; Fri, 03 Jul 2020 05:03:38 -0400
X-MC-Unique: V_WzGbf8NfeAIg1YKSX-WQ-1
Received: by mail-wm1-f72.google.com with SMTP id g6so28645033wmk.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AZqj3bTam91VJKMgXj5mJaby8iNVg3MqxY1e+jpggf8=;
 b=GYXrGfvHYRrJ8O+ITIt7UEajzRZu7LnuT/gnHROiMbQe3zUWpHxhfQ0HYjX1/E6JSf
 nJlWKvjRmBCIeTUacD/DLLkmYdQ6jINPZ2MjuwWfyKV7GM+QtSvbU4Vm1FeR/XzVmoIv
 Fpl82GXOLEMGo/6Yc6tAGbtSAz+TKNbKSauTwKWFEiBSaj0IcZ2di1KWf0WPC3iCMdo9
 2TRESfuRbwooKH2xzA6joptQEWe5hrXTbXGJPhF+MnfOTAlSkltpo0YnWonVAmay2A10
 ScAsjZs3uDzb4P0VxrF09b7IOXU5iYRIEfT+V0kwJobh/6GykRLsfHEB/nfX9RlQfNrN
 ZH2w==
X-Gm-Message-State: AOAM532csp1GwMEXrzoLoOn5E0ethGfol0UPjyQmn1dw6N7iIsZ+eXDj
 iOeY+Zgd3m5Ug4Kfjr9CFVTHwm+t5pON2W34yS34FXA0zXgKltGG8SSMvxc14UtYv7mA6vwB64/
 i/oKWj08d4amMjhg=
X-Received: by 2002:adf:e944:: with SMTP id m4mr36398271wrn.252.1593767017154; 
 Fri, 03 Jul 2020 02:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznoot4RKu6ewktM7kVzYViOQ+YF9Kf/tp8FAaPlHR1r42c6UpGWD9YwduYyhKcX5Jl3NuvhQ==
X-Received: by 2002:adf:e944:: with SMTP id m4mr36398265wrn.252.1593767016996; 
 Fri, 03 Jul 2020 02:03:36 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u65sm12684816wmg.5.2020.07.03.02.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:36 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200703090252.368694-3-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
since that change makes unit tests much slower for all developers, while it's not
a robust way to fix migration tests. Migration tests need to find
a more robust way to discover a reasonable bandwidth without slowing
things down for everyone.

Fixes: 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index dc3490c9fa..21ea5ba1d2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
      * without throttling.
      */
     migrate_set_parameter_int(from, "downtime-limit", 1);
-    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
 
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
-- 
MST


