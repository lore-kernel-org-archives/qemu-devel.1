Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7F82087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMBQHQMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7F82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLps-00082Y-1o
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBLpF-0007G9-E2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBLpC-00027L-AT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598549792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/tr81l7qBVBJx6JohB2LVSl4N8zV0HsFUlXO47NX7t4=;
 b=XMBQHQMus0bNsBTA6cKtiTMahtTyC7OXD0WYIP5KtzPlDIl3fe5E4xX4VJDgsid/DUzK5V
 A4nAvFN4CG9+4vfyuZnWgIY96VhWiCnzJBHjr+tJ4sxbjpE7NQxSpG4uFplQ/wsuRZGySo
 GjnY7KSu65pxRptdbvupH2jx/d16Ag8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-mWMQDJFIO0aZ5Q8LkR-dCg-1; Thu, 27 Aug 2020 13:36:30 -0400
X-MC-Unique: mWMQDJFIO0aZ5Q8LkR-dCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4057D802B62;
 Thu, 27 Aug 2020 17:36:29 +0000 (UTC)
Received: from work-vm (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B88610AF;
 Thu, 27 Aug 2020 17:36:27 +0000 (UTC)
Date: Thu, 27 Aug 2020 18:36:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1] migration: tls: fix memory leak in
 migration_tls_get_creds
Message-ID: <20200827173625.GE2837@work-vm>
References: <20200722033228.71-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200722033228.71-1-yezhenyu2@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
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
Cc: zhengchuan@huawei.com, berrange@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhenyu Ye (yezhenyu2@huawei.com) wrote:
> Currently migration_tls_get_creds() adds the reference of creds
> but there was no place to unref it.  So the OBJECT(creds) will
> never be freed and result in memory leak.
> 
> The leak stack:
> Direct leak of 104 byte(s) in 1 object(s) allocated from:
>     #0 0xffffa88bd20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
>     #1 0xffffa7f0cb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
>     #2 0x14b58cb in object_new_with_type qom/object.c:634
>     #3 0x14b597b in object_new qom/object.c:645
>     #4 0x14c0e4f in user_creatable_add_type qom/object_interfaces.c:59
>     #5 0x141c78b in qmp_object_add qom/qom-qmp-cmds.c:312
>     #6 0x140e513 in qmp_marshal_object_add qapi/qapi-commands-qom.c:279
>     #7 0x176ba97 in do_qmp_dispatch qapi/qmp-dispatch.c:165
>     #8 0x176bee7 in qmp_dispatch qapi/qmp-dispatch.c:208
>     #9 0x136e337 in monitor_qmp_dispatch monitor/qmp.c:150
>     #10 0x136eae3 in monitor_qmp_bh_dispatcher monitor/qmp.c:239
>     #11 0x1852e93 in aio_bh_call util/async.c:89
>     #12 0x18531b7 in aio_bh_poll util/async.c:117
>     #13 0x18616bf in aio_dispatch util/aio-posix.c:459
>     #14 0x1853f37 in aio_ctx_dispatch util/async.c:268
>     #15 0xffffa7f06a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
> 
> Since we're fine to use the borrowed reference when using the creds,
> so just remove the object_ref() in migration_tls_get_creds().
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>

Queued, sorry for the delay.

> ---
>  migration/tls.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/tls.c b/migration/tls.c
> index 5171afc6c4..7a02ec8656 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -58,7 +58,6 @@ migration_tls_get_creds(MigrationState *s,
>          return NULL;
>      }
>  
> -    object_ref(OBJECT(ret));
>      return ret;
>  }
>  
> -- 
> 2.19.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


