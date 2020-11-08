Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB5C55ABD
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF8E206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0SUZYrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF8E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrcJ-0005c1-5F
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbray-0004Ff-Tf
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrax-0000V7-3p
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVjcP+pti2u4PYxK7LerM3qHxrgoqrncvBuoP4reknY=;
 b=i0SUZYrw8/1tHbLzs7JdAGGKmK/7ha9ifPLl++HoCozDgDD+gc7NtPr0Jz6Q9qnPx60/Hp
 ROLrTj2DJkSzBj/g8s9pckxgi0k7WUCqERb3/0HCvcAz0S3C7lFJ0gG9Zn2psX/+aUrzsf
 CBR5eQ3yoJ61ioFSEGig+qWx8zwpoIw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-ujktNPoIPL-vuStZPXlhYA-1; Sun, 08 Nov 2020 15:47:25 -0500
X-MC-Unique: ujktNPoIPL-vuStZPXlhYA-1
Received: by mail-wr1-f70.google.com with SMTP id q15so3378258wrw.8
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AVjcP+pti2u4PYxK7LerM3qHxrgoqrncvBuoP4reknY=;
 b=m8En1RgTn93WiDSEXPgb8E/aepsHmkGrXN5y5YrGgZS6zmNLjSNmK/gXoHWcqPf7O1
 /LFActMqnoClx5C1f4Bocix5DOObAJYZm+TgtrOwWTFhjQRvpRYK+XgWa9Y1WPfd/q67
 IzYutLE3BVdyhYWS1Znn256LWhvMBd1wiEYwLK+bnru3469JiZMBhYoIL5/0Iamj8ieH
 9sXg+3Hfrmq5KZcW1AJqEGz8rDAG588aAYiDyIc3c3X6BSBtTIaiPRjbhm1suCTBNvdd
 DgH3cGxUfoH80vEZdaEEAxSZkHusuf1qyr/u3cqd14bjZwI8bUyYXdmuRlCuI0/XUESw
 GM3A==
X-Gm-Message-State: AOAM533+FCcoAuD/d48ncILhT/yG2E23yuJidTVlp7gxQFE8b7xyvxQm
 +XKJeQQy634SjFmuNrSYU5KnNcGjkqqe7TD3V3TCiFuVZjGmALb9SM6BLQZsu7gpKtkklZNL0J7
 FyBBlhxAtBabpFsQ=
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr10553024wml.3.1604868443413;
 Sun, 08 Nov 2020 12:47:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzAe3q+xAjauzyNHWuwSWjS8Qw0/Uvwxtpr5r7okJhqpWngHAM5/kVWsPibPQvVgylMUkZIw==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr10553001wml.3.1604868443284;
 Sun, 08 Nov 2020 12:47:23 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c62sm5502227wme.22.2020.11.08.12.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 05/17] gitlab-ci: Split CONFIGURE_ARGS one argument
 per line for build-disabled
Date: Sun,  8 Nov 2020 21:45:23 +0100
Message-Id: <20201108204535.2319870-6-philmd@redhat.com>
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will keep adding/removing options to our 'configure' script,
so for easier maintainability it makes sense to have CONFIGURE_ARGS
declared as one option per line. This way we can review diff easily
(or rebase/cherry-pick).

No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Daniel P . Berrange <berrange@redhat.com>
---
 .gitlab-ci.yml | 80 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b15ae5c302..9f090cca5e3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -203,23 +203,69 @@ build-disabled:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --disable-attr --disable-avx2 --disable-bochs
-      --disable-brlapi --disable-bzip2 --disable-cap-ng --disable-capstone
-      --disable-cloop --disable-coroutine-pool --disable-curl --disable-curses
-      --disable-dmg --disable-docs --disable-glusterfs --disable-gnutls
-      --disable-gtk --disable-guest-agent --disable-iconv --disable-kvm
-      --disable-libiscsi --disable-libpmem --disable-libssh --disable-libusb
-      --disable-libxml2 --disable-linux-aio --disable-live-block-migration
-      --disable-lzo --disable-malloc-trim --disable-mpath --disable-nettle
-      --disable-numa --disable-parallels --disable-pie --disable-qcow1
-      --disable-qed --disable-qom-cast-debug --disable-rbd --disable-rdma
-      --disable-replication --disable-sdl --disable-seccomp --disable-sheepdog
-      --disable-slirp --disable-smartcard --disable-snappy --disable-spice
-      --disable-strip --disable-tpm --disable-usb-redir --disable-vdi
-      --disable-vhost-crypto --disable-vhost-net --disable-vhost-scsi
-      --disable-vhost-user --disable-vhost-vdpa --disable-vhost-vsock
-      --disable-virglrenderer --disable-vnc --disable-vte --disable-vvfat
-      --disable-xen --disable-zstd
+    CONFIGURE_ARGS:
+      --disable-attr
+      --disable-avx2
+      --disable-bochs
+      --disable-brlapi
+      --disable-bzip2
+      --disable-cap-ng
+      --disable-capstone
+      --disable-cloop
+      --disable-coroutine-pool
+      --disable-curl
+      --disable-curses
+      --disable-dmg
+      --disable-docs
+      --disable-glusterfs
+      --disable-gnutls
+      --disable-gtk
+      --disable-guest-agent
+      --disable-iconv
+      --disable-kvm
+      --disable-libiscsi
+      --disable-libpmem
+      --disable-libssh
+      --disable-libusb
+      --disable-libxml2
+      --disable-linux-aio
+      --disable-live-block-migration
+      --disable-lzo
+      --disable-malloc-trim
+      --disable-mpath
+      --disable-nettle
+      --disable-numa
+      --disable-parallels
+      --disable-pie
+      --disable-qcow1
+      --disable-qed
+      --disable-qom-cast-debug
+      --disable-rbd
+      --disable-rdma
+      --disable-replication
+      --disable-sdl
+      --disable-seccomp
+      --disable-sheepdog
+      --disable-slirp
+      --disable-smartcard
+      --disable-snappy
+      --disable-spice
+      --disable-strip
+      --disable-tpm
+      --disable-usb-redir
+      --disable-vdi
+      --disable-vhost-crypto
+      --disable-vhost-net
+      --disable-vhost-scsi
+      --disable-vhost-user
+      --disable-vhost-vdpa
+      --disable-vhost-vsock
+      --disable-virglrenderer
+      --disable-vnc
+      --disable-vte
+      --disable-vvfat
+      --disable-xen
+      --disable-zstd
     TARGETS: arm-softmmu i386-softmmu ppc64-softmmu mips64-softmmu
       s390x-softmmu i386-linux-user
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
-- 
2.26.2


