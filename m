Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB48220825
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4qcwZVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB48220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BPe-0001OK-TE
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIu-000607-BU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BIr-0002kg-Al
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1N4ofAFt8gge/A1hpgmW713jHeM+0oHS9zGyfXW/vA=;
 b=C4qcwZVBIlu5drWRhTIoym6oRd0ZcD7Yja7pcOdhq6BMJ2ku5eC9lKJ+j7oBEQamcpNCJs
 MYyAvvapHe/YXz19fAvaKReovzcowMmBZOqGzmCwJGjniZRc4knr5fTVD2Nz78ulgo/31v
 qe2pASYFwORlTs9rJjLIoWHCdlY7M9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-0UyTpUyYPCi9KBP5bNT_0A-1; Mon, 10 Aug 2020 13:09:38 -0400
X-MC-Unique: 0UyTpUyYPCi9KBP5bNT_0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27A4B80BCAB
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:38 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 693645F1E9;
 Mon, 10 Aug 2020 17:09:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 016/147] configure: generate Meson cross file
Date: Mon, 10 Aug 2020 19:06:54 +0200
Message-Id: <1597079345-42801-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:11:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/configure b/configure
index ad5bd1a..f38c783 100755
--- a/configure
+++ b/configure
@@ -8582,6 +8582,49 @@ echo "# Automatically generated by configure - do not modify" > "$iotests_common
 echo >> "$iotests_common_env"
 echo "export PYTHON='$python'" >> "$iotests_common_env"
 
+cross="config-meson.cross"
+cross_arg=
+
+if test -n "$cross_prefix"; then
+    echo "# Automatically generated by configure - do not modify" > $cross
+    echo "[binaries]" >> $cross
+    echo "c = '$cc'" >> $cross
+    echo "cpp = '$cxx'" >> $cross
+    echo "ar = '$ar'" >> $cross
+    echo "nm = '$nm'" >> $cross
+    echo "pkgconfig = '$pkg_config_exe'" >> $cross
+    echo "ranlib = '$ranlib'" >> $cross
+    echo "strip = '$strip'" >> $cross
+    echo "windres = '$windres'" >> $cross
+
+    echo "[properties]" >> $cross
+    echo "root = '$prefix'" >> $cross
+
+    echo "[host_machine]" >> $cross
+if test "$mingw32" = "yes" ; then
+    echo "system = 'windows'" >> $cross
+fi
+case "$ARCH" in
+    i386|x86_64)
+        echo "cpu_family = 'x86'" >> $cross
+        ;;
+    ppc64le)
+        echo "cpu_family = 'ppc64'" >> $cross
+        ;;
+    *)
+        echo "cpu_family = '$ARCH'" >> $cross
+        ;;
+esac
+    echo "cpu = '$cpu'" >> $cross
+if test "$bigendian" = "yes" ; then
+    echo "endian = 'big'" >> $cross
+else
+    echo "endian = 'little'" >> $cross
+fi
+
+    cross_arg="--cross-file=$cross"
+fi
+
 rm -rf meson-private/ meson-logs/ meson-info/
 NINJA=$PWD/ninjatool $meson setup \
         --prefix "$prefix" \
@@ -8597,11 +8640,13 @@ NINJA=$PWD/ninjatool $meson setup \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
+        $cross_arg \
         "$PWD" "$source_path"
 
 if test "$?" -ne 0 ; then
     error_exit "meson setup failed"
 fi
+touch ninjatool.stamp
 
 # Save the configure command line for later reuse.
 cat <<EOD >config.status
-- 
1.8.3.1



