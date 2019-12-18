Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD1B206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffmarJqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD1B206EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPvp-0000BC-Gm
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPrz-00042w-QA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPry-0002dn-Ld
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:27 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPry-0002cz-Fv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:26 -0500
Received: by mail-pg1-x542.google.com with SMTP id k197so435061pga.10
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Toe6+kf85085QGBznhMe/ZC3IHb6MH8qdiKw5XlMFI=;
 b=ffmarJqSOoWRRJ5Qixi6fN4Y6Fx0Lh9cOfGrdDRa0B2w/drHIBmGHpPU018P36NEx+
 LJDfFwiMk+GWmrjheD59oPdZ7/Erer1TPxuWR4SUtHwiiJX/ATSccpifVIOucGMQSeTz
 1m+BH7kq5AT33MXSEah3M+lnQu7ib6TFHb0SiAB5pahjKVTmKdLBkldDqX5dRNsBeJFl
 GBo2qZMSXttsKjpGixXbKYvkGvhkPtS2d9oLhIxeblfP+Xs/i8bOIBvzsgXGr1Od/Y7A
 jBS5cKBvJT10/ObOuCPMfF1XKAb4YalkR5BoFejcrq1JYLejccn1gQxGry3Gq65GnOpu
 D9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Toe6+kf85085QGBznhMe/ZC3IHb6MH8qdiKw5XlMFI=;
 b=adJ4oZE66NZ8XdKgNporQim6QVnvzuG6VjHnpdZmynOY0NyCbdTjUEimRFzQW5RJRi
 r21qAs/mRK9AiDfu2sJ7u8s1NW5x/Hrb3LLjFRPW2tSdgZCtVugjxh824yDt2v5UK8pi
 tbj/lH0BdjozTcA3eTO+dOoR7hwSt543NFEc8wsJGXyxKFwDI2B37L8RJp1uHPqIoTny
 RjIlJ/M2sIfQPjK6ZrhOd84+H0SVZYMJ6sf9qHdMXIXTNWSK5BPD30BVIashXNZtJtjr
 U70RR1x56daqGay2vYBzkM3WSIfD1aYtL86+PmD23bS89yMRWJYWlJWXuMp+d2fegMvl
 Z2WA==
X-Gm-Message-State: APjAAAW7UmhhQx7mgBMdgfrvF0NoNKkKPRI0WBA/De45n2T1js6xaIq4
 Cfisc4mZl+/76/Pp1fM7wuk8Fvpt8hg=
X-Google-Smtp-Source: APXvYqzyoVU80nkVM6viZDd7ZtB0p0SrBMZyumo1mlLO5ihNbChTPwBahQXi90mgQe5g8ujkMk/d1Q==
X-Received: by 2002:a63:4d5e:: with SMTP id n30mr288667pgl.275.1576639165011; 
 Tue, 17 Dec 2019 19:19:25 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] configure: Drop adjustment of textseg
Date: Tue, 17 Dec 2019 17:19:14 -1000
Message-Id: <20191218031920.6414-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adjustment was random and unnecessary.  The user mode
startup code in probe_guest_base() will choose a value for
guest_base that allows the host qemu binary to not conflict
with the guest binary.

With modern distributions, this isn't even used, as the default
is PIE, which does the same job in a more portable way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 47 -----------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/configure b/configure
index 84b413dbfc..255ac432af 100755
--- a/configure
+++ b/configure
@@ -6292,49 +6292,6 @@ if test "$cpu" = "s390x" ; then
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
@@ -7897,10 +7854,6 @@ if test "$gprof" = "yes" ; then
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


