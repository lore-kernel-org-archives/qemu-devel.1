Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E367C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF5F22277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYIrmWto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF5F22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWPX-00040H-Gx
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOC-0002Oa-Q2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOA-00056B-Pn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hY3XoHDJm32PZi7BwJLzO4ic4jZo8hY8HxWuZY+w1x4=;
 b=AYIrmWtoZtOcUnLshx3/shJ2IqSiychAaCk+5VQGZ0zXyhgSJfXF60QvpcgSXUE2ah4ehI
 Ri6S8WNFEtxvzfSMMkqO75tGT27Kyl5GJ5i0IP4qXTARF5DqN6cUcXaGOlL2XLykorjhmx
 2aaAwKW+PUx+Q7nq4lnROd3pMEI5AZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-99FV2V9uMWmA_TGSzaU8Pw-1; Mon, 02 Nov 2020 04:44:32 -0500
X-MC-Unique: 99FV2V9uMWmA_TGSzaU8Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04870809DC7;
 Mon,  2 Nov 2020 09:44:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB22672C0;
 Mon,  2 Nov 2020 09:44:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E20601132921; Mon,  2 Nov 2020 10:44:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/11] test-util-sockets: Correct to set has_abstract,
 has_tight
Date: Mon,  2 Nov 2020 10:44:13 +0100
Message-Id: <20201102094422.173975-3-armbru@redhat.com>
In-Reply-To: <20201102094422.173975-1-armbru@redhat.com>
References: <20201102094422.173975-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code tested doesn't care, which is a bug I will fix shortly.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-util-sockets.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 15da867b8f..9d317e73a6 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -243,7 +243,9 @@ static gpointer unix_server_thread_func(gpointer user_data)
 
     addr.type = SOCKET_ADDRESS_TYPE_UNIX;
     addr.u.q_unix.path = abstract_sock_name;
+    addr.u.q_unix.has_tight = true;
     addr.u.q_unix.tight = user_data != NULL;
+    addr.u.q_unix.has_abstract = true;
     addr.u.q_unix.abstract = true;
 
     fd = socket_listen(&addr, 1, &err);
@@ -267,7 +269,9 @@ static gpointer unix_client_thread_func(gpointer user_data)
 
     addr.type = SOCKET_ADDRESS_TYPE_UNIX;
     addr.u.q_unix.path = abstract_sock_name;
+    addr.u.q_unix.has_tight = true;
     addr.u.q_unix.tight = user_data != NULL;
+    addr.u.q_unix.has_abstract = true;
     addr.u.q_unix.abstract = true;
 
     fd = socket_connect(&addr, &err);
-- 
2.26.2


