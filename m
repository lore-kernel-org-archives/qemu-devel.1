Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6301C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D8722527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkMIC2af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D8722527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNzZ-0004hq-Oh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxp-0002ed-SB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxo-0005gA-QV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxo-0005dv-K2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id w15so2623900wru.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PH7UeOYv3AaEAyoiruUKVOCR4GfXDd27Kf2Yko972zU=;
 b=KkMIC2afPP7er6EMMZVmh7Mm86Qtdyw8GEd/41txIwD7nn9x/dB1QUeGqWGbHp+MLN
 s7gp7Jatu7QKuQNt2ZffEYzL7F/Wr8Pi71AtVx7T+juYAhsADEvF3V5npmyglKEc4Xuh
 cL9XSclfrpql+S9GJhjKFLcagHReZlMa8A9E7YPtM630FBkSeiZ6R4RXcK/+XdL9pCVy
 yqzq0ketLYYWjaEu00Hd0X5FSeklMjUcMFsDvNiJZBdUuQlKAW4EOXnGGx4Ivm47GC3o
 +yqmBudMf8uf65XUjUcxShzHM5qzlpCPir0KefHrVtabxTrLevk6G3SG/Xl3igHD1qR2
 GxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PH7UeOYv3AaEAyoiruUKVOCR4GfXDd27Kf2Yko972zU=;
 b=TpAV7HRQOeotKG7dFf9NyCt+yssM+pvJDRgGQPNCj80/msiqFpSis0/xGSju8Oc/X4
 LmYehGgT97SxGSqtXZbmHaOrdj7trTfpPtBan+jbONSvg1/QboHY5PsyYUT8IbbVg0QO
 Y1ip2kHjhBcRMR9dkkjTthJg+10MYhNyBoWfNVdRF1o7gxiyVSCxK646gbvw+pzovNVf
 wxa5D1dWn8jrAQymH9brPOMf7umzBPadmC/YMcG55czY+PSrBIqr8Rj/S9nBZnPBA/xR
 U3afetDonVinOJtR27qqCQR4oj1OBYtwkPnzwjidf1s02Q60xnfO9nTciQOYPwg/wbKk
 JW2w==
X-Gm-Message-State: APjAAAXd6fyEB4OLXKTjylpWzJqbCyFtfh+fE0854oL6R79rVLTZfOBK
 aXH5NBEqVPlb3+hK/Ng7nG7yAqps
X-Google-Smtp-Source: APXvYqzQu8+Il+Ac4szdLi8B0eAEAuG3hk8OVneswrjBIe5KT8NhmTsfpdJJRvVrAvC7t/ZYfqVdiA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr5699975wrm.139.1576155183211; 
 Thu, 12 Dec 2019 04:53:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 005/132] configure: generate Meson cross file
Date: Thu, 12 Dec 2019 13:50:49 +0100
Message-Id: <1576155176-2464-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/configure b/configure
index 3e3eb3d..2f3e231 100755
--- a/configure
+++ b/configure
@@ -7852,6 +7852,46 @@ echo "# Automatically generated by configure - do not modify" > "$iotests_common
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
 rm -rf meson-private meson-info meson-logs
 NINJA=$PWD/ninjatool $python $meson setup \
 	--prefix "$prefix" \
@@ -7865,6 +7905,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
 	--localstatedir "$local_statedir" \
 	$(test "$strip_opt" = yes && echo --strip) \
 	--buildtype $(if test "$debug" = yes; then echo debug; else echo debugoptimized; fi) \
+        $cross_arg \
 	"$PWD" "$source_path"
 
 if test "$?" -ne 0 ; then
-- 
1.8.3.1



