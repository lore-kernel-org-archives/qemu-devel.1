Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA34C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695902086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tETMFwNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695902086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi61-0005HX-Vl
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrF-0005Ia-WC
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrE-0003HU-MF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrE-0003GZ-GB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so5358697wmc.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=orwZmwJz4TFkQtH30UdbtL2NHAyTnKMIxHRZCfSWvJU=;
 b=tETMFwNG79kT+wKZgD6uIf28CdGeqW0rn9bFlc/BfNxgP9GM+U3PPQYpVkYYH66JkV
 OYjStpIJI4gLKda2whdqRWQXRN7SSi+bMZTjemPi8iZAP9LGz6ztwOP4OvSfDP33+KDY
 svRLgp4qQwxzu73ADDX2DKOXP/mAb8PupT78sxv1oo8X0lW+spRD67iJqVXmNWi709Gk
 CiPXKDE1NVf/7sEr0WCDRIZHMWj2Y4bsoFcwzLWVjHWHY5i90KQ7/kPUyXEYgUnacrdr
 c83WkmNwNzJD8gMF/PKc6kuEd8pwK0xtN9Ib40BnBod/XP5sZjf+jOrVOcKRsvsh4Nat
 niWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=orwZmwJz4TFkQtH30UdbtL2NHAyTnKMIxHRZCfSWvJU=;
 b=sAPf4hFvbvphf5eX/HEQ+4JkgOv84nKwPvB9x2jR0NZE2CGhI5Ntdt9kvaNHuxgwWA
 DW7KfhS1RWcsBzW6KOfCzwbggifmQmFVjiKk0rBYJi4mzY9jJ1OapLh2+A83CHle2OTJ
 lpU/XXJB3gKoWerNNr7q/31eFS9jb8VO0XxUU8vGw+dAqSJnfG1wv1ZkhcAbHZkpkUCd
 1BMLO+Bk1mY1QT7uTZe/kvYLBGgikyAl/gTKI81Y66RK5l8V5ozzxuGA7gl9UYmKvQ/L
 Nbt9rOO0EfqaJd5B1NOZUiOQLKTXxvkiYEG0JTSU5JTP1mCwfW0hpc2Rt3gzSer+zZ+Y
 R/rw==
X-Gm-Message-State: APjAAAXsWxRVtSG2CaAKgSg+Gfz2otWyqTZ+cGdhdvOhPxEU03RvUcxi
 EWQW5/8zIe+94ckgK4EPfSG1lbp1
X-Google-Smtp-Source: APXvYqz9UaMLInZm1agxeG8vsmEztHbAWIku6qOGVGEBD5imsL9APqwV4bOAWYzmk/wRemGj3/hp9w==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr3677163wmg.28.1570035127169; 
 Wed, 02 Oct 2019 09:52:07 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/30] Makefile: Remove generated files when doing 'distclean'
Date: Wed,  2 Oct 2019 18:51:35 +0200
Message-Id: <1570035113-56848-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

When running "make distclean" we currently leave a lot of generated
files in the build directory. Fix that.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |  6 +++---
 tests/Makefile.include | 12 +++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 8da3359..47b1e1f 100644
--- a/Makefile
+++ b/Makefile
@@ -696,14 +696,14 @@ clean: recurse-clean
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
-	rm -f fsdev/*.pod scsi/*.pod
+	rm -f fsdev/*.pod scsi/*.pod docs/*.pod docs/*/*.pod docs/*/.buildinfo
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	@# May not be present in generated-files-y
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
-	rm -f qapi-gen-timestamp
+	rm -f qapi-gen-timestamp vhost-user-input
 	rm -rf qga/qapi-generated
 	rm -f config-all-devices.mak
 
@@ -724,7 +724,7 @@ distclean: clean
 	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
-	rm -f po/*.mo tests/qemu-iotests/common.env
+	rm -f po/*.mo
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451..48b52da 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema check-unit check-softfloat check-qtest chec
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
-	rm -f tests/test-qapi-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
+	rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
+	rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
+		tests/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*
 
 clean: check-clean
 
+check-distclean:
+	rm -f tests/test-qapi-types*.c tests/test-qapi-visit*.c \
+		tests/test-qapi-commands*.c tests/test-qapi-events*.c \
+		tests/test-qapi-emit-events.[ch] tests/test-qapi-introspect.c \
+		tests/include/test-qapi-*.c
+
+distclean: check-distclean
+
 # Build the help program automatically
 
 all: $(QEMU_IOTESTS_HELPERS-y)
-- 
1.8.3.1



