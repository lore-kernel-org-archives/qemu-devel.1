Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFCBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B08A2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vg+NK7CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B08A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B1k-0003ia-Ha
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArU-0002v5-K7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArT-0005zT-Jc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:33325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArT-0005yw-DG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id r17so322370wme.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SKHA4RaCRlFvjpRvwJ6bGEV5aXzSjabMiK2LHrB3a8I=;
 b=Vg+NK7CXE0Najuibkw2vGpMbnV2Q2IOSwJUKikPvjaoTi4beCxO7gD6/2Tb/aI/Ty6
 OI9W0TJzhsNMF0GDURLkCY4S+XhEBXYbJGoxd7tyghc5LxTiAoJoJwZrGZX7yjtI5WTN
 H9vcAdUwsNe6uMWASS8D0giOtWW9YDT40GaDAe4j1lA1CjaNnxzs2yMO10RS5MCS/4DY
 /beuNj/b3Xnh386DnXJWQhMeGN6i3eMqE3LAPY6tqPjOBALSA9EKkIHU0BdQAyoKbNi1
 bLbtgOAbNfDfhYrIoPxKHq/mz7FAcq52dxNuqiiwDOJCTyFPIow0u6eacFSYYk/PCdIK
 cfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKHA4RaCRlFvjpRvwJ6bGEV5aXzSjabMiK2LHrB3a8I=;
 b=A2vXdJqW9vsvoKEpHDhf9o7ri/DMELe9eRo1fDHF2Q/aAAo482twLDmshw57QymtH/
 khxP7PQmbaHP3pr+WqpXZlHzPIml/LGHwGAqYLRxhs8xULBY9cZ2gauku6RvpThkKivS
 HTHAHQgCJHc3mFfSxHMZNOCy8gYETPco8QSxr4O0dbh5SqfgWokyw87O52GHA8NxWso7
 a6QnZ67r7vvrZwV+ld/ifF+hUCVMlAykDy92J4c6wEsFFSb/rJLN48chxapyljrcZcg8
 SRCAKNuUBJfoYBsJocWUHNNyvjJpQSOijkDi+lMZsIWD2LXH4JyH2UUfdpXLB9UF4gha
 EFug==
X-Gm-Message-State: APjAAAXnbSB05sHPvmuZzXP+E8xRqa7WaigsRzMDtojSgyp/OBgx9ehS
 OZmCcrqA+JwBAUa33vYh/TuOU72PqxCV3Q==
X-Google-Smtp-Source: APXvYqxvDAHrZPZqzgcSX8p2xtoAlbUdIWLpqc7FqD2vFnfASy9MmsD+gGD878bOau5Frg2xAXF+4w==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr840856wmc.75.1567525010167;
 Tue, 03 Sep 2019 08:36:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:24 +0100
Message-Id: <20190903153633.6651-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 12/21] hw/arm: Use sysbus_init_child_obj for
 correct reference counting
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Both object_initialize() and qdev_set_parent_bus() increase the
reference counter of the new object, so one of the references has
to be dropped afterwards to get the reference counting right.
In machine model code this refcount leak is not particularly
problematic because (unlike devices) machines will never be
created on demand via QMP, and they are never destroyed.
But in any case let's use the new sysbus_init_child_obj() instead
to get the reference counting here right.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190823143249.8096-4-philmd@redhat.com
[PMM: rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4_boards.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index f69358a5ba8..2781d8bd419 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -131,8 +131,8 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
 
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
-    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
+    sysbus_init_child_obj(OBJECT(machine), "soc",
+                          &s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                              &error_fatal);
 
-- 
2.20.1


