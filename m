Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047FEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50E2206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E23QUxkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50E2206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtT3L-0001zw-TA
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtT2a-0001O9-Iw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:40:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37404
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtT2Y-00024p-QA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594287624;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I+d1r+uuDTv1kGz6Udb514iI2wjbGYwoU10+nygoQiE=;
 b=E23QUxkpYk7CloCwkn6K+bibKlOKIa0saHWeGqXoFFult2DUuO8iB55Q6lepH5vuvOqFcK
 mlsIo7kSBFTaVD+Jsd9xIBbynjNCVc1N35w5ajMsf0MCPOGniQczgOkakHDehm4mWCvwZ6
 ODQ/7CmeL2ZOb2tRUPiFyolHW7Jygts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-JtswNKeqPx-hlAPKG_VzXQ-1; Thu, 09 Jul 2020 05:40:23 -0400
X-MC-Unique: JtswNKeqPx-hlAPKG_VzXQ-1
Received: by mail-wm1-f70.google.com with SMTP id g124so1767554wmg.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 02:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=I+d1r+uuDTv1kGz6Udb514iI2wjbGYwoU10+nygoQiE=;
 b=i3jtvjTNQw4qXFtwlZvQ0l84YEnMUeawYW4RE3gUmVuSm80HDftBC8PfmIF33E/OQt
 KYh6zkxhCgpRml8JSKNPySWtdyCMgwkr/Nb25jGWKyDFUGDZIm+xDaN/M4ifEw22gFPd
 0wixc0yNiaCtrav5kDShV2S/jvbMVytRDvyfPL+fumYa3saqDQwLtQUdb2k8uo7aNJWM
 +8REmS7cTCLZjfkjmrHFg06vhyVKlaVDksGPAHDDgKRMBVgIzLNr1HvV4haTVObRswgc
 xaCOm+znXIGcOm2LASO1gTxuvgER+Siz/qK5kE4fDCNw+MTdDqcTpdCt0LXOwt2FYA9B
 5LFA==
X-Gm-Message-State: AOAM533Ofo1uh4eUWJxD3y57mYfXpQAmTV5f9U+P1bzzK8a/07ZpUYw1
 m/utjiWEoAqsO/VfZwJzaCZrAimlqSJi/Vt40OYrDo4rAHB/caVCBwyzs5U5/li34bW5UN7/xPT
 R8GLI1gglDQyWc+g=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr61422397wrs.384.1594287621990; 
 Thu, 09 Jul 2020 02:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi0jZkUnW661WsFzvRQ074aou/8RztX84CUDiQx2E0Uyq5/n7OlW5Qa8jTQ0bQnA0wWcKlWQ==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr61422377wrs.384.1594287621739; 
 Thu, 09 Jul 2020 02:40:21 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id y77sm4302599wmd.36.2020.07.09.02.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 02:40:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH] migration: fix memory leak in qmp_migrate_set_parameters
In-Reply-To: <1594283305-105724-1-git-send-email-zhengchuan@huawei.com> (Chuan
 Zheng's message of "Thu, 9 Jul 2020 16:28:25 +0800")
References: <1594283305-105724-1-git-send-email-zhengchuan@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jul 2020 11:40:20 +0200
Message-ID: <87mu492fi3.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
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
Reply-To: quintela@redhat.com
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, fangying1@huawei.com,
 zhukeqian1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> wrote:
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

Nice catch.

Reviewed-by: Juan Quintela <quintela@redhat.com>

Queued.

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


