Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C60C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7CF22263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9aEUPaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7CF22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Ik-0000RY-Vb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Ah-0008FP-0J
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Af-0008So-EH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BidoL8dEegdrM2deUWRHfDO/6zWVfLj47EJ1lH5mvto=;
 b=c9aEUPaQq+48Q8xhhH5/wTmTXxdYNtQiCE6ZzBs5jttEfRN6deR8p5fcQBp3946yw1qegh
 fRtMO7W3iINlDqv/NV7L870Cuom95uI7+e6XAOcE0thXLRvIU35KjY3x6u1FnuHmk7jvVR
 6bD8rpWBFizo/HU1/uBnCLJ59dfvVwA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-I15IZh5HND-fk6UsdLxm4Q-1; Mon, 26 Oct 2020 06:56:11 -0400
X-MC-Unique: I15IZh5HND-fk6UsdLxm4Q-1
Received: by mail-wm1-f71.google.com with SMTP id s140so147229wme.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BidoL8dEegdrM2deUWRHfDO/6zWVfLj47EJ1lH5mvto=;
 b=iGncK7io4lEWo5u99MMwTA56FHX++PEfCHZIKiN+9ueUw/BxY9mHqt8ujbUaBRMc0j
 dDwpOgKl7OCs3/OCUEMBEfG9UJ2jcrcDpUB4hgo6bs3iKDZUs6ABinBwGMJYfYHx4inQ
 CGfKpbKogQo2FH+KJr5nNNQVh2cfnGb+lGpi9AxelPoyjcoik+PreBByVGnxZSovxUy3
 U2thb+YNl0/EIBXu0uhsLPXxlvF/xaG/mIMpux3K/zOwkDEHk1Z9NgJyzqn0ABS2vqKC
 t4W7BtsiVd43wJ/TG7U2wPhV3lQHvOS91MrsE926wXOTrQanAfwjuPAonOQEoAQMcEzC
 Ulrg==
X-Gm-Message-State: AOAM5324Z6jVScbCGvZ4z6+MLKD2KHcG8u+jwUpmFqKSQPHFm6lKA2M0
 Anyuqbep6nbyIgFmEG1fBMSKE3b4Xd5am/olqZNX80ydDI9C8iqSNr6KR4nVYlJgBt6DcXJFq0O
 QXkSNo9UsxSmWjY0=
X-Received: by 2002:a05:600c:24d:: with SMTP id
 13mr14575999wmj.99.1603709769694; 
 Mon, 26 Oct 2020 03:56:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvib1sr9e0v6WzW/KFg2T/nJ/r7jrV/iPkNrvuKzj0bl/9aXsjVL4B2fzpWr8yyHH4Qkn7nQ==
X-Received: by 2002:a05:600c:24d:: with SMTP id
 13mr14575991wmj.99.1603709769565; 
 Mon, 26 Oct 2020 03:56:09 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e25sm22898049wra.71.2020.10.26.03.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/19] util/vfio-helpers: Let qemu_vfio_verify_mappings()
 use error_report()
Date: Mon, 26 Oct 2020 11:54:58 +0100
Message-Id: <20201026105504.4023620-14-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of displaying the error on stderr, use error_report()
which also report to the monitor.

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 2c4598d7faa..488ddfca2a9 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -661,13 +661,13 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
     if (QEMU_VFIO_DEBUG) {
         for (i = 0; i < s->nr_mappings - 1; ++i) {
             if (!(s->mappings[i].host < s->mappings[i + 1].host)) {
-                fprintf(stderr, "item %d not sorted!\n", i);
+                error_report("item %d not sorted!", i);
                 qemu_vfio_dump_mappings(s);
                 return false;
             }
             if (!(s->mappings[i].host + s->mappings[i].size <=
                   s->mappings[i + 1].host)) {
-                fprintf(stderr, "item %d overlap with next!\n", i);
+                error_report("item %d overlap with next!", i);
                 qemu_vfio_dump_mappings(s);
                 return false;
             }
-- 
2.26.2


