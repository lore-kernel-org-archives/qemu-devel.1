Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFD521D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFlVlUc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFD521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8pK-0003ak-Nc
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ug-00019j-DX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ue-0004fz-MZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZoa4RowV/fB16RrOuni5OhsgOZy07E6WT0/T3ii30M=;
 b=MFlVlUc1gD7+6qQeweQ+jkSaifce0tpxf226ATswznRkUFD+5f0uf9Fg0B42A87pj/zGgX
 Bfh13Kusw0HcHVyAoabgB/pol4tbRAoxqvQ1fFoALjrcgEUUNO5tAOJlwOOEOxfG32oB+K
 0BzJoNIL+sOw7Y8IRbV4gkYufojyiF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-EfyzLUtGOaOAn2cZSieiUA-1; Tue, 15 Sep 2020 06:47:19 -0400
X-MC-Unique: EfyzLUtGOaOAn2cZSieiUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFF0A1005E64;
 Tue, 15 Sep 2020 10:47:18 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 514D05FC2A;
 Tue, 15 Sep 2020 10:47:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 22/22] block/rbd: add 'namespace' to
 qemu_rbd_strong_runtime_opts[]
Date: Tue, 15 Sep 2020 12:46:27 +0200
Message-Id: <20200915104627.699552-23-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 19ae9ae014 ("block/rbd: Add support for ceph namespaces")
introduced namespace support for RBD, but we forgot to add the
new 'namespace' options to qemu_rbd_strong_runtime_opts[].

The 'namespace' is used to identify the image, so it is a strong
option since it can changes the data of a BDS.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1821528
Fixes: 19ae9ae014 ("block/rbd: Add support for ceph namespaces")
Cc: Florian Florensa <fflorensa@online.net>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200914190553.74871-1-sgarzare@redhat.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/rbd.c b/block/rbd.c
index 171c67e3a0..9bd2bce716 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1247,6 +1247,7 @@ static QemuOptsList qemu_rbd_create_opts = {
 
 static const char *const qemu_rbd_strong_runtime_opts[] = {
     "pool",
+    "namespace",
     "image",
     "conf",
     "snapshot",
-- 
2.26.2


