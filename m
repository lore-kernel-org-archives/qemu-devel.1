Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BACC3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4092024695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3SWeYCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4092024695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7bzT-0002TI-Bw
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7btn-00005A-JK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7btm-00047m-AV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7btm-00047b-68
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582881933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSi3RRcGBkfNvhBl8w4t9UcTEFa6L5QdrZ6e3GeWCmY=;
 b=S3SWeYCW/q3wTewuxcK2tdP96JEuJvawLtG/o+zcUiA9Bb3yXjgEqkOWVt4T3QTY6u8fqA
 1N314AmIxDS7WOE9A2HZBR0U8ojCGjK72v3Q5MxVxF0G4gQ7dwmTPRPF1v3WxQxh0sRnw/
 sag7xav3sdYReQQU4ZYELeU2cu6ailk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-3rFE9a4HNsuMPwDVvftS8Q-1; Fri, 28 Feb 2020 04:25:31 -0500
X-MC-Unique: 3rFE9a4HNsuMPwDVvftS8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D2E18A8C82;
 Fri, 28 Feb 2020 09:25:30 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E357660BE0;
 Fri, 28 Feb 2020 09:25:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] migration/savevm: release gslist after dump_vmstate_json
Date: Fri, 28 Feb 2020 10:24:16 +0100
Message-Id: <20200228092420.103757-12-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-1-quintela@redhat.com>
References: <20200228092420.103757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'list' forgot to free at the end of dump_vmstate_json_to_file(), although i=
t's called only once, but seems like a clean code.

Fix the leak as follow:
Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
    #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
    #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
    #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139)
    #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qemu=
/qom/object.c:1084
    #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qemu/=
qom/object.c:1028
    #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x3b=
5f7)
    #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/ob=
ject.c:1038
    #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom/o=
bject.c:1092
    #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu/m=
igration/savevm.c:638
    #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
    #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
    #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-softm=
mu/qemu-system-x86_64+0x27f020d)

Indirect leak of 7472 byte(s) in 467 object(s) allocated from:
    #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
    #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
    #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
    #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139)
    #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qemu=
/qom/object.c:1084
    #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qemu/=
qom/object.c:1028
    #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x3b=
5f7)
    #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/ob=
ject.c:1038
    #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom/o=
bject.c:1092
    #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu/m=
igration/savevm.c:638
    #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
    #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
    #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-softm=
mu/qemu-system-x86_64+0x27f020d)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1d4220ece8..c00a6807d9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -665,6 +665,7 @@ void dump_vmstate_json_to_file(FILE *out_file)
     }
     fprintf(out_file, "\n}\n");
     fclose(out_file);
+    g_slist_free(list);
 }
=20
 static uint32_t calculate_new_instance_id(const char *idstr)
--=20
2.24.1


