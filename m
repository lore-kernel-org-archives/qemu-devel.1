Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C2F208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fd6cSe/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C2F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO3M-0003Y7-IN
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTr-0001Eo-6e
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTm-00065k-K6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRK53+pDYcDLjVOE+RyVzoB7xkv++WHHTKynkaeNFbI=;
 b=Fd6cSe/fej64UASh9U2uskmYye61LR+Mt7wvJjUz7i0kv6vFKTG4e6Se5apQWxPvIawznR
 ZwjUsnugnfc4ljTwhcWo5XIeYa6WEtqtBr99OTNY9gAf7iDMtcAJ+kgIllqqhEKOjrO/lV
 hdIc1zXp20o9/8SiMjQHe9KotvHyv/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Jbv4V-YoPvmIG6I8TaByCQ-1; Thu, 24 Sep 2020 05:23:52 -0400
X-MC-Unique: Jbv4V-YoPvmIG6I8TaByCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38281420F5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05BCF60E1C
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/92] net: relocate paths to helpers and scripts
Date: Thu, 24 Sep 2020 05:22:27 -0400
Message-Id: <20200924092314.1722645-46-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/net/net.h |  4 ++--
 net/tap.c         | 26 +++++++++++++++++++-------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index e7ef42d62b..897b2d7595 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -209,8 +209,8 @@ void netdev_add(QemuOpts *opts, Error **errp);
 int net_hub_id_for_client(NetClientState *nc, int *id);
 NetClientState *net_hub_port_find(int hub_id);
 
-#define DEFAULT_NETWORK_SCRIPT "/etc/qemu-ifup"
-#define DEFAULT_NETWORK_DOWN_SCRIPT "/etc/qemu-ifdown"
+#define DEFAULT_NETWORK_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifup"
+#define DEFAULT_NETWORK_DOWN_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifdown"
 #define DEFAULT_BRIDGE_HELPER CONFIG_QEMU_HELPERDIR "/qemu-bridge-helper"
 #define DEFAULT_BRIDGE_INTERFACE "br0"
 
diff --git a/net/tap.c b/net/tap.c
index 14dc904fca..04ce72dd2f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -478,6 +478,7 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
                                  Error **errp)
 {
     sigset_t oldmask, mask;
+    g_autofree char *default_helper = NULL;
     int pid, status;
     char *args[5];
     char **parg;
@@ -487,6 +488,10 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
     sigaddset(&mask, SIGCHLD);
     sigprocmask(SIG_BLOCK, &mask, &oldmask);
 
+    if (!helper) {
+        helper = default_helper = get_relocated_path(DEFAULT_BRIDGE_HELPER);
+    }
+
     if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) == -1) {
         error_setg_errno(errp, errno, "socketpair() failed");
         return -1;
@@ -588,8 +593,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 
     assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
     bridge = &netdev->u.bridge;
-
-    helper = bridge->has_helper ? bridge->helper : DEFAULT_BRIDGE_HELPER;
+    helper = bridge->has_helper ? bridge->helper : NULL;
     br     = bridge->has_br     ? bridge->br     : DEFAULT_BRIDGE_INTERFACE;
 
     fd = net_bridge_run_helper(helper, br, errp);
@@ -773,8 +777,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    const char *script = NULL; /* suppress wrong "uninit'd use" gcc warning */
-    const char *downscript = NULL;
+    const char *script;
+    const char *downscript;
     Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
@@ -784,6 +788,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
     vhostfdname = tap->has_vhostfd ? tap->vhostfd : NULL;
+    script = tap->has_script ? tap->script : NULL;
+    downscript = tap->has_downscript ? tap->downscript : NULL;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -934,13 +940,19 @@ free_fail:
             return -1;
         }
     } else {
+        g_autofree char *default_script = NULL;
+        g_autofree char *default_downscript = NULL;
         if (tap->has_vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
         }
-        script = tap->has_script ? tap->script : DEFAULT_NETWORK_SCRIPT;
-        downscript = tap->has_downscript ? tap->downscript :
-            DEFAULT_NETWORK_DOWN_SCRIPT;
+
+        if (!script) {
+            script = default_script = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
+        }
+        if (!downscript) {
+            downscript = default_downscript = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
+        }
 
         if (tap->has_ifname) {
             pstrcpy(ifname, sizeof ifname, tap->ifname);
-- 
2.26.2



