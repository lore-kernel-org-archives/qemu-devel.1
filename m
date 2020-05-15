Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7524206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUC7BqQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7524206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdNt-00025j-Vo
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEb-0007zY-W0
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEb-0001gv-99
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OktuFlpyEDCogWQETFKDEsXyn69UzB2tvuqAaVa6mdg=;
 b=UUC7BqQUnWuUIkCjvwg9yMM2jvS5FY2wVaqRdfB7j03vK7WrfBJLXkv8jjetHQ1e8R+iNG
 CKkR7hf7Yl4+MW54eWJ3SnR16GZqzFaUy+S+CGugRgC4NWvrp369Ua2ZRplrxRfWm1nZOe
 dWN3qmuxcWSr7GGsHlO9E/JiupozzVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-ZhQxhYeHOE2XJj1VhaK3UQ-1; Fri, 15 May 2020 12:30:49 -0400
X-MC-Unique: ZhQxhYeHOE2XJj1VhaK3UQ-1
Received: by mail-wm1-f71.google.com with SMTP id a67so1420500wme.6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OktuFlpyEDCogWQETFKDEsXyn69UzB2tvuqAaVa6mdg=;
 b=XON4w/ruqqg4Zb4b+eI6Wa6AY2dE1eFkeCFqt5np9B+dqwTMgggSlagM5HXR2Ij9QB
 +bZXBNZ+VizT19nxi+4tifiw261E0t5lPt41ARA4fCMzNDTL4OkSNniuD/bmZlo7gYDS
 w7k9ttLOz9sjAWPaY0qMVz808MzHGv6F/PtYQVBN33d26Keyx12ext9UL2AGerRqUQvQ
 gttuHuPPEAi2btzuRA4SQhQgtbCekalJL1qA2RI8QcP7zMAS/3JKaCv05730jhttviIp
 NcaDIxqIkW9pV/g8NyQ1m2ZMa7s7mAVikGl6xDwmh/WPmr0fylefTNwWnLkxYU5XM0VQ
 POfg==
X-Gm-Message-State: AOAM531ENy6Z+p8O/bIxjzjkmOYmD5U1LSsUVK3W76MeZunOikrWKn6D
 k1aTuFhl1VLAfcTDcJNBMHrNinNjzvsRu+J5kw5dOR68M6XX13IqXkv5YgxnDzHLvFzVEwRJphj
 vDqijXRsNLlTtNg4=
X-Received: by 2002:a05:600c:21c2:: with SMTP id
 x2mr4880119wmj.148.1589560247914; 
 Fri, 15 May 2020 09:30:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0kWYqIavdmRwwF41X+xixuw/Fo9G4vDFMRGQHnfV73iCzCUyPk5INn4I3I2kG3hh/P2Pm+Q==
X-Received: by 2002:a05:600c:21c2:: with SMTP id
 x2mr4880097wmj.148.1589560247761; 
 Fri, 15 May 2020 09:30:47 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s8sm3836173wrt.69.2020.05.15.09.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 09:30:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] gitlab-ci: Remove flex/bison packages
Date: Fri, 15 May 2020 18:30:27 +0200
Message-Id: <20200515163029.12917-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515163029.12917-1-philmd@redhat.com>
References: <20200515163029.12917-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b889fb96b6..994774250f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,7 +4,7 @@ include:
 
 before_script:
  - apt-get update -qq
- - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev genisoimage
+ - apt-get install -y -qq libglib2.0-dev libpixman-1-dev genisoimage
 
 build-system1:
  script:
-- 
2.21.3


