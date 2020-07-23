Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EC2C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC2822BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt5APxQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC2822BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyXIW-0007xK-Sb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 05:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyXHx-0007XK-OH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:13:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyXHv-00007a-GZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595495594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QOiDlXLCXc3HWJFuM2jyNDeB53M9taCIvdP/ByoITdQ=;
 b=Mt5APxQtMvWwulX49xrA7mjmL21BGMkq1AFlSi2MEZQlhofhchIrFmxAL/mcXA4idZU2gQ
 /VmmQk5w1DSQaHFXQ1ccszk1SOLaMFntDfq7gVZKWDLPTkJa1LQZiiNpM/JZyABN4qB1Xf
 uL51T3V623gTEUqbmknQ3w7VcVByKgo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-r0btt8NmMWy7g9usFtPfnw-1; Thu, 23 Jul 2020 05:13:12 -0400
X-MC-Unique: r0btt8NmMWy7g9usFtPfnw-1
Received: by mail-wm1-f71.google.com with SMTP id s2so357953wmj.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 02:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QOiDlXLCXc3HWJFuM2jyNDeB53M9taCIvdP/ByoITdQ=;
 b=YTree/0/GrZ++wZKZUfSvWfHgGNKONmo94A8DAvUA3tM+nZdtroJ5m7K8n/ILi96M0
 Kqxu9hgxXt0y8Jg67hca/xcAmeY+OWaYl0JpTynvwHPRxoKVP++7p1o7a3KFdDysYHXT
 y3XrQy0k6j6oTllVrQfU9xDjxwOQpxCPsawW9L3Y+dmdJdF3G3nfcwBV2oofpanjb6Pe
 hFVbRVEmc7t5hxW7eNReMBUjY5s3xho4kKkApAdMpvj7vGGoRYhsdkLG+AbhcOAAaP9p
 /wE8Rdj5IQmZJfL5T//yVfXFcDXFNBaMJm+OPfIv+EKFsOoMqdAebzV0aI8yBbQFF94i
 sr+Q==
X-Gm-Message-State: AOAM533n69q4usLdGkQeMoQfhxvetc7mAR61zjUlyvhdNR9ykDN7bR5W
 Z1ShRs5a3RZbFaSRliG1QbS0MtxSY8XaGRyWdItPtZhXGPkxgNzfqNKfjrsDK67Lhq4sNOsNibs
 AYZvD6O5WybXWh6o=
X-Received: by 2002:adf:e690:: with SMTP id r16mr3405041wrm.249.1595495591274; 
 Thu, 23 Jul 2020 02:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA5kEI1wVywfkDggOEBJ53Mc+EgSFXUQk5simgbnepn/lY2odr6oazGfuzm1WTgcCwYxUepw==
X-Received: by 2002:adf:e690:: with SMTP id r16mr3405029wrm.249.1595495591059; 
 Thu, 23 Jul 2020 02:13:11 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d132sm2647616wmd.35.2020.07.23.02.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 02:13:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1?] qapi/error: Check format string argument in
 error_propagate_prepend()
Date: Thu, 23 Jul 2020 11:13:09 +0200
Message-Id: <20200723091309.18690-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error_propagate_prepend() "behaves like error_prepend()", and
error_prepend() uses "formatting @fmt, ... like printf()".
error_prepend() checks its format string argument, but
error_propagate_prepend() does not. Fix that.

This would have catched the invalid format introduced in commit
b98e8d1230f:

    CC      hw/sd/milkymist-memcard.o
  hw/sd/milkymist-memcard.c: In function ‘milkymist_memcard_realize’:
  hw/sd/milkymist-memcard.c:284:70: error: format ‘%s’ expects a matching ‘char *’ argument [-Werror=format=]
    284 |         error_propagate_prepend(errp, err, "failed to init SD card: %s");
        |                                                                     ~^
        |                                                                      |
        |                                                                      char *

Fixes: 4b5766488f ("Fix use of error_prepend() with &error_fatal, &error_abort")
Inspired-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qapi/error.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7932594dce..eeeef1a34d 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -381,6 +381,7 @@ void error_propagate(Error **dst_errp, Error *local_err);
  *     error_propagate(dst_errp, local_err);
  * Please use ERRP_GUARD() and error_prepend() instead when possible.
  */
+GCC_FMT_ATTR(3, 4)
 void error_propagate_prepend(Error **dst_errp, Error *local_err,
                              const char *fmt, ...);
 
-- 
2.21.3


