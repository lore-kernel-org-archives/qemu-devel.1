Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B85C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56594206CB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9hurbdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56594206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRYUu-00078D-8V
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 06:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRYUA-00069A-Pg
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 06:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRYU8-0002iK-By
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 06:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602411707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFOe0AKntJXd1DbWSJAKvmGw7n/k9PTEoCY1i1dOkWo=;
 b=d9hurbdrvaIagOhVOc6Po2/YnN8/2l3t+YFNzhM+eLRNgG+IjfkaVarPqtAXvOGPp6njye
 RgAVB/pjxkrARx4ZOZVcBEKcgC7GTDoX1lTJxsZjFAO/lQPBRiBRXIIY14sFYSkgbXDMJC
 lC3hl6b+I3S7Gk/HGvrsjp/rBSMnfl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Ye_PXnpoPMWomj0fql-UCQ-1; Sun, 11 Oct 2020 06:21:45 -0400
X-MC-Unique: Ye_PXnpoPMWomj0fql-UCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F5E64085;
 Sun, 11 Oct 2020 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7BF60DA0;
 Sun, 11 Oct 2020 10:21:42 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] crypto: luks: fix tiny memory leak
Date: Sun, 11 Oct 2020 13:21:35 +0300
Message-Id: <20201011102136.622361-2-mlevitsk@redhat.com>
In-Reply-To: <20201011102136.622361-1-mlevitsk@redhat.com>
References: <20201011102136.622361-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 02:10:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the case when underlying block device doesn't support the
bdrv_co_delete_file interface, an 'Error' wasn't freed.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/crypto.c b/block/crypto.c
index 0807557763..9b61fd4aa8 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -736,6 +736,7 @@ fail:
         if ((r_del < 0) && (r_del != -ENOTSUP)) {
             error_report_err(local_delete_err);
         }
+        error_free(local_delete_err);
     }
 
     bdrv_unref(bs);
-- 
2.26.2


