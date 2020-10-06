Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C60C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E892075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBSXJqT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E892075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmZ8-0007N2-9I
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmWJ-0003Pd-RG
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmWH-0001wI-4r
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601989000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uo2CBkWFfKQfoIhaUjbFZ5zVf7ry84pgNlp78mZ6R2E=;
 b=ZBSXJqT5AkOyw73yUEbR2WlEzmd3KHsPKa3/N31D+RDb23lAyo3AQV8kFJREv8C9cvS1yg
 eeayePbSUdYrNAgPtmLzeU9HTD0CGovaIBKlptyTJfyjYfnIIPO+UclG/ExfRuuZyd6RlC
 cdwUtnmlpWoYIsf9e8DbqACpms9ptLs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-CHlrOM_9Nb6RfLDvCmUo5A-1; Tue, 06 Oct 2020 08:56:37 -0400
X-MC-Unique: CHlrOM_9Nb6RfLDvCmUo5A-1
Received: by mail-wm1-f72.google.com with SMTP id p17so660475wmi.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uo2CBkWFfKQfoIhaUjbFZ5zVf7ry84pgNlp78mZ6R2E=;
 b=FFfMQmKjwd7FnXUA7+KFvZxRGtDkMEwCK92uJQciFXEVdP5qch0G1sMjYE45WcHA2F
 shfyIPkWsphuA+Y4faiiSNqhtYfe5RNJN4j1EdRB8YmC2BEIanMdNHF3UIId01nOygUB
 OjxkLT8z4IV8zUtqQBmeCFaMPibUL209J2WgOaBo3xpQPoDtEOQPRUwiJ40u5Bl1dbtk
 jXCDFssLj+7nQ7Ssw37JLq02MFWZ2DrNyjLDDBspRFLBB0ktoF+nNVv3BfsP8pmp10xV
 dEbSj2hWmWzkCXR/kOE7lHChvNsu/cpQ5wlFrcWJd+tGy2wB66kAbjiBXou400ySboEp
 Bm8Q==
X-Gm-Message-State: AOAM5302LaoKHn5DTM7xNcWNroRjsWfogtygnaXrjcpVNPPlT6g5AWps
 daBo5CoW0gY/sw/7WyhMvy6qTPQQ7e0GTWEgOgMnycqhiGc65HDjIozctAJkDVKdlZdfGVmJdk4
 xg1FioV9cHyuhjUM=
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr4657241wms.36.1601988995380; 
 Tue, 06 Oct 2020 05:56:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt/Va/EZ57ZPFYV0CpGFlbTfh0g7Kaso5whh9xynKcqrV4rSeY5XklV10J1UM97NWLqQvOLw==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr4657223wms.36.1601988995221; 
 Tue, 06 Oct 2020 05:56:35 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h17sm4772675wro.27.2020.10.06.05.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] io: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 14:55:59 +0200
Message-Id: <20201006125602.2311423-7-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 meson.build    | 10 ++++++++++
 io/meson.build | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 0e3598e267..f9d952d685 100644
--- a/meson.build
+++ b/meson.build
@@ -1064,6 +1064,7 @@ block_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
 chardev_ss = ss.source_set()
 common_ss = ss.source_set()
+io_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
 softmmu_ss = ss.source_set()
@@ -1328,6 +1329,15 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+io_ss = io_ss.apply(config_host, strict: false)
+libio = static_library('io', io_ss.sources() + genh,
+                       dependencies: [io_ss.dependencies()],
+                       link_with: libqemuutil,
+                       name_suffix: 'fa',
+                       build_by_default: false)
+
+io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
+
 libmigration = static_library('migration', sources: migration_files + genh,
                               name_suffix: 'fa',
                               build_by_default: false)
diff --git a/io/meson.build b/io/meson.build
index 768c1b5ec3..bcd8b1e737 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -1,4 +1,3 @@
-io_ss = ss.source_set()
 io_ss.add(genh)
 io_ss.add(files(
   'channel-buffer.c',
@@ -14,12 +13,3 @@ io_ss.add(files(
   'net-listener.c',
   'task.c',
 ))
-
-io_ss = io_ss.apply(config_host, strict: false)
-libio = static_library('io', io_ss.sources() + genh,
-                       dependencies: [io_ss.dependencies()],
-                       link_with: libqemuutil,
-                       name_suffix: 'fa',
-                       build_by_default: false)
-
-io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
-- 
2.26.2


