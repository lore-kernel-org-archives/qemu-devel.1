Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F225B22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3J/P87R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F225B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOVy-0005N7-Jg
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyT-0003hR-Tk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyS-0006xk-Hp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:45 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyS-0006wK-Aj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:44 -0500
Received: by mail-wr1-x434.google.com with SMTP id y17so2620744wrh.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=ei8jF5qbLXtxjPutgGE6w3tCMlOPMMGLFJnXJVitOgM=;
 b=Q3J/P87RQrRQT0gwuP73e3d6gPpUVFWFPTVD7xYBqKslxJdKtovNRu/jMBDfG5WSF7
 dlC+97cGJ3LiKpp41/XYqAXTpVLtOLpx3TcWEalezy5escQKBqTwzNfAYvez3QZmdA15
 ut7LYqjX+ZCRMOIC1DUOcD7Drd4uWT4chqg7gaP/Bs1vKFqUV77emvZ7MMJzsl+uKpnt
 7qt8UfFfx9KpEUFlPeWRL/Ok/kNhP/jQjZFZEFqPYsgk6D2IYnRG0sse8psi1CzFFCxe
 /qmeY+v/WRzb6oBxBzo4sXna3vQjKQcqVkJS9zUFYop2WLP3kWz1HD+rpp8TeH4HzRVN
 zHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=ei8jF5qbLXtxjPutgGE6w3tCMlOPMMGLFJnXJVitOgM=;
 b=IfRPZYGI99ZgB3kNy1d+iuLOqdfy45C0iflTB7IHSRS92COWYwNjmoPY66N3rKZxbG
 lHoWEMvEgB/burqzl8kzq/Ya3d+QH2HoLeDA1zk9e6zHaQzIXMs/XUpH0wj1avddLE9C
 nFe4AvZuciK5TuoFjnVdeyi0dhQX/xMkPC0Na4mFIokekRRaeFjKCQzJAWrl8DVOexsq
 inQvNY1CoGnGMQSmW/+bDocZniw81rfi7Pcs+3uBMuLOvEJ/WCu40pwVAYHefLdy99bl
 BIvNXz3sqwVX6IaQKm00xMHMpiX9EZLgbEJt1Jm9UNvyAVQeYuEunVifYjDQZQU4eW78
 DYVQ==
X-Gm-Message-State: APjAAAXkXBdVfGxElAcEzS9xOiy27mFo8R1ulrvJGXyr92Fb2iAdy9mX
 JFSuzFj7Jesz3VNNuQbTuYESjVcN
X-Google-Smtp-Source: APXvYqwFvqYOVlix7yxNuYba5MNm/+VTeLW1tOPDbJgqJl0JlkZ4VDBYgddM+cE2JSTv3PPeyoMXUw==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr6156062wru.344.1576155223173; 
 Thu, 12 Dec 2019 04:53:43 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 045/132] configure, Makefile;
 remove TOOLS and HELPERS-y variable
Date: Thu, 12 Dec 2019 13:51:29 +0100
Message-Id: <1576155176-2464-46-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

Everything involving tools is now done by meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 12 ++----------
 configure |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 0cbdc34..c4cfca9 100644
--- a/Makefile
+++ b/Makefile
@@ -113,8 +113,6 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-y =
-
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
@@ -143,7 +141,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
 TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
@@ -246,7 +244,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
+	rm -f TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
@@ -407,12 +405,6 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
-ifneq ($(TOOLS),)
-	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
-endif
-ifneq ($(HELPERS-y),)
-	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
-endif
 ifneq ($(vhost-user-json-y),)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/vhost-user/"
 	for x in $(vhost-user-json-y); do \
diff --git a/configure b/configure
index 4757e45..658b062 100755
--- a/configure
+++ b/configure
@@ -6042,7 +6042,6 @@ if [ "$eventfd" = "yes" ]; then
   ivshmem=yes
 fi
 
-tools=""
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
@@ -7271,7 +7270,6 @@ else
 fi
 QEMU_INCLUDES="-iquote ${source_path}/tcg $QEMU_INCLUDES"
 
-echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "INSTALL=$install" >> $config_host_mak
-- 
1.8.3.1



