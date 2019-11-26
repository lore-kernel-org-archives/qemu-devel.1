Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F149C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394A82071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+YYczk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394A82071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXuj-0007pK-NE
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsF-0005fI-0P
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXnS-0003hD-A7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:10:15 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXnS-0003h1-4R
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:10:14 -0500
Received: by mail-pf1-x444.google.com with SMTP id d199so4300163pfd.11
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ecShvr+Zq6STOGx1l0iQ8cCvKv5lb6vZ/WjknM9nD6E=;
 b=d+YYczk4lJH43WHRgPgABeQW5AYRNcl7DJRbNi1c4p2WWFqkvolmM2XsQ44czI+mWp
 aVmIt6CW9B+7OpTNN+ps0zReed0nBfjwq9pklcNZKWKoIW7k1EQMTOHSi4d0/BCnYQee
 jinDCFwA6wNeZ4cBOG9cHPVSHcKoTCX0NlPdmJVevRHmMaf97cZDvXxtiWam3BPVOLr9
 RFEZ0ncycDTNPn5Urku5wMT1KOZ8+LKL42IakRmapDH1VNSLE/H9DD99CM6pQ9LMRigI
 y0T8KiZRlGegkVpLl3zTTtrATMEXAozU32i+jHRlYa3drVFQX+N2oBh6kWr44Z3T2zcB
 SEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ecShvr+Zq6STOGx1l0iQ8cCvKv5lb6vZ/WjknM9nD6E=;
 b=TFf6pK10DpKosKiGxAK8zr2zUVHP+uX5CVQrG7VdJMIvZOtNEp2cZ5eZuHUGCTqyrl
 p49kFtuYE3vw/pJoS1QNPA1FkGYIRart+L3fzxXzDgy/OLSHwYDM/QQzV0QIaAvEdLY6
 1C2eymSssoJYv6AUwv6NXOi6VtiDz4t5QRA0tGsK4rKTmoPFWhaLCRnQFu71OrqXjRZD
 13RHvTvVrfKFU65rmmmnGdrA4BeJTAS3uAb0oovo8AG4GkIBT1Yad3XAFsrGErcrxok1
 sjehMOnMlok1nwZl9rhEPkv1K1giinvEj6I5vqyUToyUicYjKtWaSKr9Al4mEtJNIjx8
 yYdg==
X-Gm-Message-State: APjAAAVLZkEz3vWM+4fiu+AeDTA/GckHdJ6Wo3yJ/B/Or6nMuO0WTNca
 ePA8/XREUZyKZzTUbAnRCLk=
X-Google-Smtp-Source: APXvYqxLnUahtpS2ezzELlW12TWhqW19OSB0jtp9PSXtwd5yFTcnaRJ86M926/WsXnNPNpvBgZKE9Q==
X-Received: by 2002:a63:e4a:: with SMTP id 10mr35864959pgo.121.1574763013362; 
 Tue, 26 Nov 2019 02:10:13 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id h9sm12059065pgk.84.2019.11.26.02.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:10:12 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC 1/3] configure: add libbpf support
Date: Tue, 26 Nov 2019 19:09:12 +0900
Message-Id: <20191126100914.5150-2-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100914.5150-1-prashantbhole.linux@gmail.com>
References: <20191126100914.5150-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a preparation to add libbpf support for Qemu. When it is
enabled Qemu can load eBPF programs and manipulated eBPF maps
libbpf APIs.

When configured with --enable-libbpf, availability of libbpf is
checked. If it exists then CONFIG_LIBBPF is defined and the qemu
binary is linked with libbpf.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 configure | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/configure b/configure
index 6099be1d84..a7e8a8450d 100755
--- a/configure
+++ b/configure
@@ -504,6 +504,7 @@ debug_mutex="no"
 libpmem=""
 default_devices="yes"
 plugins="no"
+libbpf="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1539,6 +1540,8 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
+  --enable-libbpf) libbpf="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1825,6 +1828,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  libbpf      eBPF program support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6084,6 +6088,19 @@ case "$slirp" in
     ;;
 esac
 
+##########################################
+# Do we have libbpf
+if test "$libbpf" != "no" ; then
+  if $pkg_config libbpf; then
+    libbpf="yes"
+    libbpf_libs=$($pkg_config --libs libbpf)
+  else
+    if test "$libbpf" == "yes" ; then
+      feature_not_found "libbpf" "Install libbpf devel"
+    fi
+    libbpf="no"
+  fi
+fi
 
 ##########################################
 # End of CC checks
@@ -6599,6 +6616,7 @@ echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
+echo "XDP offload support $libbpf"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7457,6 +7475,11 @@ if test "$plugins" = "yes" ; then
     fi
 fi
 
+if test "$libbpf" = "yes" ; then
+  echo "CONFIG_LIBBPF=y" >> $config_host_mak
+  echo "LIBBPF_LIBS=$libbpf_libs" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.20.1


