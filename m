Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE0EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B524920760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0dOZer1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B524920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmkR-0001qq-H9
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmW3-00033H-09
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmW1-0001tS-3z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iu4VFbji1NYalAxtgTpGrAQFcSu9AmIxH2mbp91RPjA=;
 b=J0dOZer1FfVU0kC16LT2sptU2GeHr+1z2otsTJXMCqZvvlbT5fjGw7siPBL82cVcAbmBdu
 N+rMUSpvqtoyMD4NkbznOgoKupMcr5465a44zPf8NAaDzoIux3pJEcUe3qshEGsAqN9x/V
 v4W9KD374OvqY5k/AiEy/2iVKts3z40=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-gcrpu401PBqahDuh3j51fg-1; Tue, 06 Oct 2020 08:56:21 -0400
X-MC-Unique: gcrpu401PBqahDuh3j51fg-1
Received: by mail-wr1-f70.google.com with SMTP id 33so2988314wrf.22
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iu4VFbji1NYalAxtgTpGrAQFcSu9AmIxH2mbp91RPjA=;
 b=d2kjqVkKXx6iuUTTBKd6/dy6yAvq3Vya4iIo7v+1X300sTVxXUyqMLr+J2ZqN3hG9r
 h37eA3MtZmfi1D15yfw9N/D9UZgDvKzSECVLQzy/aCwB86nMR7H72CARSab9fHl+44MW
 MHc4w4HBjNcp0UVW4kcm6diQsYEb3uB3egpVr6g7l6JLMDljIvxbFSLFvgiOTequywaK
 vPtXzTsbtWFX6xWEchK5l5UWB8XH6TTUwXvqedfrwukeTpmz/XC3Nr+rjVT0/lzXNeYJ
 PpUa/T63/PFd1kbe9eWySEE6CqjWuclAPjVy3TvWXnTGO1jvAEzpaBIGdqzk0KngjcGG
 DnYQ==
X-Gm-Message-State: AOAM530yzhQI/hn0Qq1T7Dna1GpPbO2KHg9puwdt4BWVXY0iCkcqssOm
 d+439mN3qnEgZihvBMeCmkv8N5ChjFxmF7v76xORVjulBfUTAKUnp5AyjvVBJVhIGZXAqS0vZhL
 hcLcMOrULkAHQKWo=
X-Received: by 2002:adf:f584:: with SMTP id f4mr4590311wro.383.1601988980104; 
 Tue, 06 Oct 2020 05:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+WUzcbY4Qb1+NBLQViKKYuMdVWkEAjiUpRbAfy8WJwU2jgXQJd/r6+HrmRrPY5XIl/x7DLg==
X-Received: by 2002:adf:f584:: with SMTP id f4mr4590284wro.383.1601988979900; 
 Tue, 06 Oct 2020 05:56:19 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b8sm3850769wmb.4.2020.10.06.05.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] hw/core: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 14:55:56 +0200
Message-Id: <20201006125602.2311423-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006125602.2311423-1-philmd@redhat.com>
References: <20201006125602.2311423-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Be consistent creating all the libraries in the main meson.build file.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build         | 6 ++++++
 hw/core/meson.build | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 60497f5615..47eb7d3709 100644
--- a/meson.build
+++ b/meson.build
@@ -1346,6 +1346,12 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
 
 qmp = declare_dependency(link_whole: [libqmp])
 
+libhwcore = static_library('hwcore', sources: hwcore_files + genh,
+                           name_suffix: 'fa',
+                           build_by_default: false)
+hwcore = declare_dependency(link_whole: libhwcore)
+common_ss.add(hwcore)
+
 ###########
 # Targets #
 ###########
diff --git a/hw/core/meson.build b/hw/core/meson.build
index fc91f98075..4a744f3b5e 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -14,12 +14,6 @@ hwcore_files = files(
   'qdev-clock.c',
 )
 
-libhwcore = static_library('hwcore', sources: hwcore_files + genh,
-                           name_suffix: 'fa',
-                           build_by_default: false)
-hwcore = declare_dependency(link_whole: libhwcore)
-common_ss.add(hwcore)
-
 common_ss.add(files('cpu.c'))
 common_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
 common_ss.add(when: 'CONFIG_GENERIC_LOADER', if_true: files('generic-loader.c'))
-- 
2.26.2


