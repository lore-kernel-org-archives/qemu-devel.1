Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB0C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D129920848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWs5mnpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D129920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVV4M-0004EF-LE
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVV2z-0002xs-33
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVV2x-0002VK-Ei
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603351802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aso/dolho7QYlJklTkEwkTdXLT+Tu197uubrZLZNTVE=;
 b=hWs5mnpalrKnw8vae6yENw3ytwO1VGgjLLH+Xs6SUXSksgAM8qcPl8KcIO6xgqBcAyQcaz
 ShIbtsVKxEXI5Dk8QwFbQfgZoWv0vk8JE0H9HF4eyXL+Nai1ltmFFhgstKc6VrtVPdSPQt
 EUBEGMedbIIphPS/bh9tL8vcN7O1t9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-f6E_0qgvP4KvoBTkWUzgDQ-1; Thu, 22 Oct 2020 03:30:00 -0400
X-MC-Unique: f6E_0qgvP4KvoBTkWUzgDQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so275056wrq.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 00:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aso/dolho7QYlJklTkEwkTdXLT+Tu197uubrZLZNTVE=;
 b=D6z4ywteD4mYT+/2TM7XpEvO4O/NdFlVLgxZv59AxSwPuSNvwkxLjevLrVIXzP2xLA
 sdjGej7wZlWm2l7HCchJ1GDco0Bo4Xkavsx8ClorYYdhyEHzAg1mXBnSlZBws2huBOwQ
 py4GIxDte+ZlGqRScINhzHmBCO+8/7Tfxpv+PI97pMSyuQs1CWdvPySBxAY+/TYlwWYz
 HccIUZyYuIrL+xo445xJxY+AJ0f0h1JM0wwX1C4lykUJGj6BuQKSHyZdzfhkKybyGLI7
 oCbewimSVUiVYdBGGgS474G2ck0Onr7DeqtVcj6H+6jGB0bx56zXNjHTmHAC2oRUaCik
 DsLQ==
X-Gm-Message-State: AOAM530FlIbytp8m0g3kazQoBLdXvj9sU3NPoyT/+T3dCbDz07rLZVEw
 O6L52pkjgSGjrtp6jTnoW05L+BePBJ6MBn4nV8HrtgG0ukWH5E2PbjOTgxZ5qjGmBdcWIetvsvx
 CcNsupas1LgoS09o=
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr1241807wrh.213.1603351798964; 
 Thu, 22 Oct 2020 00:29:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu3aRcWWukgPNqFToFkLcddMM7eXWGf34NJg7kLq2pQa15w+j+4VyPjxHPdTYCWokL0M8dOA==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr1241790wrh.213.1603351798821; 
 Thu, 22 Oct 2020 00:29:58 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t6sm2167204wre.30.2020.10.22.00.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 00:29:57 -0700 (PDT)
Subject: Re: [PATCH 20/22] vl: move CHECKPOINT_INIT after preconfig
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-21-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3edbadf8-4b13-dec0-952b-bb9bfa1bcf0d@redhat.com>
Date: Thu, 22 Oct 2020 09:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021205716.2359430-21-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 10:57 PM, Paolo Bonzini wrote:
> Move CHECKPOINT_INIT right before the machine initialization is
> completed.  Everything before is essentially an extension of
> command line parsing.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   softmmu/vl.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 0a6f47e7d6..e9391929f6 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -3194,6 +3194,11 @@ void qemu_finish_machine_init(void)
>           exit(1);
>       }
>   
> +    /* This checkpoint is required by replay to separate prior clock
> +       reading from the other reads, because timer polling functions query
> +       clock values from the log. */
> +    replay_checkpoint(CHECKPOINT_INIT);
> +
>       machine_run_board_init(current_machine);
>   
>       /*
> @@ -4424,11 +4429,6 @@ void qemu_init(int argc, char **argv, char **envp)
>       if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>           exit(1);
>   
> -    /* This checkpoint is required by replay to separate prior clock
> -       reading from the other reads, because timer polling functions query
> -       clock values from the log. */
> -    replay_checkpoint(CHECKPOINT_INIT);
> -
>       current_machine->boot_order = boot_order;
>   
>       /* parse features once if machine provides default cpu_type */
> 


