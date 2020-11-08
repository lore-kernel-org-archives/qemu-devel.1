Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32375C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 21:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C92D206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdZN+D2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C92D206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrot-0002ds-Pt
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 16:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbz-0005s3-Lj
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbx-0000af-Gw
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1WN1/m2uFtCo3Xbkv4MrIigyX5ILJ7fts0VkcGwaX8=;
 b=FdZN+D2NFjWv5FyDa6dtnGRF6JDPYTWs/ao+wy4dY37ynZrAfQIFHIa0d+q2da5FEMzXWZ
 zlRzO1XT+xIy2GB6BxEd+g5rsccKBZhwblLCc+yufVDyJqt8kCId1OSg3yaty+2OAAjwxv
 ljYuqkNwIJKe150rT9/drZ8RwQCysvc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-mDJfPy5XMpag109eDi4DfQ-1; Sun, 08 Nov 2020 15:48:27 -0500
X-MC-Unique: mDJfPy5XMpag109eDi4DfQ-1
Received: by mail-wr1-f71.google.com with SMTP id h11so3364055wrq.20
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+1WN1/m2uFtCo3Xbkv4MrIigyX5ILJ7fts0VkcGwaX8=;
 b=TtwV5aBg9r1KysSiSdneCJDanlJ39BhqxISxoEpyXWV3scAvIVPwqh5QfueUUGGEHu
 UFDDV7ihUqjqSDocGHjhsD0RVxQmXePjtAvEDYxZvGHkfSxTEQKfPHj8mk8q2m3IJ0jL
 mZlnqb6wVNnG6HRPLJIPX1zx/IzsHMU8kqueD3VZorZLbIhOB/KyUOuYVbUhOSb5CPCl
 MmUUOnRhDZaXA3M/+i3fD5KrEWSwZzZmrwHTcfLTINlxpv8IF/KYSgOza/1BY+eMSxpi
 jwnqbuxjmE6oKxru52X1KQOJNBslv/HKIlOt3x43l9XtDLLpLm7mPzzRk/pviX2kVRcU
 n8IQ==
X-Gm-Message-State: AOAM533rUqoxmEtqJR4b1IdVVmbRpLND8lYkXBZZlKQeXtgnvXi6lwA9
 jfTxT5e6luLkr/pd3hUKQi+lEqrBqN+LmexeA3sHsGeBVWKx6ljym6wQELjXuAZesx2Z6t951NL
 wIHVGVTGRKyU0uso=
X-Received: by 2002:adf:fc84:: with SMTP id g4mr6436123wrr.202.1604868505508; 
 Sun, 08 Nov 2020 12:48:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzN7NY1Bjo4kWPHq7oq8IBocbIx5+v9C8KKMEXy92pQM+G9NfPCRNcySZLqWSlscS+aHynewQ==
X-Received: by 2002:adf:fc84:: with SMTP id g4mr6436108wrr.202.1604868505341; 
 Sun, 08 Nov 2020 12:48:25 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u195sm10587770wmu.18.2020.11.08.12.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:48:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 17/17] gitlab-ci: Make MIPS user-mode 32-bit
 little-endian job optional
Date: Sun,  8 Nov 2020 21:45:35 +0100
Message-Id: <20201108204535.2319870-18-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep the mips user-mode emulation by default on 32-bit big endian
and 64-bit little endian targets, but make it optional on 32-bit
little endian. User can still run the job manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
---
 .gitlab-ci.d/crossbuilds.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index e4526e98232..5f611b5ff42 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -78,6 +78,9 @@ cross-mipsel-user:
   <<: *cross_user_build_job_definition
   variables:
     IMAGE: debian-mipsel-cross
+  rules:
+    - when: manual
+      allow_failure: true
 
 cross-mips64el-system:
   <<: *cross_system_build_job_definition
-- 
2.26.2


