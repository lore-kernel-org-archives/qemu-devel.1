Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8388C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05442074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqfDbsHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05442074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EZ8-0005Uk-SY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k1EXA-0001uV-4Q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:48:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k1EX8-0006nQ-Gw
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596138485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaH6/prDe0zOnbw0p8530Sh7BSPAEfCKXw62zps8Fcw=;
 b=JqfDbsHI3gZp7mdod1aAZDep1y/AozSZJVND/aAlrYCqvzRj3UohxKGpcWF2PumhskuEhh
 ZgQTu7KuwKv5/fneq3/hJLFEsPjxDc6pbcfGdjCCEJ9xWChzZrEbC9y2Vqv8SvyRAVbdiV
 qCXNy0CiW66LYwggpCrC4wuGHQem5C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-EYzzquMQPYmMbdvrSRlkPQ-1; Thu, 30 Jul 2020 15:48:03 -0400
X-MC-Unique: EYzzquMQPYmMbdvrSRlkPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851D4101C8A0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 19:48:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-166.rdu2.redhat.com [10.10.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 055E05BAC3;
 Thu, 30 Jul 2020 19:47:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6F4FD223D09; Thu, 30 Jul 2020 15:47:48 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] virtiofsd: Skip setup_capabilities() in sandbox=NONE
 mode
Date: Thu, 30 Jul 2020 15:47:36 -0400
Message-Id: <20200730194736.173994-6-vgoyal@redhat.com>
In-Reply-To: <20200730194736.173994-1-vgoyal@redhat.com>
References: <20200730194736.173994-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, vromanso@redhat.com, dwalsh@redhat.com,
 dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

setup_capabilites() tries to give some of the required capabilities
to act as a full fledged file server in priviliged mode. In unpriviliged
mode we can't get those capabilities and setup_capabilities() will fail.

So don't setup capabilities when sandbox=NONE.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index a6fa816b6c..1a0b24cbf2 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -3030,7 +3030,8 @@ static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
     }
 
     setup_seccomp(enable_syslog);
-    setup_capabilities(g_strdup(lo->modcaps));
+    if (lo->sandbox != SANDBOX_NONE)
+       setup_capabilities(g_strdup(lo->modcaps));
 }
 
 /* Set the maximum number of open file descriptors */
-- 
2.25.4


