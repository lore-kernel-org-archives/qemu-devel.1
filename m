Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD47C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF833218AC
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT6wn6J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF833218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJld-0002Bk-MQ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFJks-0000cZ-F3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:12:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFJkq-0004oP-U0
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599495147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GQ+cbz0CeEvC6Na5RtSDFgnFbW74Fu3NiI79vFOKvmY=;
 b=VT6wn6J7/zvfbIb1HH4Ws8OrnlPDOpN5SuBOQyAwzLC+mgvt4l63E077qZiBqzg30N9pa3
 WK2LbFhjONw5/FoVGJr71f19rNlGhpss9PXfnvUB+OHKbL5Cz/XeQDxSM0TVrwe8PNXRr1
 ixFPXv1CcHCwdXTP9PhBb0nVj71gREw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-E4-W6OcLPkKx7DX2ApkpDg-1; Mon, 07 Sep 2020 12:12:26 -0400
X-MC-Unique: E4-W6OcLPkKx7DX2ApkpDg-1
Received: by mail-ed1-f71.google.com with SMTP id c3so5034424edm.7
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GQ+cbz0CeEvC6Na5RtSDFgnFbW74Fu3NiI79vFOKvmY=;
 b=f+ReM4K+zf2NR6GxO9UOU/fafFys+9Tqk0vagsjwVdp98KtbphGa52oFxCBlGoODTL
 YydpeGF5n9oaf7r1Aeds4KFsNi4sBbwJ/pQrhpn6NYlGfkzuuPzZ8q2jA5u0y+Cq1tBZ
 DeSsP7sZTkMDWobmUp9FruuTciE3agQzNKH6oeJM0/f/1ywW4K8zzplk47MMJALaedpx
 9lvei+mgGLV3QvuDUCRS8ogXCjPQKEItb1XC2fSBQky9OuulLqC1BxC55Cn52WFFjmh7
 bucUdXa0S5CM2ynx5R5YiJi5qYy2vWa3g3Z1dWR+eeTa6+yq4IavZKVcTL0o6EBIC6EI
 Cpgw==
X-Gm-Message-State: AOAM530l0MyNbq/0YiBrEmDbUp8RLHUK4w1ZNCsXMvIoCkU4wgrzLgI9
 OB/ow7pCwzGIzUp1HdzerqhOzHf4hSjbVO3sEGp0I+whaU4wu9FXqa0DRAnbiePWfewA4hUZvbo
 j+2MelsfOzeZZZJ8=
X-Received: by 2002:a05:6402:503:: with SMTP id
 m3mr22934253edv.45.1599495144699; 
 Mon, 07 Sep 2020 09:12:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm30FMGWjXv65OteFjz3fJMtuByluwoPlo0w+rfw0pp83FfRh++C+/d5ohurw46re8/GS79w==
X-Received: by 2002:a05:6402:503:: with SMTP id
 m3mr22934231edv.45.1599495144562; 
 Mon, 07 Sep 2020 09:12:24 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id qu9sm15634445ejb.24.2020.09.07.09.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:12:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] scripts/git.orderfile: Display meson files along with
 buildsys ones
Date: Mon,  7 Sep 2020 18:12:22 +0200
Message-Id: <20200907161222.41915-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit a56650518f5 ("configure: integrate Meson in the build
system") we replaced many Makefile by Meson files. Adapt the
git.orderfile script to display the new file at the same position.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/git.orderfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 73fd818d7f3..a021afc2d51 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -18,6 +18,7 @@ docs/*
 configure
 Makefile*
 *.mak
+meson.build
 
 # qapi schema
 qapi/*.json
-- 
2.26.2


