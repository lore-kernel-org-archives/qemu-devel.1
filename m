Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8475C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B05206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2iOH26v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B05206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcTo-0001yR-Ol
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcRr-0005yW-LL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcRq-0000MU-2v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oIY682DeEuaCbUEJmw3MHm6R2Ne5vdY+4EdtReIoGY=;
 b=H2iOH26vAt4jpIfVNgzwliSU2K51oX22khy68QaQvdzamvsXlK7L67LVxpUwqCIVy3l7+p
 76j9Kktth42QaskHFDWYo3q5ClFCf2AJ0jSo4RVPgJWD1BBj4rn3+JjNn59nWg18e5G4AH
 RcaZ5bJDLLpTRjd3rXXpDB31vnezaUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-LIN7KR14OAWIIdVRKeizgw-1; Thu, 09 Jul 2020 15:43:07 -0400
X-MC-Unique: LIN7KR14OAWIIdVRKeizgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32A06C7466;
 Thu,  9 Jul 2020 19:43:06 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CE677981F;
 Thu,  9 Jul 2020 19:43:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] block/vxhs: auto-ify URI parsing variables
Date: Thu,  9 Jul 2020 23:42:24 +0400
Message-Id: <20200709194234.2117650-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/vxhs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/vxhs.c b/block/vxhs.c
index d79fc97df66..5d61cfb7548 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -174,14 +174,12 @@ static QemuOptsList runtime_tcp_opts = {
  */
 static int vxhs_parse_uri(const char *filename, QDict *options)
 {
-    URI *uri = NULL;
-    char *port;
-    int ret = 0;
+    g_autoptr(URI) uri = NULL;
+    g_autofree char *port = NULL;
 
     trace_vxhs_parse_uri_filename(filename);
     uri = uri_parse(filename);
     if (!uri || !uri->server || !uri->path) {
-        uri_free(uri);
         return -EINVAL;
     }
 
@@ -190,15 +188,13 @@ static int vxhs_parse_uri(const char *filename, QDict *options)
     if (uri->port) {
         port = g_strdup_printf("%d", uri->port);
         qdict_put_str(options, VXHS_OPT_SERVER ".port", port);
-        g_free(port);
     }
 
     qdict_put_str(options, "vdisk-id", uri->path);
 
     trace_vxhs_parse_uri_hostinfo(uri->server, uri->port);
-    uri_free(uri);
 
-    return ret;
+    return 0;
 }
 
 static void vxhs_parse_filename(const char *filename, QDict *options,
-- 
2.27.0.221.ga08a83db2b


