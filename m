Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA13C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C5A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isNmxjqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C5A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltl9-00060A-D9
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltk5-0004Jb-RW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44317
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltk3-0004lZ-JP
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YldnbglfueR/JxDNR3GOT5PAuLJHMwf8AbnvT6htMeE=;
 b=isNmxjqM24TU6n3GzOZZ9x4spgY+aDtQHt6EjMKW6rFUrCHX6wGc3EWUlllHScYtlW5jeb
 knIot/aTjWaTSXLEMCD76dOIlVrQEmGjAlNGWf5cbk5Y0nIJLJX4SDxwiMThmVqCJDO5t8
 ihF9orqkhRvP/5jMuIQ+btkBctJyXvw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Qxdl8fWPMqeVicchOqh2jw-1; Thu, 18 Jun 2020 08:34:00 -0400
X-MC-Unique: Qxdl8fWPMqeVicchOqh2jw-1
Received: by mail-wr1-f71.google.com with SMTP id r5so2748693wrt.9
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YldnbglfueR/JxDNR3GOT5PAuLJHMwf8AbnvT6htMeE=;
 b=FSL5rdIKd2p90ifckB4JwN38FK/shwpxIU67YQlO9/wZdCPHVhZxQgPFJHCAxrPEPx
 wYTroQpy+TjP5gf7+meHvQaA5ACojLmhvPragy8vJNASXQgoNVmy7vo1EUu7HnYOnMuz
 cdRThok/N8tGjVXzZ5cKOIWM6BWOHPUNygY/r4bYl+StFiqgzgH1jo7DY1cwqw6hke4p
 CDI1hWX4Ynm7FT4jfg8D+REm2f3eifdduHbciGYOmzvEYENi86NvpC3SdJXpdPqxPTAs
 GeXAc+gS5c18/2xqV3RZuU0haIRYwoL8zAt3d90xDdm6eY9FSggrcMWmRRq3QKP2jBPU
 aVew==
X-Gm-Message-State: AOAM530EQkn9e2+Q0XXS02icGczqFuHdWaDJ/U6vPOCV7GnFYxULFwN2
 HzKjwYX/nlriGuwpHTDofU+lMG7oLyEkbqdNoYGaxN213sqX0VjFrWPnlu0pRJXs9PSDez2HJMf
 rn6hBXJhcm+4JJyw=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4501810wrq.189.1592483639354; 
 Thu, 18 Jun 2020 05:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqrO3zrA4hgzKR/Nsj9dOwgIrb4dyU5vvx8n8L1MVW3efYapJkfriD5Maaedj8FxDEZ4ZeFA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4501799wrq.189.1592483639201; 
 Thu, 18 Jun 2020 05:33:59 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id o15sm3450918wrv.48.2020.06.18.05.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:33:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 03/10] MAINTAINERS: Cover the HAX accelerator stub
Date: Thu, 18 Jun 2020 14:33:35 +0200
Message-Id: <20200618123342.10693-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cover accel/stubs/hax-stub.c in the HAXM section.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 426439a2c3..cebb0d385a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -476,6 +476,7 @@ M: Colin Xu <colin.xu@intel.com>
 L: haxm-team@intel.com
 W: https://github.com/intel/haxm/issues
 S: Maintained
+F: accel/stubs/hax-stub.c
 F: include/sysemu/hax.h
 F: target/i386/hax-*
 
-- 
2.21.3


