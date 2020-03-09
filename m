Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E430C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB3521D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2jlWF/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB3521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKjR-00005J-8w
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZx-00027r-MH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZw-0001V3-3O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZv-0001U2-Rz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id p2so11015255wrw.7
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xNFVrqrgv4Q6fMRbpldg27PAr4NFe+ct3Bp7b377yzc=;
 b=m2jlWF/94JET/z9oJjviUIgEbcRO2EagzBLwqW4xFn8j33UQ/Meixbu7zzt1elTpw6
 Jq6NiZgL0nUoyngKm/BOkTbt0ugwoS+8iUvceAJFGO0mXf1Y1w3L/A0mD7FpWy/newag
 Km6S3SLurzo6i4TBlskTMwVoWoQ5iYlohb1DU7PlmPGe68xRR4b0LbWdznRT4tD6Dh7D
 YE2QtZWVGhh99TRWUNBtCXUAVaaR1/V7THnJqqzzaWHTcJuGJUAyaH7+4UfJI8w6vU2x
 73kCc/iyzzsNHQqtRWQd40p5493i2fVPGt/0bB3L9CFI5pXMveebECIeM5jSfiskvXU8
 PYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xNFVrqrgv4Q6fMRbpldg27PAr4NFe+ct3Bp7b377yzc=;
 b=cEJ/dh1Fw6B3bQjc3PiIN65kEogDdA89UT/+aPO3RL7eQN4cIXZjenn+TxG1U8JOyj
 kqBCF1d+grZ5tqWdfH2iL7MEIoACG2r+FzisOHEbF69G94lb6GisMbcAlMgDG9WTL3m3
 nTkbucjuNv79E7jeH51Xf05NWcOdpp8mZBTQNO5f8NQzrF4PBF+I3iGxx2yxZ4qiCsdp
 buRwwvzTeT0HElZsAtNAqCZ7HOY2IHz/ZpaR2a6KiufoVEpY+XjtTMarQmc3rYOPDlQ1
 o1uuF99ZGbgAn88YITB79Djluj6ACEhRRCM8iaL1B/zkU26k+5OqMVAW3wLfpLEpemOf
 vG/A==
X-Gm-Message-State: ANhLgQ32Bed/NRtflW1fBkUu24QAXS8eAwFUxp15y+Au+uOokieYFG5N
 wrGzqgWEI5zDaquWZOVDG5mtpW9ECf1p6g==
X-Google-Smtp-Source: ADFU+vsfM5f2wLk1VSe1Vi7MgxjbEtoWjgmH6saOXNW+kPrY3qii6r2FH63C8mio9104KwfMc/5y/w==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr12854243wrq.412.1583768666516; 
 Mon, 09 Mar 2020 08:44:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/18] Makefile: Remove redundant Texinfo related rules
Date: Mon,  9 Mar 2020 15:44:01 +0000
Message-Id: <20200309154405.13548-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now don't build anything from Texinfo, so we can remove
some redundant Makefile pattern rules and the rule for
generating the version.texi file that used to be included
from many Texinfo source files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile  | 31 +------------------------------
 rules.mak | 14 +-------------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/Makefile b/Makefile
index 98f58b84ef0..36fe8d6e641 100644
--- a/Makefile
+++ b/Makefile
@@ -732,8 +732,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
-	rm -f fsdev/*.pod scsi/*.pod
+	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *~ */*~
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	@# May not be present in generated-files-y
@@ -766,7 +765,6 @@ distclean: clean
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f docs/version.texi
 	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
@@ -987,31 +985,6 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
 	ui/shader/texture-blit-frag.h
 
 # documentation
-MAKEINFO=makeinfo
-MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
-MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
-TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
-
-docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
-	$(call quiet-command,(\
-		echo "@set VERSION $(VERSION)" && \
-		echo "@set CONFDIR $(qemu_confdir)" \
-	)> $@,"GEN","$@")
-
-%.html: %.texi docs/version.texi
-	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-	--html $< -o $@,"GEN","$@")
-
-%.info: %.texi docs/version.texi
-	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
-
-%.txt: %.texi docs/version.texi
-	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-	--plaintext $< -o $@,"GEN","$@")
-
-%.pdf: %.texi docs/version.texi
-	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
 # Sphinx builds all its documentation at once in one invocation
 # and handles "don't rebuild things unless necessary" itself.
@@ -1081,8 +1054,6 @@ $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
 
 html: sphinxdocs
 
-$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
-
 # Reports/Analysis
 
 %/coverage-report.html:
diff --git a/rules.mak b/rules.mak
index e39b073d464..00d323a071a 100644
--- a/rules.mak
+++ b/rules.mak
@@ -144,7 +144,7 @@ cc-option = $(if $(shell $(CC) $1 $2 -S -o /dev/null -xc /dev/null \
 cc-c-option = $(if $(shell $(CC) $1 $2 -c -o /dev/null -xc /dev/null \
                 >/dev/null 2>&1 && echo OK), $2, $3)
 
-VPATH_SUFFIXES = %.c %.h %.S %.cc %.cpp %.m %.mak %.texi %.sh %.rc Kconfig% %.json.in
+VPATH_SUFFIXES = %.c %.h %.S %.cc %.cpp %.m %.mak %.sh %.rc Kconfig% %.json.in
 set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath $(PATTERN) $1)))
 
 # install-prog list, dir
@@ -381,18 +381,6 @@ define unnest-vars
         $(eval $v := $(filter-out %/,$($v))))
 endef
 
-TEXI2MAN = $(call quiet-command, \
-	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $(TEXI2PODFLAGS) $< $@.pod && \
-	$(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
-	"GEN","$@")
-
-%.1:
-	$(call TEXI2MAN)
-%.7:
-	$(call TEXI2MAN)
-%.8:
-	$(call TEXI2MAN)
-
 GEN_SUBST = $(call quiet-command, \
 	sed -e "s!@libexecdir@!$(libexecdir)!g" < $< > $@, \
 	"GEN","$@")
-- 
2.20.1


