Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DBDC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE7524672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvGwpm/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE7524672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMv4-00078L-HC
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1irMsp-0003Zp-2N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1irMsn-0008H8-P7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:09:26 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1irMsn-0008Fy-Jg
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:09:25 -0500
Received: by mail-pg1-x544.google.com with SMTP id q127so6452619pga.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i4DDI49kN7XSXGAfcKghDbO8KY6etjG0aejbOuVFbHs=;
 b=MvGwpm/dt5xW9XylAFzJ//mw6CZnt0toHpWbkboAx5/DdKG2/gK79e4gytVbmyudv2
 VsXyeqnXTOWSnDkOmkD7rqJh5OBBDSW7XzMdGwjUqkovLIUuHrjKq1+1BB0cWL7y28eO
 mdOnTOQuQXwwDWlMRdiqLSq6SzQkdqi7n/p/cQtQFeg8cGV+WR1DtvUwhUJDhKkfZe5z
 j+/u/p8Zk+orfLanaDlTA5C+kwUbYUtmoaUDR+WVilmp45/Y5eFRgyWpJTxA9bTrb1i6
 oQX202q5mk3r0SRpSwD9DioXBi6SkJ5L9b3C6ME/0cKsAh+LtNycghc8iPvD2s2RQ6ov
 T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i4DDI49kN7XSXGAfcKghDbO8KY6etjG0aejbOuVFbHs=;
 b=V5RjrgQyHYwOwcJ4fNJsNPquB/zuAEHjN2pcREOPds7gsHQ3KxOTF+bWSIqcxbbzEx
 +L5aVpdswNZ+u9cHvi2BYYDK0ErlCbI9/5ITlVhwggg8gEt8s3Ba+LGBWnIzBWNE/N+L
 Zrv179Y3GvpHD3P8WPnwqcfOUzr3tZ7O9qBiJskEE/ti1bS1bpRZTa5yIqfd7Mkkkhc+
 i4nl04Ws7qYE2EL8lZLKDhYBPCBAd9VFk0w3QEyPX97HZCSUj+tnkh6G9X7ryoqz30eE
 gyKF2jm2zxek8JvWGn3yBsAiJVzc9Cjg2j89JvqFUYOzPMmPs4RtGw13Pr713l4W+8+p
 mELg==
X-Gm-Message-State: APjAAAWUwkj4Uy9v60J323rlbfn15zHtVP2Y1FT1ifnEzeeCQTqq/UQx
 oADyZMp/ejMUBz2uwI0c9mPByBLVBEO8sg==
X-Google-Smtp-Source: APXvYqxKO8lMaLrMYhqL0qp+2Fu9QHrhuWIAOkeOam/zqvv+lpp85RAvD81lUi5dXC0WMTXEs1swPA==
X-Received: by 2002:a63:d705:: with SMTP id d5mr26766696pgg.24.1579010963348; 
 Tue, 14 Jan 2020 06:09:23 -0800 (PST)
Received: from localhost.localdomain ([175.124.145.172])
 by smtp.googlemail.com with ESMTPSA id a17sm17264773pjv.6.2020.01.14.06.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 06:09:22 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] building configuration files changes
Date: Tue, 14 Jan 2020 22:06:20 +0800
Message-Id: <20200114140620.10385-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114140620.10385-1-coiby.xu@gmail.com>
References: <20200114140620.10385-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libvhost-user depends on sys/poll.h, sys/socket.h and eventfd. Although
Windows has the equivalent Winsock, it doesn't have eventfd. So only
enable this feature on Linux.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Makefile               | 1 +
 Makefile.objs          | 2 +-
 Makefile.target        | 1 +
 configure              | 2 +-
 tests/Makefile.include | 5 ++++-
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6b5ad1121b..80c514f96b 100644
--- a/Makefile
+++ b/Makefile
@@ -558,6 +558,10 @@ qemu-img.o: qemu-img-cmds.h

 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+
+ifdef CONFIG_LINUX
+qemu-vu$(EXESUF): qemu-vu.o blockdev-vu.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS) libvhost-user.a
+endif
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)

 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 7c1e50f9d6..5404daca00 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -53,6 +53,7 @@ common-obj-$(CONFIG_WIN32) += os-win32.o
 common-obj-$(CONFIG_POSIX) += os-posix.o

 common-obj-$(CONFIG_LINUX) += fsdev/
+common-obj-$(CONFIG_LINUX) += blockdev-vu.o

 common-obj-y += accel/
 common-obj-y += migration/
diff --git a/Makefile.target b/Makefile.target
index 6e61f607b1..d5405976ce 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -159,6 +159,9 @@ obj-y += monitor/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
+ifdef CONFIG_LINUX
+obj-y += ../contrib/libvhost-user/libvhost-user.o
+endif
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)

diff --git a/configure b/configure
index 0ce2c0354a..8ad4da57be 100755
--- a/configure
+++ b/configure
@@ -6169,6 +6169,9 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
+  if [ "$linux" = "yes" ] ; then
+    tools="qemu-vu\$(EXESUF) $tools"
+  fi
   if [ "$ivshmem" = "yes" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49e3b0d319..33bd48247b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -746,6 +746,7 @@ qos-test-obj-y += tests/libqos/virtio.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
 qos-test-obj-y += tests/libqos/virtio-balloon.o
 qos-test-obj-y += tests/libqos/virtio-blk.o
+qos-test-obj-y += tests/libqos/vhost-user-blk.o
 qos-test-obj-y += tests/libqos/virtio-mmio.o
 qos-test-obj-y += tests/libqos/virtio-net.o
 qos-test-obj-y += tests/libqos/virtio-pci.o
@@ -788,6 +789,7 @@ qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-$(CONFIG_VIRTFS) += tests/virtio-9p-test.o
 qos-test-obj-y += tests/virtio-blk-test.o
+qos-test-obj-$(CONFIG_LINUX) += tests/vhost-user-blk-test.o
 qos-test-obj-y += tests/virtio-net-test.o
 qos-test-obj-y += tests/virtio-rng-test.o
 qos-test-obj-y += tests/virtio-scsi-test.o
@@ -935,7 +937,8 @@ endef
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(check-qtest-y)
 	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
 	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
-	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
+	  QTEST_QEMU_IMG=./qemu-img$(EXESUF) \
+	  QTEST_QEMU_VU_BINARY=./qemu-vu$(EXESUF))

 check-unit: $(check-unit-y)
 	$(call do_test_human, $^)
--
2.24.1


