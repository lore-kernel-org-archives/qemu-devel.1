Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C835C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C9C2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yea+hGhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C9C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtHL-0008HV-7y
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtGR-0006et-NQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:06:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtEV-00038N-6d
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEQk/7b4iuk15wbAGxtyI0iAv4L+NwU0U/kEhBXITRM=;
 b=Yea+hGhZMyzs+m5RBX6tGP258TEPHClqB3LeKJIdYbN52ZC+XW1pwxnUSXiMGF/o/A4swq
 NeUnqkIyr2lHwIhUeN2l/1DGfc0Uje82f+FMNn3GWOSrR7XIFx5yr6eAPF5SkY+VBTNq5z
 58AthdBVjSkh8PUkt4IP9FQqjWPIjHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-f7akZ9LFNoecRrzRpqeSwA-1; Wed, 26 Aug 2020 07:04:41 -0400
X-MC-Unique: f7akZ9LFNoecRrzRpqeSwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EAF3807334;
 Wed, 26 Aug 2020 11:04:40 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD5A1972A;
 Wed, 26 Aug 2020 11:04:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] configure: always /-seperate directory from qemu_suffix
Date: Wed, 26 Aug 2020 15:04:13 +0400
Message-Id: <20200826110419.528931-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Otherwise, we may accept very strange directory names...

While at it, quote the variables.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 0e04c47722..61216b9210 100755
--- a/configure
+++ b/configure
@@ -474,7 +474,7 @@ modules="no"
 module_upgrades="no"
 prefix="/usr/local"
 firmwarepath="\${prefix}/share/qemu-firmware"
-qemu_suffix="/qemu"
+qemu_suffix="qemu"
 slirp=""
 oss_lib=""
 bsd="no"
@@ -1823,12 +1823,12 @@ Advanced options (experts only):
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
   --mandir=PATH            install man pages in PATH
-  --datadir=PATH           install firmware in PATH$qemu_suffix
-  --docdir=PATH            install documentation in PATH$qemu_suffix
+  --datadir=PATH           install firmware in PATH/$qemu_suffix
+  --docdir=PATH            install documentation in PATH/$qemu_suffix
   --bindir=PATH            install binaries in PATH
   --libdir=PATH            install libraries in PATH
   --libexecdir=PATH        install helper binaries in PATH
-  --sysconfdir=PATH        install config in PATH$qemu_suffix
+  --sysconfdir=PATH        install config in PATH/$qemu_suffix
   --localstatedir=PATH     install local state in PATH (set at runtime on win32)
   --firmwarepath=PATH      search PATH for firmware files
   --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
@@ -6467,9 +6467,9 @@ EOF
     fi
 fi
 
-qemu_confdir=$sysconfdir$qemu_suffix
-qemu_moddir=$libdir$qemu_suffix
-qemu_datadir=$datadir$qemu_suffix
+qemu_confdir="$sysconfdir/$qemu_suffix"
+qemu_moddir="$libdir/$qemu_suffix"
+qemu_datadir="$datadir/$qemu_suffix"
 qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
-- 
2.26.2


