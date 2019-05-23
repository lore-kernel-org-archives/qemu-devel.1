Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695CDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3750E21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fpfl0mDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3750E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpJE-00058a-CN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:07:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTpI0-0004Of-Et
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTpHz-0000P2-3C
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:05:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTpHy-0000MW-FH
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:05:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id s17so6696237wru.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Ume50n8qkYBKGcbQ5wkyvsOh4prOkl3w7x4Kl5qGVnc=;
	b=Fpfl0mDdESslAV3eqgH6v7fmBKDioLGiugegouZenqv4Pa+q6n9wLUuJa2xi+ZC74x
	8l7Hb8ISfA0Ycvop0Eteio3pLNgGKGrmbWMljcjJQLDfNXgyJOhUJ57GDtbIQaqM51ED
	Ij919ZZZ//o1tsmUXzT75avK9ZjM8MmRgkZZgSeATgxvCv+5Ig8vmKjZdAXX1KI50PbR
	JECNaF3N5X8zJ0UWKzYkJ27Bnk8SNUWG3umFQEngYxoHTaKw8JzEyqjypBRybVq4Ul5J
	WDnhYq/JlBHSrjCzluidfD/RV8TZbGGQkb+3Mlrp3nP11I3ev5Fv+Vkebn+XETj2mubF
	/0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Ume50n8qkYBKGcbQ5wkyvsOh4prOkl3w7x4Kl5qGVnc=;
	b=t8HCVjiE0iqAzvjeuV1ULN5fwB/fDr2KY0LZh2zrkkFSuOncCfonStpLBUWSg4jKS6
	qu3xKAZQh4oyrPP2i/JM6vwOk+iX9GnwSWelXe9JbSaI2sfUG1//CazgvwUXf/Q/SA9X
	k/FduqkLDfOWH89sx7rjGxKf0pQrANQuRfW8mxFSBeAq0jyFWroOFjMw2nXzLwEpjoyr
	d3ZH7XmSdGXtvAeiP3h4owF0dT90qvfDWJJAXoq2d/AYIAjDIFy93njX8eoSQdzb/7ol
	hwKGSDkz29yRhkz9noAPH1tJUNkHUJJL9Ef36KhzBhHEeloAnuBRzBLG3SBERkwrdcLv
	xgbw==
X-Gm-Message-State: APjAAAXLYwHMBj7p46StthhNDELaQDdYD4D3q+kf1/G7stz/tZ3/ROo2
	uUMWYQBT5mdpqrm/QMxkKivUIGascolDgg==
X-Google-Smtp-Source: APXvYqzgUqxEKtbLKVGbzZZCZqiMb1olqo6S5Ki6sYYlF8qar5NEzDcmXh8f0YhEMakVY4cTNscCNw==
X-Received: by 2002:adf:f7c8:: with SMTP id a8mr2113431wrq.148.1558623946354; 
	Thu, 23 May 2019 08:05:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	h17sm13739322wrq.79.2019.05.23.08.05.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:05:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:05:43 +0100
Message-Id: <20190523150543.22676-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2] hw/core/bus.c: Only the main system bus can
 have no parent
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
some qbus buses not being connected to qdev devices -- if the
bus has no parent object then we register a reset function which
resets the bus on system reset (and unregister it when the
bus is unparented).

Nearly a decade later, we have now no buses in the tree which
are created with non-NULL parents, so we can remove the
workaround and instead just assert that if the bus has a NULL
parent then it is the main system bus.

(The absence of other parentless buses was confirmed by
code inspection of all the callsites of qbus_create() and
qbus_create_inplace() and cross-checked by 'make check'.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
v1->v2: clean up also the bus_unparent() code
---
 hw/core/bus.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index e09843f6abe..b8839c7268d 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -96,10 +96,9 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
         bus->parent->num_child_bus++;
         object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
         object_unref(OBJECT(bus));
-    } else if (bus != sysbus_get_default()) {
-        /* TODO: once all bus devices are qdevified,
-           only reset handler for main_system_bus should be registered here. */
-        qemu_register_reset(qbus_reset_all_fn, bus);
+    } else {
+        /* The only bus without a parent is the main system bus */
+        assert(bus == sysbus_get_default());
     }
 }
 
@@ -108,18 +107,16 @@ static void bus_unparent(Object *obj)
     BusState *bus = BUS(obj);
     BusChild *kid;
 
+    /* Only the main system bus has no parent, and that bus is never freed */
+    assert(bus->parent);
+
     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
         DeviceState *dev = kid->child;
         object_unparent(OBJECT(dev));
     }
-    if (bus->parent) {
-        QLIST_REMOVE(bus, sibling);
-        bus->parent->num_child_bus--;
-        bus->parent = NULL;
-    } else {
-        assert(bus != sysbus_get_default()); /* main_system_bus is never freed */
-        qemu_unregister_reset(qbus_reset_all_fn, bus);
-    }
+    QLIST_REMOVE(bus, sibling);
+    bus->parent->num_child_bus--;
+    bus->parent = NULL;
 }
 
 void qbus_create_inplace(void *bus, size_t size, const char *typename,
-- 
2.20.1


