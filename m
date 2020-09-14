Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A588C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE31208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkMdwxgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE31208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHtoh-0002tg-D7
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 15:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kHtnj-0002Aa-5j
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:06:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kHtng-0003C0-NH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600110362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oFZdK73Fi1v06R1BQEtNO5ERcMGQtQ2UZdsZwov3AW8=;
 b=NkMdwxggPlli/aBBaK1hs/a929BEoWjGljOqv2eWqEJJjaxonTrFV+9+urYbOYDmcXmKhn
 UKWkC7Ta1HGXA6AiE2pG55Y1X37Sxmvep+wMZjBeZOqub9PlYzk1rtMPT4IPV/IE0iFAhU
 x9ql7ogildoMZozPBfe0F3mhvNmHLV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-_JR80_WYOoOhxc5u5ap3Ug-1; Mon, 14 Sep 2020 15:06:00 -0400
X-MC-Unique: _JR80_WYOoOhxc5u5ap3Ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7422B802B61;
 Mon, 14 Sep 2020 19:05:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-152.ams2.redhat.com
 [10.36.114.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 042B35DA7E;
 Mon, 14 Sep 2020 19:05:54 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block/rbd: add 'namespace' to qemu_rbd_strong_runtime_opts[]
Date: Mon, 14 Sep 2020 21:05:53 +0200
Message-Id: <20200914190553.74871-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Florian Florensa <fflorensa@online.net>,
 Jason Dillaman <dillaman@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 19ae9ae014 ("block/rbd: Add support for ceph namespaces")
introduced namespace support for RBD, but we forgot to add the
new 'namespace' options to qemu_rbd_strong_runtime_opts[].

The 'namespace' is used to identify the image, so it is a strong
option since it can changes the data of a BDS.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1821528
Fixes: 19ae9ae014 ("block/rbd: Add support for ceph namespaces")
Cc: Florian Florensa <fflorensa@online.net>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/rbd.c b/block/rbd.c
index 688074c64b..5356753fbe 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1289,6 +1289,7 @@ static QemuOptsList qemu_rbd_create_opts = {
 
 static const char *const qemu_rbd_strong_runtime_opts[] = {
     "pool",
+    "namespace",
     "image",
     "conf",
     "snapshot",
-- 
2.26.2


