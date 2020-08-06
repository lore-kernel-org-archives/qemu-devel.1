Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F00DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA37221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBPhX3S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA37221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lWf-0006KP-43
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNi-0003cw-8W
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNe-0006N8-Ke
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EYh1VwOFtefpbZysAsfDv7kNCI+3BEtJ+RUW3VlNc0=;
 b=JBPhX3S6mYNTQpzvegCsNi/+BI3kPq+3J9TmCbrpIXvgMzeWFfn54xZpoI4unTSZzbT8fD
 c0JeJRqUIxpQdfuplxEcyuXJWfFxzu6p7JLYX1vb7DF6NGu/zLdvXKboGT1+xan5LQ/huW
 CbWZN2eNqLpEFEfM8dxGjxuoxKj0zec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Lnu4UIG1Meq_Kqrx50fYmQ-1; Thu, 06 Aug 2020 15:16:44 -0400
X-MC-Unique: Lnu4UIG1Meq_Kqrx50fYmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F73919200C0
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:43 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40AA41D3;
 Thu,  6 Aug 2020 19:16:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 010/143] configure: expand path variables for meson configure
Date: Thu,  6 Aug 2020 21:14:06 +0200
Message-Id: <1596741379-12902-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index c4843f9..29cde6a 100755
--- a/configure
+++ b/configure
@@ -415,16 +415,7 @@ LDFLAGS_SHARED="-shared"
 modules="no"
 module_upgrades="no"
 prefix="/usr/local"
-mandir="\${prefix}/share/man"
-datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
-qemu_docdir="\${prefix}/share/doc/qemu"
-bindir="\${prefix}/bin"
-libdir="\${prefix}/lib"
-libexecdir="\${prefix}/libexec"
-includedir="\${prefix}/include"
-sysconfdir="\${prefix}/etc"
-local_statedir="\${prefix}/var"
 confsuffix="/qemu"
 slirp=""
 oss_lib=""
@@ -979,12 +970,6 @@ if test "$mingw32" = "yes" ; then
     LIBS="-liberty $LIBS"
   fi
   prefix="c:/Program Files/QEMU"
-  mandir="\${prefix}"
-  datadir="\${prefix}"
-  qemu_docdir="\${prefix}"
-  bindir="\${prefix}"
-  sysconfdir="\${prefix}"
-  local_statedir=
   confsuffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
@@ -1638,6 +1623,26 @@ for opt do
   esac
 done
 
+libdir="${libdir:-$prefix/lib}"
+libexecdir="${libexecdir:-$prefix/libexec}"
+includedir="${includedir:-$prefix/include}"
+
+if test "$mingw32" = "yes" ; then
+    mandir="$prefix"
+    datadir="$prefix"
+    qemu_docdir="$prefix"
+    bindir="$prefix"
+    sysconfdir="$prefix"
+    local_statedir=
+else
+    mandir="${mandir:-$prefix/share/man}"
+    datadir="${datadir:-$prefix/share}"
+    qemu_docdir="${qemu_docdir:-$prefix/share/doc/qemu}"
+    bindir="${bindir:-$prefix/bin}"
+    sysconfdir="${sysconfdir:-$prefix/etc}"
+    local_statedir="${local_statedir:-$prefix/var}"
+fi
+
 case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
-- 
1.8.3.1



