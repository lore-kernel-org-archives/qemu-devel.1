Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF26C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7749B20720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJz3iHtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7749B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juGSa-0003ei-P4
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 10:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQb-0000bl-5a
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQZ-0003ul-Ca
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a6so8689238wrm.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v8mHmtdIzSaQMbyzkPxWV2NqBNHMAqcUngVPlqJSJqg=;
 b=rJz3iHtWLXviGhFqW2O0e/NmA3tEKOay1FUvlm5h/Ew2Sv8FAjCvyBUR4nCEtBZv7r
 6N+eyBW9ymGBkDOZE/e30pkDLm34VGKWGv7RllVLoGGS4LvXgYqv5JspRFOkt7u4t+bs
 6b9agSfYJPZ+6KJ0cZrx3JG/qTyGi+BZF5bHl6xLZot2h/zHxx2XXn2vpeQ+3rr+513g
 +ZEYM3Mk8OyBDc3NY5+3iJSB0uUH8a8O+2lRUUSUYW3kNQio7UOL6MWlXZ+Ano7aVnkI
 2yaNwCahVPyckJ4fcnzowIeU4wx3Fr3+IdmsCIIUjLTBH7XPb8IdM4DlMINDNJwdL9Ul
 wu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v8mHmtdIzSaQMbyzkPxWV2NqBNHMAqcUngVPlqJSJqg=;
 b=KbJbAiJ3quXUKjZwSxI6+CRJV4vZepUI8lyhCZzMFSE+9futTPc3oWe66Z4QvtxDkQ
 hBGnzd3kGOkidPHW1AzdW7ge/hUY79IM2Enj26C3PlEYuNsARSlmLxAlZ3voAmryDSXb
 jWh0QCtP9tzdrxpuYr3decwPUTsOWIw+Pc0lt7pVFf5JfFKEhGt6JRlobLwwlvoYRB8V
 xKkJL8BTt7mnCmGGuo9uCVIFOWfzB4nKaT6+DqogDyoV+zCSg2Hckp2rQMVBMbJL5xoJ
 k+1pUlbCRxEgHJeS+lvqsXOkGa4/MvVPOg9eQfkBZOTbdMh1uca6VjuTWke9c3kI+ZAO
 sYZw==
X-Gm-Message-State: AOAM531YMajoYfeRTuVxY5PtXu2Gz4nPlE/zbKKMr5OopwLiIxf4rkC8
 m3ayBh+qihT9zwHcES/qJ4th67DK/JHviA==
X-Google-Smtp-Source: ABdhPJywBn72rkUxB8FsYPticalsTBym/mOPEDyyBuaNtVyO8tMLZ8ndZmYTEyrRS2mRSPGg8IAF5g==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr71002122wrn.20.1594477469465; 
 Sat, 11 Jul 2020 07:24:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u10sm13448525wml.29.2020.07.11.07.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 07:24:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 1/3] qdev: Move doc comments from qdev.c to qdev-core.h
Date: Sat, 11 Jul 2020 15:24:23 +0100
Message-Id: <20200711142425.16283-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711142425.16283-1-peter.maydell@linaro.org>
References: <20200711142425.16283-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The doc-comments which document the qdev API are split between the
header file and the C source files, because as a project we haven't
been consistent about where we put them.

Move all the doc-comments in qdev.c to the header files, so that
users of the APIs don't have to look at the implementation files for
this information.

In the process, unify them into our doc-comment format and expand on
them in some cases to clarify expected use cases.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h       | 57 ++++++++++++++++++++++++++++++++++++
 include/hw/qdev-properties.h | 13 ++++++++
 hw/core/qdev.c               | 33 ---------------------
 3 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fe78073c708..2d441d1fb2e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -320,9 +320,66 @@ compat_props_add(GPtrArray *arr,
 
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
+/**
+ * qdev_new: Create a device on the heap
+ * @name: device type to create (we assert() that this type exists)
+ *
+ * This only allocates the memory and initializes the device state
+ * structure, ready for the caller to set properties if they wish.
+ * The device still needs to be realized.
+ * The returned object has a reference count of 1.
+ */
 DeviceState *qdev_new(const char *name);
+/**
+ * qdev_try_new: Try to create a device on the heap
+ * @name: device type to create
+ *
+ * This is like qdev_new(), except it returns %NULL when type @name
+ * does not exist, rather than asserting.
+ */
 DeviceState *qdev_try_new(const char *name);
+/**
+ * qdev_realize: Realize @dev.
+ * @dev: device to realize
+ * @bus: bus to plug it into (may be NULL)
+ * @errp: pointer to error object
+ *
+ * "Realize" the device, i.e. perform the second phase of device
+ * initialization.
+ * @dev must not be plugged into a bus already.
+ * If @bus, plug @dev into @bus.  This takes a reference to @dev.
+ * If @dev has no QOM parent, make one up, taking another reference.
+ * On success, return true.
+ * On failure, store an error through @errp and return false.
+ *
+ * If you created @dev using qdev_new(), you probably want to use
+ * qdev_realize_and_unref() instead.
+ */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
+/**
+ * qdev_realize_and_unref: Realize @dev and drop a reference
+ * @dev: device to realize
+ * @bus: bus to plug it into (may be NULL)
+ * @errp: pointer to error object
+ *
+ * Realize @dev and drop a reference.
+ * This is like qdev_realize(), except the caller must hold a
+ * (private) reference, which is dropped on return regardless of
+ * success or failure.  Intended use::
+ *
+ *     dev = qdev_new();
+ *     [...]
+ *     qdev_realize_and_unref(dev, bus, errp);
+ *
+ * Now @dev can go away without further ado.
+ *
+ * If you are embedding the device into some other QOM device and
+ * initialized it via some variant on object_initialize_child() then
+ * do not use this function, because that family of functions arrange
+ * for the only reference to the child device to be held by the parent
+ * via the child<> property, and so the reference-count-drop done here
+ * would be incorrect. For that use case you want qdev_realize().
+ */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 void qdev_unrealize(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 587e5b7d317..8f3a98cba69 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -282,6 +282,19 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
  */
 void qdev_property_add_static(DeviceState *dev, Property *prop);
 
+/**
+ * qdev_alias_all_properties: Create aliases on source for all target properties
+ * @target: Device which has properties to be aliased
+ * @source: Object to add alias properties to
+ *
+ * Add alias properties to the @source object for all qdev properties on
+ * the @target DeviceState.
+ *
+ * This is useful when @target is an internal implementation object
+ * owned by @source, and you want to expose all the properties of that
+ * implementation object as properties on the @source object so that users
+ * of @source can set them.
+ */
 void qdev_alias_all_properties(DeviceState *target, Object *source);
 
 /**
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 01796823b41..96772a15bd5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -128,13 +128,6 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
     }
 }
 
-/*
- * Create a device on the heap.
- * A type @name must exist.
- * This only initializes the device state structure and allows
- * properties to be set.  The device still needs to be realized.  See
- * qdev-core.h.
- */
 DeviceState *qdev_new(const char *name)
 {
     if (!object_class_by_name(name)) {
@@ -143,11 +136,6 @@ DeviceState *qdev_new(const char *name)
     return DEVICE(object_new(name));
 }
 
-/*
- * Try to create a device on the heap.
- * This is like qdev_new(), except it returns %NULL when type @name
- * does not exist.
- */
 DeviceState *qdev_try_new(const char *name)
 {
     if (!module_object_class_by_name(name)) {
@@ -378,14 +366,6 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-/*
- * Realize @dev.
- * @dev must not be plugged into a bus.
- * If @bus, plug @dev into @bus.  This takes a reference to @dev.
- * If @dev has no QOM parent, make one up, taking another reference.
- * On success, return true.
- * On failure, store an error through @errp and return false.
- */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 {
     assert(!dev->realized && !dev->parent_bus);
@@ -399,16 +379,6 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     return object_property_set_bool(OBJECT(dev), "realized", true, errp);
 }
 
-/*
- * Realize @dev and drop a reference.
- * This is like qdev_realize(), except the caller must hold a
- * (private) reference, which is dropped on return regardless of
- * success or failure.  Intended use:
- *     dev = qdev_new();
- *     [...]
- *     qdev_realize_and_unref(dev, bus, errp);
- * Now @dev can go away without further ado.
- */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 {
     bool ret;
@@ -814,9 +784,6 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
                                           prop->info->description);
 }
 
-/* @qdev_alias_all_properties - Add alias properties to the source object for
- * all qdev properties on the target DeviceState.
- */
 void qdev_alias_all_properties(DeviceState *target, Object *source)
 {
     ObjectClass *class;
-- 
2.20.1


