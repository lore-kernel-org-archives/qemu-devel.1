Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C72206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK8eUPys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C72206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPj1-0000Lq-1c
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPft-0005tY-2j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPfr-0000dk-6Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iBj366HDTDMnWgMVaB3F0YknnASmntgiVGR2sJtUQI=;
 b=JK8eUPyspY5+iMNRzHnSpiQemUgWi2wax3ld1Qphtja+9Hx1CiRvHXB5flt/zJEW+UQjGa
 e2L2YvrWrfOaMOFQyTIVBd0CNl51DSvnrEDMbYZmLp89WHRVzNeKyxa9BNn12mRA3mXKrY
 8eC3+3tw/fb42rkSTnbuQw4qDmiq138=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-55Zzqu_QOFKaZEuC37xElw-1; Thu, 11 Jun 2020 12:03:22 -0400
X-MC-Unique: 55Zzqu_QOFKaZEuC37xElw-1
Received: by mail-wm1-f69.google.com with SMTP id j128so1495244wmj.6
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7iBj366HDTDMnWgMVaB3F0YknnASmntgiVGR2sJtUQI=;
 b=HUUMw/pwGgyvGOp0jYiYokbhQsGBwjFAhrWiNUlg2BzkcoNrEZ+hdLOnEa4hDBcg+Q
 yXP/eF3AJdPCvaHQXNEmaC94YWDq4hwUfWlBkeIIkOPJO1tL76miVLiIbnw1Tt9+09hr
 GmFrRNu/3nT3hJsMJfZQnfUjIdBIdhG/4gqQmrnmDFG5Fy8TDN4S91xI99AJgg/ir4SA
 wB5UPv++67FG/QrlBW7/D2wId+ne8cCFVlEKMmeMt/m+rmNsD6uzk+/zguClErbLPZCH
 ZvDCH8zlValqkUiOufgASqW6rRHaZ0froK4iAOQGRudLpasFRsLFDd2C49z0xoqlPsY/
 axHQ==
X-Gm-Message-State: AOAM531NVFjH0T0rkugfi+y5/IncILhN55EIUbTRTH7xqS8Ofo+BOn1R
 e9oYNc6j+aJSs3TcAIkdHLmgHOCKMRUlf8tHTcF2PqxB3/Mp6X/DnVd78pwit6b3fe4u5dgAVHA
 RJ5nBLF6lMYEplyQ=
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr9363313wma.83.1591891401289; 
 Thu, 11 Jun 2020 09:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysYVRwNxY8KI8rLxmGY2TQHT1+N0syLuE0dhRmn5YmtrYNyAItSL3gGuMfFqmDn8cWQJIKDA==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr9363172wma.83.1591891399406; 
 Thu, 11 Jun 2020 09:03:19 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z2sm5396336wrs.87.2020.06.11.09.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/11] backends: Add TPM files into their own directory
Date: Thu, 11 Jun 2020 18:02:57 +0200
Message-Id: <20200611160306.2751-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we will have various TPM backend files, it is cleaner
to use a single directory.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 backends/{tpm.c => tpm/tpm_backend.c} | 0
 MAINTAINERS                           | 2 +-
 backends/Makefile.objs                | 2 +-
 backends/tpm/Makefile.objs            | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename backends/{tpm.c => tpm/tpm_backend.c} (100%)
 create mode 100644 backends/tpm/Makefile.objs

diff --git a/backends/tpm.c b/backends/tpm/tpm_backend.c
similarity index 100%
rename from backends/tpm.c
rename to backends/tpm/tpm_backend.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 3abe3faa4e..9deb15b268 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2385,7 +2385,7 @@ F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
-F: backends/tpm.c
+F: backends/tpm/
 F: tests/qtest/*tpm*
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd57..22d204cb48 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -1,7 +1,7 @@
 common-obj-y += rng.o rng-egd.o rng-builtin.o
 common-obj-$(CONFIG_POSIX) += rng-random.o
 
-common-obj-$(CONFIG_TPM) += tpm.o
+common-obj-$(CONFIG_TPM) += tpm/
 
 common-obj-y += hostmem.o hostmem-ram.o
 common-obj-$(CONFIG_POSIX) += hostmem-file.o
diff --git a/backends/tpm/Makefile.objs b/backends/tpm/Makefile.objs
new file mode 100644
index 0000000000..8cf5772824
--- /dev/null
+++ b/backends/tpm/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y += tpm_backend.o
-- 
2.21.3


