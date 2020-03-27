Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED334C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C0A2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCDtsAJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C0A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHx7X-000632-Si
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx55-0003BY-SH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx54-0000GY-M4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:03:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx54-0000DM-GN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:03:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id d17so5243552pgo.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y0Khsh6UQLm4SSnMSPV2VuzsbkNKE7igcenjK3oMio8=;
 b=kCDtsAJoGFSOUFY9lAEXvEM4fSsCch7Hx+ApDoq+Xdv+o+cFwGCqk8oNAV1u70exk1
 OcJQ3hQbBqoyw/zZJy57tf1e9OrnGzbso8Rh3P+bGuMEpvx2roKEzRewoFeRLHAEJgqm
 SxdPzQlu0ZfSh7VbBGMDtUbqYgah202fhyS62CeROp8l/dBHtka42doOO6sKZgPJS9gV
 WjmcIFdsli9sRfnqChX0s8ycZZKo1g7mB1WAb1/EKbVU8ZVqHK70/MbvdxKoFq5jSR4d
 14uDSWZ/7eD9RQNNAyaF3Ro27Rehxflvcz0ZX6lgQZCVSiUsZMNMPS2590wB9a7LWLXQ
 17iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y0Khsh6UQLm4SSnMSPV2VuzsbkNKE7igcenjK3oMio8=;
 b=m4WHrUFDeWvHyD1vUbzQsICMSwmqve8NA5ItOKAktfKvLGdr/miO2xdPMlIoBiwfmm
 5Mxl8hdYzvnjFMKJz/XHm80cYoR+5KnOvLHjgNHWW+C4ix5XuEnUVOWRTCRS4BZE+BJq
 gF171eDLEj8wLTVeWmsAHL8wltrkESV/cozc4K4Yc/AtL68trqpdryiO6UhVcH9T+XH/
 TuUGwWt9eshSjha00F6MltxTYU4jmGbyQrkEQfB5s7MKMzaVCi05VphxEVHm1dNgSzO5
 DXwVxYFULu5spYW9zJEgZ9vMHvisa9OaEeb1n/Ld8oCIKRcWhktPnj46oEt84UuuaMvf
 hLjA==
X-Gm-Message-State: ANhLgQ1LQJF3CGMa2iKWWXZaH222B7Av6PfuFIeT85QWmOAQS/GFVn41
 7RTGu5wJXVlvrMvqh2csIrOHhSiw3YU=
X-Google-Smtp-Source: ADFU+vuT//rKPg2fu0uEwd2siuQkQo34heKGqlxAc4SGr5vNfHiOKmcRFVEUuMfXhpB+3qDnsrRjLg==
X-Received: by 2002:a62:fcc7:: with SMTP id e190mr1345817pfh.285.1585346637131; 
 Fri, 27 Mar 2020 15:03:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:03:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 1/7] configure: Drop adjustment of textseg
Date: Fri, 27 Mar 2020 15:03:47 -0700
Message-Id: <20200327220353.27233-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: dim@FreeBSD.org, Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 roger.pau@citrix.com
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
 configure | 47 -----------------------------------------------
 Makefile  |  2 +-
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/configure b/configure
index 89fe881dd4..2afcae61df 100755
--- a/configure
+++ b/configure
@@ -6498,49 +6498,6 @@ if test "$cpu" = "s390x" ; then
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
@@ -8175,10 +8132,6 @@ if test "$gprof" = "yes" ; then
   fi
 fi
 
-if test "$target_linux_user" = "yes" || test "$target_bsd_user" = "yes" ; then
-  ldflags="$ldflags $textseg_ldflags"
-fi
-
 # Newer kernels on s390 check for an S390_PGSTE program header and
 # enable the pgste page table extensions in that case. This makes
 # the vm.allocate_pgste sysctl unnecessary. We enable this program
diff --git a/Makefile b/Makefile
index fc2808fb4b..84ef881600 100644
--- a/Makefile
+++ b/Makefile
@@ -795,7 +795,7 @@ rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(M
 endef
 
 distclean: clean
-	rm -f config-host.mak config-host.h* config-host.ld $(DOCS)
+	rm -f config-host.mak config-host.h* $(DOCS)
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
-- 
2.20.1


