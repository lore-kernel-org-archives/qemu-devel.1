Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6204DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BB120708
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0I1uBnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BB120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW092-00050r-HB
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVzhQ-0008Hx-By
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVzhM-0007kf-SP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bxXrlpPLMCF09ngrKuqRoNt3ETWF66Y7x7LfysZEGQ=;
 b=O0I1uBnB/6csKNTELkdAQe6pyHFbbWiSVzKgqgHErm6gLlpoGSeEwt3peU5khI2+ee5WOO
 Q5bkkOEtkAeW0X6n5IVSBKbE1yasqcgcg0sNty03VFroLijE3mB6D1MFFH/wHTqzXbsjkr
 wzu1QZR4+ku4/XnxyRPZmY4bFhiGzFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-U4VKrUo4NvCacn8eBE_TLw-1; Fri, 23 Oct 2020 12:13:42 -0400
X-MC-Unique: U4VKrUo4NvCacn8eBE_TLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2CEFEC507;
 Fri, 23 Oct 2020 16:13:40 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB4C5C1CF;
 Fri, 23 Oct 2020 16:13:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/6] qemu-storage-daemon: Use qmp_chardev_add() for
 --chardev
Date: Fri, 23 Oct 2020 18:13:12 +0200
Message-Id: <20201023161312.460406-7-kwolf@redhat.com>
In-Reply-To: <20201023161312.460406-1-kwolf@redhat.com>
References: <20201023161312.460406-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

While this makes the code quite a bit longer and arguably isn't very
elegant, it removes the dependency on QemuOpts from the --chardev option
of the storage daemon.

Going through qmp_chardev_add() already now ensures that semantics and
accessible features won't change incompatibly once we QAPIfy it fully.

Note that there are a few differences between the command line option
-chardev in the system emulator and chardev-add in QMP. The --chardev
option of qemu-storage-daemon will follow QMP in these respects:

* All chardev types using ChardevHostdev accept a "path" option on the
  command line, but QMP renamed it to "device"

* ChardevSocket:

  - Intentionally different defaults (documented as such): server=false
    and wait=true (if server=true) on the command line, but server=true
    and wait=false in QMP.

  - Accidentally different defaults: tight=true on the command line, but
    tight=false in QMP (this is a bug in commit 776b97d3).

  - QMP has a nested SocketAddressLegacy field, whereas the command line
    accepts "path"/"host"/"port"/"fd"/etc. on the top level.

  - The command line has a "delay" option, but QMP has "nodelay"

* ChardevUdp has two SocketAddressLegacy fields, the command line has
  "host"/"port"/"localaddr"/"localport" on the top level with defaults
  for values that are mandatory in SocketAddressLegacy

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 storage-daemon/qemu-storage-daemon.c | 47 ++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index e419ba9f19..b543c30951 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -37,6 +37,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-block-export.h"
+#include "qapi/qapi-visit-char.h"
 #include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -207,18 +208,46 @@ static void process_options(int argc, char *argv[])
             }
         case OPTION_CHARDEV:
             {
-                /* TODO This interface is not stable until we QAPIfy it */
-                QemuOpts *opts = qemu_opts_parse_noisily(&qemu_chardev_opts,
-                                                         optarg, true);
-                if (opts == NULL) {
-                    exit(EXIT_FAILURE);
-                }
+                QDict *args;
+                Visitor *v;
+                ChardevBackend *chr_options;
+                char *id;
+                bool help;
 
-                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
-                    /* No error, but NULL returned means help was printed */
+                args = keyval_parse(optarg, "type", &help, &error_fatal);
+                if (help) {
+                    if (qdict_haskey(args, "type")) {
+                        /* TODO Print help based on the QAPI schema */
+                        qemu_opts_print_help(&qemu_chardev_opts, true);
+                    } else {
+                        qemu_chr_print_types();
+                    }
                     exit(EXIT_SUCCESS);
                 }
-                qemu_opts_del(opts);
+
+                /*
+                 * TODO Flattened version of chardev-add in the QAPI schema
+                 *
+                 * While it's not there, parse 'id' manually from the QDict
+                 * and treat everything else as the 'backend' option for
+                 * chardev-add.
+                 */
+                id = g_strdup(qdict_get_try_str(args, "id"));
+                if (!id) {
+                    error_report("Parameter 'id' is missing");
+                    exit(EXIT_FAILURE);
+                }
+                qdict_del(args, "id");
+
+                v = qobject_input_visitor_new_keyval(QOBJECT(args));
+                visit_set_flat_simple_unions(v, true);
+                visit_type_ChardevBackend(v, NULL, &chr_options, &error_fatal);
+                visit_free(v);
+
+                qmp_chardev_add(id, chr_options, &error_fatal);
+                qapi_free_ChardevBackend(chr_options);
+                g_free(id);
+                qobject_unref(args);
                 break;
             }
         case OPTION_EXPORT:
-- 
2.28.0


