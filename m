Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A004AC3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A5D22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A5D22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UdR-0001Cl-G1
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPN-0006N6-DU
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPM-00053p-7r
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPM-000537-2V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C85A308FB9A
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:27 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A583360F88
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:10 +0200
Message-Id: <1566408501-48680-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 21 Aug 2019 17:28:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/13] configure: define CONFIG_TOOLS here
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

Defining CONFIG_TOOLS on the basis of $(TOOLS) has the disadvantage
of including it also if e.g. qemu-ga is requested.  The correct
information is available in configure, define it there.

This also has the benefit of not installing the manpages for block layer
tools if the only "tool" being built is the guest agent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 5 ++---
 configure | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 00825cd..574fede 100644
--- a/Makefile
+++ b/Makefile
@@ -84,8 +84,7 @@ endif
 
 include $(SRC_PATH)/rules.mak
 
-# notempy and lor are defined in rules.mak
-CONFIG_TOOLS := $(call notempty,$(TOOLS))
+# lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
 # Create QEMU_PKGVERSION and FULL_VERSION strings
@@ -809,7 +808,7 @@ ifdef CONFIG_POSIX
 	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-block-drivers.7 "$(DESTDIR)$(mandir)/man7"
 	$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
-ifneq ($(TOOLS),)
+ifeq ($(CONFIG_TOOLS),y)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
diff --git a/configure b/configure
index e96981b..b7f4283 100755
--- a/configure
+++ b/configure
@@ -6617,6 +6617,9 @@ fi
 if test "$profiler" = "yes" ; then
   echo "CONFIG_PROFILER=y" >> $config_host_mak
 fi
+if test "$want_tools" = "yes" ; then
+  echo "CONFIG_TOOLS=y" >> $config_host_mak
+fi
 if test "$slirp" != "no"; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
-- 
1.8.3.1



