Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9E7C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F5F20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agptUs5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F5F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkzw-000265-AK
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktu-0001kn-GY
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPkto-0005Kk-TM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKqEEWSZWPIXjq0Tj3/IAfDoo8ykF8LYWdg8EMySCCE=;
 b=agptUs5yGvSQszEvahz1EtyhljqZ9US7M+aGnQ1aqmE+VQXqmx5oXEBjwRBjyMMUZd2Txi
 lQDcA/Q29CLFMSa54d7XHMN7KY5MC3BRAWWjLJwMVkAzsnmMCoOzl+MzPadUa3sYUBgRA5
 vgnJV4lmHnFopFCD+G+lEvwH4dngpfo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-n_Y09hB8N8S_tRatBQR3SA-1; Tue, 06 Oct 2020 07:12:48 -0400
X-MC-Unique: n_Y09hB8N8S_tRatBQR3SA-1
Received: by mail-wm1-f69.google.com with SMTP id d197so582188wmd.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BKqEEWSZWPIXjq0Tj3/IAfDoo8ykF8LYWdg8EMySCCE=;
 b=gCTt8Kj5QMyA3cizNMvZDUfwOfWLCdkvBnvn/jK+9pKEuvrFMAEMetLX2XOuSIzaz3
 etDZk6ByfPCPtj0I++jPS2JDokydzdr1Eg1BSN/Ot7Rp9hUm12KMLMxeqBXmPpbifczr
 VSKbjURLaGhZHZSxI7vli++uSX2Uo4HN2thSmZ5TVoOg5r5wE/TluLW6R10Rwst8Xf56
 dg9/J9eMIjxGvzKACtlIi20n+dmdpNj3yNh36YYPIpkCkq6Nx7ZArhHE/3JDK3kJFmf/
 JwEu6hHjthKnFd71HlDlQmpz+p69x9T/Y7FKqEWRNC60LItaDjXj5GVS8UHljeiNln4s
 Pa8Q==
X-Gm-Message-State: AOAM531nT2+w74I4vx3bAgMi187mdRKDSQrHx+sLh94PNpF3y9tnOLme
 SFTu4dQyqcQSxvxJp5VUzS8B67WHEh/3pqtNXqjn6jYJSdJZvMvBHvNjHevVQD/J2DahlB78P7v
 k3yOFTm6DdAA++AM=
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr4253866wmb.170.1601982766686; 
 Tue, 06 Oct 2020 04:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMy/QU2uilQ/Xyup8ZFTEoGJqUG3jSl3lY0ZpSCF7XJgsUaz8JTmrGCdwQlwXTwBGoQgTf8Q==
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr4253842wmb.170.1601982766507; 
 Tue, 06 Oct 2020 04:12:46 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n10sm3548248wmk.7.2020.10.06.04.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:12:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] chardev: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:14 +0200
Message-Id: <20201006111219.2300921-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006111219.2300921-1-philmd@redhat.com>
References: <20201006111219.2300921-1-philmd@redhat.com>
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
index ccfa3e9531..6bec7a0994 100644
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


