Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 21:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8771220825
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iveyGIw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8771220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyMDJ-0001pL-So
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 17:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyMCO-0000uY-3I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 17:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyMCL-0004mQ-Fw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 17:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595452964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B9+YDjP4qEkKntT1sMjchOWGstNEksxlhJZaKqmixrk=;
 b=iveyGIw13/JrNTY51UsvrmRdFETAJsS52dkz9Pw6cT6SUWAAMZaaBwPgqspfFSrxK49b5z
 PmF/Usy6HjshwsoiSNRsfBfIVQu/yUwXia9zxmU9CuVJr5eEYtwaSPUVV3eCFRgKz7ODCn
 oKfSEgWoZDlSHIKzWwhWRv8Nz7Xm6As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-PZjyX5QiPAi_wIBQJUkY3Q-1; Wed, 22 Jul 2020 17:22:40 -0400
X-MC-Unique: PZjyX5QiPAi_wIBQJUkY3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CAC918C63C1;
 Wed, 22 Jul 2020 21:22:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F173B5C1BB;
 Wed, 22 Jul 2020 21:22:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] nbd: Fix large trim/zero requests
Date: Wed, 22 Jul 2020 16:22:31 -0500
Message-Id: <20200722212231.535072-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: vsementsov@virtuozzo.com, qemu-stable@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although qemu as NBD client limits requests to <2G, the NBD protocol
allows clients to send requests almost all the way up to 4G.  But
because our block layer is not yet 64-bit clean, we accidentally wrap
such requests into a negative size, and fail with EIO instead of
performing the intended operation.

The bug is visible in modern systems with something as simple as:

$ qemu-img create -f qcow2 /tmp/image.img 5G
$ sudo qemu-nbd --connect=/dev/nbd0 /tmp/image.img
$ sudo blkdiscard /dev/nbd0

or with user-space only:

$ truncate --size=3G file
$ qemu-nbd -f raw file
$ nbdsh -u nbd://localhost:10809 -c 'h.trim(3*1024*1024*1024,0)'

Alas, our iotests do not currently make it easy to add external
dependencies on blkdiscard or nbdsh, so we have to rely on manual
testing for now.

This patch can be reverted when we later improve the overall block
layer to be 64-bit clean, but for now, a minimal fix was deemed less
risky prior to release.

CC: qemu-stable@nongnu.org
Fixes: 1f4d6d18ed
Fixes: 1c6c4bb7f0
Fixes: https://github.com/systemd/systemd/issues/16242
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4752a6c8bc07..029618017c90 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2378,8 +2378,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
             flags |= BDRV_REQ_NO_FALLBACK;
         }
-        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
-                                request->len, flags);
+        ret = 0;
+        /* FIXME simplify this when blk_pwrite_zeroes switches to 64-bit */
+        while (ret == 0 && request->len) {
+            int align = client->check_align ?: 1;
+            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                                        align));
+            ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
+                                    len, flags);
+            request->len -= len;
+            request->from += len;
+        }
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "writing to file failed", errp);

@@ -2393,8 +2402,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "flush failed", errp);

     case NBD_CMD_TRIM:
-        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
-                              request->len);
+        ret = 0;
+        /* FIXME simplify this when blk_co_pdiscard switches to 64-bit */
+        while (ret == 0 && request->len) {
+            int align = client->check_align ?: 1;
+            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                                        align));
+            ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
+                                  len);
+            request->len -= len;
+            request->from += len;
+        }
         if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->blk);
         }
-- 
2.27.0


