Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA05C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9349922205
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BK/p66dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9349922205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNRN-0005EC-Tl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNm-0000Kt-IY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNh-00080n-1h
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594742527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyHJr/bBDTg6+0dit92IOQ9uBFEdiYfGfe+lP+xf4C8=;
 b=BK/p66dP1wif58kbh/7dfAREHHl/78+wh+oZI7UzZz7rwuCAOpEONAkVUE8DcuhYP4RKll
 heTYtYpIojUZG1TuPXkTPX3JjrW+xiRK60B5jmN2zuKu1/LmAgjSOgz5ZACyYcKLzYqPa7
 7HtF9w4CkphOfOXGOxcJI7ZVtNDBnOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-VubIWJApNAWQnz-8TZVV0A-1; Tue, 14 Jul 2020 12:02:06 -0400
X-MC-Unique: VubIWJApNAWQnz-8TZVV0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3C0B800597;
 Tue, 14 Jul 2020 16:02:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FBC5C1B2;
 Tue, 14 Jul 2020 16:02:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EACD17741CA; Tue, 14 Jul 2020 18:02:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 2/5] qom: Plug memory leak in "info qom-tree"
Date: Tue, 14 Jul 2020 18:01:59 +0200
Message-Id: <20200714160202.3121879-3-armbru@redhat.com>
In-Reply-To: <20200714160202.3121879-1-armbru@redhat.com>
References: <20200714160202.3121879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e8c9e65816 "qom: Make "info qom-tree" show children sorted"
created a memory leak, because I didn't realize
object_get_canonical_path_component()'s value needs to be freed.

Reproducer:

    $ qemu-system-x86_64 -nodefaults -display none -S -monitor stdio
    QEMU 5.0.50 monitor - type 'help' for more information
    (qemu) info qom-tree

This leaks some 4500 path components, 12-13 characters on average,
i.e. roughly 100kBytes depending on the allocator.  A couple of
hundred "info qom-tree" here, a couple of hundred there, and soon
enough we're talking about real memory.

Plug the leak.

Fixes: e8c9e65816f5dbfe18ad3b2be938d0d8192d459a
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-hmp-cmds.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 9ed8bb1c9f..aaacadacca 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent);
 
 static int qom_composition_compare(const void *a, const void *b, void *ignore)
 {
-    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
-                     b ? object_get_canonical_path_component(b) : NULL);
+    g_autofree char *ac = object_get_canonical_path_component(a);
+    g_autofree char *bc = object_get_canonical_path_component(b);
+
+    return g_strcmp0(ac, bc);
 }
 
 static int insert_qom_composition_child(Object *obj, void *opaque)
-- 
2.26.2


