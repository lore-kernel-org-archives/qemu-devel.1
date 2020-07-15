Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B509C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1B920657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLyTYKIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1B920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhEp-0007Y6-4N
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvhE5-0006hP-Cu
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:13:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvhE1-0005r3-Mt
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594818808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YxvZqKylwW+i1AJeh/rArAfffml21QWKrCjIs4KqnXE=;
 b=dLyTYKIefm6yTArdCZknmWGp+XT90NrMJzAumJg5ygL9AgxKcEuqSpzTUJpo98zALhifSD
 3as0mp+N+eiMFCSU9J35kV3qaLd+d5p9NfXnHEc3jHcBr9b4Rm72lVa4dfRPuKO0BQznHd
 fgePwxm5DmMOh7RCABsUnvy/3klu7pU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-UNtzVRDNOduJpNHprwZrZA-1; Wed, 15 Jul 2020 09:13:26 -0400
X-MC-Unique: UNtzVRDNOduJpNHprwZrZA-1
Received: by mail-wr1-f70.google.com with SMTP id w4so1332153wrm.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 06:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YxvZqKylwW+i1AJeh/rArAfffml21QWKrCjIs4KqnXE=;
 b=XD2NzpyfgeekUu8YUIoD+KXGdYD8Y8/6hzJgAVTtgjOjpP44J4QsK3qLrxgMrQ1Xo5
 TeRMW2Dp9YNf9qOol4s5XtrG74mqWJPh+PEqk44DM1mKBWWNXGY/FibGJiTOEbL1O3xV
 BTQGFGedEsLVAnPgZ8GJyklkFJ1buF4CcqGq6JBe9c6j2Q+Q/RfBU92ULOM0LeTCd3bi
 cNv6EC4HJpLRB2gvN6ifjxd2BLR1P0lxYuoULkEF5Pa9tAqyYhJozwB3oJ3HSG1q3uWY
 ryc/74ybHzaZ1fXyuJbcouQKW31pVMlkjVba0O+jmbFp9zo8r6SZ53qOYIkeJHcQvBus
 lmig==
X-Gm-Message-State: AOAM531QNkkCx9XvgvacKahuPcfLHuxGElxJuGeeAZyLyPpgIHlv03vy
 AEZmJ0br0g8H0knOZL//4XsOVgq5cWWUJnzAe6mPzfQbPHrFKsQSOhJlUlSo9IgskL5NNhcUwxB
 dtlRuVkKBFDkIF5I=
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr8583999wmj.20.1594818804712; 
 Wed, 15 Jul 2020 06:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz71dmsk0a0sW7Q22AsGsqhwC5l0BFWzmIFpeDomuyiy8ZpLlWV6k1NSEwrnPELGkxk4dYfxw==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr8583980wmj.20.1594818804481; 
 Wed, 15 Jul 2020 06:13:24 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w12sm3721416wrm.79.2020.07.15.06.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 06:13:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/vfio: Move some target-independent devices to
 common-objs
Date: Wed, 15 Jul 2020 15:13:22 +0200
Message-Id: <20200715131322.28767-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices do not depend on the target CPU configuration
(32 or 64-bit, big / little endian). Move them to common-obj
to compile them once for all the targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/vfio/Makefile.objs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index 9bb1c09e84..f663a800b1 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,8 +1,9 @@
 obj-y += common.o spapr.o
-obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
+obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
 obj-$(CONFIG_VFIO_PLATFORM) += platform.o
-obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
-obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
 obj-$(CONFIG_VFIO_AP) += ap.o
-obj-$(CONFIG_VFIO_IGD) += igd.o
+common-obj-$(CONFIG_VFIO_PCI) += display.o
+common-obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
+common-obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
+common-obj-$(CONFIG_VFIO_IGD) += igd.o
-- 
2.21.3


