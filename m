Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E9620758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1CbKK88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaik1-0001Kv-1Q
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigm-0005Gn-EX
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigl-0003GL-CD
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49/f+keEDjKs+v+LzGBui/j6kv7VOomAe8IriXvd7qU=;
 b=R1CbKK88ZiGMgGvOTuHyvNnDMYCXRsHL9VNZLJngYIEgMDZTmWEfwhW75IrPdL3IlWdCC3
 HPKlGytMoXKq1hL6uzcLZ6jmKW2FK3fr8eDKnI5pu6Gpts4UjjMcTRArkpm5iKVMn/9x/s
 YhyM8UL3DhzuJzvix4J4qK41xAeaAKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-4ipxGvMUPkWpzSDahPDmeA-1; Mon, 18 May 2020 12:32:24 -0400
X-MC-Unique: 4ipxGvMUPkWpzSDahPDmeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3703E835B74;
 Mon, 18 May 2020 16:32:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD4525D9DC;
 Mon, 18 May 2020 16:32:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] qemu-img: refactor dump_map_entry JSON format output
Date: Mon, 18 May 2020 11:32:16 -0500
Message-Id: <20200518163218.649412-5-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
References: <20200518163218.649412-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
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

Previously dump_map_entry identified whether we need to start a new JSON
array based on whether start address == 0. In this refactor we remove
this assumption as in following patches we will allow map to start from
an arbitrary position.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-Id: <20200513133629.18508-4-eyal.moscovici@oracle.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index c88f412333ec..4aa9414aba6f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2902,9 +2902,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         break;
     case OFORMAT_JSON:
-        printf("%s{ \"start\": %"PRId64", \"length\": %"PRId64","
+        printf("{ \"start\": %"PRId64", \"length\": %"PRId64","
                " \"depth\": %"PRId64", \"zero\": %s, \"data\": %s",
-               (e->start == 0 ? "[" : ",\n"),
                e->start, e->length, e->depth,
                e->zero ? "true" : "false",
                e->data ? "true" : "false");
@@ -2913,8 +2912,8 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
         }
         putchar('}');

-        if (!next) {
-            printf("]\n");
+        if (next) {
+            puts(",");
         }
         break;
     }
@@ -3089,6 +3088,8 @@ static int img_map(int argc, char **argv)

     if (output_format == OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");
+    } else if (output_format == OFORMAT_JSON) {
+        putchar('[');
     }

     length = blk_getlength(blk);
@@ -3125,6 +3126,9 @@ static int img_map(int argc, char **argv)
     }

     ret = dump_map_entry(output_format, &curr, NULL);
+    if (output_format == OFORMAT_JSON) {
+        puts("]");
+    }

 out:
     blk_unref(blk);
-- 
2.26.2


