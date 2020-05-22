Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17852054F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv/OlCbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17852054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAhh-00087w-0a
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgj-0006a3-Tm
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54407
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgj-0002SF-6Q
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0X3nhCPIdBU+MkX2L6TDEsAOd8fgbYU7zMqrgwUeac=;
 b=Hv/OlCbLZZL9Ez4jM86zrrpVEtIKQiGjhKojbJD7hz21BwaUsceyPRrq0QrFEQ4K+aORB4
 ii8QvXMBQOCtT11llreBq678m7Nckdoub+ZrXsoF3EWrLnlAopCLDWCqXM6FdUxSbf89Ls
 yrs3W9LKno6YkmHOM+9UXppolnGG3YQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-un4yGojmPKW7k7nZGQIekw-1; Fri, 22 May 2020 12:38:21 -0400
X-MC-Unique: un4yGojmPKW7k7nZGQIekw-1
Received: by mail-wm1-f72.google.com with SMTP id l26so2866293wmh.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i0X3nhCPIdBU+MkX2L6TDEsAOd8fgbYU7zMqrgwUeac=;
 b=Tj5KXfJQaf8nKFmQw5hKHYiIuqGa4WxbJxKrreTt8TgQdUUBh2z1Jy+d4EMbz6yUTs
 PI9q34Y0azm2yEjewCRU2atPMV4l2di70FvbamGHHRFZgeAfzhFuJylOrnvE+x1GekTB
 f6EW7aBI4fm19UKLtbfOL4isSyQeWPz5mxshGg/DP5dyIPdL5wcFh0jeaGhMkB4V2Vd1
 ESrR5l0+tUPL9g+6vtlfiTByt8AzjnIO9APqg8e59u+Z2x8o8vu70mbgSfqMTQr9MG1u
 Z48HoTCugGcvjWiQx42mxwHhFVCQB8UYiohCOWSzgphCBx2w8R9ThhmKQlssUo1lKw51
 Nn6g==
X-Gm-Message-State: AOAM531bVxRCCenR1s2zeF/W/w57UQ0kPqA+Ud5EOd+sGzgxC3ISRDbq
 Yr6K8pko0SIzYR2SJrg/87qJYONQj4m6ulQtLY1n//pMRMRhVOcqsAT6a8aMga9010rvELQATc+
 m29A/djAgsOlzvqY=
X-Received: by 2002:a1c:e188:: with SMTP id y130mr15059227wmg.83.1590165499649; 
 Fri, 22 May 2020 09:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU4Tpxwzqm2Lh7k726ZhonVTNgf8nL7wXUytk8+vF5JZ7N3ORrYK+U47MRG0o0qwQ/Zm15bw==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr15059219wmg.83.1590165499509; 
 Fri, 22 May 2020 09:38:19 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z7sm9934568wrl.88.2020.05.22.09.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/11] rules.mak: Add startwith() rule
Date: Fri, 22 May 2020 18:37:52 +0200
Message-Id: <20200522163759.11480-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a rule to test if a string starts with a substring.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 rules.mak | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rules.mak b/rules.mak
index 694865b63e..e39bee93d5 100644
--- a/rules.mak
+++ b/rules.mak
@@ -191,6 +191,13 @@ ne = $(if $(subst $2,,$1)$(subst $1,,$2),y,n)
 isempty = $(if $1,n,y)
 notempty = $(if $1,y,n)
 
+# startwith
+# Usage: $(call startwith, startstr, fullstr)
+#
+# This macro returns a string (TRUE) when @fullstr starts with
+# @startstr, else returns the empty string (FALSE)
+startwith = $(findstring :$(strip $1),:$(strip $2))
+
 # Generate files with tracetool
 TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
 
-- 
2.21.3


