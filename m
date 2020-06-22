Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A198620732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Idkss52k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A198620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnR47-00016c-Ui
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnR2u-00006r-NO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:19:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnR2t-0005vQ-3c
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592849990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omB/C5xhlgaHTAk2xiwoKR+JnhPBVcdye6A/qfnjfTY=;
 b=Idkss52k1LDr0qJZNTLFS1WPwViOVRnbsCDiZNKGlzDejJYplG57qWvaUC05ewq+mlUupJ
 VwsDjfU7UaGA0qYyeb+IiM4X3oDKimo2iRKyi/BcU+lUIrsuW2iKsfeXVH1sM76s6jNJB0
 0X/qM7JlxZckovaBGzsEEiif2WENHo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-rqnMv9NaPTWIJLOEMi0LjA-1; Mon, 22 Jun 2020 14:19:48 -0400
X-MC-Unique: rqnMv9NaPTWIJLOEMi0LjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86A7100A907;
 Mon, 22 Jun 2020 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE4D610F2;
 Mon, 22 Jun 2020 18:19:46 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] qga: Use qemu_get_host_name() instead of
 g_get_host_name()
Date: Mon, 22 Jun 2020 20:19:36 +0200
Message-Id: <873fc5052847ee5df75a75e30960d6d4ab44473b.1592849834.git.mprivozn@redhat.com>
In-Reply-To: <cover.1592849834.git.mprivozn@redhat.com>
References: <cover.1592849834.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, vfeenstr@redhat.com, marcandre.lureau@gmail.com,
 mdroth@linux.vnet.ibm.com, sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Problem with g_get_host_name() is that on the first call it saves
the hostname into a global variable and from then on, every
subsequent call returns the saved hostname. Even if the hostname
changes. This doesn't play nicely with guest agent, because if
the hostname is acquired before the guest is set up (e.g. on the
first boot, or before DHCP) we will report old, invalid hostname.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1845127

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qga/commands.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index efc8b90281..d3fec807c1 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -515,11 +515,20 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
 GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
     GuestHostName *result = NULL;
-    gchar const *hostname = g_get_host_name();
-    if (hostname != NULL) {
-        result = g_new0(GuestHostName, 1);
-        result->host_name = g_strdup(hostname);
+    g_autofree char *hostname = qemu_get_host_name(errp);
+
+    /*
+     * We want to avoid using g_get_host_name() because that
+     * caches the result and we wouldn't reflect changes in the
+     * host name.
+     */
+
+    if (!hostname) {
+        hostname = g_strdup("localhost");
     }
+
+    result = g_new0(GuestHostName, 1);
+    result->host_name = g_steal_pointer(&hostname);
     return result;
 }
 
-- 
2.26.2


