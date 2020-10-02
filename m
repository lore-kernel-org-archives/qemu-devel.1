Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEEFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A560C206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5hq4mDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A560C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMXE-0004ng-Mx
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMIF-0001fb-Qp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMID-0004ZH-Dp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oU4wIUtNWlL0lHrzq52j/ZFdiheTWGrcaPhI9T2bBRg=;
 b=S5hq4mDHs6LmMok/LLyncn04xUU7KsvD7Wrw//C9QXgPe8cQNGkk+GQ5l2MLbuFqNhOCx6
 48b5goiZuB2+e/jVju/ldxa6MbgbCnpJECHldP6xjpbhorwJOTIXKVurM3q74R2BG8sb+/
 OH+dcli6ciofyKF9e/cK0dka4eLCKts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-8Xl9FQBbPrSA2vJz03HqLw-1; Fri, 02 Oct 2020 10:44:15 -0400
X-MC-Unique: 8Xl9FQBbPrSA2vJz03HqLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4C611054F8E;
 Fri,  2 Oct 2020 14:44:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0B1C5D9D3;
 Fri,  2 Oct 2020 14:44:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/37] nbd/server: Simplify export shutdown
Date: Fri,  2 Oct 2020 16:43:24 +0200
Message-Id: <20201002144345.253865-17-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Closing export is somewhat convoluted because nbd_export_close() and
nbd_export_put() call each other and the ways they actually end up being
nested is not necessarily obvious.

However, it is not really necessary to call nbd_export_close() from
nbd_export_put() when putting the last reference because it only does
three things:

1. Close all clients. We're going to refcount 0 and all clients hold a
   reference, so we know there is no active client any more.

2. Close the user reference (represented by exp->name being non-NULL).
   The same argument applies: If the export were still named, we would
   still have a reference.

3. Freeing exp->description. This is really cleanup work to be done when
   the export is finally freed. There is no reason to already clear it
   while clients are still in the process of shutting down.

So after moving the cleanup of exp->description, the code can be
simplified so that only nbd_export_close() calls nbd_export_put(), but
never the other way around.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200924152717.287415-13-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 1cc915f01d..fb70374df5 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1678,8 +1678,6 @@ void nbd_export_close(NBDExport *exp)
         QTAILQ_REMOVE(&exports, exp, next);
         QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
-    g_free(exp->description);
-    exp->description = NULL;
     nbd_export_put(exp);
 }
 
@@ -1706,19 +1704,12 @@ void nbd_export_get(NBDExport *exp)
 void nbd_export_put(NBDExport *exp)
 {
     assert(exp->refcount > 0);
-    if (exp->refcount == 1) {
-        nbd_export_close(exp);
-    }
-
-    /* nbd_export_close() may theoretically reduce refcount to 0. It may happen
-     * if someone calls nbd_export_put() on named export not through
-     * nbd_export_set_name() when refcount is 1. So, let's assert that
-     * it is > 0.
-     */
-    assert(exp->refcount > 0);
     if (--exp->refcount == 0) {
         assert(exp->name == NULL);
-        assert(exp->description == NULL);
+        assert(QTAILQ_EMPTY(&exp->clients));
+
+        g_free(exp->description);
+        exp->description = NULL;
 
         if (exp->blk) {
             if (exp->eject_notifier_blk) {
-- 
2.25.4


