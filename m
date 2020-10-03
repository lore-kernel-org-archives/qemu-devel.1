Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D1CC46466
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 02:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96C3206FA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 02:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh3FcArw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96C3206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOXVs-0003xi-Ku
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 22:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOXUK-0002O6-3t
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 22:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOXUI-0002fE-27
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 22:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601692889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qxe3ZVpSMpdE2wUQdy1oDx4GudQGhTY007X6Dg4W44=;
 b=Eh3FcArw0HDYjCy4UHX7so3JSbv1d+uMRGy1uRsDiT+GJcSX8LzcYYGCe32U+VV6aZ02Wg
 GSUB/ZgAmmx5nlb3LzyAZeK6q9SJmoQ7Ie8vLJWKNxXwBTitniU3ABpyTThOMN0HwFSLve
 qs5W5RcG0eUqhlsr690w3xJOiQlYG+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-L72Th0L2Oo2oscCSTHqWHQ-1; Fri, 02 Oct 2020 22:41:27 -0400
X-MC-Unique: L72Th0L2Oo2oscCSTHqWHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A468F1074648;
 Sat,  3 Oct 2020 02:41:26 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5235A60BE2;
 Sat,  3 Oct 2020 02:41:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] kernel-doc: Handle function typedefs that return pointers
Date: Fri,  2 Oct 2020 22:41:19 -0400
Message-Id: <20201003024123.193840-2-ehabkost@redhat.com>
In-Reply-To: <20201003024123.193840-1-ehabkost@redhat.com>
References: <20201003024123.193840-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 21:59:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One example that was not being parsed correctly by kernel-doc is:

  typedef Object *(ObjectPropertyResolve)(Object *obj,
                                          void *opaque,
                                          const char *part);

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/kernel-doc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 40ad782e342..57a4a72970f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1318,8 +1318,8 @@ sub dump_typedef($$) {
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
 
     # Parse function prototypes
-    if ($x =~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
-	$x =~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
+    if ($x =~ /typedef\s+(\w+\s*\**)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
+	$x =~ /typedef\s+(\w+\s*\**)\s*(\w\S+)\s*\s*\((.*)\);/) {
 
 	# Function typedefs
 	$return_type = $1;
-- 
2.26.2


