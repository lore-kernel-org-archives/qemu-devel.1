Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA1C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AA520708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwtSieZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AA520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwUh-0002Gv-VV
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRb-0006JU-Cv
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRa-0001M3-98
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588919109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfS14LJEpOzY6PX3UrAqMHPU323E/PoXkpCr/b9ynrI=;
 b=RwtSieZvzaVn1yN88Y6wDfHoBwh+etUpgg7qa0/HjT4eNdCl26zuUS6rLuCQOmgFxANa7j
 khyJGhJKJ08sWfkjM5Yq1+21jbqGCCcsGL76KcyXYfD0LWy27nC1YGVSQT2c6wPnksYHMJ
 5K0upoSMj4qVg61aH9g1qAaMSz9/C5Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-PHToQnYdNHCo4tSrH2Rfcw-1; Fri, 08 May 2020 02:25:08 -0400
X-MC-Unique: PHToQnYdNHCo4tSrH2Rfcw-1
Received: by mail-wr1-f69.google.com with SMTP id f15so402544wrj.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 23:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QtFWs4BxQJZYmga34DJ69kEprWz+1I1FCi2dNjcpyyQ=;
 b=YOa/JoYPwAEOoHJw+JwwbIkYQ/9fPEfabF0fN766CzHaSFLGsp8eqo39AfOlQDccps
 VYTwE+qlzMQIDFY5OOSctoBdqIsz4yCf1wAdv02mvzsplwRZCOjtnitAy9KOXJx6M0v8
 C+qgPDsZh74UC0l7jtrHxFF0c8Sv2n66TsAPOjH03qKCniY8ymmF2gf/jjbZfRoC9MOB
 3ASR+QVq/KaTXZFirWnZmrbu7NUO46X6a7i1LnEnX24wWPcTzIeKYk+Gf4Mmvs4RTTeB
 BMxfwcakN6dE5q8inAG1lijJwYLNPZJTJQVfb4oDzpuNJeFYiGANR0xLwuVfHpAUeAfu
 IPgQ==
X-Gm-Message-State: AGi0PuY97oGz4uBZ+K6FflHuOd9qAdPrEYUCp5UZeSVi5EJ1QE4EhjuY
 nyfZFI+fx8Qa5PsHmhfpBjxV7b8SNh8ExBCBUckH0PTqoxfUulBoitHQkVbDJ4i5SQM09mB5k0u
 b4hGj2KQKiuqYMKw=
X-Received: by 2002:a1c:8094:: with SMTP id b142mr1182404wmd.61.1588919105848; 
 Thu, 07 May 2020 23:25:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypIqeXAJW3AWL3zXCLwWFgpEGhKvp4glTtjV0jZlpsYrscbMVm/0s36scgQzMwv6oEgiNDOYiw==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr1182374wmd.61.1588919105605; 
 Thu, 07 May 2020 23:25:05 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w18sm1304743wro.33.2020.05.07.23.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 23:25:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] memory: Rename memory_region_do_writeback ->
 memory_region_writeback
Date: Fri,  8 May 2020 08:24:53 +0200
Message-Id: <20200508062456.23344-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200508062456.23344-1-philmd@redhat.com>
References: <20200508062456.23344-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We usually use '_do_' for internal functions. Rename
memory_region_do_writeback() as memory_region_writeback().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory.h | 4 ++--
 memory.c              | 2 +-
 target/arm/helper.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..1b7cfdd5b6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1474,14 +1474,14 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
                               Error **errp);
 /**
- * memory_region_do_writeback: Trigger cache writeback or msync for
+ * memory_region_writeback: Trigger cache writeback or msync for
  * selected address range
  *
  * @mr: the memory region to be updated
  * @addr: the initial address of the range to be written back
  * @size: the size of the range to be written back
  */
-void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size=
);
+void memory_region_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size);
=20
 /**
  * memory_region_set_log: Turn dirty logging on or off for a region.
diff --git a/memory.c b/memory.c
index 601b749906..aa1f807392 100644
--- a/memory.c
+++ b/memory.c
@@ -2198,7 +2198,7 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_a=
ddr_t newsize, Error **errp
 }
=20
=20
-void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size=
)
+void memory_region_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
 {
     /*
      * Might be extended case needed to cover
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a94f650795..c4710b7371 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6829,7 +6829,7 @@ static void dccvap_writefn(CPUARMState *env, const AR=
MCPRegInfo *opaque,
         mr =3D memory_region_from_host(haddr, &offset);
=20
         if (mr) {
-            memory_region_do_writeback(mr, offset, dline_size);
+            memory_region_writeback(mr, offset, dline_size);
         }
     }
 }
--=20
2.21.3


