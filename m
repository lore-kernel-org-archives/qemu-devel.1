Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F516C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0A624681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHl4rApd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0A624681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWaJ-0002oo-HI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8y-0005TQ-V8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8u-0002Dz-3U
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:20 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8t-0002Bo-RP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id a6so2514880wrx.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xKsruomlpZIj63jCP80AfOWLcpIpXh9Adez6NQRvp84=;
 b=rHl4rApd9UcQ/wF0NCxE6neHQbyyBJW6FVpRJ/I5Gs0uViXUb8RONv4yM9eR381ufY
 b0DM++yZUA0KSvnes2Mr3d9EdNUEm1ncTM2REI72q0Tw+z2g6j7gKEVVxU1h/C8fjM+g
 1MghD0C3o7jDA4aeg2RbNiebvPS0uaeQPvBouiCI0HKmal/l/Oi9MZ3l9GS/4Sjuvh9K
 NNz24nfWVZi5f0h4ohQ9YKy50NgjvIpgK9NxYSrlNxIIOzEdVv/GImIzgnAzyY/XXOaH
 6SAUXB1dvQXkvK6OXq8QuzWemsdC/Os87lnPfxYED9xL+uQ3appdwAJb0YkUD/edjE5+
 2Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xKsruomlpZIj63jCP80AfOWLcpIpXh9Adez6NQRvp84=;
 b=Ij/hyvCvNZEE7RI6GnOvyx3fYLjSB7GG3qL+khr+ORR0rBySkLnafhuZtjrjT4oxyD
 uC/rV3Nrl+TVVoqXzYX+0KRaGPIosU5fPev5yVvMf+HPGXkkVF1rhaShA1u8Wu/BGETI
 moM4g7NlAAI0LNmdDH2ATDNdTrufztFGRIxe+OCjpWTYodCXIiNcke+NOPh1e+e4QY1T
 7MFwdV42jMZkunmDlChHTexmMSnvFE8nY1B/hJRI2Ngm9E1TcO2YEDxH3FpwDCC3pZgz
 A4fGitjEl833Rj3XNNIQObJR4zlqgpd9iZxjCUYQt8eeeIycVCIifa6xXufn6HMWdpjB
 R8gQ==
X-Gm-Message-State: APjAAAUH5B/IeqFW4hANDymYwj97YGhW6zASkuhhVtqHyV9blOEq6P59
 6BsInf8vtpEyzRxLMsc2YeE9xpOV
X-Google-Smtp-Source: APXvYqwK2QwcPRqdGv6EM561nwbCYfH8ak718uMisy1I3pvIs81fSmUHapKXAayQkvb4Z68uLeofGQ==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr32023869wrv.0.1580234353982;
 Tue, 28 Jan 2020 09:59:13 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 138/142] rules.mak: drop unneeded macros
Date: Tue, 28 Jan 2020 18:53:38 +0100
Message-Id: <20200128175342.9066-139-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.txt |   5 +-
 rules.mak                   | 179 ------------------------------------
 2 files changed, 1 insertion(+), 183 deletions(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 41bd08ea3a..fea67b207c 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -404,10 +404,7 @@ using Makefile.target for the build rules.
 - rules.mak
 
 This file provides the generic helper rules for invoking build tools, in
-particular the compiler and linker. This also contains the magic (hairy)
-'unnest-vars' function which is used to merge the variable definitions
-from all Makefile.objs in the source tree down into the main Makefile
-context.
+particular the compiler and linker.
 
 
 - default-configs/*.mak
diff --git a/rules.mak b/rules.mak
index 92597864fe..dd4ec2aa92 100644
--- a/rules.mak
+++ b/rules.mak
@@ -161,15 +161,6 @@ define install-prog
 	$(if $(STRIP),$(STRIP) $(foreach T,$1,"$2/$(notdir $T)"),)
 endef
 
-# find-in-path
-# Usage: $(call find-in-path, prog)
-# Looks in the PATH if the argument contains no slash, else only considers one
-# specific directory.  Returns an # empty string if the program doesn't exist
-# there.
-find-in-path = $(if $(findstring /, $1), \
-        $(wildcard $1), \
-        $(wildcard $(patsubst %, %/$1, $(subst :, ,$(PATH)))))
-
 # Logical functions (for operating on y/n values like CONFIG_FOO vars)
 # Inputs to these must be either "y" (true) or "n" or "" (both false)
 # Output is always either "y" or "n".
@@ -208,173 +199,3 @@ clean: clean-timestamp
 
 # will delete the target of a rule if commands exit with a nonzero exit status
 .DELETE_ON_ERROR:
-
-# save-vars
-# Usage: $(call save-vars, vars)
-# Save each variable $v in $vars as save-vars-$v, save their object's
-# variables, then clear $v.  saved-vars-$v contains the variables that
-# where saved for the objects, in order to speedup load-vars.
-define save-vars
-    $(foreach v,$1,
-        $(eval save-vars-$v := $(value $v))
-        $(eval saved-vars-$v := $(foreach o,$($v), \
-            $(if $($o-cflags), $o-cflags $(eval save-vars-$o-cflags := $($o-cflags))$(eval $o-cflags := )) \
-            $(if $($o-libs), $o-libs $(eval save-vars-$o-libs := $($o-libs))$(eval $o-libs := )) \
-            $(if $($o-objs), $o-objs $(eval save-vars-$o-objs := $($o-objs))$(eval $o-objs := ))))
-        $(eval $v := ))
-endef
-
-# load-vars
-# Usage: $(call load-vars, vars, add_var)
-# Load the saved value for each variable in @vars, and the per object
-# variables.
-# Append @add_var's current value to the loaded value.
-define load-vars
-    $(eval $2-new-value := $(value $2))
-    $(foreach v,$1,
-        $(eval $v := $(value save-vars-$v))
-        $(foreach o,$(saved-vars-$v),
-            $(eval $o := $(save-vars-$o)) $(eval save-vars-$o := ))
-        $(eval save-vars-$v := )
-        $(eval saved-vars-$v := ))
-    $(eval $2 := $(value $2) $($2-new-value))
-endef
-
-# fix-paths
-# Usage: $(call fix-paths, obj_path, src_path, vars)
-# Add prefix @obj_path to all objects in @vars, and add prefix @src_path to all
-# directories in @vars.
-define fix-paths
-    $(foreach v,$3,
-        $(foreach o,$($v),
-            $(if $($o-libs),
-                $(eval $1$o-libs := $($o-libs)))
-            $(if $($o-cflags),
-                $(eval $1$o-cflags := $($o-cflags)))
-            $(if $($o-objs),
-                $(eval $1$o-objs := $(addprefix $1,$($o-objs)))))
-        $(eval $v := $(addprefix $1,$(filter-out %/,$($v))) \
-                     $(addprefix $2,$(filter %/,$($v)))))
-endef
-
-# unnest-var-recursive
-# Usage: $(call unnest-var-recursive, obj_prefix, vars, var)
-#
-# Unnest @var by including subdir Makefile.objs, while protect others in @vars
-# unchanged.
-#
-# @obj_prefix is the starting point of object path prefix.
-#
-define unnest-var-recursive
-    $(eval dirs := $(sort $(filter %/,$($3))))
-    $(eval $3 := $(filter-out %/,$($3)))
-    $(foreach d,$(dirs:%/=%),
-            $(call save-vars,$2)
-            $(eval obj := $(if $1,$1/)$d)
-            $(eval -include $(SRC_PATH)/$d/Makefile.objs)
-            $(call fix-paths,$(if $1,$1/)$d/,$d/,$2)
-            $(call load-vars,$2,$3)
-            $(call unnest-var-recursive,$1,$2,$3))
-endef
-
-# unnest-vars
-# Usage: $(call unnest-vars, obj_prefix, vars)
-#
-# @obj_prefix: object path prefix, can be empty, or '..', etc. Don't include
-# ending '/'.
-#
-# @vars: the list of variable names to unnest.
-#
-# This macro will scan subdirectories's Makefile.objs, include them, to build
-# up each variable listed in @vars.
-#
-# Per object and per module cflags and libs are saved with relative path fixed
-# as well, those variables include -libs, -cflags and -objs. Items in -objs are
-# also fixed to relative path against SRC_PATH plus the prefix @obj_prefix.
-#
-# All nested variables postfixed by -m in names are treated as DSO variables,
-# and will be built as modules, if enabled.
-#
-# A simple example of the unnest:
-#
-#     obj_prefix = ..
-#     vars = hot cold
-#     hot  = fire.o sun.o season/
-#     cold = snow.o water/ season/
-#
-# Unnest through a faked source directory structure:
-#
-#     SRC_PATH
-#        ├── water
-#        │   └── Makefile.objs──────────────────┐
-#        │       │ hot += steam.o               │
-#        │       │ cold += ice.mo               │
-#        │       │ ice.mo-libs := -licemaker    │
-#        │       │ ice.mo-objs := ice1.o ice2.o │
-#        │       └──────────────────────────────┘
-#        │
-#        └── season
-#            └── Makefile.objs──────┐
-#                │ hot += summer.o  │
-#                │ cold += winter.o │
-#                └──────────────────┘
-#
-# In the end, the result will be:
-#
-#     hot  = ../fire.o ../sun.o ../season/summer.o
-#     cold = ../snow.o ../water/ice.mo ../season/winter.o
-#     ../water/ice.mo-libs = -licemaker
-#     ../water/ice.mo-objs = ../water/ice1.o ../water/ice2.o
-#
-# Note that 'hot' didn't include 'water/' in the input, so 'steam.o' is not
-# included.
-#
-define unnest-vars
-    # In the case of target build (i.e. $1 == ..), fix path for top level
-    # Makefile.objs objects
-    $(if $1,$(call fix-paths,$1/,,$2))
-
-    # Descend and include every subdir Makefile.objs
-    $(foreach v, $2,
-        $(call unnest-var-recursive,$1,$2,$v)
-        # Pass the .mo-cflags and .mo-libs along to its member objects
-        $(foreach o, $(filter %.mo,$($v)),
-            $(foreach p,$($o-objs),
-                $(if $($o-cflags), $(eval $p-cflags += $($o-cflags)))
-                $(if $($o-libs), $(eval $p-libs += $($o-libs))))))
-
-    # For all %.mo objects that are directly added into -y, just expand them
-    $(foreach v,$(filter %-y,$2),
-        $(eval $v := $(foreach o,$($v),$(if $($o-objs),$($o-objs),$o))))
-
-    $(foreach v,$(filter %-m,$2),
-        # All .o found in *-m variables are single object modules, create .mo
-        # for them
-        $(foreach o,$(filter %.o,$($v)),
-            $(eval $(o:%.o=%.mo)-objs := $o))
-        # Now unify .o in -m variable to .mo
-        $(eval $v := $($v:%.o=%.mo))
-        $(eval modules-m += $($v))
-
-        # For module build, build shared libraries during "make modules"
-        # For non-module build, add -m to -y
-        $(if $(CONFIG_MODULES),
-             $(foreach o,$($v),
-                   $(eval $($o-objs): CFLAGS += $(DSO_OBJ_CFLAGS))
-                   $(eval $o: $($o-objs)))
-             $(eval $(patsubst %-m,%-y,$v) += $($v))
-             $(eval modules: $($v:%.mo=%$(DSOSUF))),
-             $(eval $(patsubst %-m,%-y,$v) += $(call expand-objs, $($v)))))
-
-    # Post-process all the unnested vars
-    $(foreach v,$2,
-        $(foreach o, $(filter %.mo,$($v)),
-            # Find all the .mo objects in variables and add dependency rules
-            # according to .mo-objs. Report error if not set
-            $(if $($o-objs),
-                $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs))))
-        $(shell mkdir -p ./ $(sort $(dir $($v))))
-        # Include all the .d files
-        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.o,$($v)))))
-        $(eval $v := $(filter-out %/,$($v))))
-endef
-- 
2.21.0



