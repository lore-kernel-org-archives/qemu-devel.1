Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418B2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6432074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkiHxkzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6432074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGcs-0005tl-9p
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGby-0004pD-J7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGbx-00008h-T7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttjV0syfgjbLAzbS9wNPqlHp/5sYrehPP++5NBowujA=;
 b=KkiHxkzWAij2Lgrdiio1rANdnH3S1iywvUT+WhkLNjPruElcbzHOKBn7Ss2/4GmGkG7dE0
 walh4v6Eyajnn8jbd1gqdeUc7M4qZxq32nO7Sg7FpsChIFKEjsA+yjMJLQtP1aMkOA7EbA
 fd8kdONWJGCQQ/zUtBmq7/HmiJomaQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-ppe1CJ0iN8erEp0Fs5EzTQ-1; Fri, 05 Jun 2020 13:58:30 -0400
X-MC-Unique: ppe1CJ0iN8erEp0Fs5EzTQ-1
Received: by mail-wm1-f69.google.com with SMTP id t145so3252432wmt.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttjV0syfgjbLAzbS9wNPqlHp/5sYrehPP++5NBowujA=;
 b=ahjqvvVtrpjcbe7p3Tjn8Ix4Rv1W2SP8ph/GQ/fwAN3YUEgstQacIQbNn0wcf6X9Td
 aP/sjChI7xLf1MocJkVWvlofGeUO4C7QonWwd101QPuHUWnzLXQE+rxD6wO7U9GHtupD
 noUf0m8BJl1KQb/VilX341mnEGR8cFdtLh6kn6+Zi3zCOTSOdD77SM5QLCn7uFyAov3Z
 SyxQ9pRrWNd9izNObFBYCWvvmxg6PIMX6Z6Ez7AD5p8F5ygCjqZrUonIQ88dJn8v6zYQ
 6uaEl7bvjAIncR7MoM3Ds3crdO5zsvx0Ob9YrqeiOVF07WObtwSR4/2Hhn/lBLXZeS3F
 jB0g==
X-Gm-Message-State: AOAM531Tp8M3hZtWvVeORgAfiTVRIrPnvHKsm1kdlQditcaKG7mE25Cg
 +HZsV6TaeBMYPLrATkJKQqT08kUIfTgBaKD9tY4/QVKrp7ViI3un50gQhx11NElAZtOtL1vLzOi
 UvMb7C3jD9K+hUes=
X-Received: by 2002:a1c:7414:: with SMTP id p20mr3793331wmc.124.1591379909184; 
 Fri, 05 Jun 2020 10:58:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi64nmslVM2Sf2WYxKCISBkz6vX/k9wAEZfGlOlc810FjBw6PF7F2BwZxTyTMYv0EOG9Q7Hg==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr3793319wmc.124.1591379909035; 
 Fri, 05 Jun 2020 10:58:29 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t13sm12674224wrn.64.2020.06.05.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:58:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/11] MAINTAINERS: Fix KVM path expansion glob
Date: Fri,  5 Jun 2020 19:58:11 +0200
Message-Id: <20200605175821.20926-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605175821.20926-1-philmd@redhat.com>
References: <20200605175821.20926-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7d9cb0a5..948790b433 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,7 +361,7 @@ Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: */kvm.*
+F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
 F: include/hw/kvm/
-- 
2.21.3


