Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA9C33CAB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 05:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E4621556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 05:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h37HcGKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E4621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqrr8-0003RL-6B
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 00:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1iqrng-0007o2-D8
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1iqrnf-0007AQ-4C
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:58:04 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:41011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1iqrne-00078G-TK
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 23:58:03 -0500
Received: by mail-pg1-x535.google.com with SMTP id x8so4097279pgk.8
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 20:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EQMyzeRthVsHsvanx1IY5iAxlbRqxtmJUNUIngmWAlk=;
 b=h37HcGKpWzAd4VTJVn7G3SKFYITfFU+wzluErHcVOtv1DXaXJw29GC/wJh8FUX8/U0
 XaSbl46qJVl8JhU9gDuYm6Q9E1PDWsOPhUu1IqHYcOvn+rgZBGewZwoU+3st/Q3sPiUt
 EyzZaKLO2lI250RUGR0j6HUw4YISye1thAPgnSvCd7DnmahEAB+GlzFdY0/9YvvjxcB2
 ksecZ149Mezh7H8UjPYnaRtg2E560lSmPgEvCylVC4UxBwGTn/zDGlOZ3H2OLzrj1eNs
 hwsx3S0oeXwsbaKzR/WV2NX9pKiHne40K44/WxerETgHx0U2YsR+ECnPKsLIPF4r2i6a
 oTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EQMyzeRthVsHsvanx1IY5iAxlbRqxtmJUNUIngmWAlk=;
 b=h+cZgIr67QKfnUyEjzlNZ9qaebF9IOnKvAbNkFZ7rtDXP3ua3yoQppTfERm+aBZYxF
 UVGHbxsKObEbu9DLtXIqTl26m5f2Qq5yNuhpVjfmj2kj4wJyKJrxdhSb2sj/0FT2Iy45
 IbXdxUZfxz9PjTn58S9eOQDnn5p/8bghJD2nMNdyr6mr97p/acfZa90zsoKZV6dS+FcS
 KKtu9LXG3fnMK939Pcni4quKsUBYl4yIW7nsjp/DLXpnswT5g4/GJn5icznJkExgg3JV
 DOpeuHlsP42EHFIvvvGXKM0p4xubuP5NsCBfILOyz/wDQSwYp5gOA+CgONWbUvNKRJ0c
 DR2Q==
X-Gm-Message-State: APjAAAW+MOj+x0QqWQwSzXXleL8ajOEKx/8Pd510oNFjsCn6fQyoO6Vo
 5iqtu9xmpsO9MGGzlBRb05d7g7JcF6a0Zw==
X-Google-Smtp-Source: APXvYqxcZ+1XV2qEA92vZkHoV47Ngmrj8t7C0v9bwb2JMF4IJUYUSwDwiXmpQi5lq1mPmSKsUxl/fA==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr19176519pgg.48.1578891481500; 
 Sun, 12 Jan 2020 20:58:01 -0800 (PST)
Received: from localhost.localdomain ([175.124.145.172])
 by smtp.googlemail.com with ESMTPSA id o19sm17590552pjr.2.2020.01.12.20.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2020 20:58:00 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] building configuration files changes
Date: Mon, 13 Jan 2020 12:57:04 +0800
Message-Id: <20200113045704.12318-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113045704.12318-1-coiby.xu@gmail.com>
References: <20200113045704.12318-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Makefile               | 1 +
 Makefile.objs          | 2 +-
 Makefile.target        | 1 +
 configure              | 2 +-
 tests/Makefile.include | 5 ++++-
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6b5ad1121b..1b98201d29 100644
--- a/Makefile
+++ b/Makefile
@@ -558,6 +558,7 @@ qemu-img.o: qemu-img-cmds.h

 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-vu$(EXESUF): qemu-vu.o blockdev-vu.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS) libvhost-user.a
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)

 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 7c1e50f9d6..f77b110fc9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -42,7 +42,7 @@ io-obj-y = io/
 # single QEMU executable should support all CPUs and machines.

 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o block/
+common-obj-y = blockdev.o blockdev-nbd.o blockdev-vu.o block/
 common-obj-y += bootdevice.o iothread.o
 common-obj-y += dump/
 common-obj-y += job-qmp.o
diff --git a/Makefile.target b/Makefile.target
index 6e61f607b1..51a9a9c349 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -159,6 +159,7 @@ obj-y += monitor/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
+obj-y += ../contrib/libvhost-user/libvhost-user.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)

diff --git a/configure b/configure
index 0ce2c0354a..b13d4a8da7 100755
--- a/configure
+++ b/configure
@@ -6165,7 +6165,7 @@ fi

 tools=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools"
+  tools="qemu-img\$(EXESUF) qemu-vu\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49e3b0d319..7d7692734c 100644
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
+qos-test-obj-y += tests/vhost-user-blk-test.o
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


