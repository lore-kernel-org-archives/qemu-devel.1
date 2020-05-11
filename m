Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6373C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7F7207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WygJmv5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7F7207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3dm-0004Un-Fm
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3ct-0002eF-2y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3cr-0002lO-NX
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589185044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rIPhqoKFhvCMyRl2KtOiDjv/4TZafEjLFWFcywObE8c=;
 b=WygJmv5KF8wTvpHT+gWc7TERtMpbofb5au/QmbEOm5DXIhYjCjq8x7kqTN2av0Jmi2FL0i
 qGvsB0DytHqT3YpA0c9Z2DA7rXPQWKyO8iiIi6rHcZ56GXRs13sv0OXp7uc6RABtD1L+Tb
 9RyWKmEjkOUMUdds1iy7n3VG0Oz5blw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-89mkvD11OBWUKW1twukMPg-1; Mon, 11 May 2020 04:17:23 -0400
X-MC-Unique: 89mkvD11OBWUKW1twukMPg-1
Received: by mail-wr1-f72.google.com with SMTP id r14so4570909wrw.8
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 01:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rIPhqoKFhvCMyRl2KtOiDjv/4TZafEjLFWFcywObE8c=;
 b=Vywo7RTgL/5kydk4GDfHsd7cpantbqG3xWn539IjXo6rOELENJOf+Y+nS+3vrnq+hy
 RZ8drF8yB3vufk1KRQIP154jC/2ikoX/IP0YmDWhRDpgWVN2G7uMjAj1QbeJUaj6hOLO
 HbWY+5uy9uVPX1T9qECggYiVebyLPEkwIgD3obgurFg6eFxeiVO5kj45Qim2g85BUMBr
 729fLtHso4zGRq6XYhxcjl9+zYnuk+NZzqWYgr2J8fFiBjF5u0VB+HjfYHkhVFvd06AQ
 x1RJYbN+w7F7OwXnhHCwpVxzfA5q2moWLPc/x6W5HpErdv8jr+2q/BcqGAUw0dWpCD7g
 ZLsw==
X-Gm-Message-State: AGi0Pua9e57IpLEf4wbNckkv+12QpMp53whk+uy83XZpSGAGo1O0MZw7
 ZKX9CRqYwhKh56uwi4t+d+WXBiD0iqEQ+YxkZ/oToI6iTMKkJn+4O8oIKubqnUl/X7qBosW1MN4
 aNxGYm9y0syMzeIo=
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr18802898wrp.81.1589185041676; 
 Mon, 11 May 2020 01:17:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1oTocdl007S8OWeCJo2/QObtPTMv9E8lCZCUBxNtIxkEtBqpCAEz11yE4rPDzOXTPOJDgoQ==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr18802867wrp.81.1589185041495; 
 Mon, 11 May 2020 01:17:21 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k4sm22603053wmf.41.2020.05.11.01.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 01:17:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] memory: Add memory_region_sync() & make NVMe emulated
 device generic
Date: Mon, 11 May 2020 10:17:15 +0200
Message-Id: <20200511081719.31641-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the pointless dirty_log_mask check before msync'ing,
let the NVMe emulated device be target-agnostic.

Supersedes: <20200508062456.23344-1-philmd@redhat.com>

Philippe Mathieu-Daudé (4):
  memory: Simplify memory_region_do_writeback()
  memory: Rename memory_region_do_writeback() -> memory_region_sync()
  hw/block: Let the NVMe emulated device be target-agnostic
  exec: Rename qemu_ram_writeback() as qemu_ram_msync()

 include/exec/memory.h   | 13 +++++++------
 include/exec/ram_addr.h |  4 ++--
 exec.c                  |  2 +-
 hw/block/nvme.c         |  6 ++----
 memory.c                |  7 +++----
 target/arm/helper.c     |  2 +-
 hw/block/Makefile.objs  |  2 +-
 7 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.21.3


