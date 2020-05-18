Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6D2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8DB20709
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7ql2V4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8DB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiiE-0007B1-1C
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigl-0005Do-JZ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigk-0003DM-KF
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+juXcJOAG82/3PgIt7OdR8p9Z6Nh/+OtN61JebXt68=;
 b=H7ql2V4YjuK57KvSuABVQNCeGbwMrzpNdBi4BSNv/crEXiXE907q937bUZ94iqUVAa+hFS
 dvnRJxsx1Kuf5+zKldb7PZNdKLKZDvHCcZlhmFwfv7SmzUtNLR9385OQ1gyS8yPKZtcp2U
 MKQEtd2UxNoHUH9CTta5K39TR6YlNC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-NmOhcSM8OBW-NsMvcyfL0g-1; Mon, 18 May 2020 12:32:22 -0400
X-MC-Unique: NmOhcSM8OBW-NsMvcyfL0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2260E107ACCA;
 Mon, 18 May 2020 16:32:21 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A324C5D9DC;
 Mon, 18 May 2020 16:32:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] qemu-nbd: Close inherited stderr
Date: Mon, 18 May 2020 11:32:13 -0500
Message-Id: <20200518163218.649412-2-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
References: <20200518163218.649412-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Raphael Pour <raphael.pour@hetzner.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Pour <raphael.pour@hetzner.com>

Close inherited stderr of the parent if fork_process is false.
Otherwise no one will close it. (introduced by e6df58a5)

This only affected 'qemu-nbd -c /dev/nbd0'.

Signed-off-by: Raphael Pour <raphael.pour@hetzner.com>
Message-Id: <d8ddc993-9816-836e-a3de-c6edab9d9c49@hetzner.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: Enhance commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4aa005004ebd..306e44fb0a4b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -916,7 +916,11 @@ int main(int argc, char **argv)
         } else if (pid == 0) {
             close(stderr_fd[0]);

-            old_stderr = dup(STDERR_FILENO);
+            /* Remember parent's stderr if we will be restoring it. */
+            if (fork_process) {
+                old_stderr = dup(STDERR_FILENO);
+            }
+
             ret = qemu_daemon(1, 0);

             /* Temporarily redirect stderr to the parent's pipe...  */
-- 
2.26.2


