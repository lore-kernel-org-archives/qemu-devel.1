Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A62C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582DA20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3BVKzg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582DA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBF6S-0003bh-HG
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBF4o-0002Aw-2h
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBF4m-0002gk-B6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:51:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBF4m-0002gX-28
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583747515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pCo7KP1UN4FlxVwL/NiMJs2s+2Ata9IZ1GgtvV+pcs=;
 b=R3BVKzg5f4ev4YvXoD8f1QAC9infsu2UzKxgE/3pv1tOOfgM3/TYc4bnFFm5HJqVETjow2
 cpDsLJiGqNXTK9UQtSd12zLmSmt1LRjew7wjQY9SK1MNpkFsSTfLT5aOC9nHBBVbFzgzJE
 jnwwQxo/TPp5rxVj2ddCkdO9RjNOLpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-3KvAD0nIMKiTx_KtjxOgCg-1; Mon, 09 Mar 2020 05:51:51 -0400
X-MC-Unique: 3KvAD0nIMKiTx_KtjxOgCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4486A14E6;
 Mon,  9 Mar 2020 09:51:49 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEF329051C;
 Mon,  9 Mar 2020 09:51:47 +0000 (UTC)
Date: Mon, 9 Mar 2020 10:51:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] qom-qmp-cmds: fix two memleaks in qmp_object_add
Message-ID: <20200309105145.2f3f6a81@redhat.com>
In-Reply-To: <20200309092212.3249-1-pannengyuan@huawei.com>
References: <20200309092212.3249-1-pannengyuan@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 17:22:12 +0800
Pan Nengyuan <pannengyuan@huawei.com> wrote:

> 'type/id' forgot to free in qmp_object_add, this patch fix that.
> 
> The leak stack:
> Direct leak of 84 byte(s) in 6 object(s) allocated from:
>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>     #3 0x56344954e692 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qmp-cmds.c:258
>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:132
>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:175
>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:145
>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:234
>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/util/async.c:136
> 
> Direct leak of 54 byte(s) in 6 object(s) allocated from:
>     #0 0x7fe2a5ebf768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
>     #1 0x7fe2a5044445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
>     #2 0x7fe2a505dd92 in g_strdup (/lib64/libglib-2.0.so.0+0x6bd92)
>     #3 0x56344954e6c4 in qmp_object_add /mnt/sdb/qemu-new/qemu_test/qemu/qom/qom-qmp-cmds.c:267
>     #4 0x563449960f5a in do_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:132
>     #5 0x563449960f5a in qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qmp-dispatch.c:175
>     #6 0x563449498a30 in monitor_qmp_dispatch /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:145
>     #7 0x56344949a64f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu-new/qemu_test/qemu/monitor/qmp.c:234
>     #8 0x563449a92a3a in aio_bh_call /mnt/sdb/qemu-new/qemu_test/qemu/util/async.c:136
> 
> Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  qom/qom-qmp-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 49db926fcc..ac59ba1aa8 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -247,8 +247,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp)
>      QDict *pdict;
>      Visitor *v;
>      Object *obj;
> -    const char *type;
> -    const char *id;
> +    g_autofree const char *type = NULL;
> +    g_autofree const char *id = NULL;

not sure that's it's correct

qdict_get_try_str() returns the reference to a string within
the QDict, so caller who provided qdict should take care of
freeing it.

>  
>      type = qdict_get_try_str(qdict, "qom-type");
>      if (!type) {


