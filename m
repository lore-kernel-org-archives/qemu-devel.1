Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24422C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9AF20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsQMx7aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9AF20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJz8k-0002ye-NN
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3p-00069Q-Nc
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58739
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-00017W-IE
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koaF4vwiRiino+Myf2s8wiU10e0a3K3aFmR+6h0MKKE=;
 b=dsQMx7aQRj/o8qOIJeN6IZ78lRDoHZ4xsIjRAtXGNUZqDaPCcIs7riVQxnXHjxizwBTXge
 IuHBC+qkBkWm5OmZNzXpWd7IPXFZcrB9KUZZ13ldJLi8IjMyKrhDwtifR/UVYEr5dMQHrA
 o5BUECM4U7AXFNkm+AcQU2ceHQHhVtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292--buYI9DbMEe7b07riSuL2Q-1; Sun, 20 Sep 2020 09:07:11 -0400
X-MC-Unique: -buYI9DbMEe7b07riSuL2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6011556B56
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F03160C47
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/9] configure: rewrite accelerator defaults as tests
Date: Sun, 20 Sep 2020 09:07:02 -0400
Message-Id: <20200920130708.1156310-4-pbonzini@redhat.com>
In-Reply-To: <20200920130708.1156310-1-pbonzini@redhat.com>
References: <20200920130708.1156310-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:07:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prepare to process "auto" in meson rather than configure: localize the
code that changes "auto" to enabled/disabled, it will be moved to meson
and removed from configure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index ade456b7af..00348c2342 100755
--- a/configure
+++ b/configure
@@ -420,7 +420,7 @@ vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
 vhost_user_fs=""
-kvm="disabled"
+kvm="auto"
 hax="disabled"
 hvf="disabled"
 whpx="disabled"
@@ -814,7 +814,6 @@ HOST_VARIANT_DIR=""
 case $targetos in
 MINGW32*)
   mingw32="yes"
-  hax="enabled"
   whpx="auto"
   vhost_user="no"
   audio_possible_drivers="dsound sdl"
@@ -849,7 +848,6 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
-  hax="enabled"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
@@ -866,7 +864,6 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
-  hax="enabled"
   hvf="auto"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
@@ -903,7 +900,6 @@ Linux)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-  kvm="enabled"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
 ;;
 esac
@@ -2664,6 +2660,28 @@ if test "$seccomp" != "no" ; then
         seccomp="no"
     fi
 fi
+
+##########################################
+# simple accelerator probes
+
+if test "$kvm" = "auto" ; then
+  if test "$linux" = yes ; then
+    kvm=enabled
+  else
+    if test "$kvm" = "enabled" ; then
+      feature_not_found "kvm" "KVM is only available on Linux"
+    fi
+  fi
+fi
+
+if test "$hax" = "auto" ; then
+  if test "$mingw" = yes || test "$darwin" = yes || test "$targetos" = NetBSD; then
+    hax=enabled
+  else
+    hax=disabled
+  fi
+fi
+
 ##########################################
 # xen probe
 
-- 
2.26.2



