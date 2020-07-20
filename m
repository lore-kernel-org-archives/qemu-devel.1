Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3633C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A266A208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 05:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oFp3RE7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxOZZ-0006mA-Sk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 01:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYY-0005hi-0Q; Mon, 20 Jul 2020 01:41:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58563 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxOYU-0005w2-5r; Mon, 20 Jul 2020 01:41:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B99Zd6xBfz9sSJ; Mon, 20 Jul 2020 15:41:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595223689;
 bh=w4FmBXVE0KTHzF/+gsUfXFMNert2KBgkl92U+vdPb5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oFp3RE7Ll+jdRdZdRSqfauUkK0TGyf4Qy82V2xGES736WU6gSJDejsaAbHcLx6xNp
 F+sONBO0FeAFQGF8of5ZNTbf3MhA8alQuJKTi/wa/8rWQxOGE8lCB3ogxQbesuzhxb
 qI92qu9P+2rycInp9SNbMHiqYCQjoKGSY3g0K2Bk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 2/4] spapr_pci: Robustify support of PCI bridges
Date: Mon, 20 Jul 2020 15:41:24 +1000
Message-Id: <20200720054126.258032-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720054126.258032-1-david@gibson.dropbear.id.au>
References: <20200720054126.258032-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 01:41:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Some recent error handling cleanups unveiled issues with our support of
PCI bridges:

1) QEMU aborts when using non-standard PCI bridge types,
   unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handling"

$ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
Unexpected error in object_property_find() at qom/object.c:1240:
qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not found
Aborted (core dumped)

This happens because we assume all PCI bridge types to have a "chassis_nr"
property. This property only exists with the standard PCI bridge type
"pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
much simpler to check the presence of "chassis_nr" earlier.

2) QEMU abort if same "chassis_nr" value is used several times,
   unveiled by commit d2623129a7de "qom: Drop parameter @errp of
   object_property_add() & friends"

$ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=1 \
                        -device pci-bridge,chassis_nr=1
Unexpected error in object_property_try_add() at qom/object.c:1167:
qemu-system-ppc64: -device pci-bridge,chassis_nr=1: attempt to add duplicate property '40000100' to object (type 'container')
Aborted (core dumped)

This happens because we assume that "chassis_nr" values are unique, but
nobody enforces that and we end up generating duplicate DRC ids. The PCI
code doesn't really care for duplicate "chassis_nr" properties since it
is only used to initialize the "Chassis Number Register" of the bridge,
with no functional impact on QEMU. So, even if passing the same value
several times might look weird, it never broke anything before, so
I guess we don't necessarily want to enforce strict checking in the PCI
code now.

Workaround both issues in the PAPR code: check that the bridge has a
unique and non null "chassis_nr" when plugging it into its parent bus.

Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")
Fixes: 7ef1553dac ("spapr_pci: Drop some dead error handling")
Fixes: d2623129a7de ("qom: Drop parameter @errp of object_property_add() & friends")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
[dwg: Move check slightly to a better place]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 2a6a48744a..21681215d4 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1480,6 +1480,57 @@ static void spapr_pci_bridge_plug(SpaprPhbState *phb,
     add_drcs(phb, bus);
 }
 
+/* Returns non-zero if the value of "chassis_nr" is already in use */
+static int check_chassis_nr(Object *obj, void *opaque)
+{
+    int new_chassis_nr =
+        object_property_get_uint(opaque, "chassis_nr", &error_abort);
+    int chassis_nr =
+        object_property_get_uint(obj, "chassis_nr", NULL);
+
+    if (!object_dynamic_cast(obj, TYPE_PCI_BRIDGE)) {
+        return 0;
+    }
+
+    /* Skip unsupported bridge types */
+    if (!chassis_nr) {
+        return 0;
+    }
+
+    /* Skip self */
+    if (obj == opaque) {
+        return 0;
+    }
+
+    return chassis_nr == new_chassis_nr;
+}
+
+static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)
+{
+    int chassis_nr =
+        object_property_get_uint(bridge, "chassis_nr", NULL);
+
+    /*
+     * slotid_cap_init() already ensures that "chassis_nr" isn't null for
+     * standard PCI bridges, so this really tells if "chassis_nr" is present
+     * or not.
+     */
+    if (!chassis_nr) {
+        error_setg(errp, "PCI Bridge lacks a \"chassis_nr\" property");
+        error_append_hint(errp, "Try -device pci-bridge instead.\n");
+        return false;
+    }
+
+    /* We want unique values for "chassis_nr" */
+    if (object_child_foreach_recursive(object_get_root(), check_chassis_nr,
+                                       bridge)) {
+        error_setg(errp, "Bridge chassis %d already in use", chassis_nr);
+        return false;
+    }
+
+    return true;
+}
+
 static void spapr_pci_plug(HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
@@ -1508,6 +1559,9 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     g_assert(drc);
 
     if (pc->is_bridge) {
+        if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
+            return;
+        }
         spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev));
     }
 
-- 
2.26.2


