Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FBEC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C044D2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foIT7yyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C044D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdmK-0000Qp-17
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl7-0007Bv-RN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl4-0006If-CC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598618729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t73ewfhGZEjgSMUi7kGzfxkTAmXERrI2xtvf7jXFApM=;
 b=foIT7yyoyu/an+k7hsQFYszCGygw5lKgg9GFtUgWAeqLDKBnilBlVCyVVE1qbWpo1VVe3z
 3i1akhH5qQca5yjPZoO7PPTxSmLXryyiCMSBsTi8AL9P4ytvV/66AY2rwxOWcukXMoqJ6k
 iOXo0jK6hjnBDeg4LduS5i+tBtjjMvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-w6TCohBiMCi0n614JV49xg-1; Fri, 28 Aug 2020 08:45:27 -0400
X-MC-Unique: w6TCohBiMCi0n614JV49xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817B480EF84;
 Fri, 28 Aug 2020 12:45:25 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-100.ams2.redhat.com
 [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F43774E12;
 Fri, 28 Aug 2020 12:45:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 slp@redhat.com, yezhenyu2@huawei.com, longpeng2@huawei.com,
 berrange@redhat.com
Subject: [PULL 4/8] migration: tls: fix memory leak in migration_tls_get_creds
Date: Fri, 28 Aug 2020 13:45:05 +0100
Message-Id: <20200828124509.311210-5-dgilbert@redhat.com>
In-Reply-To: <20200828124509.311210-1-dgilbert@redhat.com>
References: <20200828124509.311210-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 02:09:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhenyu Ye <yezhenyu2@huawei.com>

Currently migration_tls_get_creds() adds the reference of creds
but there was no place to unref it.  So the OBJECT(creds) will
never be freed and result in memory leak.

The leak stack:
Direct leak of 104 byte(s) in 1 object(s) allocated from:
    #0 0xffffa88bd20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
    #1 0xffffa7f0cb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
    #2 0x14b58cb in object_new_with_type qom/object.c:634
    #3 0x14b597b in object_new qom/object.c:645
    #4 0x14c0e4f in user_creatable_add_type qom/object_interfaces.c:59
    #5 0x141c78b in qmp_object_add qom/qom-qmp-cmds.c:312
    #6 0x140e513 in qmp_marshal_object_add qapi/qapi-commands-qom.c:279
    #7 0x176ba97 in do_qmp_dispatch qapi/qmp-dispatch.c:165
    #8 0x176bee7 in qmp_dispatch qapi/qmp-dispatch.c:208
    #9 0x136e337 in monitor_qmp_dispatch monitor/qmp.c:150
    #10 0x136eae3 in monitor_qmp_bh_dispatcher monitor/qmp.c:239
    #11 0x1852e93 in aio_bh_call util/async.c:89
    #12 0x18531b7 in aio_bh_poll util/async.c:117
    #13 0x18616bf in aio_dispatch util/aio-posix.c:459
    #14 0x1853f37 in aio_ctx_dispatch util/async.c:268
    #15 0xffffa7f06a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)

Since we're fine to use the borrowed reference when using the creds,
so just remove the object_ref() in migration_tls_get_creds().

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Message-Id: <20200722033228.71-1-yezhenyu2@huawei.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/tls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/tls.c b/migration/tls.c
index 5171afc6c4..7a02ec8656 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -58,7 +58,6 @@ migration_tls_get_creds(MigrationState *s,
         return NULL;
     }
 
-    object_ref(OBJECT(ret));
     return ret;
 }
 
-- 
2.26.2


