Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5622C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1AC2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrBc+Rfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1AC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR2R-0006AV-Os
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzJ-0000vb-Ie
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27371
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzI-0006et-PP
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/VDoQzlI3PMEip7rZs9mnHodIncfMhzQDNkbQhv2i8=;
 b=HrBc+RfnUyN+2cMol2wvSFsEXguNkdPTYEHArcXcZafDlVconFtGN/yO/wWhV7J0o8mnTY
 Yl9gbB+bnskmX2liS8+K6x6Yi/MQkDfYJj3ASB0pixL7mDaQMcsmfnXxePVLp/aqKkwxVe
 0n3JT04X0Iw3K6EwDr4Z1j88gQcExI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-v20ZcIOeOsCxvQ5ZU-IkHA-1; Sun, 31 May 2020 12:39:01 -0400
X-MC-Unique: v20ZcIOeOsCxvQ5ZU-IkHA-1
Received: by mail-wm1-f71.google.com with SMTP id u11so1912763wmc.7
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/VDoQzlI3PMEip7rZs9mnHodIncfMhzQDNkbQhv2i8=;
 b=K/JWNvgFwAoZqRQICT9kZ13cLE/SVoOUxe4QmLfXDOEgolIaZ/VG9EdDPjiFR09qvw
 fjmli14XaIC2EyGRCI6nMzbovaMAyDeDBsoFxMaNmuc573IPU55Ntk9ZqJeMHtGTsC53
 CENUJnF/pE9SIA/xPGHhTip+g2vcDVn9B4EuIWBcF613SN0sJiwgv4BDpR73YTbfyMTw
 FNCq8Wvl8vzSorzpKKaTdVQ+leFu9P1pCGFEnKIS6Sqeeg3lc3JPUiF+hqbnF+228Tzj
 C0jo4oPGFNbKTUPIXR5/8/7hYsb7L7t0VQ8bPqU3v7RDmlXwCIhjVEJMfIglOSSZLctt
 3oHQ==
X-Gm-Message-State: AOAM530AUNSE4jM1E0cICeY0FiZxakPGyTNXIwxjmalYufEFQUr9ELk1
 TtW+Irw3i7rLZhvOLGWoSGDoy0/w6yHtkHxiuaHG/GOyDYJrF0mc3s3tprjt8Bpzk4UCJFc34pX
 3soUiVglZe8l+Ovk=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr17760836wmp.73.1590943140357; 
 Sun, 31 May 2020 09:39:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIEiALGuV93Ro6dhnxfm0LVwVkfTLG/HYDNsHae0Cpu2iwY0tKkx4JmUw+UJ4NEDJTtGPkpg==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr17760818wmp.73.1590943140155; 
 Sun, 31 May 2020 09:39:00 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d2sm17217183wrs.95.2020.05.31.09.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:38:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/25] scripts/qemu-gdb: Use Python 3 interpreter
Date: Sun, 31 May 2020 18:38:23 +0200
Message-Id: <20200531163846.25363-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200512103238.7078-3-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/qemu-gdb.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index f2a305c42e..e0bfa7b5a4 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -1,5 +1,5 @@
-#!/usr/bin/python
-
+#!/usr/bin/env python3
+#
 # GDB debugging support
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
-- 
2.21.3


