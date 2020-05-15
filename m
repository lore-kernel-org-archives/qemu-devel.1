Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DAA206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewms1tD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DAA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdGK-0000yv-Ti
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEk-00081l-E9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:31:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEj-0001lq-Ki
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbk8MJIRW79uhAdI6bDQPktMUAYJE28woJU0yGXYF+Q=;
 b=ewms1tD1I78z0cSaCORpPATAdcMXNWdhMzeZZftdsSJ6NRDFXR+o2EUxgKi5/lmRGFDTXW
 A7V5VJkkHhWK/q9QoBNRJ5lwvzNGGg6QWQl0qBbthk/wwuQ1Y1KM1AMOeaXyEMgygWoE01
 ZI+VoGvIlQPvChgxDjQz5RRFFHH9dfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-C456Mcx7My6JKB3IR5uHbw-1; Fri, 15 May 2020 12:30:59 -0400
X-MC-Unique: C456Mcx7My6JKB3IR5uHbw-1
Received: by mail-wm1-f70.google.com with SMTP id l26so1228355wmh.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dbk8MJIRW79uhAdI6bDQPktMUAYJE28woJU0yGXYF+Q=;
 b=MktE1cmyYJqTWMcCiu3TT5M//J8K1Vy320A0aiBl83dmY9jsj4neDsTpirh1Iv0lwf
 39EnEFYHSjcpkt7l7iytomnyP1GMhTZ6d95errMt3gWa9ranIojxEW+cc4ZnnWYy1fLz
 F3/EDzpuYv8SD+Wet4E7MnveETH20YBcVTOPz31DAgQzy9XOF7XmahqsKXJOCW/MWIU4
 xLOApXe/90G+indO6i4j5sDfjNYfdUOUgnSUFpMEN1Qh0o6fq9Mjtha1vFFf4icuIxn8
 X345t+2y3rDM0nnCZV8ty89UmlcR5UoVafdhdE9erCuQJD/nsLqJ2YhAWL9YWLJY/77C
 iyyA==
X-Gm-Message-State: AOAM532D6ZfBRdu/Kzr4iulSin99jdeH6YYuomuwgOOrKuS+N9RA5ZeZ
 pRtgjkOkOkOpFwlpFFFDZfQp63IiLOX857cMWLQzWZds74GhYxCk4FL5z4VA8kYHmxY249F60TZ
 8HqnTWBr69Lgf5Ik=
X-Received: by 2002:a05:6000:1244:: with SMTP id
 j4mr5236760wrx.189.1589560258017; 
 Fri, 15 May 2020 09:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrFZlLdKkYNX9ENKi5i7fXLovYpUDcOMfxajZvVJBF5qQNgg4vuZUmMeFtl8jCIed5HlgHXg==
X-Received: by 2002:a05:6000:1244:: with SMTP id
 j4mr5236728wrx.189.1589560257632; 
 Fri, 15 May 2020 09:30:57 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c80sm4526706wme.15.2020.05.15.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 09:30:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] scripts/coverity-scan: Remove flex/bison packages
Date: Fri, 15 May 2020 18:30:29 +0200
Message-Id: <20200515163029.12917-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515163029.12917-1-philmd@redhat.com>
References: <20200515163029.12917-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/coverity-scan/coverity-scan.docker | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index a4f64d1283..ad4d64c0f8 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -19,7 +19,6 @@ FROM fedora:30
 ENV PACKAGES \
     alsa-lib-devel \
     bc \
-    bison \
     brlapi-devel \
     bzip2 \
     bzip2-devel \
@@ -30,7 +29,6 @@ ENV PACKAGES \
     dbus-daemon \
     device-mapper-multipath-devel \
     findutils \
-    flex \
     gcc \
     gcc-c++ \
     gettext \
-- 
2.21.3


