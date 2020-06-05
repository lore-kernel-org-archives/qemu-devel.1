Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF602074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKAEfxe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF602074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh749-0005cj-GK
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6y7-0003Hz-Oj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6y6-0005C2-Qa
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=az8pj3ArsVB5H8vNRsyPhpcnKHlQHKIjS7ekh/fQInY=;
 b=JKAEfxe40SlHceXvK44FlN9MClUw7ALfztW8DK5fHbxTbY1cR02NVuEIiQbJ07MkORRkf0
 1RHQhFxgvVPHhGg3KH+9iE/pXpRnQ6qX9upX4IhvkZteCDIcU/gcIj5PQxepNVGUAZSczm
 YxZAa3M4DIRAbuqYSe7/5BJ3Iof6YoM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-8Wsw9RmcNbCWT5RmnNM0dw-1; Fri, 05 Jun 2020 03:40:43 -0400
X-MC-Unique: 8Wsw9RmcNbCWT5RmnNM0dw-1
Received: by mail-wr1-f69.google.com with SMTP id n6so3424562wrv.6
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=az8pj3ArsVB5H8vNRsyPhpcnKHlQHKIjS7ekh/fQInY=;
 b=t2jX0YeTy8N3D1tWq6vBCSK0/XWEnI9VIbBiUqCf15SFDLsFFN3RywUxns5yFTApa8
 A5qaed3ZUIzHY1RpstwexEQD1tToH1PbuNc4+aqQjsIOVQV091G3V6kg1VQ4x8+ti/Jf
 PEhE86eMN3A0K7s+audKqaxMTEDT3vjqQXnUf14vq1pItUROuSq9CltzXcPi4Up7LFuS
 kJTK3K5KOoHiaSmvGUkPncl5Wvh5C4Qd6fOZ7WIEvIX3/a6mUrQVKMBC6rDOolA7rpb4
 RTQBQY9f0e9Kuk5L+J+2gvDFpbuMWk8yaC85UBprjgcRhf387ciO7X1H6NRgBxIb8xLY
 ZEPw==
X-Gm-Message-State: AOAM530Yk/kR5pMkJKXOwmTJszxD7xoqOHBSmWYoYt85NpgrxUzUO2iV
 BLzei3+ytBYqMCV8NYXv6RQQ6qrm/WkB663cFv17ak9p6QlNi9E+c1T0nVzZXwfh85izp1yGtxf
 qpS2h1RIV9Ppj6SA=
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr1335590wmg.136.1591342841731; 
 Fri, 05 Jun 2020 00:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjosdXqbB2lWnipFcjRUCbc87BLwgWAHuj6sTXVx4p7rZLvJ7kx3n0AMivynx5Fap9NO1VJg==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr1335576wmg.136.1591342841568; 
 Fri, 05 Jun 2020 00:40:41 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j5sm10889370wrq.39.2020.06.05.00.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/11] accel/Kconfig: Add the TCG selector
Date: Fri,  5 Jun 2020 09:39:51 +0200
Message-Id: <20200605073953.19268-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose the CONFIG_TCG selector to let minikconf.py uses it.

When building with --disable-tcg build, this helps to deselect
devices that are TCG-dependent.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile      | 1 +
 accel/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 648757f79a..f8a45e1379 100644
--- a/Makefile
+++ b/Makefile
@@ -405,6 +405,7 @@ endif
 MINIKCONF_ARGS = \
     $(CONFIG_MINIKCONF_MODE) \
     $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
+    CONFIG_TCG=$(CONFIG_TCG) \
     CONFIG_KVM=$(CONFIG_KVM) \
     CONFIG_SPICE=$(CONFIG_SPICE) \
     CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
diff --git a/accel/Kconfig b/accel/Kconfig
index c21802bb49..2ad94a3839 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -1,3 +1,6 @@
+config TCG
+    bool
+
 config KVM
     bool
 
-- 
2.21.3


