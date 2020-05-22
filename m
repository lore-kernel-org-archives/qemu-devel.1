Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3226C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1533206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdZi+SW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1533206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBRR-0006WL-TN
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQA-0003mT-9i
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQ9-0001qj-FP
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CL2hEmRqA1LEXMFCszT8EAy5Qc2losjLa/A+thU98aw=;
 b=cdZi+SW7Q0HtRqXAu/rOYRAIqG7yBuubRuXuajj0maXpsNrmPg1UuY+whfg+awTJcAwyUs
 QNRPjY0Oi2/BQReRNXSK7ZWrO2xwW1odQp+DGxgGVtE3BsHbWtEo1wL/egqjZ5CuutYxS5
 gOv0F/x3aFd1kg1/rfKI10mEQPAVolQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-pm1b4tmQNrqwJlqucESnbw-1; Fri, 22 May 2020 13:25:19 -0400
X-MC-Unique: pm1b4tmQNrqwJlqucESnbw-1
Received: by mail-wr1-f70.google.com with SMTP id p8so4654447wrj.5
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CL2hEmRqA1LEXMFCszT8EAy5Qc2losjLa/A+thU98aw=;
 b=LlqyWcvp5AuQ0x3xKmsWRmXg31DLGP1EPth5Yo3fP8437DqDw+B0qSKkw0Frm6tHxs
 gJwaahVc9+AYWEYGhqHqMiFQknB6xxGbyy+i96z0K1AsjET49adCHY1u0H0JQuniFGxb
 +fSnuFATjLH5fbFPtGEtwmgDN0kiVvHeeUWI6v0zT46k25OOAwfs06azBKTXpI+fK7EZ
 0AZnX9euuhW7ERqi5tYFKnLFyHe06c5TNYQPA8g85QYZvXuJxs2HXhqw98etdwluwDj6
 AT6pg2EmEi2MXJlebW5hf55ZJjfsrfvfexlrCQGmURjsFVL4pIslXNWdusm+PZpsUtt2
 Ls9w==
X-Gm-Message-State: AOAM531MdLdhyrMN+4PdzWOtSM68qZrs5p+GneiGn532yyCJ2ha5IwMp
 Wu6UQd3h/H6ddj1JbVEQL0tViXsXOKxsjKb7209ozrQWWjxUtafPkHiFC1Ss60SJGmS7jDe1jMj
 Lq+Y7lybtepQNQhk=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr14836578wmk.66.1590168317947; 
 Fri, 22 May 2020 10:25:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/BUFYlRbNPUDqgC+Yy5PUJkeU3Fa9faWNYMcRwVTmifznNcN7+AUHGEY657btc7LHWYPvdg==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr14836558wmk.66.1590168317806; 
 Fri, 22 May 2020 10:25:17 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r14sm15207666wmb.2.2020.05.22.10.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/13] Makefile: Only build virtiofsd if system-mode is
 enabled
Date: Fri, 22 May 2020 19:24:58 +0200
Message-Id: <20200522172510.25784-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not build the virtiofsd helper when configured with
--disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 40e4f7677b..d1af126ea1 100644
--- a/Makefile
+++ b/Makefile
@@ -345,7 +345,7 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyyy)
 HELPERS-y += virtiofsd$(EXESUF)
 vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
 endif
-- 
2.21.3


