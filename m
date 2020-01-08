Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F5C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368532070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7W37y9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368532070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2MF-0000HG-Sw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hp-0002wk-5A
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hn-0002QT-O5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:37 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Hn-0002LI-HE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:35 -0500
Received: by mail-pl1-x643.google.com with SMTP id b22so530498pls.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jtgRZgZU54ZLuu3kEDdlzDMYHm/i2EeM+6uTqSYqeAM=;
 b=X7W37y9vlnV4c7BjI4B3+DffP3yKnI0Cw+BBxEV6/EbqLgyFMehs+p+Ht+9CO5CnhL
 GRuTlRyJHH5plU/ZYLSJ83l1V1iyrgXdGLVdDsDHUieVZt65g0H1ugi1sWkWlRw8TY/v
 5opLBTvboe7ZEROYC+hL2gLAJ3rhT22fN2he4CcHnIpY1dIQRVnIKoVdj/jLc9GEKhhh
 WwiHuO//75aBSrjJzgszYiL4O6vS6Tg/zlnE3sFFoNZ5xlSwbcTeZIG9sxhCZ9U9waA6
 0m1Rbe1izPb4qn2nj248PuHkGxoLRYn3dd+78Q037OGIXvJdFG35zOEm1VkOBep4RDSj
 Mqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jtgRZgZU54ZLuu3kEDdlzDMYHm/i2EeM+6uTqSYqeAM=;
 b=LR9AhxKVXV6NqOiYvGC8KCNGMer8aWIiUQiaTDNIp1Uyljfehr/l4ar5JZSQBDKe9s
 1phjxArgX0wyRs6DOwCC+S590i+7UH0v7vnqC7CJUj0jsjvaADhkOmb/NnuXCV431MNA
 OjLaYV0MPyXwRbynmUTP1tfMq0dcs+X6zzlZyUrT2BjvneCyNvQVPMk3A4MP7m9qvK3t
 SwNJT3FtxBG/fiGHL8kPtXPMSX0hcD0uS/lH+6oVkQ16HXL3Pr7OKlgWlogTn55o3G7r
 oDDRgQM0a5iPd139WKDjo7RJYBvmA80APfG1wemsQ3qHSAxMA03KRSxsInoM4GigdXRb
 QB7g==
X-Gm-Message-State: APjAAAWjELDUeM0frB2YU40nzmb6WM13JUakabc+Zwooxq40FONNIgvj
 co4srVjCd2osbmXMTFlX4Q6jhlj6vq/HKQ==
X-Google-Smtp-Source: APXvYqzRNEkSn6bexZn21prKTpz8mp/KHqWw4ZeBz4p6C2H2iS5cj/gpmDcKvw+5SBfNqxUmrbPSCA==
X-Received: by 2002:a17:90a:d995:: with SMTP id
 d21mr2145032pjv.118.1578455131072; 
 Tue, 07 Jan 2020 19:45:31 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] configure: Drop adjustment of textseg
Date: Wed,  8 Jan 2020 14:44:43 +1100
Message-Id: <20200108034523.17349-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adjustment was random and unnecessary.  The user mode
startup code in probe_guest_base() will choose a value for
guest_base that allows the host qemu binary to not conflict
with the guest binary.

With modern distributions, this isn't even used, as the default
is PIE, which does the same job in a more portable way.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Remove mention of config-host.ld from make distclean
---
 Makefile  |  2 +-
 configure | 47 -----------------------------------------------
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/Makefile b/Makefile
index 6b5ad1121b..95809ec455 100644
--- a/Makefile
+++ b/Makefile
@@ -727,7 +727,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(M
 endef
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
diff --git a/configure b/configure
index 0ce2c0354a..0f365bfdf1 100755
--- a/configure
+++ b/configure
@@ -6308,49 +6308,6 @@ if test "$cpu" = "s390x" ; then
   fi
 fi
 
-# Probe for the need for relocating the user-only binary.
-if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
-  textseg_addr=
-  case "$cpu" in
-    arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
-      # ??? Rationale for choosing this address
-      textseg_addr=0x60000000
-      ;;
-    mips)
-      # A 256M aligned address, high in the address space, with enough
-      # room for the code_gen_buffer above it before the stack.
-      textseg_addr=0x60000000
-      ;;
-  esac
-  if [ -n "$textseg_addr" ]; then
-    cat > $TMPC <<EOF
-    int main(void) { return 0; }
-EOF
-    textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
-    if ! compile_prog "" "$textseg_ldflags"; then
-      # In case ld does not support -Ttext-segment, edit the default linker
-      # script via sed to set the .text start addr.  This is needed on FreeBSD
-      # at least.
-      if ! $ld --verbose >/dev/null 2>&1; then
-        error_exit \
-            "We need to link the QEMU user mode binaries at a" \
-            "specific text address. Unfortunately your linker" \
-            "doesn't support either the -Ttext-segment option or" \
-            "printing the default linker script with --verbose." \
-            "If you don't want the user mode binaries, pass the" \
-            "--disable-user option to configure."
-      fi
-
-      $ld --verbose | sed \
-        -e '1,/==================================================/d' \
-        -e '/==================================================/,$d' \
-        -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
-        -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
-      textseg_ldflags="-Wl,-T../config-host.ld"
-    fi
-  fi
-fi
-
 # Check that the C++ compiler exists and works with the C compiler.
 # All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end to don't miss any other that could be added.
 if has $cxx; then
@@ -7905,10 +7862,6 @@ if test "$gprof" = "yes" ; then
   fi
 fi
 
-if test "$target_linux_user" = "yes" || test "$target_bsd_user" = "yes" ; then
-  ldflags="$ldflags $textseg_ldflags"
-fi
-
 # Newer kernels on s390 check for an S390_PGSTE program header and
 # enable the pgste page table extensions in that case. This makes
 # the vm.allocate_pgste sysctl unnecessary. We enable this program
-- 
2.20.1


