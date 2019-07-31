Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02233C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F00206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQGsW7X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F00206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrGJ-0005om-3Y
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8h-00027r-GB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8e-0000kT-CE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8d-0000fE-F8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id v15so61447898wml.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1nyFaFW/wTOm9VXlvjfZCzFrDnNypgzHnbD0BmcShzY=;
 b=RQGsW7X45cJA5Ute1FzYGoYoH3q6mW6FHCEK620UxSjtuDovwy7Bp0ajbxc3ErOxj/
 H2dovLD3E46rfG+Ptc0SkNnRoM7dTGupkIlFvAder0si4q85nefqfbDrw48cOL7xpICc
 lzx1QTn9z5HSMlW0ksyzbalh8MT6kphywqcl4AiYvpV8lOlwmXYHABv6h+zxM9YFq0yu
 KDzbBThRgFNqbRNj7wfGKvX5KbONoNT+g416Hy/vs5ZzFRvzysJ3CSvC3rz6Lv3ujv44
 kWEyJVmbSJro0ApGAamjIaHXeFuEjCPNjqtx0ReOsOEUQII5If8FVTiEILWFle8hS1EC
 6CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1nyFaFW/wTOm9VXlvjfZCzFrDnNypgzHnbD0BmcShzY=;
 b=NAbUs2hxGVao+Rp74LfBItn+O6Cu+Wk1noC8GZHoZyGrwrDRjwktxKabZgiawj07mN
 L7U/KIV9mCb6pEUyfkCztCKSaqWpsNaoieWnHUk10+6LLxtIied6N4Sg4AU5B56I3m/o
 EHtU4xS1I7yqlN9MWXt9wadpU4YsNpirunEik9UKDVz53cZkqmZsGFvhfoENz4dYTbce
 E0uww4fnxZrt6twMAbP1ogcl8r3UVQCqDAgSLOMzpn7hDBy4NdL3g5inZbrB8u6GJRlv
 zWA9s7wOJv3lBr8Bwx+QKCSH5gXbI0Ni05dkR/b4dicVHRTiUe+gsd4AdSHE3+d0n/At
 1VxA==
X-Gm-Message-State: APjAAAUd51VyrqnbZqSOuHy2uCJfNy98dbPH4nTSJtjP6mqaQndDhlBD
 kTOf++YGSLWyfgk9qN6kVWSMVw==
X-Google-Smtp-Source: APXvYqzA5vwrBGB1EW1V1+kcijpdq+RQtodwRTg59IEE2FtM+6cdGVvpHCnfLQZLa5JgXCy90oiZCQ==
X-Received: by 2002:a1c:9c8a:: with SMTP id
 f132mr111826314wme.29.1564589247908; 
 Wed, 31 Jul 2019 09:07:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t1sm82381007wra.74.2019.07.31.09.07.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71BBD1FF87;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:36 +0100
Message-Id: <20190731160719.11396-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4 11/54] docs/devel: add plugins.rst design
 document
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mostly extracted from Emilio's more verbose commit comments
with some additional verbiage from me.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - some rewording and tweaks
  - made non-atomicity of inline ops more explicit
  - expanded description of plugin unload
---
 docs/devel/index.rst   |   1 +
 docs/devel/plugins.rst | 107 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 docs/devel/plugins.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 1ec61fcfed9..2ff058bae38 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -22,3 +22,4 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
+   plugins
diff --git a/docs/devel/plugins.rst b/docs/devel/plugins.rst
new file mode 100644
index 00000000000..0a31227b613
--- /dev/null
+++ b/docs/devel/plugins.rst
@@ -0,0 +1,107 @@
+..
+   Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+   Copyright (c) 2019, Linaro Limited
+   Written by Emilio Cota and Alex Bennée
+
+================
+QEMU TCG Plugins
+================
+
+QEMU TCG plugins provide a way for users to run experiments taking
+advantage of the total system control emulation can have over a guest.
+It provides a mechanism for plugins to subscribe to events during
+translation and execution and optionally callback into the plugin
+during these events.
+
+API Stability
+=============
+
+This is a new feature for QEMU and it does allow people to develop
+out-of-tree plugins that can be dynamically linked into a running QEMU
+process. However the project reserves the right to change or break the
+API should it need to do so.
+
+Exposure of QEMU internals
+--------------------------
+
+The plugin architecture actively avoids leaking implementation details
+about how QEMU's translation works to the plugins. While there are
+conceptions such as translation time and translation blocks the
+details are opaque to plugins. The plugin is able to query select
+details of instructions and system configuration only through the
+exported *qemu_plugin* functions. The types used to describe
+instructions and events are opaque to the plugins themselves.
+
+Usage
+=====
+
+The QEMU binary needs to be compiled for plugin support:
+
+::
+    configure --enable-plugins
+
+Once built a program can be run with multiple plugins loaded each with
+their own arguments:
+
+::
+    $QEMU $OTHER_QEMU_ARGS \
+      -plugin tests/plugin/libhowvec.so,arg=inline,arg=hint \
+      -plugin tests/plugin/libhotblocks.so
+
+Arguments are plugin specific and can be used to modify their
+behaviour. In this case the howvec plugin is being asked to use inline
+ops to count and break down the hint instructions by type.
+
+Plugin Life cycle
+=================
+
+First the plugin is loaded and the public qemu_plugin_install function
+is called. The plugin will then register callbacks for various plugin
+events. Generally plugins will register a handler for the *atexit*
+if they want to dump a summary of collected information once the
+program/system has finished running.
+
+When a registered event occurs the plugin callback is invoked. The
+callbacks may provide additional information. In the case of a
+translation event the plugin has an option to enumerate the
+instructions in a block of instructions and optionally register
+callbacks to some or all instructions when they are executed.
+
+There is also a facility to add an inline event where code to
+increment a counter can be directly inlined with the translation.
+Currently only a simple increment is supported. This is not atomic so
+can miss counts. If you want absolute precision you should use a
+callback which can then ensure atomicity itself.
+
+Finally when QEMU exits all the registered *atexit* callbacks are
+invoked.
+
+Internals
+=========
+
+Locking
+-------
+
+We have to ensure we cannot deadlock, particularly under MTTCG. For
+this we acquire a lock when called from plugin code. We also keep the
+list of callbacks under RCU so that we do not have to hold the lock
+when calling the callbacks. This is also for performance, since some
+callbacks (e.g. memory access callbacks) might be called very
+frequently.
+
+  * A consequence of this is that we keep our own list of CPUs, so that
+    we do not have to worry about locking order wrt cpu_list_lock.
+  * Use a recursive lock, since we can get registration calls from
+    callbacks.
+
+As a result registering/unregistering callbacks is "slow", since it
+takes a lock. But this is very infrequent; we want performance when
+calling (or not calling) callbacks, not when registering them. Using
+RCU is great for this.
+
+We support the uninstallation of a plugin at any time (e.g. from
+plugin callbacks). This allows plugins to remove themselves if they no
+longer want to instrument the code. This operation is asynchronous
+which means callbacks may still occur after the uninstall operation is
+requested. The plugin isn't completely uninstalled until the safe work
+has executed while all vCPUs are quiescent.
-- 
2.20.1


