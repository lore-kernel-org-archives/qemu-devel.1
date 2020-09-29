Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87BAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1937021734
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 00:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eS4Q8vjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1937021734
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN3kK-0005h7-1K
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 20:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TIJyXwsKCh0ALDBGG7FH7G9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--hskinnemoen.bounces.google.com>)
 id 1kN3gG-0002K3-KB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 20:39:44 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:37689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TIJyXwsKCh0ALDBGG7FH7G9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--hskinnemoen.bounces.google.com>)
 id 1kN3gE-0000Ph-Ra
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 20:39:44 -0400
Received: by mail-yb1-xb49.google.com with SMTP id x1so3013683ybi.4
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 17:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=IE9YiOAtzWYoZYcMDmL5AUmQ+PJ06ojbARZV342gJy8=;
 b=eS4Q8vjXUpdO9EMbbN+iv3/haS33YOyKlZo034g1j5iji3pIYcwiYMupM4zGCQIeBV
 NLE034W5P8xfb6zqLQxMlmw1UVQ6qymDbH17icyXA3oZSqnX0MThtWUXa11rh5j1pNnR
 HVK5he3pfbYPaoz/yhHnpKtlf9tgO+Mv6j5d1LwbiHrBrxeluXrrjs2uV8xAPyHYBHac
 Iau+JZsChrNaiDPsa/KsH7I5vZBFefIRvC3v3AKpQZ+H+OnsrpYV4be7UJneLCgfy6pD
 b8QtZ+4znocqtyvyHVEnCR28vaED7GiJmcKhQxU/yAo7SbhqEy4ISfxGByxFeopZoqPA
 CSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=IE9YiOAtzWYoZYcMDmL5AUmQ+PJ06ojbARZV342gJy8=;
 b=aaEnd6174OtEk8/axTpChRy38Z32uuPcvm7T+P0QDeQsHogNgFAl6EUS1NQVOOqp9V
 YZoUF9ZXk/uHiBYuUP7KNr6z6ic69+fmTpF/n8olK4nqendSNq9qZNdSm+cPSjNJGTvy
 8jQTyaLqRynH2p1VlDUufiFe+Dha661tkWZn2D3B92i77TNC3cZBGC63z86rTBuvcJ2h
 REGW4cHKqYVDj9++MYOPTGdmkrljUudVQ0bX39S5ls7rWLbQ48cce7qkQbKY/sEQRW1X
 Cc5T50W/Lmnj1ptn1X0PiGmgbX1z6YB0ICtszqtLkR+3br0ddTdIm1IvJZV9ZbNChrNk
 YpQQ==
X-Gm-Message-State: AOAM533Bpc39VgV9izs7xi0f4bAv7VMTQgOF+rQZjMQ755PURr9ocp2B
 yBnX2NFujRsZxXkGw7t/I95vewflxdDj3q23UYziapnQptedGCRXvyrQYbLSsyLtfeMAwljgiCF
 SsaFG33jnGz3jlaHIgsqmle5J6VgsaQ3WsUuCoHkvQfYDXW0IwYQhuzl3Z5evpQPoazBSkkplow
 ==
X-Google-Smtp-Source: ABdhPJySV96yQ17e4fJZqw0CTKxsP4G/VCU2QmaKygzlovPsaQQuFlAE6Ni74ez0nqEpfoVfGDD7oUylncpgDKSUFQ==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a25:b78d:: with SMTP id
 n13mr2876098ybh.152.1601339980945; Mon, 28 Sep 2020 17:39:40 -0700 (PDT)
Date: Mon, 28 Sep 2020 17:39:16 -0700
In-Reply-To: <20200929003916.4183696-1-hskinnemoen@google.com>
Message-Id: <20200929003916.4183696-4-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200929003916.4183696-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [RFC 3/3] docs/specs: IPMI device emulation: BMC
To: qemu-devel@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, joel@jms.id.au, clg@kaod.org, 
 venture@google.com, wuhaotsh@google.com, minyard@acm.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3TIJyXwsKCh0ALDBGG7FH7G9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

The IPMI document is expanded with a proposal to emulate BMC-side IPMI
devices. This allows a QEMU instance running server software to interact
with a different QEMU instance running BMC firmware, which should
closely model how a real server system works.

The document as rendered by "make sphinxdocs" can be seen here:

https://hskinnemoen.github.io/qemu/specs/ipmi.html

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/specs/ipmi.rst | 83 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/docs/specs/ipmi.rst b/docs/specs/ipmi.rst
index e0f9ab20ba..f45a452ef9 100644
--- a/docs/specs/ipmi.rst
+++ b/docs/specs/ipmi.rst
@@ -91,6 +91,89 @@ further delegated to an external emulator, or a real BMC. The
 ``ipmi-bmc-extern`` device has a required ``chardev`` property which specifies
 the communications channel to the external BMC.
 
+Baseband Management Controller (BMC) emulation
+==============================================
+
+.. note:: This section is just a proposal. QEMU does not yet support BMC-side
+   IPMI emulation.
+
+This section is about emulation of IPMI-related devices in a System-on-Chip
+(SoC) used as a Baseband Management Controller. This is not to be confused with
+emulating the BMC device as seen by the main processor.
+
+SoCs that are designed to be used as a BMC often have dedicated hardware that
+allows them to be connected to one or more of the IPMI System Interfaces. The
+BMC-side hardware interface is not standardized, so each type of SoC may need
+its own device implementation in QEMU, for example:
+
+* ``aspeed-ipmi-ibt`` for emulating the Aspeed iBT peripheral.
+* ``npcm7xx-ipmi-kcs`` for emulating the Nuvoton NPCM7xx Host-to-BMC Keyboard
+  Controller Style (KCS) channels.
+
+.. blockdiag::
+
+    blockdiag bmc_ipmi {
+        orientation = portrait
+        default_group_color = "none";
+        class responder [color = lightblue];
+        class host [color = salmon];
+
+        host [color="aquamarine", label="External Host"]
+
+        group {
+            orientation = portrait
+
+            group {
+                orientation = portrait
+
+                ipmi-responder [class = "responder"]
+                npcm7xx-ipmi-kcs [class = "responder", stacked]
+
+                ipmi-responder <- npcm7xx-ipmi-kcs [hstyle = generalization];
+            }
+
+            group {
+                orientation = portrait
+
+                ipmi-host [class = "host"];
+                ipmi-host-sim [class = "host"];
+                ipmi-host-extern [class = "host"];
+
+                ipmi-host <- ipmi-host-sim [hstyle = generalization];
+                ipmi-host <- ipmi-host-extern [hstyle = generalization];
+            }
+
+            ipmi-responder <-> ipmi-host
+        }
+
+        ipmi-host-extern <-> host [label="chardev"];
+    }
+
+IPMI Responder
+--------------
+
+The software running on the BMC needs to intercept reads and writes to the
+system interface registers on the main processor. This requires special
+hardware that needs to be emulated by QEMU. We'll call these device *IPMI
+responders*.
+
+All *IPMI responder* devices should implement the ``ipmi-responder`` interface
+to allow an IPMI Host implementation to interact with them in a standard way.
+
+IPMI Host
+---------
+
+Mirroring the main processor emulation, the responder devices delegate
+emulation of host behavior to a Host device that is a subclass of
+``ipmi-host``. This type of device is called a Host because that's what it
+looks like to the BMC guest software.
+
+The host behavior may be further delegated to an external emulator (e.g.
+another QEMU VM) through the ``ipmi-host-extern`` host implementation. This
+device has a required ``chardev`` property which specifies the communications
+channel to the external host. The wire format is the same as for
+``ipmi-bmc-extern``.
+
 Wire protocol
 =============
 
-- 
2.28.0.709.gb0816b6eb0-goog


