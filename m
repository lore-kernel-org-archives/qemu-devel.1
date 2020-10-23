Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFFAC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D56208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw7I1qgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D56208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVu5R-0007Bz-PP
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4E-0005Rr-Uh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4C-0001cS-JF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603447979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tP/gMH/HfFI5S2PE5IDkwCGaaGnO+UQ47UdNsudO/w=;
 b=cw7I1qgEvwsfZUfF262yTqOTjqlc4O1qvGBR4CnQHKlk2lx2yg3wJnZLWv5hOUW5Ja1b5f
 4NoRbrf0I4rZLeTQNA+7yyU0CRR6jZyh9GH4oWnqkYF2tPTCeLH7rFHCx1VHnqShd1aOLD
 KHGswdCxrls1Y1tKCTPWIri0+1VRYy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-9U1rg_a2OXCWqOg8Zdgdyg-1; Fri, 23 Oct 2020 06:12:57 -0400
X-MC-Unique: 9U1rg_a2OXCWqOg8Zdgdyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE767186DD27;
 Fri, 23 Oct 2020 10:12:56 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CD1A6EF41;
 Fri, 23 Oct 2020 10:12:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/6] char: Factor out qemu_chr_print_types()
Date: Fri, 23 Oct 2020 12:12:18 +0200
Message-Id: <20201023101222.250147-3-kwolf@redhat.com>
In-Reply-To: <20201023101222.250147-1-kwolf@redhat.com>
References: <20201023101222.250147-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll want to call the same from a non-QemuOpts code path.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/chardev/char.h |  1 +
 chardev/char.c         | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index db42f0a8c6..3b91645081 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -212,6 +212,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
  */
 void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
 
+void qemu_chr_print_types(void);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
 
diff --git a/chardev/char.c b/chardev/char.c
index 78553125d3..028612c333 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -633,6 +633,16 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
     return backend;
 }
 
+void qemu_chr_print_types(void)
+{
+    GString *str = g_string_new("");
+
+    chardev_name_foreach(help_string_append, str);
+
+    qemu_printf("Available chardev backend types: %s\n", str->str);
+    g_string_free(str, true);
+}
+
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
                                 Error **errp)
 {
@@ -644,12 +654,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     char *bid = NULL;
 
     if (name && is_help_option(name)) {
-        GString *str = g_string_new("");
-
-        chardev_name_foreach(help_string_append, str);
-
-        qemu_printf("Available chardev backend types: %s\n", str->str);
-        g_string_free(str, true);
+        qemu_chr_print_types();
         return NULL;
     }
 
-- 
2.28.0


