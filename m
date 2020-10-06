Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C9C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E513C2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBg6Quaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E513C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmdL-0002ri-NU
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmW8-00039u-1F
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmW5-0001tv-20
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XFQO4+C4ntP2b83qPWVKeB3auO8XBYBXJzdLRqnK/M=;
 b=DBg6QuafqjDcMyIBmd3DGZnJLel1expxVczPG0J6o45A7LW5nMuQKlU6c4Rxp6B1K6Y+3v
 G9Wd6YX6IQiXho9NK5znazx1IdDb8Ix5xlh/jtP1jWYNpVBBu+oogeb30Fv6yt9RoYVL/S
 stNesbJsGje6WYV2p9akijDiQ/VKkRI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-R83JbxZcNqCqHZQM1mFPqg-1; Tue, 06 Oct 2020 08:56:26 -0400
X-MC-Unique: R83JbxZcNqCqHZQM1mFPqg-1
Received: by mail-wm1-f72.google.com with SMTP id u5so664935wme.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XFQO4+C4ntP2b83qPWVKeB3auO8XBYBXJzdLRqnK/M=;
 b=Gtu6F5RFvizHBmM6wuOlsr6i+T3iMbDRWBMihxGDICQKYAXZfb/+69av9BMAqDZOAD
 GAF40U80qkR1Ndoy9SzWASBx4951HB9/gMf19zuJX3M65JeVJ37EDgYfVIwz1kYJ9U7J
 oLQNdUIi3yos43azRfGhirgAKCuoZRxEwrMGKaj1SFKOVI0koNk7i7GcGNVPxLi9wgoD
 Rmm+VTSNI06F1s7BwfMVNwLOClJe0mV2MWPVph2XfKozutAhhRSOHpsQUFr0Aq5KkTI0
 oq0S9AE2QFVD90jYok7Im8A0mtrx6/oVfJC+v9BXpdeuQ2GrsFDjOHwstyWrYaWtImum
 2ywQ==
X-Gm-Message-State: AOAM530Nlae4GWn1sCbr4Q8GQ5RNXqNUwz1azeb82OHI/pIfuOgKIXx4
 6qM8CtacIsu43Phf9wlPNsFY8rimpyN8Qp7LFMOXuRfBu8AC2h0GIn2tIrHdff5kKQnxs5spEqY
 degL6l5ta96dxWcI=
X-Received: by 2002:a5d:6311:: with SMTP id i17mr4576649wru.243.1601988985347; 
 Tue, 06 Oct 2020 05:56:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp9TFYXdx8eKlKnz69xteHGW/NyBhHnCt25BlfDngVePi8xiWeZZb2/mGFxP6YCeosXeHWCw==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr4576632wru.243.1601988985189; 
 Tue, 06 Oct 2020 05:56:25 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c4sm3950738wme.27.2020.10.06.05.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] chardev: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 14:55:57 +0200
Message-Id: <20201006125602.2311423-5-philmd@redhat.com>
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
 meson.build         | 7 +++++++
 chardev/meson.build | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 47eb7d3709..3c0d7b4d44 100644
--- a/meson.build
+++ b/meson.build
@@ -1062,6 +1062,7 @@ sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
 blockdev_ss = ss.source_set()
 block_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
+chardev_ss = ss.source_set()
 common_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
@@ -1346,6 +1347,12 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
 
 qmp = declare_dependency(link_whole: [libqmp])
 
+libchardev = static_library('chardev', chardev_ss.sources() + genh,
+                            name_suffix: 'fa',
+                            build_by_default: false)
+
+chardev = declare_dependency(link_whole: libchardev)
+
 libhwcore = static_library('hwcore', sources: hwcore_files + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
diff --git a/chardev/meson.build b/chardev/meson.build
index 54e88d0310..dd2699a11b 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -1,4 +1,3 @@
-chardev_ss = ss.source_set()
 chardev_ss.add(files(
   'char-fe.c',
   'char-file.c',
@@ -25,11 +24,6 @@ chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
 ))
 
 chardev_ss = chardev_ss.apply(config_host, strict: false)
-libchardev = static_library('chardev', chardev_ss.sources() + genh,
-                            name_suffix: 'fa',
-                            build_by_default: false)
-
-chardev = declare_dependency(link_whole: libchardev)
 
 softmmu_ss.add(files('chardev-sysemu.c', 'msmouse.c', 'wctablet.c', 'testdev.c'))
 softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
-- 
2.26.2


