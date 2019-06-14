Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7747C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5528217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uquMfLGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5528217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbptw-0007u1-0c
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkG-0000WF-Pl
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkF-0002yp-FM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:34935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkF-0002xt-6i
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id c6so3058468wml.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LmI/mBSkUBusQla1865jT/J9Nwa1pt6elfDdpjwViYY=;
 b=uquMfLGT0bzb1W7jFdk6JmHnArAfpiR8pgyFKkVjm6Jlt6mZl5MMic2J5EtTl4jQzz
 bXVp6Jx1KQDQWqWwXgKMGOGaxU24ChVXoNWpmEIj70QUp6795aTV/slTUq/LGMQaFD40
 uedjmkmTDOrevmLGcCuDuSLMd1Tw0mL25KG3TMV/m68bb2La1OmW/37MXZ0RZmrgVcIC
 3ve9X34WEEJrMtekRX2/LfgZv6JVI8MEHLm4vETNPZElE/CjQ+zlboJnjDIQ657RfgXh
 ZA1Xi0GOqMfmyYp1Ua2YGoQhlnqM82MSdcQJWfmS7x9ZJKd+exqdhEjYOS9Mvaj/vhD1
 21eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LmI/mBSkUBusQla1865jT/J9Nwa1pt6elfDdpjwViYY=;
 b=kWaaGPMY7wHsfiReQdlB2qsSUzFKZAk2ZPI+5+RSLjTuS22xPbmbgXjqua0TpWyuhi
 Ej7odFjvQkI0+Oq2pJL0bT3PE69KKWAxeTuOrbbTOPW56wfjkoZyhqMEtiHWkvIHXQe0
 d7H2L6+Ob6x+viFsachq2Bz8yvByakVU0RXLdqhL8w39z80erFdhqmColMgv94HpYaz9
 DQpYknxWXM+6ZiY+ab8TGe0vjELkSKGw5uYWFDenZ7C342EIDZj/1VoU23FyI0HUl+x9
 tgrMM7B8rNw6/BxO1lfHqrYaw5G63dS7hGFGcniR9VOzVIxbhgKcdkwK6X06ngYwpNoo
 km5g==
X-Gm-Message-State: APjAAAVYv7yav4Vx/q9lFf+Xg+gMiso823cqZpkCX+Nf4wHPbS6sm8sv
 R4EYm88fwed6FMKjq41jOCONNA==
X-Google-Smtp-Source: APXvYqwUsrcBj0hO3R1n/BFkgctTyDnI4apXTJ83PUPxly6zkbN5uXcm8Hf7cxjA4qN4TYBDT7iaHg==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr8695931wmh.159.1560532325862; 
 Fri, 14 Jun 2019 10:12:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o4sm2720965wmh.35.2019.06.14.10.12.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D57DA1FF92;
 Fri, 14 Jun 2019 18:12:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:15 +0100
Message-Id: <20190614171200.21078-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PATCH v3 05/50] docs/devel: add plugins.rst design
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mostly extracted from Emilio's more verbose commit comments
with some additional verbiage from me.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/index.rst   |  1 +
 docs/devel/plugins.rst | 99 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 docs/devel/plugins.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 2a4ddf40ad..7e6d20c970 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -21,3 +21,4 @@ Contents:
    testing
    decodetree
    secure-coding-practices
+   plugins
diff --git a/docs/devel/plugins.rst b/docs/devel/plugins.rst
new file mode 100644
index 0000000000..b0c30375ef
--- /dev/null
+++ b/docs/devel/plugins.rst
@@ -0,0 +1,99 @@
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
+out-of-tree plugins than can be dynamically linked into a running QEMU
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
+Plugin Life cycle
+=================
+
+First the plugin is loaded and the public qemu_plugin_install function
+is called. The plugin with then register callbacks for various plugin
+events. Generally at least the atexit_cb is registered so the plugin
+can dump its information at the end of a run.
+
+When a registered event occurs the plugin callback is called. The
+callbacks may provide additional information. In the case of a
+translation event the plugin has an option to enumerate the
+instructions in a block of instructions and optionally register
+callbacks to some or all instructions when they are executed.
+
+There is also a facility to add an inline event where code to
+increment a counter can be directly inlined with the translation.
+Currently only a simple increment is supported. This is not atomic so
+the plugin must either keep it's counters separated and indexed by CPU
+or use a callback which can ensure atomicity.
+
+Finally when QEMU exits all the registered atexit callbacks are called
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
+We support the uninstallation of a plugin at any time (e.g. from plugin
+callbacks). This means some callbacks might still be called after the uninstall
+function returns. The plugin isn't completely uninstalled until the
+safe work has executed while all vCPUs are quiescent.
-- 
2.20.1


