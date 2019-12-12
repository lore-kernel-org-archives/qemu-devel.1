Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D430C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437AE2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkgVcHFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437AE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOkC-0007CB-UY
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyj-000450-AM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyh-0007Tq-V2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyh-0007SI-NK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id f4so3557009wmj.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=buKkqi9qKAWxhyG87IWpSJum7q79CbkXoaPrIe8090Y=;
 b=XkgVcHFjdMjArpF7+0JnbuFNSAAK0zSVtNJfwa5I1nLZKjuWePdnLpwN8yYOZXA3zO
 C/W4g/1mw/Btjp7OFP37h21e77U6wPiYDHt//Ln0FUQg9tB3/7vAaUDdMRbAGU+Vkmiw
 /U1D8gLeCVCmsgJRkdZJ63N3aN/2sgQeY34tH5qZGX7c8K+dFmsDHTextlM6qoO8sbpS
 HjeSaUsVKxk7CyGxUV8jLCA4vxYG9OlaiWUAAL49DUfXGoZMPcMtfYpRzmPW0WawLW6b
 IBRQCqidD9h9lE847C/fPUr1xF7z/IQ/cUULcikZNFwPmiLyMWDN0BCKRrKQu0OLr5qF
 QFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=buKkqi9qKAWxhyG87IWpSJum7q79CbkXoaPrIe8090Y=;
 b=TM1LrPVdB9PPD9peAD6/ysqYM3oVYDnCLSrtvzc3ABRTSalJerZZUdt9LVV4o5zJZ0
 jR866U+F2mIVI5YUvNoRoNVBSHEN8rMHKh/+KB6Jqte7rq88FlcddotE9BBS/6jIDpyB
 dYHfH6b+KImKyz0VsGNa1VMi8JGqIzAJl4MNW/cXo1abrEWjv474siE/9ZACUM1dezsc
 sKoJTGQwb7w+gqT53kieqGMuoZhyD8VogC7RsAl78YHxaxglFhm0Q0Nv9bXkJIgfDicL
 1ryLARxNTBR85ymcw4+EESHVzMrs6N9XpCwPHM0C8q8rhULqRcdKsrEDLxEXervdBqCP
 dCrg==
X-Gm-Message-State: APjAAAVRAxypwfXwMGDd+mypJLuSUP21Wj2b0zfb4C4Mi88pN+sLO38W
 oV2b603/Ne7wcp/R0w/XSQUcY31s
X-Google-Smtp-Source: APXvYqzwwYzR4FoZnPU2n0R8Ng2AWbqj5v+KzbsW2vK+MVyyHwQaZUN8HEcvF01lhS0jgGVEA4KOBQ==
X-Received: by 2002:a05:600c:257:: with SMTP id
 23mr6429763wmj.123.1576155238539; 
 Thu, 12 Dec 2019 04:53:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 060/132] meson: convert fsdev/
Date: Thu, 12 Dec 2019 13:51:44 +0100
Message-Id: <1576155176-2464-61-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile.objs       |  6 +-----
 fsdev/Makefile.objs | 12 ------------
 fsdev/meson.build   | 10 ++++++++++
 3 files changed, 11 insertions(+), 17 deletions(-)
 delete mode 100644 fsdev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 12d0a78..00289b6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,6 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-$(CONFIG_LINUX) = fsdev/
-
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
@@ -56,14 +54,12 @@ common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
 
 common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
-
-common-obj-y += hw/
 endif
 
 #######################################################################
 # Target-independent parts used in system and user emulation
 
-common-obj-y += hw/
+common-obj-y = hw/
 common-obj-y += disas/
 
 ######################################################################
diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
deleted file mode 100644
index 42cd70c..0000000
--- a/fsdev/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-# Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
-# only pull in the actual 9p backend if we also enabled virtio or xen.
-ifeq ($(CONFIG_FSDEV_9P),y)
-common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-else
-common-obj-y = qemu-fsdev-dummy.o
-endif
-common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
-
-# Toplevel always builds this; targets without virtio will put it in
-# common-obj-y
-common-obj-$(CONFIG_ALL) += qemu-fsdev-dummy.o
diff --git a/fsdev/meson.build b/fsdev/meson.build
index eee8507..ae84c13 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -1,3 +1,13 @@
+fsdev_ss = ss.source_set()
+fsdev_ss.add(files('qemu-fsdev-opts.c', 'qemu-fsdev-throttle.c'))
+fsdev_ss.add(when: 'CONFIG_ALL', if_true: files('qemu-fsdev-dummy.c'))
+fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
+  '9p-iov-marshal.c',
+  '9p-marshal.c',
+  'qemu-fsdev.c',
+), if_false: files('qemu-fsdev-dummy.c'))
+softmmu_ss.add_all(when: 'CONFIG_LINUX', if_true: fsdev_ss)
+
 if have_tools and libattr.found() and libcap_ng.found() and 'CONFIG_VIRTFS' in config_host
   executable('virtfs-proxy-helper', files('virtfs-proxy-helper.c', '9p-marshal.c', '9p-iov-marshal.c'),
              dependencies: [qemuutil, libattr, libcap_ng])
-- 
1.8.3.1



