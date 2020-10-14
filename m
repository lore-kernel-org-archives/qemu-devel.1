Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A0C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AB72222F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMVxhOGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AB72222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShAB-0002eB-TE
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSh8z-0001Yw-VY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSh8w-0008Dm-RI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602683318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttasglJhGde7vJ5qYn/fjxo5arUXRuHvccFkj+Gi+T4=;
 b=PMVxhOGNkkY1VzBuExJNXo7Np1YXyMryWu1HnCXHyndkUbrxCER9VMlOPWrmfWrLDNiZxa
 v4Wb5leKJ7IpslY/jyvjAaZnWcC3tS/lOffqe+07OTDz1ieQ/kBFF+hfVgImowGiIijKxi
 WuXLaTClbu3xrgZuNhu6TD3tQwiw8oU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-r9j0i4l1PI6lo1T0Fvp15A-1; Wed, 14 Oct 2020 09:48:35 -0400
X-MC-Unique: r9j0i4l1PI6lo1T0Fvp15A-1
Received: by mail-wr1-f72.google.com with SMTP id r8so1312930wrp.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 06:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ttasglJhGde7vJ5qYn/fjxo5arUXRuHvccFkj+Gi+T4=;
 b=klDQHS4GUMTpccRzLyxCWRmpMEr7relA+2Ft9RlE9OV6Fk4j9FH0+oyyIjIFJ0x8aF
 6DTVvQJR6KL9CNjYgFRBHyezU7ObeHej7D9VkLE3bYvOLoDv580JZRfRBjkqMOF1tmL6
 MC8i3hbs63eQXedTgDloKVecDEzoUaENqNb0ziDdQE0fPLLNmjiqZEZC0v3fvPujjfqL
 VP8VEqf/qiYFnYRrA1Qp0mqQq8RLsatuvpLiOvw9hfRu/JaBo0F7J74SwTjxu6wUiaDj
 HFrQfFVjraYjVV9E2kzvrCaO5n6FsxPQSRWlMLxuxAkFpi16o8Y8fAh0CkyxGLwwPwWn
 Z6Eg==
X-Gm-Message-State: AOAM531ur/eZ7DqT2DApKpNu9oFBG8vxO0BQ9RaYWbIJAzhfwp9x4MgJ
 r4INfR5tH1N7IQgwZ7hWvaDwc23i6Yt+4E0QyddZANcQ5zslPEjHU0muuKaCrLtytAe4CY5qLg4
 JL6/+kg1N9VwMmPA=
X-Received: by 2002:a1c:a949:: with SMTP id s70mr3751498wme.17.1602683314172; 
 Wed, 14 Oct 2020 06:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdQl315plmIF47FeIW43bT/ALpQqObtl60RbG/3Y/WMwRNUJfQVozhJXKr7TrePOZbru5neg==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr3751479wme.17.1602683313937; 
 Wed, 14 Oct 2020 06:48:33 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p4sm5160001wru.39.2020.10.14.06.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 06:48:33 -0700 (PDT)
Subject: Re: [PATCH] cpus: Drop declaration of cpu_remove()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160268285707.1107461.15035929822602623985.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <431287f0-94a9-8c81-443a-b3d80ca33a32@redhat.com>
Date: Wed, 14 Oct 2020 15:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160268285707.1107461.15035929822602623985.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 3:40 PM, Greg Kurz wrote:
> cpu_remove() got superseded by cpu_remove_sync() in commit dbadee4ff4a0,
> but its prototype wasn't removed. We could possibly keep the shorter
> cpu_remove() naming but it seems better to highligth that this blocks
> until the CPU thread is joined.
> 
> Fixes: dbadee4ff4a0 ("cpus: join thread when removing a vCPU")
> Cc: pbonzini@redhat.com
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   include/hw/core/cpu.h |    8 --------
>   1 file changed, 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


