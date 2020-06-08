Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255D12076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5TL+a3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255D12076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKtY-00043O-5m
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnO-0002XO-Bi
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnN-0005us-J2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8yrkgLM4/OkwPbZujjPqfX6dhsQYk2Ie6TTqh1ySZY=;
 b=T5TL+a3HUhR1W/qVo2RYYn4LwvVXPUg2lqHnqXKa9wv4g4Qk7/T6mbMEqS3qDXDx+qgsoG
 qFzV3dIj9zh1G4y17gmh80fkNjHBGktLG53/CKpWBiU972H4TYjsmNIel7qnvFInE98wGA
 jQlgnZYVyV2nwlWbZVo2pK2B407vktw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-KClviDq9NtO4k9Q1De8eYg-1; Mon, 08 Jun 2020 12:38:41 -0400
X-MC-Unique: KClviDq9NtO4k9Q1De8eYg-1
Received: by mail-wr1-f70.google.com with SMTP id a4so7379798wrp.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u8yrkgLM4/OkwPbZujjPqfX6dhsQYk2Ie6TTqh1ySZY=;
 b=CQziyO0LM7zJCysyanr4U1O3fuo2UmSuhqpqVEw6Q9kjvcPS+tgk6zpIVCYa3yJA54
 YV0WHSKg+uqb6pfVvFzupkBjVrv9IpD7D8APGwPwXzvQuvcNY9UzL573budfMgKp3ruK
 oxo6bMvdMwkP5BQZmQDWolb+1cN9Y6Of4pkaPvL2xz9DAbo3KJkOkBbOl69uR9B1lgtS
 uWN5WOXvUxtldRuBM1UZYm5LOPkip+WkCd85YGB6W93+rsh3aLhTTami/YhVVcXeJTWV
 tl6ortNwTHqhxv0cnyXMtSsspquTVpRN0g5dR46QGS4rmS5WnwmAv4RuHTNTM8+LQ5aE
 +U+Q==
X-Gm-Message-State: AOAM533CjFhgko06J4VKMuzuNxQQoJqsDzycDo1NFRaLOCEwKCFeHNhy
 fvYFAbajXuQegtE8sUdcsk01Xw5S5ugb7rUB5aZ7MKa3GhLloCQEYTk2llBFPbPUpM9bya5d1b8
 ES6o/f0guUOOrrck=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr202521wme.162.1591634320349; 
 Mon, 08 Jun 2020 09:38:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBAvfo4UWHuwzvkiCtGL61lZ31RSREKHowPssGMmXbHDe7SEegYTprt4A97wE1/in+ze6qdA==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr202509wme.162.1591634320139; 
 Mon, 08 Jun 2020 09:38:40 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s132sm125966wmf.12.2020.06.08.09.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 03/10] MAINTAINERS: Cover the HAX accelerator stub
Date: Mon,  8 Jun 2020 18:38:16 +0200
Message-Id: <20200608163823.8890-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
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
index 93dd8eb8b5..bd85dcf57f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -474,6 +474,7 @@ M: Colin Xu <colin.xu@intel.com>
 L: haxm-team@intel.com
 W: https://github.com/intel/haxm/issues
 S: Maintained
+F: accel/stubs/hax-stub.c
 F: include/sysemu/hax.h
 F: target/i386/hax-*
 
-- 
2.21.3


