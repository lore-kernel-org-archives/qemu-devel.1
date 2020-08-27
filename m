Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B4C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CE9207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCk5Rn9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CE9207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBL83-0003Pt-EY
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBL7Q-0002y2-QS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBL7O-00049x-KW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598547076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UMw16oURt22yHRtt7/uMdn4Lwg6eFkWEtf6ogE08ZoM=;
 b=SCk5Rn9ykb7kZqxPXxPAAGR4b0AtlVM2A09QNPNUDcjxUY/shTUKnIyU9JG7GV5OrMdvUe
 /04k0OnyttF3gw4zJWz2pDV4qcYlvOxSaLAzQn9Q5j6/G28ILRaZ2b7TEIWbL13btUWRTn
 gSwFPZ6YikvFvzapbqh++wno/MRECGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-LUgEmKBYNF-y0ubc3ss75w-1; Thu, 27 Aug 2020 12:51:14 -0400
X-MC-Unique: LUgEmKBYNF-y0ubc3ss75w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16A2A107464C;
 Thu, 27 Aug 2020 16:51:13 +0000 (UTC)
Received: from work-vm (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 210B31944D;
 Thu, 27 Aug 2020 16:51:10 +0000 (UTC)
Date: Thu, 27 Aug 2020 17:51:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH] migration: fix memory leak in qmp_migrate_set_parameters
Message-ID: <20200827165108.GA122424@work-vm>
References: <1594283305-105724-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1594283305-105724-1-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, fangying1@huawei.com,
 zhukeqian1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> From: Zheng Chuan <zhengchuan@huawei.com>
> 
> "tmp.tls_hostname" and "tmp.tls_creds" allocated by migrate_params_test_apply()
> is forgot to free at the end of qmp_migrate_set_parameters(). Fix that.
> 
> The leak stack:
> Direct leak of 2 byte(s) in 2 object(s) allocated from:
>    #0 0xffffb597c20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
>    #1 0xffffb52dcb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
>    #2 0xffffb52f8143 in g_strdup (/usr/lib64/libglib-2.0.so.0+0x74143)
>    #3 0xaaaac52447fb in migrate_params_test_apply (/usr/src/debug/qemu-4.1.0/migration/migration.c:1377)
>    #4 0xaaaac52fdca7 in qmp_migrate_set_parameters (/usr/src/debug/qemu-4.1.0/qapi/qapi-commands-migration.c:192)
>    #5 0xaaaac551d543 in qmp_dispatch (/usr/src/debug/qemu-4.1.0/qapi/qmp-dispatch.c:165)
>    #6 0xaaaac52a0a8f in qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:125)
>    #7 0xaaaac52a1c7f in monitor_qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:214)
>    #8 0xaaaac55cb0cf in aio_bh_call (/usr/src/debug/qemu-4.1.0/util/async.c:117)
>    #9 0xaaaac55d4543 in aio_bh_poll (/usr/src/debug/qemu-4.1.0/util/aio-posix.c:459)
>    #10 0xaaaac55cae0f in aio_dispatch (/usr/src/debug/qemu-4.1.0/util/async.c:268)
>    #11 0xffffb52d6a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
>    #12 0xaaaac55d1e3b(/usr/bin/qemu-kvm-4.1.0+0x1622e3b)
>    #13 0xaaaac4e314bb(/usr/bin/qemu-kvm-4.1.0+0xe824bb)
>    #14 0xaaaac47f45ef(/usr/bin/qemu-kvm-4.1.0+0x8455ef)
>    #15 0xffffb4bfef3f in __libc_start_main (/usr/lib64/libc.so.6+0x23f3f)
>    #16 0xaaaac47ffacb(/usr/bin/qemu-kvm-4.1.0+0x850acb)
> 
> Direct leak of 2 byte(s) in 2 object(s) allocated from:
>    #0 0xffffb597c20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
>    #1 0xffffb52dcb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
>    #2 0xffffb52f8143 in g_strdup (/usr/lib64/libglib-2.0.so.0+0x74143)
>    #3 0xaaaac5244893 in migrate_params_test_apply (/usr/src/debug/qemu-4.1.0/migration/migration.c:1382)
>    #4 0xaaaac52fdca7 in qmp_migrate_set_parameters (/usr/src/debug/qemu-4.1.0/qapi/qapi-commands-migration.c:192)
>    #5 0xaaaac551d543 in qmp_dispatch (/usr/src/debug/qemu-4.1.0/qapi/qmp-dispatch.c)
>    #6 0xaaaac52a0a8f in qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:125)
>    #7 0xaaaac52a1c7f in monitor_qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:214)
>    #8 0xaaaac55cb0cf in aio_bh_call (/usr/src/debug/qemu-4.1.0/util/async.c:117)
>    #9 0xaaaac55d4543 in aio_bh_poll (/usr/src/debug/qemu-4.1.0/util/aio-posix.c:459)
>    #10 0xaaaac55cae0f in in aio_dispatch (/usr/src/debug/qemu-4.1.0/util/async.c:268)
>    #11 0xffffb52d6a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
>    #12 0xaaaac55d1e3b(/usr/bin/qemu-kvm-4.1.0+0x1622e3b)
>    #13 0xaaaac4e314bb(/usr/bin/qemu-kvm-4.1.0+0xe824bb)
>    #14 0xaaaac47f45ef (/usr/bin/qemu-kvm-4.1.0+0x8455ef)
>    #15 0xffffb4bfef3f in __libc_start_main (/usr/lib64/libc.so.6+0x23f3f)
>    #16 0xaaaac47ffacb(/usr/bin/qemu-kvm-4.1.0+0x850acb)
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: KeQian Zhu <zhukeqian1@huawei.com>
> Reviewed-by: HaiLiang <zhang.zhanghailiang@huawei.com@huawei.com>

Queued

> ---
>  migration/migration.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 92e44e0..045180c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1342,12 +1342,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>  
>      if (params->has_tls_creds) {
>          assert(params->tls_creds->type == QTYPE_QSTRING);
> -        dest->tls_creds = g_strdup(params->tls_creds->u.s);
> +        dest->tls_creds = params->tls_creds->u.s;
>      }
>  
>      if (params->has_tls_hostname) {
>          assert(params->tls_hostname->type == QTYPE_QSTRING);
> -        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
> +        dest->tls_hostname = params->tls_hostname->u.s;
>      }
>  
>      if (params->has_max_bandwidth) {
> -- 
> 1.8.3.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


