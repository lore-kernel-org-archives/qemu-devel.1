Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34746C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2698206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9p25/vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2698206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5JD-0006ke-7I
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0002Ug-4t
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0000Qk-3w
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0000QI-0J
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPcScmOeOhS1CNjgYDmco4c2KEYNfVkIUVRESJAays8=;
 b=S9p25/vCxD5GXSH7AzOq/wvyM3cgs0n8nPM8Q8YNOgBDKRRdbYTAcVwtawiljxOvLqZHjH
 E7Bfb2Wx1x/zRV8fPTDc+nhgUgMwFkT9YWG5jICjJGx5jM/287tELumQI4vzFAPneAkNT2
 D7SgoRg7ET2VNHDLZfO1TL21g46QPQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-tj_EBB23PheOCByAjId5pA-1; Thu, 02 Apr 2020 15:06:52 -0400
X-MC-Unique: tj_EBB23PheOCByAjId5pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0797A1050940
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7EADA0F2;
 Thu,  2 Apr 2020 19:06:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] qmp: fix leak on callbacks that return both value and
 error
Date: Thu,  2 Apr 2020 15:06:38 -0400
Message-Id: <20200402190640.1693-14-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Direct leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7fa114931887 in __interceptor_calloc (/lib64/libasan.so.6+0xb0887)
    #1 0x7fa1144ad8f0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x588f0)
    #2 0x561e3c9c8897 in qmp_object_add /home/elmarco/src/qemu/qom/qom-qmp-=
cmds.c:291
    #3 0x561e3cf48736 in qmp_dispatch /home/elmarco/src/qemu/qapi/qmp-dispa=
tch.c:155
    #4 0x561e3c8efb36 in monitor_qmp_dispatch /home/elmarco/src/qemu/monito=
r/qmp.c:145
    #5 0x561e3c8f09ed in monitor_qmp_bh_dispatcher /home/elmarco/src/qemu/m=
onitor/qmp.c:234
    #6 0x561e3d08c993 in aio_bh_call /home/elmarco/src/qemu/util/async.c:13=
6
    #7 0x561e3d08d0a5 in aio_bh_poll /home/elmarco/src/qemu/util/async.c:16=
4
    #8 0x561e3d0a535a in aio_dispatch /home/elmarco/src/qemu/util/aio-posix=
.c:380
    #9 0x561e3d08e3ca in aio_ctx_dispatch /home/elmarco/src/qemu/util/async=
.c:298
    #10 0x7fa1144a776e in g_main_context_dispatch (/lib64/libglib-2.0.so.0+=
0x5276e)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200325184723.2029630-3-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qmp-dispatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index c30c7ff9e1..79347e0864 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -155,6 +155,8 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject=
 *request,
     cmd->fn(args, &ret, &err);
     qobject_unref(args);
     if (err) {
+        /* or assert(!ret) after reviewing all handlers: */
+        qobject_unref(ret);
         goto out;
     }
=20
--=20
2.18.2



