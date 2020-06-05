Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7382074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbxFvAMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7382074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh73q-0004ug-Pj
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xu-0002iP-HZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xt-000573-DY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZFf7G8NXamXZhDqWtiyiSwxOIFrSXUEnseP+sLni2o=;
 b=RbxFvAMcEXtHgMNkXb0ZPnY3WmrXqOaschxyBphVQDZq/n2yHp3bjXfs9ujZX08WH7NZcf
 d8YmK712/cm8JccdSDw6ZhiEpNoGlR3CGZvVB18p92JoZ85TkxmZfumZ+i5ay9y/UvT3/D
 Ll7B0/+djNxT7TurysJYCKsr7+gvkLM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-avlTOh2gMquZ0S3IpelQPQ-1; Fri, 05 Jun 2020 03:40:12 -0400
X-MC-Unique: avlTOh2gMquZ0S3IpelQPQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16so3385937wre.22
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ZFf7G8NXamXZhDqWtiyiSwxOIFrSXUEnseP+sLni2o=;
 b=cWTsm6meGxf1bbzhYLqk61v6Ay+p8jjqicsWZReX0x98VKjQ21GoawrVZ8uxV8+fTd
 JNszYyQ53rSXG3R+eluLhU9vit3yy3K/4VrPf5H/JeejWfg/4d7s/cfilnPErGY/y3gi
 91yCOEWC7WbAA/8kup9kZsa7rg9E7IVWxrR4kXUbHXIkwJXKC0QgjK4PV1u1QgrYVq4T
 7RyZCSWKEVtKkHn4pFd6lMOvHWrYFdvvWiAJ3r6sxPU+f/NttAKgmQKW71B2nKbZ6Ugo
 HI8icgfS7fOVmOYC0Si4a7iPphQVQsV4iSgzi6Taq4RWSC3PeXtQdDE4bR9wYp7HZOlW
 eAlw==
X-Gm-Message-State: AOAM531nokJs26kR+Ry5TfBIhDAmPK3E/07eDnbWv6c0xr0rMVQlMeWV
 JxLstlbP+QUlxPYKf+o1MN7EZh0TO7tn9fWGWYseUxEfdNhzbaIa9mU+TUe984JJCyr1Aq0e3Su
 ycVqgNrFxdO4w5Eo=
X-Received: by 2002:a5d:4841:: with SMTP id n1mr8685733wrs.64.1591342811041;
 Fri, 05 Jun 2020 00:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY79KqdbaGk/M1MDzUlkuiyhcSXcNWg+5Zw0W11jjbsxSwnD89SDtmSjPg2+BJsQjAKS742w==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr8685709wrs.64.1591342810877;
 Fri, 05 Jun 2020 00:40:10 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v2sm11030246wrn.21.2020.06.05.00.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/11] MAINTAINERS: Add an entry for the HAX accelerator
Date: Fri,  5 Jun 2020 09:39:45 +0200
Message-Id: <20200605073953.19268-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vincent Palatin <vpalatin@chromium.org>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Yu Ning <yu.ning@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Wu <lepton@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nobody replied since the first time [*] that patch was
posted, so mark HAX as orphan.

[*] https://mid.mail-archive.com/20200316120049.11225-4-philmd@redhat.com

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
This patch has been posted 5 times, first time more than 2 months ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689009.html

Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Vincent Palatin <vpalatin@chromium.org>
Cc: Yu Ning <yu.ning@intel.com>
Cc: Tao Wu <lepton@google.com>
Cc: haxm-team@intel.com
Cc: Colin Xu <colin.xu@intel.com>
Cc: Wenchao Wang <wenchao.wang@intel.com>
Invalid: Hang Yuan <hang.yuan@intel.com>
Invalid: David Chou <david.j.chou@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f725c12161..05d7210204 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,6 +426,12 @@ F: accel/accel.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 
+HAX Accelerator
+S: Orphan
+F: accel/stubs/hax-stub.c
+F: target/i386/hax-all.c
+F: include/sysemu/hax.h
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


