Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA8C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA34122277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVgSHDnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA34122277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWUZ-0002TX-FT
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOE-0002QF-Gc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOC-00057I-Ky
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwrmCu8Z+VToUL++7XlQwBDo0tZGAu+UOPIYYneNtSI=;
 b=jVgSHDnZaSJnntjJsv0s11BrS6E9fGRAkxXgh8evrels9J7jygckKU1DZqiRVvkEgYU0Zf
 sCVIK0cpjji9n1PfAg+xYV0fBPhcupxWEMyysNJxHB/TahfZpUMvTwvUAmYsi5/9xALiDB
 IgEwHOyLZSguhMGvjEFhtIoVIpLdOtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-63iiw2GlO52-XrIiRSPjhw-1; Mon, 02 Nov 2020 04:44:34 -0500
X-MC-Unique: 63iiw2GlO52-XrIiRSPjhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44135186840E;
 Mon,  2 Nov 2020 09:44:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B47D1A8EC;
 Mon,  2 Nov 2020 09:44:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0170810EE551; Mon,  2 Nov 2020 10:44:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/11] sockets: Fix socket_sockaddr_to_address_unix() for
 abstract sockets
Date: Mon,  2 Nov 2020 10:44:19 +0100
Message-Id: <20201102094422.173975-9-armbru@redhat.com>
In-Reply-To: <20201102094422.173975-1-armbru@redhat.com>
References: <20201102094422.173975-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
support" neglected to update socket_sockaddr_to_address_unix().  The
function returns a non-abstract socket address for abstract
sockets (wrong) with a null @path (also wrong; a non-optional QAPI str
member must never be null).

The null @path is due to confused code going back all the way to
commit 17c55decec "sockets: add helpers for creating SocketAddress
from a socket".

Add the required special case, and simplify the confused code.

Fixes: 776b97d3605ed0fc94443048fdf988c7725e38a9
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-sockets.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 3ceaa81226..a578c434c2 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1270,10 +1270,20 @@ socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
 
     addr = g_new0(SocketAddress, 1);
     addr->type = SOCKET_ADDRESS_TYPE_UNIX;
-    if (su->sun_path[0]) {
-        addr->u.q_unix.path = g_strndup(su->sun_path, sizeof(su->sun_path));
+#ifdef CONFIG_LINUX
+    if (!su->sun_path[0]) {
+        /* Linux abstract socket */
+        addr->u.q_unix.path = g_strndup(su->sun_path + 1,
+                                        sizeof(su->sun_path) - 1);
+        addr->u.q_unix.has_abstract = true;
+        addr->u.q_unix.abstract = true;
+        addr->u.q_unix.has_tight = true;
+        addr->u.q_unix.tight = salen < sizeof(*su);
+        return addr;
     }
+#endif
 
+    addr->u.q_unix.path = g_strndup(su->sun_path, sizeof(su->sun_path));
     return addr;
 }
 #endif /* WIN32 */
-- 
2.26.2


