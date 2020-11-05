Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC05C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357CA2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE48rmht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357CA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakqk-0007xk-7t
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakoY-0006gM-Fg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakoV-0007YT-U1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604604050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0xgQtdulOoh02cnDSLdHlJ5v0w+t9rUfDHLb2Dlo9o=;
 b=RE48rmhtF5DFNNTeyIY+AFFaTgwNRznmitcLp2/bjitmkSyOrZ4j+HqahXDAD3cNfztONI
 spegi5bbjSWewwT2NaCnWd9cRYb+PW3fDYyD/yJdDs0pcusJJhDgQ2N/S6grZjZWhP8cy6
 rjK+0GaTDPAF8NZI/GciFv6l/F9H5HU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-cjqPYmbBOpS-b8yKURloEQ-1; Thu, 05 Nov 2020 14:20:48 -0500
X-MC-Unique: cjqPYmbBOpS-b8yKURloEQ-1
Received: by mail-wm1-f70.google.com with SMTP id 8so692763wmg.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t0xgQtdulOoh02cnDSLdHlJ5v0w+t9rUfDHLb2Dlo9o=;
 b=MSFwhDK8Exx1LmpArja+6i+o3Y9uGeQakiTSSjNmkbPUnSb0fVzhas+zNK+THE2dUu
 up0Mjw78pSPvB1+AviTm8OKLHENTyZJhMlvH5l5XnGjN9Xy2POaZUFKp3qD7tr9V1yi7
 bq4yRk8KV1dQhEnIsZNfYCiMLLa3NcfxutJ+SFDgQ9Rr9ZYArgb89ukkn3l6IftK+9pf
 R3Ra1HZ47jQmH1cREnlEb8n8aAuQicr9n2mB+Zy+i/ig5fC+AxBvNyb+v09A9Hp9NcU1
 t8cnJBiiU3CKStV+dds6z7Emth2jyldBFVtFZ++f4iBVWSnbYqsZbRpN+X9m5jhwNwF6
 ex+g==
X-Gm-Message-State: AOAM533wE4dCrzorZHBgOqjPcTXE6cQU8OOfkNDqv1MvzIKZyWOsCnE8
 eU+TP2IETE3Trrcadom6J6Ao0+B28nwLsolO0CQjiMdmWQPyUaQwFKpHmMjjIGJstChhMnKXSQH
 h6kv13V1JLjipByE=
X-Received: by 2002:adf:db44:: with SMTP id f4mr4795475wrj.168.1604604047209; 
 Thu, 05 Nov 2020 11:20:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2jKg6Kx/VFml1jPb++uW/A+bmxzZHzhCCNrJjrZMJhbFGDNmyfrL1NXdQVAfOUQDOCkFu1w==
X-Received: by 2002:adf:db44:: with SMTP id f4mr4795464wrj.168.1604604047092; 
 Thu, 05 Nov 2020 11:20:47 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u3sm4185532wro.33.2020.11.05.11.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 11:20:46 -0800 (PST)
Subject: Re: [RFC PATCH 13/15] accel/stubs: drop unused cpu.h include
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <233db685-910d-3317-4bf6-09111852a522@redhat.com>
Date: Thu, 5 Nov 2020 20:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-14-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, stratos-dev@op-lists.linaro.org,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, "open list:X86 HAXM CPUs" <haxm-team@intel.com>,
 Colin Xu <colin.xu@intel.com>, stefano.stabellini@xilinx.com,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/stubs/hax-stub.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/accel/stubs/hax-stub.c b/accel/stubs/hax-stub.c
> index 1a9da83185..49077f88e3 100644
> --- a/accel/stubs/hax-stub.c
> +++ b/accel/stubs/hax-stub.c
> @@ -14,7 +14,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "cpu.h"
>  #include "sysemu/hax.h"
>  
>  int hax_sync_vcpus(void)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


