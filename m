Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DFC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3AA20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa7FzbtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3AA20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyArv-00047e-RU
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyArC-0003EE-SD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyArB-00054J-4u
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595409368;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNxCn/bvdtiZ861UgMIkJ29hcAIO+AEGQEvLAzPm1aA=;
 b=aa7FzbtWXdCOOITNiajb/+CVdSPR+ZvA0I28EPd4fiEXzuMYNYDeI/nWJRfH0bZ+gbYOqN
 2LSLNUD1bViQ8w6DA5pVYbdnDBipKceGSUFXEqDVykDyZD90UHQgGQ2mpXRTo0tWogc2an
 PXI/fNxEqJhHhsrbpuBlJbdrTtWC44M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-m2D9XlYlOBOSvEuGclMLQw-1; Wed, 22 Jul 2020 05:16:04 -0400
X-MC-Unique: m2D9XlYlOBOSvEuGclMLQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E3E9193F561;
 Wed, 22 Jul 2020 09:16:03 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 754037B41E;
 Wed, 22 Jul 2020 09:16:01 +0000 (UTC)
Date: Wed, 22 Jul 2020 10:15:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1] migration: tls: fix memory leak in
 migration_tls_get_creds
Message-ID: <20200722091558.GE2323046@redhat.com>
References: <20200722033228.71-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200722033228.71-1-yezhenyu2@huawei.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: xiexiangyou@huawei.com, zhengchuan@huawei.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 11:32:28AM +0800, Zhenyu Ye wrote:
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
> ---
>  migration/tls.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


