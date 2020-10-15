Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F05C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB93D2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPkpI9Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB93D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9O5-0000dx-Lu
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT9LY-0007ca-Nr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT9LW-0007zE-8f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602791729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hY6NSIdGMND623SIUpYhlmDmSoigYS44bW1MlKzqono=;
 b=QPkpI9AvjpuwZzdEntNGecODDBHX64dPhZEuo0UHJ2F1EOA1fxBfL3+vFRP/zc5tgeQLE5
 32stNDMH0hWsIAfFu1WmWycvf4xGbfAYyGxhGzcPgZVfEDBPJkiaJkAJ93Jvt93ci6TIAP
 dzjm3ge2KCjZGJkfzOnvpX32y41Nu50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-bN4X7TD8O7a7Qjw_ln28wQ-1; Thu, 15 Oct 2020 15:55:27 -0400
X-MC-Unique: bN4X7TD8O7a7Qjw_ln28wQ-1
Received: by mail-wm1-f72.google.com with SMTP id f26so143010wml.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hY6NSIdGMND623SIUpYhlmDmSoigYS44bW1MlKzqono=;
 b=o58h3f6D9mwiSrsDalYTxfPF+Svd+goSfMOtB/u7L/I+ZQzBpaVy/vmgZiFR+V18Oa
 +SDZgSkRq39FnvRNy2Vpv70OliohRFbh/4IUqxBi4Z0mj2tPpq4c4qdU25a3CCU2HKc6
 EhN+CjaNCoXFBFz+q/Qyuva8TraCCM3wP30yWpv2CpAtdDpqpjXmUezbVAIdjFb9q9/E
 2eVQJQi5nAfY754lkpqCV02JGH0gUKW3fRqgEtc0iCIHsbsRj1E9/0wiV4PXgvOGmp6+
 Z8uyTqNicp8i/PQssbC1ZO5BEJ5RH3PxlsK6Ic4BUQeftUxXPtX8f6MKLuzK+E0YzJBJ
 vJsA==
X-Gm-Message-State: AOAM531Fg4pJyFlMpjSzrnz0rHS0JxRS3dv9hRHVko4MUeUi35mjWS3d
 f6f+Cd9KFd+dtNewjsXkUmupcv4nz3faAtRZwMnyg/+F2YoCupmg81NnKIvdvM1ksW0K6n2l0Ik
 bkhRTABCVPN18p3w=
X-Received: by 2002:a1c:e045:: with SMTP id x66mr300725wmg.104.1602791725995; 
 Thu, 15 Oct 2020 12:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzneoKbQsEig5P6RPgwD6y6T1InPbMqzzxWPNJcbz8fDPN4PQ9dAwNRHUXMV/O7AfqOouCcTw==
X-Received: by 2002:a1c:e045:: with SMTP id x66mr300717wmg.104.1602791725817; 
 Thu, 15 Oct 2020 12:55:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 30sm538471wrr.35.2020.10.15.12.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 12:55:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] pci: Change error_report to assert(3)
To: Ben Widawsky <ben.widawsky@intel.com>, qemu-devel@nongnu.org
References: <20201015181411.89104-1-ben.widawsky@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9c27793-7686-5bf3-bf5a-74800311657b@redhat.com>
Date: Thu, 15 Oct 2020 21:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015181411.89104-1-ben.widawsky@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 8:14 PM, Ben Widawsky wrote:
> Asserts are used for developer bugs. As registering a bar of the wrong
> size is not something that should be possible for a user to achieve,
> this is a developer bug.
> 
> While here, use the more obvious helper function.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>   hw/pci/pci.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


