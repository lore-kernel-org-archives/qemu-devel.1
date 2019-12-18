Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4402820717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hauNGhrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4402820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhx3-00052s-DS
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu7-0001TG-3T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu5-0003uP-9m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhu3-0003tP-Kw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:49 -0500
Received: by mail-pg1-x543.google.com with SMTP id x8so2020726pgk.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3CCNiOkBdotcPLlflc1t8sogIYTztDmOMbypR3M+57k=;
 b=hauNGhrJnf8EflRroccGva02uhxQK4nlyYK3/WZhLfdvOlUcO2wcF8qCNd3nDP/lJu
 eOVZk7maOwFKw8BRBLCfI/YQ8GmPVZI952/1Uvc8vGFMkVJb19tpo5nXHE5Q/kilYmsI
 X3U+hrOUlnCyxPLFoua5Bu54JJxF1z22+58WEruv9itdVSrlQ3otlf/t4mgzG13AyRHU
 6Sa2TVf5LV3NhyLcjJt9pqt7lkseyPmXmZyxSlt6lnaQa8ZU9azwnF8ekEtJemK7xr6S
 vNXf0uR4Esl4T/fTfHWYi8caFdf5x47Emh0CDMr0O5PRPeff9VPAlsajGfeTIvIvx6kz
 mNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3CCNiOkBdotcPLlflc1t8sogIYTztDmOMbypR3M+57k=;
 b=X2jpK1H1JvmtalQeYESPvoYZ5C14CpOt0yE2hV1iUH7GwC65p8O8l7n04iwqZdjhqe
 dxrDDt1P5nFvWbAVbYYE6JPR++0woBN4KuScNwwU8UoNcpINpWM3jOuhjDbLxIPtxKmo
 vJ9lz0TGGowzcnj1KiFhvHkW+AQNRFE9tz6t5vRqjKQPPIMUr0sxKs9DheV2ZnvkyG1k
 E2Qhq4W39y/bMbifvEVxlSlbYU2k0USEb+tGMxxq6s6Cv1hDSVyyX2C28OiblTTMV1+o
 xCpu1anzb+NSa/Hi7dSPxuKXQavruZ0IHmtGmXVroBaePbCAV5tYXSSRzDV2+PvTEC6a
 p6+w==
X-Gm-Message-State: APjAAAUfOExxcmsHD4cH9SrnRGJlNYUYOoRoEX19WaMgfAzu9Ls9gEvs
 cS7DH4pYthWIuk2aUk9eBSCrCQm8rgs=
X-Google-Smtp-Source: APXvYqz+ERz3/Du+bwWPQ8QF+fuu6WwO3qzMQXne32jDiZfpM/MK2KJpaaVkPzJQlMoQZNoOB383sg==
X-Received: by 2002:a65:4d0b:: with SMTP id i11mr5891442pgt.340.1576708486236; 
 Wed, 18 Dec 2019 14:34:46 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] configure: Drop adjustment of textseg
Date: Wed, 18 Dec 2019 12:34:35 -1000
Message-Id: <20191218223441.23852-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: philmd@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adjustment was random and unnecessary.  The user mode
startup code in probe_guest_base() will choose a value for
guest_base that allows the host qemu binary to not conflict
with the guest binary.

With modern distributions, this isn't even used, as the default
is PIE, which does the same job in a more portable way.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Remove mention of config-host.ld from make distclean
---
 Makefile  |  2 +-
 configure | 47 -----------------------------------------------
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/Makefile b/Makefile
index 1361def144..adf83f75a1 100644
--- a/Makefile
+++ b/Makefile
@@ -735,7 +735,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(M
 endef
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f config-host.mak config-host.h* $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
diff --git a/configure b/configure
index e0c66ee9b6..30e3875c6b 100755
--- a/configure
+++ b/configure
@@ -6298,49 +6298,6 @@ if test "$cpu" = "s390x" ; then
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
@@ -7903,10 +7860,6 @@ if test "$gprof" = "yes" ; then
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


