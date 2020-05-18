Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A05C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3B620715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgiHm0/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3B620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jak7b-0007k1-Ot
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jak4h-0005Bb-BC
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:01:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jak4g-00033j-9x
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589824873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=49tYsxIzzACQzUjPEMtptE4ywZ48RR5MimwNRO4Z8aM=;
 b=GgiHm0/ZlroQLAsZjnbCawrhuIfbUvhNXIrT3Uhj18JBFNyx2Qe5XjySAB2g3m5DP5i7ix
 I3PyeT+Z+/65f8gYaGDeNdQozGfTjidAVf3rPFEz895c0nGaJjuSpLip4CThcAvThPE5UB
 sRd4DGg9hpFgIYKr22lDDfT5Eiunz4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-33UsVXUCPm6EIefVrc_Wtw-1; Mon, 18 May 2020 14:01:09 -0400
X-MC-Unique: 33UsVXUCPm6EIefVrc_Wtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A268108BD0D
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 18:01:08 +0000 (UTC)
Received: from thuth.com (ovpn-112-242.ams2.redhat.com [10.36.112.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1902C1001B2C;
 Mon, 18 May 2020 18:01:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] net: Drop the legacy "name" parameter from the -net
 option
Date: Mon, 18 May 2020 20:01:02 +0200
Message-Id: <20200518180103.32484-2-thuth@redhat.com>
In-Reply-To: <20200518180103.32484-1-thuth@redhat.com>
References: <20200518180103.32484-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

It's been deprecated since QEMU v3.1, so it's time to finally
remove it. The "id" parameter can simply be used instead.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/deprecated.rst | 15 +++++++++------
 net/net.c                  | 10 +---------
 qapi/net.json              |  3 ---
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3142fac386..1b87c8f0db 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -47,12 +47,6 @@ The 'file' driver for drives is no longer appropriate for character or host
 devices and will only accept regular files (S_IFREG). The correct driver
 for these file types is 'host_cdrom' or 'host_device' as appropriate.
 
-``-net ...,name=``\ *name* (since 3.1)
-''''''''''''''''''''''''''''''''''''''
-
-The ``name`` parameter of the ``-net`` option is a synonym
-for the ``id`` parameter, which should now be used instead.
-
 ``-smp`` (invalid topologies) (since 3.1)
 '''''''''''''''''''''''''''''''''''''''''
 
@@ -470,6 +464,15 @@ What follows is a record of recently removed, formerly deprecated
 features that serves as a record for users who have encountered
 trouble after a recent upgrade.
 
+System emulator command line arguments
+--------------------------------------
+
+``-net ...,name=``\ *name* (removed in 5.1)
+'''''''''''''''''''''''''''''''''''''''''''
+
+The ``name`` parameter of the ``-net`` option was a synonym
+for the ``id`` parameter, which should now be used instead.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/net/net.c b/net/net.c
index 38778e831d..a24da66e66 100644
--- a/net/net.c
+++ b/net/net.c
@@ -969,12 +969,10 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
 {
     Netdev legacy = {0};
     const Netdev *netdev;
-    const char *name;
     NetClientState *peer = NULL;
 
     if (is_netdev) {
         netdev = object;
-        name = netdev->id;
 
         if (netdev->type == NET_CLIENT_DRIVER_NIC ||
             !net_client_init_fun[netdev->type]) {
@@ -987,12 +985,6 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
         const NetLegacyOptions *opts = net->opts;
         legacy.id = net->id;
         netdev = &legacy;
-        /* missing optional values have been initialized to "all bits zero" */
-        name = net->has_id ? net->id : net->name;
-
-        if (net->has_name) {
-            warn_report("The 'name' parameter is deprecated, use 'id' instead");
-        }
 
         /* Map the old options to the new flat type */
         switch (opts->type) {
@@ -1052,7 +1044,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
         }
     }
 
-    if (net_client_init_fun[netdev->type](netdev, name, peer, errp) < 0) {
+    if (net_client_init_fun[netdev->type](netdev, netdev->id, peer, errp) < 0) {
         /* FIXME drop when all init functions store an Error */
         if (errp && !*errp) {
             error_setg(errp, QERR_DEVICE_INIT_FAILED,
diff --git a/qapi/net.json b/qapi/net.json
index cebb1b52e3..fc7c95f6d8 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -474,8 +474,6 @@
 #
 # @id: identifier for monitor commands
 #
-# @name: identifier for monitor commands, ignored if @id is present
-#
 # @opts: device type specific properties (legacy)
 #
 # Since: 1.2
@@ -483,7 +481,6 @@
 { 'struct': 'NetLegacy',
   'data': {
     '*id':   'str',
-    '*name': 'str',
     'opts':  'NetLegacyOptions' } }
 
 ##
-- 
2.18.1


