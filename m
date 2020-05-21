Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8361020721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmtgCyEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8361020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblXn-0000lr-P2
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblX9-0000M7-Kt
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:46:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblX8-0008FZ-1i
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590068808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGg6kljqLZsw/VBpvzlc383WvusJtWLXPgTGda1XxZ8=;
 b=HmtgCyEFIAJ/UXyeyIq25Sfxm2aBZHTtD7r+vzjmJO4Iybr6s/URdXiosY6gg3p/j8/Wr+
 iSJLgHOSKUAdghslRpUtlZ6bjdDBfUSSSiWbdd49KTrGqwzB62q0fOg8kgxqvw5tGFJIMD
 9uvKWBjzijEjTigukQQNtpV/J//VAcU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-GHcsL2TkMHys9uU2OYx-Rw-1; Thu, 21 May 2020 09:46:46 -0400
X-MC-Unique: GHcsL2TkMHys9uU2OYx-Rw-1
Received: by mail-wm1-f70.google.com with SMTP id a206so1869707wmh.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uGg6kljqLZsw/VBpvzlc383WvusJtWLXPgTGda1XxZ8=;
 b=GTknLWrFVddDvlXspcX9IW9OGUNjmiSAxWk7Nj3NxV6TFOTdeNTlMQ7UEW9ydCr4ii
 DfZn52f0SLkvgZ5H76R8KL1cjHkhAJ7kyps1jeVHl15dc8O10zR0qHPt33UUiofewy9s
 mzGkeYwixFajBjNTFWzSl3g3F6TAUEw9dcgRMW76u7iLiKRyE2YINwlnjhM63m3ppSp7
 8GjTqjsBeNw4WvMiTJkFMylzQxXhW79Fn9+C+MC1nDIdPxANE9PQpOHXg3A82u30wFmE
 OuiTMFneBVcN26IHznCpBmejn3FZq1geWtu7sYGBpRlnNm0rL4pt5thb6SXcPxeehx7F
 APWQ==
X-Gm-Message-State: AOAM532+NNiwjO7hEruB3n8OT3AaOkiiCpaSOF0XPnkZ8WZ317E0f3gZ
 Wk7J2ldv7D+giqjK2/LvYn+7VoTnev84z9rVRfvpbMTGlgKtndzTPv01W8amC79ggwnlsRxKa4o
 b1vNCI2kszStiers=
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr8889381wmj.176.1590068805667; 
 Thu, 21 May 2020 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSsZCaDpf8ZEGHn4yDvN+C+kkL1gWXpsiHAlbzCwuu4cBx4Svv+pC22kgpcuK7IV57lTaNKw==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr8889367wmj.176.1590068805462; 
 Thu, 21 May 2020 06:46:45 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id c17sm6472011wrn.59.2020.05.21.06.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 06:46:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] numa: prevent usage of -M memory-backend and -numa
 memdev at the same time
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200511141103.43768-1-imammedo@redhat.com>
 <20200511141103.43768-3-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d40862d-972f-8189-07df-af043a430ee6@redhat.com>
Date: Thu, 21 May 2020 15:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200511141103.43768-3-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/05/20 16:11, Igor Mammedov wrote:
> Options -M memory-backend and -numa memdev are mutually exclusive,
> and if used together, it might lead to a crash in the worst case.
> For example when the same backend is used with these options together:
>   -m 4G \
>   -object memory-backend-ram,id=mem0,size=4G \
>   -M pc,memory-backend=mem0 \
>   -numa node,memdev=mem0
> QEMU will abort with:
>    exec.c:2006: qemu_ram_set_idstr: Assertion `!new_block->idstr[0]' failed.
> 
> and following backtrace:
>     abort ()
>     qemu_ram_set_idstr ()
>     vmstate_register_ram ()
>     vmstate_register_ram_global ()
>     machine_consume_memdev ()
>     numa_init_memdev_container ()
>     numa_complete_configuration ()
>     machine_run_board_init ()
> 
> add a check to error out in case the user tries to use both options at
> the same time.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/core/numa.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 316bc50d75..5f81900f88 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -757,6 +757,11 @@ void numa_complete_configuration(MachineState *ms)
>          }
>  
>          if (!numa_uses_legacy_mem() && mc->default_ram_id) {
> +            if (ms->ram_memdev_id) {
> +                error_report("'-machine memory-backend' and '-numa memdev'"
> +                             " properties are mutually exclusive");
> +                exit(1);
> +            }
>              ms->ram = g_new(MemoryRegion, 1);
>              memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
>                                 ram_size);
> 

Queued, thanks.

Paolo


