Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB6BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6AF20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnvI69ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6AF20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jailX-0004dT-ID
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigm-0005HQ-KU
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigl-0003Go-P4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdxmpdzEUZLLZ6Q0W0qyeGo0cYkBFewYpDPT/hVS0mk=;
 b=hnvI69ESUXJm7DlbMAzQARrKEMY7ETGRGhUjwAiJv4ATZRHjDos5546JdkfRySgXmYpduw
 xtD6AEyTciZNphRFMPd/w0m6VevSZOTse2VtYSUSfERnwIlJGWnefaPXkA1nvuuUUVPPDx
 RwEeIKRvlT0uj1SKmtboir7N3ZF6Rm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-bryVW3gRM8O-J_HMQKjMdA-1; Mon, 18 May 2020 12:32:23 -0400
X-MC-Unique: bryVW3gRM8O-J_HMQKjMdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 862C5EC1AB;
 Mon, 18 May 2020 16:32:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD505D9DC;
 Mon, 18 May 2020 16:32:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] qemu-img: validate image length in img_map
Date: Mon, 18 May 2020 11:32:15 -0500
Message-Id: <20200518163218.649412-4-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
References: <20200518163218.649412-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Moscovici <eyal.moscovici@oracle.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eyal Moscovici <eyal.moscovici@oracle.com>

The code handles this case correctly: we merely skip the loop. However it
is probably best to return an explicit error.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-Id: <20200513133629.18508-3-eyal.moscovici@oracle.com>
[eblake: commit message tweak]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 5d824fc15f39..c88f412333ec 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3092,6 +3092,11 @@ static int img_map(int argc, char **argv)
     }

     length = blk_getlength(blk);
+    if (length < 0) {
+        error_report("Failed to get size for '%s'", filename);
+        return 1;
+    }
+
     while (curr.start + curr.length < length) {
         int64_t offset = curr.start + curr.length;
         int64_t n;
-- 
2.26.2


