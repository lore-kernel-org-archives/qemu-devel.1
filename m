Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C7B20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha7AZJX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C7B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05qf-0001lB-12
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k05q6-0001Lw-4m
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:18:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k05q2-0002Wz-Gz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595866732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=suw3U2SRBPelvw/teEfa99Vv6v2lBc5It1zYYhdim3A=;
 b=Ha7AZJX5NE1W+N08swsS7TDQWSgJqOb8cT27vTEdMf8VlVTf3WZSRhUssc2/YKHl/UKhBs
 f1IdxS+3JNhmqXlVgjRd3a7jgaWeuT3F/G+07Qdupmv8P5wyw7t+ksZzUbnuBPX/92Knxs
 iFPgVeOJdEPrqNzONiQxEBYsr8qlVsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-4lgGwcgqOnuuwhLoeVyejw-1; Mon, 27 Jul 2020 12:18:46 -0400
X-MC-Unique: 4lgGwcgqOnuuwhLoeVyejw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F8E8017FB;
 Mon, 27 Jul 2020 16:18:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-13.rdu2.redhat.com [10.10.115.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6536931E;
 Mon, 27 Jul 2020 16:18:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 27A1B220264; Mon, 27 Jul 2020 12:18:41 -0400 (EDT)
Date: Mon, 27 Jul 2020 12:18:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: Disable remote posix locks by default
Message-ID: <20200727161841.GA54539@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jimbothom@yandex.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now we enable remote posix locks by default. That means when guest
does a posix lock it sends request to server (virtiofsd). But currently
we only support non-blocking posix lock and return -EOPNOTSUPP for
blocking version.

This means that existing applications which are doing blocking posix
locks get -EOPNOTSUPP and fail. To avoid this, people have been
running virtiosd with option "-o no_posix_lock". For new users it
is still a surprise and trial and error takes them to this option.

Given posix lock implementation is not complete in virtiofsd, disable
it by default. This means that posix locks will work with-in applications
in a guest but not across guests. Anyway we don't support sharing
filesystem among different guests yet in virtiofs so this should
not lead to any kind of surprise or regression and will make life
little easier for virtiofs users.

Reported-by: Aa Aa <jimbothom@yandex.com>
Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 6514674f04..82d8c962d0 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -3208,7 +3208,7 @@ int main(int argc, char *argv[])
     struct lo_data lo = {
         .debug = 0,
         .writeback = 0,
-        .posix_lock = 1,
+        .posix_lock = 0,
         .proc_self_fd = -1,
     };
     struct lo_map_elem *root_elem;
-- 
2.25.4


