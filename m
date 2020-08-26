Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F17C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0460B2087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfwjtUMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0460B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtIa-0002NQ-3t
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtGX-0006l5-2t
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:06:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39096
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtEa-00038h-LI
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FwKynu//NYHMVvyqf9/IcST7xvNIQRYBCR5V/7Gzkw=;
 b=YfwjtUMZs02UgAXaN3tpsN6HUVLObvPRsy19QwzrvzfQK/JCET3BWA1zQxVKa1cj1LV5xO
 4wkUQx/eLKEsZmyM8x3/5R/5Ym7+HvjU5U8EJzaF/lGCF/5YYqgDH8nC1v5riwNhVaCzC5
 Poo5ZeK2mgqs9UOO7C46giPdYflCL9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-AE5IZg8rN_eMpfmoqB_Nfw-1; Wed, 26 Aug 2020 07:04:49 -0400
X-MC-Unique: AE5IZg8rN_eMpfmoqB_Nfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF8AF10ABDBA;
 Wed, 26 Aug 2020 11:04:48 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C314C1944D;
 Wed, 26 Aug 2020 11:04:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] configure: build docdir like other suffixed directories
Date: Wed, 26 Aug 2020 15:04:14 +0400
Message-Id: <20200826110419.528931-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
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

As documented in --help for --docdir.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 61216b9210..e880e5676d 100755
--- a/configure
+++ b/configure
@@ -1676,14 +1676,14 @@ includedir="${includedir:-$prefix/include}"
 if test "$mingw32" = "yes" ; then
     mandir="$prefix"
     datadir="$prefix"
-    qemu_docdir="$prefix"
+    docdir="$prefix"
     bindir="$prefix"
     sysconfdir="$prefix"
     local_statedir=
 else
     mandir="${mandir:-$prefix/share/man}"
     datadir="${datadir:-$prefix/share}"
-    qemu_docdir="${qemu_docdir:-$prefix/share/doc/qemu}"
+    docdir="${docdir:-$prefix/share/doc}"
     bindir="${bindir:-$prefix/bin}"
     sysconfdir="${sysconfdir:-$prefix/etc}"
     local_statedir="${local_statedir:-$prefix/var}"
@@ -1832,7 +1832,7 @@ Advanced options (experts only):
   --localstatedir=PATH     install local state in PATH (set at runtime on win32)
   --firmwarepath=PATH      search PATH for firmware files
   --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
-  --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir [$qemu_suffix]
+  --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir/docdir [$qemu_suffix]
   --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
@@ -6470,6 +6470,7 @@ fi
 qemu_confdir="$sysconfdir/$qemu_suffix"
 qemu_moddir="$libdir/$qemu_suffix"
 qemu_datadir="$datadir/$qemu_suffix"
+qemu_docdir="$docdir/$qemu_suffix"
 qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
-- 
2.26.2


