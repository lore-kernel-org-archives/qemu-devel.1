Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA0FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC11E207BB
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB4lIwa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC11E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR9X-0000Y9-3R
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0b-0003QD-MU
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0a-000721-Np
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4vVNWwGJ6X+mCxN22qm0JQKHOJ0PdAaDdcsNO2TkXQ=;
 b=CB4lIwa6Lnb5guiHSGOGs/5a3xowk44fIHL5Om/bfa816EEdzecYOxj3+2AOFGupnjPoTc
 743hOlVri7Rsz5pCumrAMgjwJku3KcypR32X/MUOkMiwB7cvnxfgAUZWz2VYjGZCtP1MQA
 7dZALHmB0zIwAoBKui70G4hw8uqcd5o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-1b8HRgV4Nv6hHSwjLPJ7NQ-1; Sun, 31 May 2020 12:40:22 -0400
X-MC-Unique: 1b8HRgV4Nv6hHSwjLPJ7NQ-1
Received: by mail-wr1-f70.google.com with SMTP id o1so3590482wrm.17
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q4vVNWwGJ6X+mCxN22qm0JQKHOJ0PdAaDdcsNO2TkXQ=;
 b=blqPPuFQgRPRq6xoAr4FKpci7b38mwK9VnrIjW78AJVA+cuRoX2yD9gvOUS10/beDU
 0Zg3ijZW4BJ9SISTCXhlNulJr+8H+6oXWGDC5nv6rFI47b8BWqkJsYfR8aNrxFi1dlP5
 6KrtkNWaWGiDoFyQ2skiLcioopqI93Ohb10pa222GVJxYIwltK5TOStGt5A3KVQhhWBk
 dMmh0KEUaKQZmU/GGrhi1CyKhofMQMqkTFpBcPPjKiFAAmAs26o1dayDeW4IMzCcMnti
 4zonuZ8mxYre/K2gu3H4jCPRcYVaIiLLse7FS8jxWfnbHHmi5CYhA1gle6EUDGl/l66S
 I5og==
X-Gm-Message-State: AOAM532W2M5rUS+ylQl6TRJ7bVk271xU783CGiH6MNcY1MiExWh7HAS0
 06UL202S3QMr7V/U7B0/e2yw6ZM6zMFNhJ9MxTZWxDLRgX4Js0XiZLeARV+rFWs2hKIJc7VtRED
 aHhRsJWR9jO0dCm0=
X-Received: by 2002:adf:eec2:: with SMTP id a2mr17399488wrp.136.1590943221349; 
 Sun, 31 May 2020 09:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTbjh1kanaHu4mvEz5G2IetIDATr+AlkqOK/pFPgvXTE/QruP8PTveawBN85Yr0c5UV+YrRQ==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr17399473wrp.136.1590943221141; 
 Sun, 31 May 2020 09:40:21 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a1sm10072069wmd.28.2020.05.31.09.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/25] tests/vm: Pass --debug through for vm-boot-ssh
Date: Sun, 31 May 2020 18:38:39 +0200
Message-Id: <20200531163846.25363-19-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:38:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Robert Foley <robert.foley@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This helps debug issues that occur during the boot sequence.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200529203458.1038-5-robert.foley@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 74ab522c55..80f7f6bdee 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -91,6 +91,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(V)$(DEBUG), --debug) \
 		--image "$<" \
 		--interactive \
 		false, \
-- 
2.21.3


