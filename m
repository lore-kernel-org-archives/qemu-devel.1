Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B467C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F2B20760
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGGExz3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F2B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsO92-0003gY-AK
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0C-00048S-QI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0A-0004AB-Om
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdEbVbX3Z61jyldCHMRCapQ7vjSG4vYACWPwWORtrLA=;
 b=YGGExz3PTHzONhG89ley583oQbyzLFF4FTdhcLWICBpZsWXqPbfjChOiGfP57qaBRMm7w0
 sd14wP1e49Nh2eirXR5qG84xzujy3NSQ5Rr0HcXdRteFrUSxQ3ZnXtiDWcOTVuyokbmAdO
 XzekhNj/7G7axLytaLbwFvQZJDQHWB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-5Pda6o7-NESwFB_qYbGQPw-1; Mon, 06 Jul 2020 06:05:28 -0400
X-MC-Unique: 5Pda6o7-NESwFB_qYbGQPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22CFC107ACCD;
 Mon,  6 Jul 2020 10:05:27 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7266CF945;
 Mon,  6 Jul 2020 10:05:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 22/31] qemu-img: convert: don't use unallocated_blocks_are_zero
Date: Mon,  6 Jul 2020 12:04:23 +0200
Message-Id: <20200706100432.2301919-23-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

qemu-img convert wants to distinguish ZERO which comes from short
backing files. unallocated_blocks_are_zero field of bdi is unrelated:
space after EOF is always considered to be zero anyway. So, just make
post_backing_zero true in case of short backing file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528094405.145708-2-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7f4938a5ef..53bd32bf8f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1681,7 +1681,6 @@ typedef struct ImgConvertState {
     BlockBackend *target;
     bool has_zero_init;
     bool compressed;
-    bool unallocated_blocks_are_zero;
     bool target_is_new;
     bool target_has_backing;
     int64_t target_backing_sectors; /* negative if unknown */
@@ -1726,7 +1725,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
     if (s->target_backing_sectors >= 0) {
         if (sector_num >= s->target_backing_sectors) {
-            post_backing_zero = s->unallocated_blocks_are_zero;
+            post_backing_zero = true;
         } else if (sector_num + n > s->target_backing_sectors) {
             /* Split requests around target_backing_sectors (because
              * starting from there, zeros are handled differently) */
@@ -2678,7 +2677,6 @@ static int img_convert(int argc, char **argv)
     } else {
         s.compressed = s.compressed || bdi.needs_compressed_writes;
         s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
-        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
     }
 
     ret = convert_do_copy(&s);
-- 
2.26.2


